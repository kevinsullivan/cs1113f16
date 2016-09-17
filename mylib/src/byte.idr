module byte

{-
A byte is a tuple of bits. Users of the
Byte type will need to have access to the
definitions for the Bit type. We add the
keyword "public" to the import of the bit
module to tell Idris to export them to accordingly
users of the byte module.
-}
import public bit

{-
We define a byte as a tuple of two bits
tagged by the MkByte constructor. We will
refer to the right bit as "bit zero" and
the left bit as "bit one." We also call them
the "low order" (b0, right) and "high-order"
bit (b1, left).
-}
public export
data Byte = MkByte Bit Bit

{-
Now we meet a very important idea: a pattern
can "pull apart a term/value and bind names to
its parts." The next two functions use this idea
to pull apart a byte, revealing its constitutent
bits, in order to return its bit zero and bit one
components. We call such a function a "projection
function," an "accessor," or an "inspector."
-}
public export
byte_b0: Byte -> Bit
byte_b0 (MkByte b1 b0) = b0

public export
byte_b1: Byte -> Bit
byte_b1 (MkByte b1 b0) = b1

{-
And now for the first time we see a function
that takes arguments of one type, here Bit, and
that returns values of another type, here Byte.
A byte in this example is a tuple of just two
bits. Bytes on your laptop are tuples of 8 bits.
And tuples of 8 such 8-bit bytes constitute what
we call a word. This is what makes your machine
a so-called 64-bit computer.
-}

public export
byte_bit_plus: Bit -> Bit -> Byte
byte_bit_plus b1 b0 =
  MkByte
    (bit_carry b1 b0)
    (bit_plus b1 b0)

-- End of first increment, along with Bit
