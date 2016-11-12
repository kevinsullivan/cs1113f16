module stateTest

import state
import variable
-- Examples

bval: Bool
bval = bool_state_init C   -- C is the Variable (MkVariable nat_two)
-- expect False

nval: Nat
nval = nat_state_init Z   -- Z is the Variable (MkVariable nat_two)
-- expect zero

-- Again, the way to think about nat_state_init is that
-- (as a function) it's like a two-column table with Variables
-- in the first column and corresponding values, here all zero,
-- in the second column.

-- Override updates such a state one variable at a time.
-- Suppose for example that we want a new state in which
-- all variables have corresponding value zero except for
-- variable #2 (MkVariable nat_two), which we now want to
-- map to have one as its corresponding value. We can use
-- override to produce the desired new state like this:
nat_state_new: t_state Nat
nat_state_new = override nat_state_init Z nat_one

-- Now in this *new* state, Variable #2 has the value one,
-- where in the init state it had value zero.
nval': Nat
nval' = nat_state_new Z


---------

-- TEST

b01: Bool
b01 = bool_state_init A

b02: Bool
b02 = bool_state_init B

b03: Bool
b03 = bool_state_init C

-- Assignment: A = True

bs: t_state Bool
bs = override bool_state_init A True

-- Assignment transformed the state to a new state
-- In this new state, all's the same but for A = True

b11: Bool
b11 = bs A

b12: Bool
b12 = bs B

b13: Bool
b13 = bs C

-- Assignment: C = 3 starting in previous state

bs': t_state Bool
bs' = override bs C True

-- In the new state, both A = True and C = True

b21: Bool
b21 = bs' A

b22: Bool
b22 = bs' B

b23: Bool
b23 = bs' C
