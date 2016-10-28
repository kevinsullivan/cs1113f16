||| A module implementing a polymorphic pair abstract data type
module pair

import nat
import bool

||| A polymorphic pair type
public export
data Pair k v = MkPair k v

p1: Pair Nat Nat
p1 = MkPair nat_zero nat_zero


p2: Pair Bool Bool
p2 = MkPair True False


p3: Pair Bool Nat
p3 = MkPair True nat_zero

export
pair_first: Pair k v -> k
pair_first (MkPair k v) = k

export
pair_second: Pair k v -> v
pair_second (MkPair k v) = v

export
pair_key: Pair k v -> k
pair_key p = pair_first p

export
pair_value: Pair k v -> v
pair_value p = pair_second p
