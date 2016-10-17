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
