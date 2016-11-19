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

Section #1: a little polymorphic subsystem for dealing
with state-specific "assignment functions -- in particular
for (Variable Nat) -> Nat and (Variable Bool) -> Bool. It
defines values of reasonable initial states, with all Nat
Variables assiged zero and all Bool Variables assigned
False.
-}

||| StateT is the type of function from (Variable t) to t
||| In our language we instantiate StateT with Nat and Bool
||| obtaining the types (Variable Nat) -> Nat and (Variable
||| Bool) -> Bool: the types of our type-specific state
||| functions.
public export
StateT: (t: Type) -> Type
StateT t = (Variable t) -> t


||| override is a polymorphic function with an implicit
||| type parameter that yields a function that when given
||| a StateT function for that state along with a variable
||| and a value returns a new StateT function, the original
||| function with the specified variable-value override.
export
override_t: {a: Type} -> (s: StateT a) -> (var: Variable a) -> (val: a) -> StateT a
override_t s var val =
  \v: Variable a =>
    ifthenelse
      (var_eq var v)
      val
      (s v)

-- We export values that we designate as "initial states"
-- for Boolean and Nat-valued variables. nat_state_init
-- maps every (Variable Nat) to zero; and bool_state_init
-- maps every Bool-valued Variable to False.

||| nat_state_init is the state-specific asignment function
||| that defines the "initial values" of all Nat variables
||| in our little language. In particular, nat_state_init is
||| the function that when given *any* Nat Variable in our
||| language returns the value assigned to that variable in
||| the state that the function represents.
export
nat_state_init: StateT Nat
nat_state_init = \v: Variable Nat => nat_zero


||| Initial state for Bool Variables assigns False to
||| all Bool variables
export
bool_state_init: StateT Bool
bool_state_init = \v: Variable Bool => False

{-
Section #2: Defining a pair-like type, State type,
that we  will use to package up a pair of type-specific
state functions, of the kind just discussed, one for Nat
and one for Bool, and a set of convenient operations on
these state-function pairs.
-}

||| The state of program execution in our system will
||| be a pair of type-specific state functions, one for
||| Nat Variables and one for Bool Variables.
public export
data State = MkState (StateT Bool) (StateT Nat)

||| given a State, getBoolState returns its StateT Bool
||| component: the function in the state that maps Bool
||| variabes to their assigned values
export
getBoolState: State -> (StateT Bool)
getBoolState (MkState bs ns) = bs

||| given a State, getNatState returns its StateT Nat
||| component: the function in the state that maps Nat
||| Variabes to their assigned values
export
getNatState: State -> (StateT Nat)
getNatState (MkState bs ns) = ns


{-
These functions override the appropriate type-specific
assignement functions within the given state.
-}

||| Override the Bool assignment function in the state
export
state_override_bool: State -> (Variable Bool) -> Bool -> State
state_override_bool (MkState bs ns) var val =
  MkState (override_t bs var val) (ns)


||| Override the Nat assignment function in the state
export
state_override_nat: State -> (Variable Nat) -> Nat -> State
state_override_nat (MkState bs ns) var val =
  MkState (bs) (override_t ns var val)


||| we define and export a state value, state_init, in which
||| all Nat Variables are assigned zero and all Bool Variables,
||| False
export
state_init: State
state_init = MkState bool_state_init nat_state_init

||| init_state is redundant with state_init
export
init_state: State
init_state = MkState bool_state_init nat_state_init
