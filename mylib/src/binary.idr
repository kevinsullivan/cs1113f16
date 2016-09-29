||| A library of functions for binary arithmetic
||| In particular, this module implements half and
||| full adder functions.
module binary

{-
We use byte to return the two-bit result of a one-bit addition.
-}
import byte2

||| Compute the sum bit of two bits
export
bit_plus: Bit -> Bit -> Bit
bit_plus (MkBit b1) (MkBit b2) =
              MkBit (bool_xor b1 b2)


||| Compute the carry bit of two bits
export
bit_carry: Bit -> Bit -> Bit
bit_carry (MkBit b1) (MkBit b2) =
            MkBit (bool_and b1 b2)


||| Implementation of a half-adder!
export
half_adder: Bit -> Bit -> Byte2
half_adder b1 b0 =
  MkByte2
    (bit_carry b1 b0)
    (bit_plus b1 b0)


||| Compute the sum bit of three bits
bit_plus3: Bit -> Bit -> Bit -> Bit
bit_plus3 (MkBit b1) (MkBit b2) (MkBit cin) =
  MkBit (bool_xor (bool_xor b1 b2) cin)


||| Compute the carry bit of three bits
bit_carry3: Bit -> Bit -> Bit -> Bit
bit_carry3 (MkBit b1) (MkBit b2) (MkBit cin) =
  MkBit (bool_or
          (bool_and (bool_xor b1 b2) cin)
          (bool_and b1 b2))


||| A full adder
export
full_adder: Bit -> Bit -> Bit -> Byte2
full_adder b1 b2 cin =
  MkByte2
    (bit_carry3 b1 b2 cin)
    (bit_plus3 b1 b2 cin)


||| Two byte addition
export
byte2_plus: Byte2 -> Byte2 -> Byte2
byte2_plus (MkByte2 b11 b10) (MkByte2 b01 b00) =
  (MkByte2
    (bit_plus3 b11 b10 (bit_carry b00 b01))
    (bit_plus b00 b01))
