module expressionTest

import expression
import variable
import state
import nat

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
st' = state_override_bool st V True

--- a Nat Variable with a nice name
N: Variable Nat
N = variable_new nat_zero

--- Now create state with V = True and N = nat_one.
st'': State
st'' = state_override_nat st' N nat_one
