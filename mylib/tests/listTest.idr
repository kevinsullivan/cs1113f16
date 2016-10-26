module listTest

import list
import nat
import bool

--- Some example values, eventually move to test file
ln: List Nat
ln = Nil

ln1: List Nat
ln1 = Cons nat_one ln

ln2: List Nat
ln2 = Cons nat_two ln1

ln3: List Nat
ln3 = Cons nat_three ln2


-- Another example, fully expanded
lb4: List Bool
lb4 = Cons (True) (Cons False (Cons (True) (Cons False Nil)))

-- Filter test
ln4: List Nat
ln4 = list_filter nat_evenb ln3

-- Map test
ln5: List Nat
ln5 = list_map nat_succ ln3

-- Pasted from list.idr

-- A few tests, to be refactored out into separate file

-- A few list values to use in test cases
l: List Nat
l = Nil

l': List Nat
l' = Cons nat_one (Cons nat_two Nil)

l'': List Nat
l'' = (Cons nat_one (Cons nat_two (Cons nat_three Nil)))


-- Test cases for list_range_by_to
r1: List Nat
r1 = list_range_by_to nat_zero nat_one nat_zero
-- expect [0], i.e., (Cons 0 Nil), the list containing just 0

r2: List Nat
r2 = list_range_by_to nat_three nat_one nat_one
-- expect [3, 2, 1]

r3: List Nat
r3 = list_range_by_to nat_three nat_two nat_one
-- expect [3, 1]

r4: List Nat
r4 = list_range_by_to nat_three nat_three nat_one
-- expect [3]

r5: List Nat
r5 = list_range_by_to nat_one nat_one nat_three
-- expect Nil

r6: List Nat
r6 = ?fill_hole_with_ambiguous_case
-- expect Nil

b1: List Bool
b1 = (Cons False (Cons False Nil))  -- [False, False]

b2: List Bool
b2 = (Cons False (Cons True (Cons False (Cons True Nil))))


br1: List Bool
br1 = list_filter_True b1
-- expect Nil

br2: List Bool
br2 = list_filter_True b2
-- expect [True, True]

-- Reduce [1, 2, 3] under addition (with zero as the identity)
n1: Nat
n1 = list_fold_right nat_plus nat_zero l''
-- expect 6

-- Reduce [1, 2, 3] under addition (with zero as the identity)
n2: Nat
n2 = list_fold_right nat_mult nat_one l''
-- expect 6
