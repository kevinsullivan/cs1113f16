||| A module providing a polymorphic list abstract data type
module list

-- The length of a list is a nat, so we need to import and export nat
import public nat
import ifthenelse

||| A polymorphic inductive list data type
||| We leave the constructors externally visible for now
public export
data List a =
  Nil |
  Cons a (List a)

||| A function that returns as a nat the length of a given list
export
list_length: List a -> Nat
list_length Nil = nat_zero
list_length (Cons head tail) =
  nat_succ (list_length tail)


||| Returns a list obtained by appending the second list to the first
-- be sure to add "export" here; we didn't do that in class last time
export
list_append: List a -> List a -> List a
list_append Nil l = l
list_append (Cons head tail) l = Cons (head) (list_append tail l)
-- Note that Idris interprets "a" as an implicitly declared type
-- This is the same as: { a: Type } -> List a -> List a -> List a

||| Return the sublist of elements for which a predicate is true
export
list_filter: (a -> Bool) -> List a -> List a
list_filter predicate Nil = Nil
list_filter predicate (Cons head tail) =
  ifthenelse
    (predicate head)
    (Cons head (list_filter predicate tail))
    (list_filter predicate tail)

||| Return the list of elements transformed by a given function
export
list_map: (a -> b) -> List a -> List b
list_map f Nil = Nil
list_map f (Cons head tail) = Cons (f head) (list_map f tail)

{-
-- Ignore for now

export
list_nil: (A: Type ) -> List A
list_nil ty = Nil { a = ty }


||| Identity function for list_nat_cons
export
list_cons: { A: Type } -> A -> List A -> List A
list_cons head tail = Cons head tail
-}
