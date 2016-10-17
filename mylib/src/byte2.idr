||| Abstract data type representing two-bit byte
module byte2

{-
A byte aggregates several bits into a tuple of bits.
The bits are essential, thus visible, parts of a byte.
Note that this is a comment. You cannot attach inline
documentation to an import directive.
-}
import public bit
import public bool

||| A two-bit byte type; constructor is private
export
data Byte2 =
  ||| Constructor that boxes two Bit values into a Byte2 value
  MkByte2 Bit Bit


||| Provide a function that packs two bits into and returns a byte
export
byte2_new: Bit -> Bit -> Byte2
byte2_new b1 b0 = MkByte2 b1 b0


||| Projection function returning low-order bit of a Byte2
export
byte2_b0: Byte2 -> Bit
byte2_b0 (MkByte2 b1 b0) = b0


||| Projection function returning high-order bit of a Byte2
export
byte2_b1: Byte2 -> Bit
byte2_b1 (MkByte2 b1 b0) = b1

||| 2-bit byte equality
byte2_eq: Byte2 -> Byte2 -> Bool
byte2_eq (MkByte2 bit11 bit10) (MkByte2 bit01 bit00) =
  bool_and (bit_eq bit11 bit01) (bit_eq bit10 bit00)
