module command

import variable
import expr
import nat
import bool
import state
import ifthenelse

export
data Command =
  Skip |
  AssignBool (Variable Bool) Bool |
  AssignNat (Variable Nat) Nat |
  Seq Command Command |
  Cond BoolExpr Command Command |
  While BoolExpr Command

commandEval: State -> Command -> State
commandEval st Skip = st
commandEval st (AssignBool var val) =
  override_bool st var val
commandEval st (AssignNat var val) =
  override_nat st var val
commandEval st (Seq c1 c2) =
  commandEval (commandEval st c1) c2
commandEval st (Cond b t f) =
  ifthenelse
    (boolExprEval b st)
    (commandEval st t)
    (commandEval st f)
