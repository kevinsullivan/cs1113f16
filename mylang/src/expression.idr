module expr

import nat
import variable
import state

-- SYNTAX for Nat expressions

||| NatExpr is the type of expressions that evaluate to
||| natural numbers (Nat). We'll call them Nat Expressions.
public export
data NatExpr =
  NatLitExpr Nat |
  NatVarExpr (Variable Nat) |
  NatPlusExpr NatExpr NatExpr

-- SEMANTICS for Nat Expressions

||| natExprEval evaluates Nat Expressions to yield Nats.
export
natExprEval: NatExpr -> State -> Nat
natExprEval (NatLitExpr n) st = n
natExprEval (NatVarExpr v) st = (getNatState st) v
natExprEval (NatPlusExpr e1 e2) st =
  nat_plus   -- the result is the sum of
    (natExprEval e1 st) -- the value of expr1
    (natExprEval e2 st) -- and expr2


-- Syntax for Bool expressions


||| BoolExpr is the type of expressions that evaluate to
||| Boolean values (Bool). We'll call them Bool Expressions.
public export
data BoolExpr =
  BoolLitExpr Bool |
  BoolVarExpr (Variable Bool) |
  BoolAndExpr BoolExpr BoolExpr |
  BoolEqExpr NatExpr NatExpr


-- Semantics for Bool expressions

||| natExprEval evaluates Nat Expressions to yield Nats.
export
boolExprEval: BoolExpr -> State -> Bool
boolExprEval (BoolLitExpr b) st = b
boolExprEval (BoolVarExpr v) st = (getBoolState st) v
boolExprEval (BoolAndExpr e1 e2) st =
  bool_and (boolExprEval e1 st) (boolExprEval e2 st)
boolExprEval (BoolEqExpr n1 n2) st =
  eq (natExprEval n1 st) (natExprEval n2 st)


---- TEST CODE, TO BE REFACTORED INTO expressionTest.idr

-- just a Bool Variable with an easy name, V
V: Variable Bool
V = variable_new nat_zero

{-
This code didn't work, because "S" is already
defined as a constructor, *visible* in this module,
in the nat module. In what follows, we use st instead,
and add primes to the name as we derive new states.

S: State
S = override_state_bool state_init  V True
-}

--- The rest shows how we can chain together a sequence
--- of Nat and Bool Variable overrides, using the result
--- of the previous one as the start point for the next.


--- We'll call the initial state, st
st: State
st = state_init

--- override: result function like input but maps V to True
st': State
st' = override_state_bool st V True

--- a Nat Variable with a nice name
N: Variable Nat
N = variable_new nat_zero

--- Now create state with V = True and N = nat_one.
st'': State
st'' = override_state_nat st' N nat_one
