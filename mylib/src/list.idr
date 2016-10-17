||| A module providing a polymorphic list abstract data type
module list

-- these imports are needed only for test code
-- the test code should be moved to listTest.idr,
-- at which point these exports can be removed.
import nat
import bool

||| A polymorphic inductive list data type
||| We leave the constructors externally visible for now
public export
data List a =
  Nil |
  Cons a (List a)

--- Some example values, eventually move to test file
ln: List Nat
ln = Nil

ln1: List Nat
ln1 = Cons nat_one ln

ln2: List Nat
ln2 = Cons nat_two ln1

ln3: List Nat
ln3 = Cons nat_three ln2

||| A function that returns as a nat the length of a given list
export
list_length: List a -> Nat
list_length Nil = nat_zero
list_length (Cons head tail) =
  nat_succ (list_length tail)


-- Another example, fully expanded
lb4: List Bool
lb4 = Cons (True) (Cons False (Cons (True) (Cons False Nil)))


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
