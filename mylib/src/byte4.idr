||| Abstract data type representing two-bit byte
module byte4

{-
A byte aggregates several bits into a tuple of bits.
The bits are essential, thus visible, parts of a byte.
Note that this is a comment. You cannot attach inline
documentation to an import directive.
-}
import public bit

||| A two-bit byte type; constructor is private
export
data Byte4 =
  ||| Constructor that boxes four Bit values into a Byte4 value
  MkByte4 Bit Bit Bit Bit


||| Pack four bits into, and return, a byte (a 4-tuple of bits)
export
byte4_new: Bit -> Bit -> Bit -> Bit -> Byte4
byte4_new b3 b2 b1 b0 = MkByte4 b3 b2 b1 b0


-- Constant byte4 values filled with zeros and ones, resp.

export
byte4_zeros: Byte4
byte4_zeros = byte4_new B0 B0 B0 B0


export
byte4_ones: Byte4
byte4_ones = byte4_new B1 B1 B1 B1

-- Projection functions, returning particular component bits

||| Projection function returning rightmost bit
export
byte4_bit0: Byte4 -> Bit
byte4_bit0 (MkByte4 b3 b2 b1 b0) = b0

||| Projection function returning next bit
export
byte4_bit1: Byte4 -> Bit
byte4_bit1 (MkByte4 b3 b2 b1 b0) = b1

||| Projection function returning next bit
export
byte4_bit2: Byte4 -> Bit
byte4_bit2 (MkByte4 b3 b2 b1 b0) = b2

||| Projection function returning leftmost (high-order) bit
export
byte4_bit3: Byte4 -> Bit
byte4_bit3 (MkByte4 b3 b2 b1 b0) = b3


-- arithmetic functions on 4-bit bytes

||| addition
byte4_plus: Byte4 -> Byte4 -> Byte4
byte4_plus (MkByte4 b13 b12 b11 b10) (MkByte4 b03 b02 b01 b00) =
  MkByte4
    (bit_plus3
      b13
      b03
      (bit_carry3
        b12
        b02
        (bit_carry3
          b11
          b01
          (bit_carry
            b10
            b00))))
    (bit_plus3
      b12
      b02
      (bit_carry3
        b11
        b01
        (bit_carry
          b10
          b00)))
    (bit_plus3
      b11
      b01
      (bit_carry
        b10
        b00))
    (bit_plus
      b10
      b00)
