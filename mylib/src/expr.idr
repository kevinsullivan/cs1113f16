module expr

import nat
import bool
import variable
import state
import option


export
data NatExpr =
  NatLitExpr Nat |
  NatVarExpr (Variable Nat) |
  NatPlusExpr NatExpr NatExpr |
  NatSubExpr NatExpr NatExpr |
  NatTimesExpr NatExpr NatExpr |
  NatMinusExpr NatExpr NatExpr

export
natExprEval: NatExpr -> State -> Nat
natExprEval (NatLitExpr n) _ = n
natExprEval (NatVarExpr v) (MkState _ nenv) = nenv v
natExprEval (NatPlusExpr e1 e2) st =
  nat_plus (natExprEval e1 st) (natExprEval e2 st)
natExprEval (NatTimesExpr e1 e2) st =
  nat_mult (natExprEval e1 st) (natExprEval e2 st)
natExprEval (NatMinusExpr e1 e2) st =
  nat_minus (natExprEval e1 st) (natExprEval e2 st)


export
data BoolExpr =
  BoolLitExpr Bool |
  BoolVarExpr (Variable Bool) |
  BoolAndExpr BoolExpr BoolExpr |
  BoolOrExpr BoolExpr BoolExpr |
  BoolNotExpr BoolExpr |
  BoolEqExpr BoolExpr BoolExpr |
  NatEqExpr NatExpr NatExpr


export
boolExprEval: BoolExpr -> State -> Bool
boolExprEval (BoolLitExpr b) _ = b
boolExprEval (BoolVarExpr v) (MkState benv nenv) = benv v
boolExprEval (BoolAndExpr e1 e2) st =
  bool_and
    (boolExprEval e1 st)
    (boolExprEval e2 st)
boolExprEval (BoolOrExpr e1 e2) st =
  bool_or
    (boolExprEval e1 st)
    (boolExprEval e2 st)
boolExprEval (BoolNotExpr e1) st =
  bool_not (boolExprEval e1 st)
boolExprEval (BoolEqExpr e1 e2) st =
  bool_eq (boolExprEval e1 st) (boolExprEval e2 st)
