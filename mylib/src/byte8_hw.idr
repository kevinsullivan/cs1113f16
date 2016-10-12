||| Abstract data type representing two-bit byte
module byte8

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
data Byte8 =
  ||| Constructor that boxes four Bit values into a Byte8 value
  MkByte8 Bit Bit Bit Bit Bit Bit Bit Bit


||| Pack four bits into, and return, a byte (a 8-tuple of bits)
export
byte8_new: Bit -> Bit -> Bit -> Bit -> Bit -> Bit -> Bit -> Bit -> Byte8
byte8_new b7 b6 b5 b4 b3 b2 b1 b0 = ?byte8_new_hole


-- Constant byte8 values filled with zeros and ones, resp.

export
byte8_zeros: Byte8
byte8_zeros = ?byte8_zeros_hole


export
byte8_ones: Byte8
byte8_ones = ?byte8_ones_hole

-- Projection functions, returning particular component bits

||| Return Bit 0
export
byte8_bit0: Byte8 -> Bit
byte8_bit0 (MkByte8 b7 b6 b5 b4 b3 b2 b1 b0) = b0

||| Return Bit 1
export
byte8_bit1: Byte8 -> Bit
byte8_bit1 (MkByte8 b7 b6 b5 b4 b3 b2 b1 b0) = b1

||| Return Bit 2
export
byte8_bit2: Byte8 -> Bit
byte8_bit2 (MkByte8 b7 b6 b5 b4 b3 b2 b1 b0) = b2

||| Return Bit 3
export
byte8_bit3: Byte8 -> Bit
byte8_bit3 (MkByte8 b7 b6 b5 b4 b3 b2 b1 b0) = b3


||| Return Bit 3
export
byte8_bit4: Byte8 -> Bit
byte8_bit4 (MkByte8 b7 b6 b5 b4 b3 b2 b1 b0) = b4


||| Return Bit 3
export
byte8_bit5: Byte8 -> Bit
byte8_bit5 (MkByte8 b7 b6 b5 b4 b3 b2 b1 b0) = b5


||| Return Bit 3
export
byte8_bit6: Byte8 -> Bit
byte8_bit6 (MkByte8 b7 b6 b5 b4 b3 b2 b1 b0) = b6


||| Return Bit 3
export
byte8_bit7: Byte8 -> Bit
byte8_bit7 (MkByte8 b7 b6 b5 b4 b3 b2 b1 b0) = b7


-- arithmetic functions on 8-bit bytes

-- natural numbers we'll need
nat_four: Nat
nat_four = nat_succ nat_three

nat_five: Nat
nat_five = nat_succ nat_four

nat_six: Nat
nat_six = nat_succ nat_five

nat_seven: Nat
nat_seven = nat_succ nat_six

||| Return the indexed bit of the given byte or B0 if the index is out of range
export
byte8_sub: Nat -> Byte8 -> Bit
byte8_sub index aByte8 = ?byte8_sub_hole


||| Return the carry bit in the indexed column when adding the two bytes
||| or the zero bit (B0) if the index is out of range
carry_sub8: Nat -> Byte8 -> Byte8 -> Bit
carry_sub8 n b1 b0 = ?carry_sub8_hole


||| Return the indexed bit of the sum of the given bytes
sum_sub8: Nat -> Byte8 -> Byte8 -> Bit
sum_sub8 n b1 b0 = ?sub_sub8_hole


||| Return the sum of two 8-bit bytes as a 8-bit byte ignoring overflows
export
byte8_plus: Byte8 -> Byte8 -> Byte8
byte8_plus b0 b1 = ?byte8_plus_hole


-- a little test case
n: Byte8
n = byte8_plus byte8_ones byte8_ones
-- expect 11111110
