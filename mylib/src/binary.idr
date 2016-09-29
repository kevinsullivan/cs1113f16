||| A library of functions for binary arithmetic
||| In particular, this module implements half and
||| full adder functions.
module binary

{-
We use byte to return the two-bit result of a one-bit addition.
-}
import byte2

||| Implementation of a half-adder!
export
half_adder: Bit -> Bit -> Byte2
half_adder b1 b0 =
  byte2_new
    (bit_carry b1 b0)
    (bit_plus b1 b0)


||| A full adder
export
full_adder: Bit -> Bit -> Bit -> Byte2
full_adder b1 b2 cin =
  byte2_new
    (bit_carry3 b1 b2 cin)
    (bit_plus3 b1 b2 cin)


{-
-- We'll come back and fix this later
||| Two byte addition
export
byte2_plus: Byte2 -> Byte2 -> Byte2
byte2_plus b1 b0 =
  (byte2_new
    (bit_plus3 b11 b10 (bit_carry b00 b01))
    (bit_plus b00 b01))
-}
