module Pebbles.Instructions.Mnemonics where

-- Blarney imports
import Blarney

-- Pebbles imports
import Pebbles.Pipeline.Interface

data Mnemonic =
    -- I extension
    LUI
  | AUIPC
  | ADD
  | SLT
  | SLTU
  | AND
  | OR
  | XOR
  | SLL
  | SRL
  | SRA
  | SUB
  | JAL
  | JALR
  | BEQ
  | BNE
  | BLT
  | BLTU
  | BGE
  | BGEU
  | LOAD
  | STORE
  | FENCE
  | ECALL
  | EBREAK
  | CSRRW
  | CSRRS
  | CSRRC

    -- M extension
  | MUL
  | DIV

    -- A extension
  | AMO

    -- F extension
  | FADD
  | FSUB
  | FMUL
  | FDIV
  | FMIN
  | FMAX
  | FSQRT
  | FCVT_W_S     -- Float to signed int
  | FCVT_WU_S    -- Float to unsigned int
  | FCVT_S_W     -- Signed int to float
  | FCVT_S_WU    -- Unsigned int to float
  | FEQ
  | FLT
  | FLE
  | FSGNJ_S
  | FSGNJN_S
  | FSGNJX_S

    -- CHERI extension
  | CGetPerm
  | CGetType
  | CGetBase
  | CGetLen
  | CGetTag
  | CGetSealed
  | CGetFlags
  | CGetAddr
  | CAndPerm
  | CSetFlags
  | CSetAddr
  | CIncOffset
  | CClearTag
  | CSetBounds
  | CSetBoundsImm
  | CSetBoundsExact
  | CSub
  | CMove
  | CJALR
  | CSpecialRW
  | CSealEntry
  | AUIPCC
  | CRRL
  | CRAM

    -- Custom extension (Cache Management)
  | CACHE_FLUSH_LINE

    -- Custom extension (SIMT convergence)
  | SIMT_PUSH
  | SIMT_POP

  deriving (Bounded, Enum, Show, Ord, Eq)

-- | Function for checking if any of the given mnemonics are active
infix 8 `is`
is :: MnemonicVec -> [Mnemonic] -> Bit 1
is vec ms = orList [unsafeAt (fromEnum m) vec | m <- ms]
