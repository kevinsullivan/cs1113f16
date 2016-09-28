||| Abstract data type simulating algebra with one value
||| and the identity function.
module unit

export
data Unit =
  ||| The single term of type Unit
  MkUnit

||| The identity function on type Unit
export
unit_id: Unit -> Unit
unit_id MkUnit = MkUnit
