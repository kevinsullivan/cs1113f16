module command

import variable
import nat
import expression
import state
import ifthenelse

-----------------------------------------------------
----------------- SYNTAX ----------------------------
-----------------------------------------------------

-- The syntax of a little imperative programming language!
public export
data Command =
  Skip |
  NatAssign (Variable Nat) NatExpr |
  BoolAssign (Variable Bool) BoolExpr |
  Seq Command Command |
  IfThenElse BoolExpr Command Command |   -- Whoa!
  While BoolExpr Command                  -- Whoa!


-----------------------------------------------------
--------------- OPERATIONAL SEMANTICS! --------------
-----------------------------------------------------

export
CommandEval: Command -> State -> State
CommandEval Skip st = st
CommandEval (NatAssign v e) st =
  override_nat st v (natExprEval e st)
CommandEval (BoolAssign v e) st =
  ?bassn_hole
CommandEval (Seq c1 c2) st =
  ?seq_hole
CommandEval (IfThenElse cond tcmd fcmd) st =
  ifthenelse
    (?cond_hole)
    (?if_true_hole)
    (?if_false_hole)
CommandEval (While cond cmd) st =
  ifthenelse
    (?cond_hole)
    (CommandEval (While cond cmd) (CommandEval cmd st))
    (?while_false_hole)
