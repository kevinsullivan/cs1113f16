||| Abstract data type representing two-bit byte
module byte2

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
data Byte2 =
  ||| Constructor that boxes two Bit values into a Byte2 value
  MkByte2 Bit Bit

{-
Now we see again an important idea: a pattern
can "pull apart a term/value and bind names to
its parts." The next two functions use this idea
to pull apart a byte, revealing its constitutent
bits, in order to return its bit zero and bit one
components. We call such a function a "projection
function," an "accessor," or an "inspector."
-}

||| Projection function returning low-order bit of a Byte2
export
byte2_b0: Byte2 -> Bit
byte2_b0 (MkByte2 b1 b0) = b0

||| Projection function returning high-order bit of a Byte2
export
byte2_b1: Byte2 -> Bit
byte2_b1 (MkByte2 b1 b0) = b1
