||| A module providing a polymorphic if/then/else function
module ifthenelse

import public bool

-- temporary, for testing, remove
import nat


{-
Polymorphism is a fancy word, but all it means for us here is that
we can specidy a whole family of ifthenelse function types, varying
in the type of value they return.

Go back now and have a look at bool_if_then_else. You will recall
that it takes a Bool (the condition) and two other Bools (the return
values for the True and false cases of the condition).

It always return a Bool. It's type is Bool -> Bool -> Bool -> Bool.
The first is the condition, then second and third are the true and
false return values, respectively, and the last is the type of the
return value, again Bool.

What we need is a conditional/ifthenelse expression that returns not
a Bool but a value of some other type. In our particular case, we want
a conditional expression that returns one Bit or another depending on
the Boolean result of comparing two nats for equality (using nat_eq).
The type we need here is Bool -> Bit -> Bit -> Bit, but is is easy to
imagine that we'll want to be able to return values of arbitrary types
based on ifthenelse comparisons.

What we need is an ifthenelse function that takes an arbitrary type,
call it T, as an argument value, where that *value* (which is some
type, such as Bool, Nat, Bit) defines the *type* of the values returned
by the branches and thus by the expression as a hole.

In other words, we need an ifthenelse function that has as its type
(T: Type) -> Bool -> T -> T -> T. If the value of the first argument,
now given the name T, defines the type shared by the third and fourth
arguments and the return result. If, for example, T is Bool, then we
have the type of bool_if_the_else.

What we'll need first is the case where the value of that first "T"
argument is Bit. Now you can see something deep about the logic of the
Idris language: in Idris, types are themselves values. When a function
takes and uses a type as a value, we call it polymorphic in that type.
A function can have several arguments, several of which could be types,
and so a function can be polymorphic in several different types.
-}

||| If-then-else returning a value of the specified type
export
ifthenelse: { t: Type } -> Bool -> t -> t -> t
ifthenelse True tbranch _ = tbranch
ifthenelse False _ fbranch = fbranch
