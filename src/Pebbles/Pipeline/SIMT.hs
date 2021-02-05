module Pebbles.Pipeline.SIMT
  ( -- Pipeline configuration
    SIMTPipelineConfig(..)
    -- Pipeline inputs and outputs
  , SIMTPipelineIns(..)
  , SIMTPipelineOuts(..)
    -- Pipeline module
  , makeSIMTPipeline
  ) where

-- Simple 32-bit SIMT pipeline, with implicit thread convergence (a la
-- Simty) and a configurable number of warps and warp size.
--
-- There are 7 pipeline stages:
--
--  0. Warp Scheduling
--  1. Active Thread Selection
--  2. Instruction Fetch
--  3. Operand Fetch
--  4. Operand Latch
--  5. Execute (& Thread Suspension)
--  6. Writeback (& Thread Resumption)
--
-- Instructions are suspended in the Execute stage if they cannot
-- complete within a clock cycle.  Suspended instructions are resumed
-- in the Writeback stage.  Resumptions can be out-of-order with
-- respect to suspensions, and there is no requirement for threads in
-- a warp to resume at the same time.  This flexibility is achieved by
-- maininting a "suspension bit" register for every thread.
-- Currently, if a warp is scheduled that contains any suspended
-- threads, then a bubble passes through the pipeline and the warp
-- will be tried again later.  In future, we might attempt to avoid
-- scheduling a warp that contains a suspended thread.
--
-- Other considerations for future: (1) give retried instructions a
-- higher priority than new instructions in the warp scheduler; (2)
-- incorporate function call depth into active thread selection, a la
-- Simty.

-- Blarney imports
import Blarney
import Blarney.Queue
import Blarney.Option
import Blarney.Stream
import Blarney.BitScan

-- General imports
import Data.List
import Data.Proxy
import qualified Data.Map as Map
import Control.Applicative hiding (some)

-- Pebbles imports
import Pebbles.Pipeline.Interface
import Pebbles.Pipeline.SIMT.Management

-- | SIMT pipeline configuration
data SIMTPipelineConfig tag =
  SIMTPipelineConfig {
    -- | Instruction memory initialisation file
    instrMemInitFile :: Maybe String
    -- | Instuction memory size (in number of instructions)
  , instrMemLogNumInstrs :: Int
    -- | Number of warps
  , logNumWarps :: Int
    -- | Number of bits used to track function call depth
  , logMaxCallDepth :: Int
    -- | Decode table
  , decodeStage :: [(String, tag)]
    -- | List of execute stages, one per lane
    -- The size of this list is the warp size
  , executeStage :: [State -> Module ExecuteStage]
  }

-- | SIMT pipeline inputs
data SIMTPipelineIns =
  SIMTPipelineIns {
      -- | Stream of pipeline management requests
      simtMgmtReqs :: Stream SIMTReq
      -- | When this wire is active, the warp currently in the execute
      -- stage (assumed to be converged) is terminated
    , simtWarpTerminatedWire :: Wire (Bit 1)
      -- | A pulse on these wires indicates that current instruction (in
      -- execute) is incrementing/decrementing the function call
      -- depth; one bit per lane
    , simtIncCallDepth :: [Bit 1]
    , simtDecCallDepth :: [Bit 1]
  }

-- | SIMT pipeline outputs
data SIMTPipelineOuts =
  SIMTPipelineOuts {
      -- | Stream of pipeline management responses
      simtMgmtResps :: Stream SIMTResp
      -- | Warp id of instruction currently in execute stage
    , simtCurrentWarpId :: Bit 32
      -- | Address of kernel closure as set by CPU
    , simtKernelAddr :: Bit 32
  }

-- | Per-thread state
data SIMTThreadState t_logInstrs t_logMaxCallDepth =
  SIMTThreadState {
    -- | Program counter
    simtPC :: Bit t_logInstrs
    -- | Function call depth (smaller is deeper)
  , simtCallDepth :: Bit t_logMaxCallDepth
  }
  deriving (Generic, Bits)

-- | SIMT pipeline module
makeSIMTPipeline :: Ord tag =>
     -- | SIMT configuration options
     SIMTPipelineConfig tag
     -- | SIMT pipeline inputs
  -> SIMTPipelineIns
     -- | SIMT pipeline outputs
  -> Module SIMTPipelineOuts
makeSIMTPipeline c inputs =
  -- Lift some parameters to the type level
  liftNat (c.logNumWarps) \(_ :: Proxy t_logWarps) ->
  liftNat (c.executeStage.length) \(_ :: Proxy t_warpSize) ->
  liftNat (c.logMaxCallDepth) \(_ :: Proxy t_logMaxCallDepth) ->
  liftNat (c.instrMemLogNumInstrs) \(_ :: Proxy t_logInstrs) -> do

    -- Sanity check
    staticAssert (c.logNumWarps <= valueOf @InstrIdWidth)
      "makeSIMTPipeline: WarpId is wider than InstrId"

    -- Number of warps and warp size
    let numWarps = 2 ^ c.logNumWarps
    let warpSize = c.executeStage.length

    -- Compute field selector functions from decode table
    let selMap = matchSel (c.decodeStage)

    -- Functions for extracting register ids from an instruction
    let srcA :: Instr -> RegId = getFieldSel selMap "rs1"
    let srcB :: Instr -> RegId = getFieldSel selMap "rs2"
    let dst  :: Instr -> RegId = getFieldSel selMap "rd"

    -- Queue of active warps
    warpQueue :: Queue (Bit t_logWarps) <- makeSizedQueue (c.logNumWarps)

    -- One block RAM of thread states per lane
    stateMems ::  [RAM (Bit t_logWarps)
                       (SIMTThreadState t_logInstrs t_logMaxCallDepth) ] <-
      replicateM warpSize makeDualRAM

    -- Instruction memory
    instrMem :: RAM (Bit t_logInstrs) Instr <-
      makeDualRAMCore (c.instrMemInitFile)

    -- Suspension bit for each thread
    suspBits :: [[Reg (Bit 1)]] <-
      replicateM warpSize (replicateM numWarps (makeReg false))

    -- Register files
    regFilesA :: [RAM (Bit t_logWarps, RegId) (Bit 32)] <-
      replicateM warpSize makeDualRAM
    regFilesB :: [RAM (Bit t_logWarps, RegId) (Bit 32)] <-
      replicateM warpSize makeDualRAM

    -- Trigger for each stage
    go1 :: Reg (Bit 1) <- makeDReg false
    go2 :: Reg (Bit 1) <- makeDReg false
    go3 :: Reg (Bit 1) <- makeDReg false
    go4 :: Reg (Bit 1) <- makeDReg false
    go5 :: Reg (Bit 1) <- makeDReg false

    -- Warp id register, for each stage
    warpId1 :: Reg (Bit t_logWarps) <- makeReg dontCare
    warpId2 :: Reg (Bit t_logWarps) <- makeReg dontCare
    warpId3 :: Reg (Bit t_logWarps) <- makeReg dontCare
    warpId4 :: Reg (Bit t_logWarps) <- makeReg dontCare
    warpId5 :: Reg (Bit t_logWarps) <- makeReg dontCare

    -- Call depth register, for each stage
    state2 :: Reg (SIMTThreadState t_logInstrs t_logMaxCallDepth) <-
      makeReg dontCare
    state3 :: Reg (SIMTThreadState t_logInstrs t_logMaxCallDepth) <-
      makeReg dontCare
    state4 :: Reg (SIMTThreadState t_logInstrs t_logMaxCallDepth) <-
      makeReg dontCare
    state5 :: Reg (SIMTThreadState t_logInstrs t_logMaxCallDepth) <-
      makeReg dontCare

    -- Active thread mask
    activeMask3 :: Reg (Bit t_warpSize) <- makeReg dontCare
    activeMask4 :: Reg (Bit t_warpSize) <- makeReg dontCare
    activeMask5 :: Reg (Bit t_warpSize) <- makeReg dontCare

    -- Instruction register for each stage
    instr4 :: Reg (Bit 32) <- makeReg dontCare
    instr5 :: Reg (Bit 32) <- makeReg dontCare

    -- Is any thread in the current warp suspended?
    isSusp4 :: Reg (Bit 1) <- makeReg dontCare
    isSusp5 :: Reg (Bit 1) <- makeReg dontCare

    -- Kernel response queue (indicates to CPU when kernel has finished)
    kernelRespQueue :: Queue SIMTResp <- makeShiftQueue 1

    -- Pipeline Initialisation
    -- =======================

    -- Register to trigger pipeline initialisation at some PC
    startReg :: Reg (Option (Bit t_logInstrs)) <- makeReg none

    -- Warp id counter, to initialise PC of each thread
    warpIdCounter :: Reg (Bit t_logWarps) <- makeReg 0

    -- Is the pipeline active?
    pipelineActive :: Reg (Bit 1) <- makeReg false

    always do
      -- When start register is valid, perform initialisation
      when (startReg.val.isSome .&. kernelRespQueue.notFull) do
        -- Write PC to each thread of warp
        let initState =
              SIMTThreadState {
                simtPC = startReg.val.val
              , simtCallDepth = ones
              }
        sequence_ [ store stateMem (warpIdCounter.val) initState
                  | stateMem <- stateMems ]
        warpIdCounter <== warpIdCounter.val + 1

        -- Insert into warp queue
        dynamicAssert (warpQueue.notFull)
          "SIMT warp queue overflow during initialisation"
        enq warpQueue (warpIdCounter.val)

        -- Finish initialisation and activate pipeline
        when (warpIdCounter.val .==. ones) do
          startReg <== none
          pipelineActive <== true

    -- Stage 0: Warp Scheduling
    -- ========================

    always do
      -- Load state for next warp on each lane
      forM_ stateMems \stateMem -> do
        load stateMem (warpQueue.first)

      -- Buffer warp id for stage 1
      warpId1 <== warpQueue.first

      -- Trigger stage 1
      when (warpQueue.canDeq .&. pipelineActive.val) do
        warpQueue.deq
        go1 <== true

    -- Stage 1: Active Thread Selection
    -- ================================

    always do
      -- Active threads are those with the max call depth, and on a
      -- tie, the min PC
      let packState s = s.simtCallDepth # s.simtPC
      let minOf a b = if packState a .<. packState b then a else b
      state2 <== tree1 minOf [mem.out | mem <- stateMems]

      -- Trigger stage 2
      warpId2 <== warpId1.val
      go2 <== go1.val

    -- Stage 2: Instruction Fetch
    -- ==========================

    always do
      -- Compute active thread mask
      let activeList = [m.out.old === state2.val | m <- stateMems]
      let activeMask :: Bit t_warpSize = fromBitList activeList
      activeMask3 <== activeMask

      -- Assert that at least one thread in the warp must be active
      dynamicAssert (activeList.orList)
        "SIMT pipeline error: no active threads in warp"

      -- Issue load to instruction memory
      load instrMem (state2.val.simtPC)

      -- Trigger stage 3
      warpId3 <== warpId2.val
      state3 <== state2.val
      go3 <== go2.val

    -- Stage 3: Operand Fetch
    -- ======================

    always do
      -- Fetch operands from each register file
      forM_ (zip regFilesA regFilesB) \(rfA, rfB) -> do
        load rfA (warpId3.val, instrMem.out.srcA)
        load rfB (warpId3.val, instrMem.out.srcB)

      -- Is any thread in warp suspended?
      -- (In future, consider only suspension bits of active threads)
      isSusp4 <== orList [map val regs ! warpId3.val | regs <- suspBits]

      -- Trigger stage 4
      warpId4 <== warpId3.val
      activeMask4 <== activeMask3.val
      instr4 <== instrMem.out
      state4 <== state3.val
      go4 <== go3.val

    -- Stage 4: Operand Latch
    -- ======================

    -- Decode instruction
    let (tagMap4, fieldMap4) = matchMap False (c.decodeStage) (instr4.val)

    -- Choose register B or immediate
    let getRegBOrImm regB =
          if Map.member "imm" fieldMap4
            then let imm = getField fieldMap4 "imm"
                 in  imm.valid ? (imm.val, regB)
            else regB

    always do
      -- Trigger stage 5
      isSusp5 <== isSusp4.val
      warpId5 <== warpId4.val
      activeMask5 <== activeMask4.val
      instr5 <== instr4.val
      state5 <== state4.val
      go5 <== go4.val

    -- Stages 5 and 6: Execute and Writeback
    -- =====================================

    -- Track how many warps have terminated
    completedWarps :: Reg (Bit t_logWarps) <- makeReg 0

    -- Track kernel success/failure
    kernelSuccess :: Reg (Bit 1) <- makeReg true

    -- Functions to convert between 32-bit PC and instruction address
    let fromPC :: Bit 32 -> Bit t_logInstrs =
          \pc -> truncateCast (slice @31 @2 pc)
    let toPC :: Bit t_logInstrs -> Bit 32 =
          \addr -> zeroExtendCast addr # (0 :: Bit 2)

    -- Buffer the decode tables
    let tagMap5 = Map.map buffer tagMap4

    -- Insert warp id back into warp queue, except on warp termination
    always do
      when (go5.val) do
        if inputs.simtWarpTerminatedWire.active
          then do
            -- We assume that a warp only terminates when it has converged
            dynamicAssert (activeMask5.val .==. ones)
              "SIMT pipeline: terminating warp that hasn't converged"
            completedWarps <== completedWarps.val + 1
            -- Have all warps have terminated?
            if completedWarps.val .==. ones
              then do
                -- Issue kernel response to CPU
                dynamicAssert (kernelRespQueue.notFull)
                  "SIMT pipeline: can't issue kernel response"
                enq kernelRespQueue (kernelSuccess.val)
                -- Re-enter initial state
                pipelineActive <== false
                kernelSuccess <== true
              else do
                kernelSuccess <== kernelSuccess.val .&.
                  inputs.simtWarpTerminatedWire.val
          else do
            dynamicAssert (warpQueue.notFull) "SIMT warp queue overflow"
            enq warpQueue (warpId5.val)

    -- Vector lane definition
    let makeLane makeExecStage threadActive suspMask regFileA
                 regFileB stateMem incCallDepth decCallDepth = do

          -- Per lane interfacing
          pcNextWire :: Wire (Bit t_logInstrs) <-
            makeWire (state5.val.simtPC + 1)
          retryWire  :: Wire (Bit 1) <- makeWire false
          suspWire   :: Wire (Bit 1) <- makeWire false
          resultWire :: Wire (Bit 32) <- makeWire dontCare

          -- Instantiate execute stage
          execStage <- makeExecStage
            State {
              instr = instr5.val
            , opA = regFileA.out.old
            , opB = regFileB.out.old
            , opBorImm = regFileB.out.getRegBOrImm.old
            , pc = ReadWrite (state5.val.simtPC.toPC) \writeVal -> do
                     pcNextWire <== writeVal.fromPC
            , result = WriteOnly \writeVal ->
                         when (instr5.val.dst .!=. 0) do
                           resultWire <== writeVal
            , suspend = do
                suspWire <== true
                return
                  InstrInfo {
                    instrId = warpId5.val.zeroExtendCast
                  , instrDest = instr5.val.dst
                  }
            , retry = retryWire <== true
            , opcode = packTagMap tagMap5
            }

          always do
            -- Execute stage
            when (go5.val .&. threadActive .&. isSusp5.val.inv) do
              -- Trigger execute stage
              execStage.execute

              -- Only update PC if not retrying
              when (retryWire.val.inv) do
                -- Compute new call depth increment
                let inc = incCallDepth.zeroExtendCast
                let dec = decCallDepth.zeroExtendCast
                dynamicAssert (state5.val.simtCallDepth .!=. 0)
                  "SIMT pipeliene: call depth overflow"
                -- Update thread state
                store stateMem (warpId5.val)
                  SIMTThreadState {
                      simtPC = pcNextWire.val
                      -- Remember, lower is deeper
                    , simtCallDepth = (state5.val.simtCallDepth - inc) + dec
                    }

              -- Update suspension bits
              when (suspWire.val) do
                suspMask!(warpId5.val) <== true

            -- Writeback stage
            if resultWire.active.old
              then do
                let idx = (warpId5.val.old, instr5.val.dst.old)
                let value = resultWire.val.old
                store regFileA idx value
                store regFileB idx value
              else do
                -- Thread resumption
                when (execStage.resumeReqs.canPeek) do
                  let req = execStage.resumeReqs.peek
                  let idx = (req.resumeReqInfo.instrId.truncateCast,
                             req.resumeReqInfo.instrDest)
                  when (req.resumeReqInfo.instrDest .!=. 0) do
                    store regFileA idx (req.resumeReqData)
                    store regFileB idx (req.resumeReqData)
                  suspMask!(req.resumeReqInfo.instrId) <== false
                  execStage.resumeReqs.consume

    -- Create vector lanes
    sequence $ getZipList $
      makeLane <$> ZipList (c.executeStage)
               <*> ZipList (activeMask5.val.toBitList)
               <*> ZipList suspBits
               <*> ZipList regFilesA
               <*> ZipList regFilesB
               <*> ZipList stateMems
               <*> ZipList (inputs.simtIncCallDepth)
               <*> ZipList (inputs.simtDecCallDepth)

    -- Handle management requests
    -- ==========================

    -- Address of kernel code ptr and args, as set by CPU
    kernelAddrReg :: Reg (Bit 32) <- makeReg dontCare

    always do
      when (inputs.simtMgmtReqs.canPeek) do
        let req = inputs.simtMgmtReqs.peek
        -- Is pipeline busy?
        let busy = startReg.val.isSome .|. pipelineActive.val
        -- Write instruction
        when (req.simtReqCmd .==. simtCmd_WriteInstr) do
          dynamicAssert (busy.inv)
            "SIMT pipeline: writing instruction while pipeline busy"
          store instrMem (req.simtReqAddr.fromPC) (req.simtReqData)
          inputs.simtMgmtReqs.consume
        -- Start pipeline
        when (req.simtReqCmd .==. simtCmd_StartPipeline) do
          when (busy.inv) do
            startReg <== some (req.simtReqAddr.fromPC)
            kernelAddrReg <== req.simtReqData
            inputs.simtMgmtReqs.consume

    -- Pipeline outputs
    return
      SIMTPipelineOuts {
        simtMgmtResps = kernelRespQueue.toStream
      , simtCurrentWarpId = warpId5.val.zeroExtendCast
      , simtKernelAddr = kernelAddrReg.val
      }