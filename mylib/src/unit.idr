||| Abstract data type simulating algebra with one value
||| and the identity function.
module unit

import public bool
import public eq

||| The type with only one value
export
data Unit =
  ||| The single term of type Unit
  MkUnit

||| Give a non-constructor name to the only value of this type
export
void: Unit
void = MkUnit

||| Ths function simulates the identity function on the Unit type
export
unit_id: Unit -> Unit
unit_id MkUnit = MkUnit


||| Unit equality
export
unit_eq: Unit -> Unit -> Bool
unit_eq u1 u2 = True


||| Implementation of Eq interface for Unit type
export
implementation Eq Unit where
  eq u1 u2 = unit_eq u1 u2
  neq u1 u2 = bool_not (eq u1 u2)
  {-
  eq _ _ = True
  neq _ _ = False
  -}
