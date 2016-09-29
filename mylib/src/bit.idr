||| Abstract data type representing binary arithmetic
module bit

-- Client of this module will need bool as well
import bool

{-
Where's a bit is considered an essential part of a byte
(thus "aggregation"), we consider a bool an inessential
detail in the implementation of bit. We use import bool
rather than import public bool because our clients should
not even need to know that this module is implemented in
part using bool. Therefore, while we must export the Bit
type, we hide the constructor, because using it requires a
bool, and we don't want our clients to know that. Instead,
we export two abstract bit values, B0 and B1. Modules that
import this one can use B0 and B1 as the two values of type
Bit. The fact that they are implemented as bools remains a
secret of this module. Thus "abstraction."
-}

export
data Bit =
  ||| Construct a term of type Bit by "boxing up" a Bool
  MkBit Bool


||| Represents constant bit value 0
export
B0: Bit
B0 = MkBit False


||| Represents constant bit value 1
export
B1: Bit
B1 = MkBit True

||| Return the concrete representation (unbox and return the Bool)
||| This function mainly just illustrates destructuring of a bit to
||| get at -- and return -- the underlying bit representation. 
bit_rep: Bit -> Bool
bit_rep (MkBit b) = b
