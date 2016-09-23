||| A library of functions for binary arithmetic
module binary

import bool   --
import bit
import byte2

||| Compute the sum bit of two bits
public export
bit_plus: Bit -> Bit -> Bit
bit_plus (MkBit b1) (MkBit b2) =
              MkBit (bool_xor b1 b2)
-- Note that this library "knows about" the internal
-- representation of Bit. You can see it used here!

||| Compute the carry bit of two bits
public export
bit_carry: Bit -> Bit -> Bit
bit_carry (MkBit b1) (MkBit b2) =
            MkBit (bool_and b1 b2)

||| Implementation of a half-adder!
public export
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

-- In general you need sum & carry of three bits



||| Compute the sum bit of three bits
bit_plus3: Bit -> Bit -> Bit -> Bit
bit_plus3 (MkBit b1) (MkBit b2) (MkBit cin) =
  MkBit (bool_xor
          (bool_xor b1 b2)
          cin)

-- Here are the steps in a top-down functional decomposition (refinement)
{-
  ?aBit1
-}
{-
  MkBit ?aBool1
-}
{-
  MkBit (bool_xor ?aBit1 ?aBit2)
-}
{-
  MkBit (bool_xor (bool_xor b1 b2) cin)
-}

||| Compute the carry bit of three bits
bit_carry3: Bit -> Bit -> Bit -> Bit
bit_carry3 (MkBit b1) (MkBit b2) (MkBit cin) =
  MkBit (bool_or
          (bool_and
            cin
            (bool_xor b1 b2))
          (bool_and
            b1
            b2))

-- Here are the steps in a top-down functional decomposition (refinement)
{-
  ?ABit3
-}
{-
  MkBit ?aBool2
-}
{-
  MkBit (bool_or ?aBool3 ?aBool4)
-}
{-
  MkBit (bool_or
          (bool_and ?aBit4 ?aBit5)
          (bool_and ?aBit6 ?aBit7)))
-}
{-
  MkBit (bool_or
          (bool_and cin (bool_xor b1 b2)
          (bool_and b1 b2)))
-}

||| Implement a full adder!
export
full_adder: Bit -> Bit -> Bit -> Byte2
full_adder b1 b2 cin =
  MkByte2
    (bit_carry3 b1 b2 cin)
    (bit_plus3 b1 b2 cin)

-- Here are the steps in a top-down functional decomposition (refinement)
{-
  ?AByte2a
-}
{-
  MkByte2 ?aBit8 ?aBit9
-}
{-
  MkByte2 (bit_carry3 b1 b2 cin) (bit_plus3 b1 b2 cin)
-}
