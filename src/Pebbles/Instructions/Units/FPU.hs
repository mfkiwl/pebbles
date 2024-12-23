module Pebbles.Instructions.Units.FPU
  ( FPUOpcode
  , FPUReq(..)
  , fpuAddSubOp
  , fpuMulOp
  , fpuDivOp
  , fpuSqrtOp
  , fpuMinOp
  , fpuMaxOp
  , fpuToIntOp
  , fpuToUIntOp
  , fpuFromIntOp
  , fpuEQOp
  , fpuLTOp
  , fpuLEOp
  , FPU
  , VecFPU
  , makeVecFPU
  , makeFPU
  ) where

-- Blarney imports
import Blarney
import Blarney.Stmt
import Blarney.Queue
import Blarney.Option
import Blarney.SourceSink
import Blarney.ClientServer
import Blarney.Vector (Vec, toList, fromList)
import Blarney.Vector qualified as V

-- Pebbles imports
import Pebbles.Util.List
import Pebbles.Util.Counter
import Pebbles.Pipeline.Interface

-- Floating-point imports
import FloatingPoint.Prims

-- Haskell imports
import Data.List

-- | FPU request opcode
data FPUOpcode = FPUOpCode { val :: Bit 4 }
  deriving (Generic, Interface, Bits)
fpuAddSubOp  = FPUOpCode 0
fpuMulOp     = FPUOpCode 1
fpuDivOp     = FPUOpCode 2
fpuSqrtOp    = FPUOpCode 3
fpuMinOp     = FPUOpCode 4
fpuMaxOp     = FPUOpCode 5
fpuToIntOp   = FPUOpCode 6
fpuToUIntOp  = FPUOpCode 7
fpuFromIntOp = FPUOpCode 8
fpuEQOp      = FPUOpCode 9
fpuLTOp      = FPUOpCode 10
fpuLEOp      = FPUOpCode 11

-- | FPU request
data FPUReq =
  FPUReq {
    opcode :: FPUOpcode
  , opA :: Bit 32
  , opB :: Bit 32
  , ctrl :: Bit 1
  } deriving (Generic, Interface, Bits)

-- | Scalar FPU interface
type FPU t_id =
  Server (t_id, FPUReq)
         (t_id, ResumeReq)

-- | Vector FPU interface
type VecFPU n t_id =
  Server (t_id, FPUOpcode, Vec n (Option FPUReq))
         (t_id, Vec n (Option ResumeReq))

-- FPU pipeline token
data FPUToken n t_id =
  FPUToken {
    opcode :: FPUOpcode
  , info :: t_id
  , mask :: Bit n
  }
  deriving (Generic, Bits)

-- | Vector FPU
makeVecFPU ::
  forall n t_id. (KnownNat n, Bits t_id) =>
    Bool -> Bool -> Bool -> Module (VecFPU n t_id)
makeVecFPU disableHardBlocks enableDivSqrt inOrder = do
    -- Request queue
    reqQueue :: Queue (t_id, FPUOpcode, Vec n (Option FPUReq)) <-
      makePipelineQueue 1

    -- Response queue (32 elements)
    respQueue :: Queue (t_id, Vec n (Option ResumeReq)) <-
      makeSizedQueue 5

    -- Counter to track the number of inflight requests
    inflightCount :: Counter 5 <- makeCounter 31

    -- Latencies of FPU operations
    let latencies =
          [ if disableHardBlocks then 10 else 3  -- Add/Sub
          , if disableHardBlocks then 9  else 3  -- Mul
          , 32                                   -- Div
          , 16                                   -- Sqrt
          , 1                                    -- Min
          , 1                                    -- Max
          , 3                                    -- ToInt
          , 3                                    -- ToUInt
          , 7                                    -- FromInt
          , 1                                    -- EQ
          , 2                                    -- LT
          , 2                                    -- LE
          ]

    -- Check latencies
    staticAssert (maximum latencies <= 32) "makeVecFPU: latency limit"

    -- Function of each FPU operation
    let funcs :: [FPUReq -> Bit 32] = 
          [ -- Add/Sub (control bit high means sub, else add)
            \req -> fpAddSub (latencies !! 0) req.ctrl req.opA req.opB
            -- Mul
          , \req -> fpMul (latencies !! 1) req.opA req.opB
            -- Div
          , \req -> if enableDivSqrt
                      then fpDiv (latencies !! 2) req.opA req.opB else 0
            -- Sqrt
          , \req -> if enableDivSqrt
                      then fpSqrt (latencies !! 3) req.opA else 0
            -- Min
          , \req -> fpMin (latencies !! 4) req.opA req.opB
            -- Max
          , \req -> fpMax (latencies !! 5) req.opA req.opB
            -- ToInt
          , \req -> fpToInt (latencies !! 6) req.opA
            -- ToUInt
          , \req -> fpToUInt (latencies !! 7) req.opA
            -- FromInt (ctrl bit high means unsigned conversion, else signed)
          , \req -> let ext = if req.ctrl then false else at @31 req.opA in
                      fpFromInt33 (latencies !! 8) (ext # req.opA)
            -- EQ
          , \req -> zeroExtend (fpCompareEq (latencies !! 9) req.opA req.opB)
            -- LT
          , \req -> zeroExtend (fpCompareLT (latencies !! 10) req.opA req.opB)
            -- LE
          , \req -> zeroExtend (fpCompareLTE (latencies !! 11) req.opA req.opB)
          ]

    -- A shift register of FPU tokens.
    -- The value tokens[i] respresents an operation whose result is
    -- available in i clock cycles.
    tokens :: [Reg (Option (FPUToken n t_id))] <-
      replicateM (maximum latencies + 1) (makeReg none)

    -- Outputs of each FPU operation
    let outputs = [V.map f (V.map (.val) reqQueue.first._2) | f <- funcs]

    -- Drain request queue
    always do
      let (info, opcode, vec) = reqQueue.first
      let latency :: Bit 6 = map fromIntegral latencies ! opcode.val

      -- Update shift register, inserting new requests when possible
      canInserts <- sequence
        [ do let canInsert = reqQueue.canDeq
                        .&&. inv inflightCount.isFull
                        .&&. inv next.val.valid
                        .&&. fromIntegral i .==. latency
                        .&&. (if not inOrder then true else 
                               inv $ orList $ map (.val.valid) (drop i tokens))
             if canInsert
               then do
                 token <== some FPUToken {
                                  opcode = opcode
                                , info = info
                                , mask = pack (V.map (.valid) vec)
                                }
               else do
                 token <== next.val
             return canInsert
        | (i, token, next) <- zip3 [1..] tokens (drop 1 tokens) ]

      -- Consume from request queue
      when (orList canInserts) do
        reqQueue.deq
        inflightCount.incrBy 1

    -- Fill response queue
    always do
      let token = (head tokens).val
      when token.valid do
        let output = outputs ! token.val.opcode.val
        let makeResumeReq valid val =
              Option valid
                ResumeReq {
                  resumeReqData = val
                , resumeReqDataTagBit = false
                , resumeReqCap = dontCare
                }
        let resp = (token.val.info,
                      V.zipWith makeResumeReq
                                (unpack token.val.mask) output)
        dynamicAssert respQueue.notFull "FPU response queue overflow"
        respQueue.enq resp

    return
      Server {
        reqs = toSink reqQueue
      , resps =
          Source {
            canPeek = respQueue.canDeq
          , peek = respQueue.first
          , consume = do
              respQueue.deq
              inflightCount.decrBy 1
          }
      }

-- | Single FPU
makeFPU :: Bits t_id => Bool -> Bool -> Bool -> Module (FPU t_id)
makeFPU disableHardBlocks enableDivSqrt inOrder = do
  vecFPU <- makeVecFPU @1 disableHardBlocks enableDivSqrt inOrder
  return
    Server {
      reqs  = mapSink (\(id, req) ->
                          (id, req.opcode, fromList [Option true req]))
                      vecFPU.reqs
    , resps = mapSource (\(id, resp) -> (id, (head (toList resp)).val))
                        vecFPU.resps
    }
