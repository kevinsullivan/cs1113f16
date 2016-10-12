||| Abstract data type representing two-bit byte
module byte4

{-
A byte aggregates several bits into a tuple of bits.
The bits are essential, thus visible, parts of a byte.
Note that this is a comment. You cannot attach inline
documentation to an import directive.
-}
import public bit
import public nat
import ifthenelse

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
          (bit_carry3
            B0
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
    (bit_plus3
      B0
      b10
      b00)

-- A better implementation

||| Return the indexed bit of the given byte or B0 if the index is out of range
export
byte4_sub: Nat -> Byte4 -> Bit
byte4_sub index aByte4 =
  ifthenelse
    (nat_eq index nat_zero)
    (byte4_bit0 aByte4)
    (ifthenelse
      (nat_eq index nat_one)
      (byte4_bit1 aByte4)
      (ifthenelse
        (nat_eq index nat_two)
        (byte4_bit2 aByte4)
        (ifthenelse
          (nat_eq index nat_three)
          (byte4_bit3 aByte4)
          (B0))))


||| Return the carry bit in the indexed column when adding the two bytes
||| or the zero bit (B0) if the index is out of range
carry_sub: Nat -> Byte4 -> Byte4 -> Bit
carry_sub n b1 b0 =
  ifthenelse
    (nat_eq n nat_zero)
    (B0)
    (bit_carry3
     (carry_sub (nat_pred n) b1 b0)
     (byte4_sub (nat_pred n) b1)
     (byte4_sub (nat_pred n) b0))


||| Return the indexed bit of the sum of the given bytes
sum_sub: Nat -> Byte4 -> Byte4 -> Bit
sum_sub n b1 b0 =
  bit_plus3
    (carry_sub n b1 b0)
    (byte4_sub n b1)
    (byte4_sub n b0)


||| Return the sum of two 4-bit bytes as a 4-bit byte ignoring overflows
export
byte4_plus': Byte4 -> Byte4 -> Byte4
byte4_plus' b0 b1 =
  byte4_new
    (sum_sub nat_three b1 b0)
    (sum_sub nat_two   b1 b0)
    (sum_sub nat_one   b1 b0)
    (sum_sub nat_zero  b1 b0)


-- a little test case
n: Byte4
n = byte4_plus' byte4_ones byte4_ones
-- expect 1110
