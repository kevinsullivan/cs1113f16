module expr

import nat
import variable
import state


public export
data Expr =
  LitExpr Nat |
  VarExpr Variable |
  PlusExpr Expr Expr

exprEval: Expr -> State -> Nat
exprEval (LitExpr n) st = n
exprEval (VarExpr v) st = st v
exprEval (PlusExpr e1 e2) st =
  nat_plus   -- the result is the sum of
    (exprEval e1 st) -- the value of expr1
    (exprEval e2 st) -- and expr2
