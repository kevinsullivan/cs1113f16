module langTest

import command
import nat
import variableTest   -- defines variables X, Y, Z
import variable
import expression
import state

-- Tests: Programs are just values of this data type!

-------------------------------------------
---- putting together a program for sum-1-X
-------------------------------------------

st: State
st = init_state

{-
In Python, the code looks like this:

x = 5
y = 0
while x != 0:
    y = y + x
    x = x - 1
-}

-- X = 5
xGetsFive: Command
xGetsFive = NatAssign
            X
            (NatLitExpr (nat_succ (nat_succ nat_three)))


st': State
st' = CommandEval xGetsFive st


-- Y = 0
yGetsZero: Command
yGetsZero = NatAssign
            Y
            (NatLitExpr nat_zero)


st'': State
st'' = CommandEval yGetsZero st'


-- X != 0
Xnot0: BoolExpr
Xnot0 = BoolNeqExpr
            (NatVarExpr X)
            (NatLitExpr nat_zero)



-- Y = Y + X
accumXinY: Command
accumXinY = NatAssign
        Y
        (NatPlusExpr
            (NatVarExpr Y)
            (NatVarExpr X))

st''': State
st''' = CommandEval accumXinY st''

-- X = X - 1
decrX: Command
decrX = NatAssign
        X
        (NatMinusExpr (
            NatVarExpr X)
            (NatLitExpr nat_one))



-- acculumate x in y decrementing x until x = 0
iterateSum: Command
iterateSum = While
                Xnot0
                (Seq
                    accumXinY
                    decrX)



-- initialize X = 5, then run the loop
sumOneToFive: Command
sumOneToFive =
        Seq
        xGetsFive
        (Seq
            yGetsZero
            iterateSum)
-- now (st X) = 0 and (st Y) = result


--------------------------------------
---- now we run (evaulate) our program
--------------------------------------

-- the answer will be in Y in the resulting state
st'''': State
st'''' = CommandEval sumOneToFive init_state


-----------------------------------------------------
-------- separate examples of other commands --------
-----------------------------------------------------

-- Example of ...
-- if X != 0:
--     X = 5
condCmd: Command
condCmd = IfThenElse
            Xnot0
            xGetsFive   -- improve this kjs
            Skip   -- improve this kjs



------------------------------------
------------ older stuff -----------
------------------------------------

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
