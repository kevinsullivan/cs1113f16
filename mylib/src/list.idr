||| A module providing a polymorphic list abstract data type
module list

-- The length of a list is a nat, so we need to import and export nat
import public nat

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
list_append: List a -> List a -> List a
list_append Nil l = l
list_append (Cons head tail) l = Cons (head) (list_append tail l)


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
