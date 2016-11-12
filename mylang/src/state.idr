||| A module defining variables, state as a functions
||| mapping variables to correspondng values, and a key
||| function, override, for changing a state (computing
||| a new one) by changing the previousl value of just
||| one variable.
module state

import dictionary
import variable
import nat
import bool
import ifthenelse


{-
Now we come to the heart of this module. We define (State a) to
be the function type for functions that take (Variable t) arguments
and that return t values as results.

A value of  type (State a) will thus be such a function,
from (Variable a) to a. We call an association of variables
with values a state. Given that (State t) is a function
*type* (not a function itself!) we will be able to declared
function values to be of this type for any given T. Such a
function will then take values of type (Variable t) as their
arguments and will return values of type t as their results.
Such a function thus establishes a mapping from variables to
values for some particular type of values, t (such as Bool or
Nat).
-}
public export
StateT: (t: Type) -> Type
StateT t = (Variable t) -> t

-- Examples (refactor)

-- Here's an example of a function of type (StateT Bool)
aBoolFunc: Variable Bool -> Bool
aBoolFunc v = False

-- StateT Bool *means* Variable Bool -> Bool, so we can
-- assign a function of this type to a variable of type
-- StateT Bool. This is just a demonstration of this idea.
aBoolState: StateT Bool
aBoolState = aBoolFunc

-- Often we don't want to have to write a named function,
-- such as boolFunc, to assign a function value to a variable.
-- In these cases we can use an "anonymous function" instead.
aBoolState': StateT Bool
aBoolState' = \v: (Variable Bool) => False
-- This says that the value of aBoolState' is "a function that
-- takes an argument, v, of type (Variable Bool) and that always
-- returns False."" One could write a more complex return result
-- expression, just as with any function definition. anonymous
-- functions are essential in writing functions that return other
-- functions. We specify the return result as an anonymous function.
-- Note that in this case, boolState' is absolutely equivalent to
-- boolState as we have defined them.

-- We can also define a similar mapping from variables to Natural
-- numbers. Here we allow Idris to infer the type of v in the
-- anonymous function expression. Be sure you read that expression
-- as "a function that takes a variable, v (of type Variable Nat),"
-- and that always returns zero. Visualize a table with variables in
-- the left column and a zero for each variable in the right column.
aNatState: StateT Nat
aNatState = \v => nat_zero    -- note the use of type inference!

{-
Now comes the crucial concept of "function overriding",
an operation (a function) that takes a state (which as we
have just seen is itself a function from variables to values),
a variable, and a value of the corresponding type, and that
returns a new state (a new function from variables to values),
that is just like the original state except that the specified
variable is now associated with the specified new value.

The override function is thus a higher-order function that
both takes a function (namely a state) as an argument (s is a
function right!), and that also returns a function (again, a
state is a function from Variables to values) as a result.
The value that this function returns is a function, and in
particular it is a function that we define using our notation
for anonymous functions.

Override is a slightly tricky function. It takes a state, which is
to say a function from variables to values, along with a variable
(let's say X) and a new value, say v, for X, and it returns a new
state--a new function from variables to values--that for the variable
X returns the new value, v, and that for any other variable returns
the value of that variable in the original state. It computes this
value by applying the original state *function* to the given variable.
Here is where we absolutely rely on our equality comparison operator
for variables. The new function reads like this: If the variable that
is passed to the new state function is equal to the variables whose
value is being overridden, return the given new value for the variable,
otherwise return the value of the variable in the original state. You
can think of this function as returning a new table from variables to
values that is just like the given one except for the single variable
whose value is being overridden, which now maps to the new value.
-}
export
override: {a: Type} -> (s: StateT a) -> (var: Variable a) -> (val: a) -> StateT a
override s var val =
  \v: Variable a =>
    ifthenelse
      (var_eq var v)
      val
      (s v)

-- We export values that we designate as "initial states"
-- for Boolean and Nat-valued variables. nat_state_init
-- maps every (Variable Nat) to zero; and bool_state_init
-- maps every Bool-valued Variable to False.

||| Initial state for Nat (Variables initialized to zero)
export
nat_state_init: StateT Nat
nat_state_init = \v: Variable Nat => nat_zero


||| Initial state for Bool (Variables initialized to False)
export
bool_state_init: StateT Bool
bool_state_init = \v: Variable Bool => False


||| The state of system in our design will comprise a pair:
||| a Bool state function along with a Nat state function.
||| Recall that these are just functions that map Variables
||| of given types to values of those types.
public export
data State = MkState (StateT Bool) (StateT Nat)


export
override_bool: State -> (Variable Bool) -> Bool -> State
override_bool (MkState bs ns) var val =
  MkState (override bs var val) (ns)


export
override_nat: State -> (Variable Nat) -> Nat -> State
override_nat (MkState bs ns) var val =
  MkState (bs) (override ns var val)

export
state_init: State
state_init = MkState bool_state_init nat_state_init
-- Projection functions to access the State functions

export
getBoolState: State -> (StateT Bool)
getBoolState (MkState bs ns) = bs

export
getNatState: State -> (StateT Nat)
getNatState (MkState bs ns) = ns

||| The overall initial state combines zero values
||| for all Nat variables and False values for all
||| Bool variables.
export
init_state: State
init_state = MkState bool_state_init nat_state_init

-- Next we define operations (functions) to override Nat
-- and Bool values, respectively.
