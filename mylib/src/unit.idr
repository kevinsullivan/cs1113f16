||| Abstract data type simulating algebra with one value
||| and the identity function.
module unit

import public bool

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
unit_eq: Unit -> Unit -> Bool
unit_eq u1 u2 = True
