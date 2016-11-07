module variable

import nat
import bool
import ifthenelse
import public eq

-----------------------------------------------------
----------------- Variables -------------------------
-----------------------------------------------------


||| A type the values of which are "variables.
||| Variables are distinguished from each other by
||| an additional natural number argument. We will
||| call that value an index. The set of values of
||| this type is thus "indexed" by values of type
||| Nat.
export
data Variable = MkVariable Nat


||| A public function that returns a variable
||| given its index. This is the public interface
||| that clients of this module can use to obtain
||| Variables.
export
variable_new: Nat -> Variable
variable_new n = MkVariable n


||| Variables are equal iff their indices are equal.
export
var_eq: Variable -> Variable -> Bool
var_eq (MkVariable n1) (MkVariable n2) = nat_eq n1 n2


||| Overload eq for Variables
public export
implementation Eq Variable where
  eq v1 v2 = var_eq v1 v2
  neq v1 v2 = bool_not (eq v1 v2)
