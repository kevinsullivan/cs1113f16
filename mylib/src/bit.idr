import bool

{-
In this module we're going to interpret Boolean
values as binary digits, where False represents
zero and True represents one. We'll then see how
we can use what we've learned about Booleans to
represent numbers and to do arithmetic!
-}

{- In order to make our interpretations (that
False represents zero and True represents one)
explicit, we will establish an alias, Bit, for
the type, Bool, and alises B0 and B1 for the
Boolean values, False and True, respectively.
We'll make these aliases visible to clients of
this module.
-}

{-
Now we encounter one of the most
important ideas in all of software
development: We can define new types
whose values are represented by values
of other types. Here we define a Bit
(binary digit) type, whose values
represent zero and one as False and
True.
-}
public export
data Bit = MkBit Bool

{-
MkBit is analogous to MkUnit, True,
and False, but in this case, this
"value constructor" for the Bit type
takes an argument, namely one of type
Bool. The result of applying MkBit to
a Bool value is an Idris term (value)
comprising the constructor name and
the given value. The two values of
this type are thus "MkBit True" (which
we interpret as representing one) and
"MkBit False" (representing zero). We
use Boolean values to represent bits
so that we can use Boolean functions
to represent (or "implement") functions
of binary arithmetic! There's a close
connection!
-}

{-
Given a value of type Bit we can get
at its underlying representation (in
this case a value of type Bool) by
"destructuring" the Bit during pattern
matching. Check it out.
-}

bit_rep: Bit -> Bool
bit_rep (MkBit b) = b

{-
For convenience, we define two "constant"
values, B0 and B1, available to any code
that imports this module. We think of B0
as the binary digit 0 and B1 as 1.
-}
public export
B0: Bit
B0 = MkBit False

public export
B1: Bit
B1 = MkBit True

{-
We've now got representations of the binary
digits, zero and one. So let's talk about
addition. Here's a simple table:

bit_add B0 B0 = B0
bit_add B0 B1 = B1
bit_add B1 B0 = B1
bit_add B1 B1 = B0

Note well: The last line says 1 + 1 = 0, and
that is a true statement in arithmetic mod 2!

Now the big question: What operation of Boolean
algebra does binary digit addition resemble?
-}

{-
public export
bit_plus: Bit -> Bit -> Bit
bit_plus (MkBit b1) (MkBit b2) =
            MkBit (bool_xor b1 b2)

public export
bit_carry: Bit -> Bit -> Bit
bit_carry (MkBit b1) (MkBit b2) =
            MkBit (bool_and b1 b2)
-}
