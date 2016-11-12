module variable

import nat
import bool
import ifthenelse
import public eq

-----------------------------------------------------
----------------- Variables -------------------------
-----------------------------------------------------


||| We first define a simple abstract data type the
||| values of which are "variables capable of having
||| associated values of type t."" We make the Variable
||| type public but make the constructor private to this
||| module.
export
data Variable t = MkVariable Nat


||| A public function that returns a variable
||| given its type (implicit) and index. This is the
||| public funtion that clients of this module can
||| use to obtain Variables, as the MkVariable
||| constructor is private to this module.
export
variable_new: { t: Type } -> Nat -> Variable t
variable_new n = MkVariable n


-- simple demonstration
v: Variable Bool
v = variable_new nat_zero


||| Equality for variables: True if two variables of a give
||| type are equal. They are "iff" their numeric "indexes"
||| are equal.
export
var_eq: {t: Type} -> Variable t -> Variable t -> Bool
var_eq (MkVariable n1) (MkVariable n2) = nat_eq n1 n2


||| Overload eq for Variables
public export
implementation Eq (Variable t) where
  eq v1 v2 = var_eq v1 v2
  neq v1 v2 = bool_not (eq v1 v2)
