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
prog1 = NatAssign X (NatLitExpr nat_two)

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
    (NatAssign X (NatLitExpr nat_one))
    (NatAssign Y (NatLitExpr nat_two))

{-
s3: State
s3 = run prog2 state_init
-- expect same result as s2
-}

-- A sequential composition of an assignment with a larger program
prog3: Command
prog3 =
  Seq
    (NatAssign X (NatLitExpr nat_one))
    (Seq
      (NatAssign Y (NatLitExpr nat_two))
      (NatAssign Z (NatLitExpr nat_three)))

{-
s4: State
s4 = run prog3 state_init
-}

-- NEW TEST CASES USING EXPRESSIONS

-- like "X = Y" in Python
prog4: Command
prog4 = NatAssign X (NatVarExpr Y)

-- like "X = Y + 1" in Python
prog5: Command
prog5 =
  NatAssign
    X
    (NatPlusExpr
      (NatVarExpr Y)
      (NatLitExpr nat_one))


---------------------


skip: Command
skip = Skip

-- X = 2
assnCmd: Command
assn = NatAssign X (NatLitExpr nat_two)


-- if True:
--     prog1
--     prog2
condCmd: Command
condCmd = IfThenElse
        (BoolLitExpr True)
        prog1
        prog2


-- if True:
--     prog1
--     prog2
bodyCmd: Command
bodyCmd = NatAssign
        X
        (NatMinusExpr X (NatLitExpr nat_one))


whileCmd: Command
whileCmd = While
            (BoolLitExpr False)
            bodyCmd


cmd5: Command
cmd5 =
  Seq
    (NatAssign X (NatLitExpr nat_one))
    (NatAssign Y (NatLitExpr nat_two))
