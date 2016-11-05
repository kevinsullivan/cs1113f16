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


||| We first define a simple abstract data type the
||| values of which are "variables capable of having
||| associated values of type t."" We make the Variable
||| type public but make the constructor private to this
||| module.
export
data Variable t = MkVariable Nat


||| Provide a public function to create a variable
export
variable_new: Nat -> Variable Nat
variable_new n = MkVariable n


-- Examples of variables, with convenient names (refactor)

X: Variable Nat
X = MkVariable nat_zero

Y: Variable Nat
Y = MkVariable nat_one

Z: Variable Nat
Z = MkVariable nat_two

A: Variable Bool
A = MkVariable nat_zero

B: Variable Bool
B = MkVariable nat_one

C: Variable Bool
C = MkVariable nat_two


||| Equality for variables: True if two variables of a give
||| type are equal. They are "iff" their numeric "indexes"
||| are equal.
export
var_eq: {t: Type} -> Variable t -> Variable t -> Bool
var_eq (MkVariable n1) (MkVariable n2) = nat_eq n1 n2


-- A few test cases for var_eq (refactor)
b1: Bool
b1 = var_eq X X
-- Expect True

b2: Bool
b2 = var_eq X Y
-- Expect False

{-
Now we come to the heart of this module. We define (t_state a) to
be the function type for functions that take (Variable t) arguments
and that return t values as results.

A value of  type (t_state a) will thus be such a function,
from (Variable a) to a. We call an association of variables
with values a state. Given that (t_state t) is a function
*type* (not a function itself!) we will be able to declared
function values to be of this type for any given T. Such a
function will then take values of type (Variable t) as their
arguments and will return values of type t as their results.
Such a function thus establishes a mapping from variables to
values for some particular type of values, t (such as Bool or
Nat).
-}
export
t_state: (t: Type) -> Type
t_state t = (Variable t) -> t

-- Examples (refactor)

-- Here's an example of a function of type (t_state Bool)
boolFunc: Variable Bool -> Bool
boolFunc v = False

-- And here we verify that claim explicity
boolState: t_state Bool
boolState = boolFunc

-- Often we don't want to have to write a named function
-- and in these cases we can provide an "anonymous function"
boolState': t_state Bool
boolState' = \v: (Variable Bool) => False
-- This says that the value of boolState' is "a function that
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
natState: t_state Nat
natState = \v => nat_zero

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
override: {a: Type} -> (s: t_state a) -> (var: Variable a) -> (val: a) -> t_state a
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
nat_state_init: t_state Nat
nat_state_init = \v: Variable Nat => nat_zero


||| Initial state for Bool (Variables initialized to False)
export
bool_state_init: t_state Bool
bool_state_init = \v: Variable Bool => False

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


-- Now comes our next move. We are going to build a little
-- language with both Boolean- and Nat-valued variables, so
-- we make a combined state by pairing up a (t_state Nat) and
-- a (t_state Bool) into a single object. A value of this type
-- of object will thus provide mappings from both Bool Variables
-- and Nat variables to corresponding values (of type Nat and
-- Bool).

||| The state of system in our design will comprise a pair:
||| a Bool state function along with a Nat state function.
||| Recall that these are just functions that map Variables
||| of given types to values of those types.
public export
data State = MkState (t_state Bool) (t_state Nat)


||| The overall initial state combines the zeroed out
||| state of Nat variables and the Falsified values of
||| the Bool variables.
export
init_state: State
init_state = MkState bool_state_init nat_state_init

-- Next we define operations (functions) that take such
-- a state and update (override) either a Bool Variable
-- or a nat value. (Is there a way to avoid having to write
-- such deplicative code?)

export override_bool: State -> (Variable Bool) -> Bool -> State
override_bool (MkState bs ns) var val =
  MkState (override bs var val) (ns)


export override_nat: State -> (Variable Nat) -> Nat -> State
override_nat (MkState bs ns) var val =
  MkState (bs) (override ns var val)

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

{- DELETE?
The next crucial concept is that of a state transformer,
a function that takes (or "starts with") a give state and
that returns a transformed state. One especially fundamental
state transform is called assignment. Given a starting state,
it takes a variable and a compatible argument value and returns
a new state that is exactly like the starting state except that
now the given variable evaluates to the given value, rather than
what it evaluated to in the original argument.  This is a tricky
piece of code that bears extra studying.
-}
