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
  NatPlusExpr NatExpr NatExpr |
  NatMinusExpr NatExpr NatExpr

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
natExprEval (NatMinusExpr e1 e2) st =
    nat_minus
    (natExprEval e1 st)
    (natExprEval e2 st)

-- Syntax for Bool expressions


||| BoolExpr is the type of expressions that evaluate to
||| Boolean values (Bool). We'll call them Bool Expressions.
public export
data BoolExpr =
  BoolLitExpr Bool |
  BoolVarExpr (Variable Bool) |
  BoolAndExpr BoolExpr BoolExpr |
  BoolEqExpr NatExpr NatExpr |
  BoolNeqExpr NatExpr NatExpr


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
boolExprEval (BoolNeqExpr n1 n2) st =
    neq (natExprEval n1 st) (natExprEval n2 st)
