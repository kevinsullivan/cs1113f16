module langTest

import command
import nat
import variableTest   -- defines variables X, Y, Z
import variable
import expression

-- Tests: Programs are just values of this data type!

-- Do nothing but skip
prog0: Command
prog0 = Skip

{-
s0: State
s0 = run prog0 state_init
-}

-- A single assignment
prog1: Command
prog1 = Assign X (LitExpr nat_two)

{-
s1: State
s1 = run prog1 state_init
-- expect s1 X = 2, s1 Y = 0, s1 Z = 0

-- An assignment in the state produced by the last assignment
s2: State
s2 = run (Assign Y nat_two) s1
-- expect s2 X = 2, s2 Y = 2, s2 Z = 0
-}

-- A sequential composition of assignments
prog2: Command
prog2 =
  Seq
    (Assign X (LitExpr nat_one))
    (Assign Y (LitExpr nat_two))

{-
s3: State
s3 = run prog2 state_init
-- expect same result as s2
-}

-- A sequential composition of an assignment with a larger program
prog3: Command
prog3 =
  Seq
    (Assign X (LitExpr nat_one))
    (Seq
      (Assign Y (LitExpr nat_two))
      (Assign Z (LitExpr nat_three)))

{-
s4: State
s4 = run prog3 state_init
-}

-- NEW TEST CASES USING EXPRESSIONS

-- like "X = Y" in Python
prog4: Command
prog4 = Assign X (VarExpr Y)

-- like "X = Y + 1" in Python
prog5: Command
prog5 =
  Assign
    X
    (PlusExpr
      (VarExpr Y)
      (LitExpr nat_one))
