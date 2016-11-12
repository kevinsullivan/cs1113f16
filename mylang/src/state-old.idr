module state

import public variable
import public nat
import ifthenelse

-----------------------------------------------------
----------------- STATE -----------------------------
-----------------------------------------------------

-- We define State to be the *type* (Variable -> Nat)
-- We're really just giving this type a useful name.
-- Here we see that types are values, too, in Idris.

public export
State: Type
State = (Variable -> Nat)
-- Now we can use "State" instead of "Variable -> Nat".
-- The state of an imperative program *is* a function that
-- associates a value with each variable.

-- A common initial state maps each Variable to zero.
||| Return an initial state mapping all variables to zero.
-- A State *is* a function! We need the value of state_init
-- to be a function. Here's notation for "anonymous functions."
export
state_init: State
state_init =
  \v: Variable => nat_zero
-- the value of state_init is a function that takes one argument,
-- v, of type Variable and that always returns nat_zero.


||| Function override takes a state, which is to say a function
||| from variables to values, along with a variable and a value,
||| and returns a new state, which is to say a new function from
||| variables to values, and one that is just like the origninal
||| state (function) except that the given variable now maps to
||| the given new value.
export
override: (s: State) -> (var: Variable) -> (val: Nat) -> State
override s var val =
  \v: Variable =>     -- return a new state (Variable -> Nat)
    ifthenelse        -- that when applied to a variable, v,
      (var_eq var v)  -- asks if v is the variable just overridden
      val             -- and if so it returns the overriding value,
      (s v)           -- and otherwise uses the original state (s)
                      -- to find the value of the given variable
{-
The export function requires some careful thinking. What it returns
is a function that, if given the variable being overridden, returns
the new value, and that otherwise just applies the old state function
to find the value of the variable in the original state.
-}
