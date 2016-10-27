||| A module providing a polymorphic list abstract data type
module list

-- The length of a list is a nat, so we need to import and export nat
import public nat
import ifthenelse
import public eq

import unit

||| A polymorphic inductive list data type
||| We leave the constructors externally visible for now
public export
data List a =
  Nil |
  Cons a (List a)


||| An attempt to implement a polymorphic (List a) equality operator.
||| Two ists are equal if their elements correspond and they are equal.
||| The problem is that we have no idea what type of elementw wlil be
||| in a given list, so we don't know what code to use to elements. We
||| can't fill the hole in this code.
public export
list_eq: Eq a => List a -> List a -> Bool
list_eq Nil Nil = True
list_eq Nil (Cons h t) = False
list_eq (Cons h t) Nil = False
list_eq (Cons h1 t1) (Cons h2 t2) =
  bool_and
    (eq h1 h2)
    (list_eq t1 t2)

b: Bool
b = list_eq (Cons nat_zero Nil) (Nil)

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
list_append (Cons head tail) l =
  Cons (head) (list_append tail l)
-- Note that Idris interprets "a" as an implicitly declared type
-- This is the same as: { a: Type } -> List a -> List a -> List a


||| Return the element at the head of the list or
||| return the second argument (the "default") if the
||| list is empty.
export
list_head: List a -> a -> a
list_head Nil default = default
list_head (Cons h t) _ = h


||| Return the tail of the given list, or Nil if the list itself is Nil
export
list_tail: List a -> List a
list_tail Nil =  Nil
list_tail (Cons h t) = t


||| Return the n'th element of a given list, or a default value
||| (the argument of type a) if n is outside the length of the list
export
-- As with list_head, we pass in a value (default) to be returned
-- if the list is Nil or if the index is too big for the number of
-- elements in the list ("out of bounds").
list_sub: (index: Nat) -> List a -> (default: a) -> a
-- If the list is Nil, we return the default value.
-- This is the base case for this recursive function.
list_sub _ Nil default = default
-- If the list is not Nil and the index is zero, then
-- the element we're looking for is at the head of the
-- list, and we return it; otherwise we recursively return
-- the element with index (n-1) in the tail of the list.
-- If the index is too big for the list, we'll eventually
-- hit the Nil list, at which point the base case kicks in.
-- Otherwise we'll end up with the index being zero with
-- the desired element at the head of the list, at which
-- point the condition (index = 0) is true and we return
-- that element.
list_sub index (Cons head tail) default =
  ifthenelse
    (nat_eq index nat_zero)
    (head)
    (list_sub (nat_pred index) tail default)


||| Return a list with n elements of the given value
export
list_repeat: (value: a) -> (n: Nat) -> List a
list_repeat val len =
  ifthenelse
    (nat_eq len nat_zero)
    Nil
    (Cons
      val
      (list_repeat val (nat_pred len)))


||| Given a list of nats, return their sum
list_sum: List Nat -> Nat
list_sum Nil = nat_zero
list_sum (Cons h t) =
  nat_plus (h) (list_sum t)


||| Given a list of nats, return their product
list_prod: List Nat -> Nat
list_prod Nil = nat_one
list_prod (Cons h t) =
  nat_mult (h) (list_prod t)

||| Given a list of nats, return the list with each nat incremented by one
list_inc: List Nat -> List Nat
list_inc Nil = Nil
list_inc (Cons h t) =
  Cons
    (nat_succ h)
    (list_inc t)

||| Given a list of nats, return the list with each nat squared
list_map_square: List Nat -> List Nat
list_map_square Nil = Nil
list_map_square (Cons h t) =
  Cons
    (nat_mult h h)
    (list_map_square t)


||| Return a list starting with a given nat and descending by 1s to 0
||| Example: list_range 3 = (Cons 3 (Cons 2 (Cons 1 (Cons 0 Nil))))
||| Example: list_range 0 = (Cons 0 Nil)
||| Note: I've used shorthand for nats: E.g., 3 is really (S (S (S Z)))
export
list_range: Nat -> List Nat
list_range n =
  ifthenelse (nat_eq n nat_zero)
  (Nil)
  (Cons n (list_range (nat_pred n)))

--- HOMEWORK STARTS HERE.

||| The function (list_range_by_to n b t) should teturn a list of natural
||| numbers starting with n, decreasing by b, until t is reached or passed,
||| where t is included in the result if it is reached exactly.
||| Examples:
|||   list_range_by_to 5 1 1 = [5, 4, 3, 2, 1]
|||   list_range_by_to 5 2 1 = [5, 3, 1]
|||   list_range_by_to 5 3 1 = [5, 2]
||| To avoid infinite loops, we specify if b = 0, the result is Nil
||| Example:
|||   list_range_by_to 5 0 1 = Nil
||| To be clear, if n = t the result is [n] (a list with just n)
||| Example:
|||   list_range_by_to 5 2 5 = [5] ("from 5 down to 5 by twos is just [5]")
||| Tere is one case for which this specification is ambiguous. Identify is
||| and represent it in the definition of r6, below. For that case, the
||| result should be Nil.
export
list_range_by_to: (n: Nat) -> (b: Nat) -> (t: Nat) -> List Nat
list_range_by_to n b t = ?fill_this_hole
-- If you haven't figured out how to solve this problem yet
-- keep working on it. It's important to be able to solve
-- problems like this on your own. Ask for help if you need it.


||| Given a list of natural numbers return the sum of their squares
||| Example: list_sum_squares Nil = 0
||| Example: list_sum_squares [0] = 0
||| Example: list_sum_squares [3, 4, 1, 2] = 30
list_sum_squares: List Nat -> Nat
list_sum_squares Nil = nat_zero
list_sum_squares (Cons h t) =
  nat_plus
    (nat_mult h h)
    (list_sum_squares t)


||| Given a list of natural numbers, return a list of Boolean values
||| where a Boolean is True if the corresponding number is even and
||| False otherwise.
||| Example: list_nat_ev_bool [5,4,3,2,1,0] = [F,T,F,T,F,T]
list_nat_ev_bool: List Nat -> List Bool
list_nat_ev_bool Nil = Nil
list_nat_ev_bool (Cons h t) =
  ifthenelse
    (nat_evenb h)
    (Cons True (list_nat_ev_bool t))
    (Cons False (list_nat_ev_bool t))


||| Given a list of natural numbers, return the sublist of even numbers
||| Example: list_filter_even [5, 4, 3, 2, 1, 4, 2, 0] = [4, 2, 4, 2, 0]
export
list_filter_even: List Nat -> List Nat
list_filter_even Nil = Nil
list_filter_even (Cons h t) =
  ifthenelse
    (nat_evenb h)
    (Cons h (list_filter_even t))
    (list_filter_even t)


||| Given a list of Booleans, return the sublist of True ones
||| Example: list_filter_even [False, False] = Nil
||| Example: list_filter_even [T, F, T, F] = [T, T]
export
list_filter_True: List Bool -> List Bool
list_filter_True Nil = Nil
list_filter_True (Cons h t) =
  ifthenelse
    (bool_id h)
    (Cons h (list_filter_True t))
    (list_filter_True t)


-- Higher-order functions involving lists

||| Return the list of elements transformed by a given function
export
list_map: (a -> b) -> List a -> List b
list_map func Nil = Nil
list_map func (Cons h t) =
  Cons (func h) (list_map func t)


||| Return the value obtained by reducing the list using the given
||| function and identity element.
export
list_fold_right: (op: a -> a -> a) -> (id: a) -> (l: List a) -> a
list_fold_right op id Nil = id
list_fold_right op id (Cons h t) =
  op h (list_fold_right op id t)


||| Return the sublist of elements for which a predicate is true
export
list_filter: (a -> Bool) -> List a -> List a
list_filter predicate Nil = Nil
list_filter predicate (Cons head tail) =
  ifthenelse
    (predicate head)
    (Cons head (list_filter predicate tail))
    (list_filter predicate tail)

list_filter_even': List Nat -> List Nat
list_filter_even' l = list_filter nat_evenb l

list_filter_True': List Bool -> List Bool
list_filter_True' l = list_filter bool_id l
