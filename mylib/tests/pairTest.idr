module pairTest

import pair
import nat
import bool

p1: Pair Nat Nat
p1 = MkPair nat_zero nat_zero

p2: Pair Bool Bool
p2 = MkPair True False

p3: Pair Bool Nat
p3 = MkPair True nat_zero
