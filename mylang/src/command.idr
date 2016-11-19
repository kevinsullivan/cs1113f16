module command

import variable
import nat
import expression
import state
import ifthenelse

-----------------------------------------------------
----------------- SYNTAX ----------------------------
-----------------------------------------------------

||| The Command type defines the forms of programs in our language
||| The syntax of a little imperative programming language!
public export
data Command =
  Skip |
  NatAssign (Variable Nat) NatExpr |
  BoolAssign (Variable Bool) BoolExpr |
  IfThenElse BoolExpr Command Command |   -- Whoa! Inductive
  While BoolExpr Command |                -- Whoa! Iductive
  Seq Command Command                     -- Whoa! Inductive


-----------------------------------------------------
--------------- OPERATIONAL SEMANTICS! --------------
-----------------------------------------------------

||| CommandEval is a function that takes a Command and a state
||| in which the evaluate it, evaluates it starting in that state,
||| and returns the resulting state. This is what it means to evaluate
||| an imperative program. (We aren't considering effects, such as I/O).
export
CommandEval: Command -> State -> State
-- Evaluating the skip command in a state st returns st unchanged
CommandEval Skip             st  = st
-- Evaluating an assignment v = e in state st returns the overridden state
CommandEval (NatAssign v e)  st  = override_state_nat st v (natExprEval e st)
-- Evaluating an assignment v = e in state st returns the overridden state
CommandEval (BoolAssign v e) st  =?bassn_hole
-- Evaluating IfThenElse command reduces to evaluating true or false branch
CommandEval (IfThenElse cond tcmd fcmd) st =
  ifthenelse
    (?cond_hole)
    (?if_true_hole)
    (?if_false_hole)
-- Evaluating a While does nothing if the condition is False
-- Otherwise it repeats the while loop in the state produced by
-- executing the body of the command in the start at the start
CommandEval (While cond cmd)  st =
  ifthenelse
    (?cond_hole)
    (CommandEval (While cond cmd) (CommandEval cmd st))
    (?while_false_hole)
-- Evaluating a sequential composition evaluates the second command
-- in the state produce by evaluating the first in the given state st
CommandEval (Seq c1 c2)       st  = ?seq_hole
