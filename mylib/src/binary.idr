||| A library of functions for binary arithmetic
module binary

import bit
import byte2

||| Compute the sum bit of two bits
-- Notice that we're forgetting to say "representation of ..."
export
bit_plus: Bit -> Bit -> Bit
bit_plus (MkBit b1) (MkBit b2) =
              MkBit (bool_xor b1 b2)
-- Note that this library "knows about" the internal
-- representation of Bit. You can see it used here!

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

{-
What we've implemented here is what, in the
field of "computer architecture" is called a
half-adder. Claude Shannon's incredible insight
(which he expressed in his Master's thesis, was
that you could represent bits as high and low
voltages, and Boolean operations as combinations
of power sources and swiches. Voila, you have
entered the world of "digital computers." The
digits of course are binary!
-}

-- Let's do a few exercises adding binary numerals
-- In general you need sum & carry of *three* bits


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


||| Implement a full adder!
export
full_adder: Bit -> Bit -> Bit -> Byte2
full_adder b1 b2 cin =
  MkByte2
    (bit_carry3 b1 b2 cin)
    (bit_plus3 b1 b2 cin)
