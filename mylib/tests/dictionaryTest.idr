module dictionaryTest

import dictionary
import nat
import bool
import eq
import pair

-- tests using a (Dictionary nat bool)

-- An empty dictionary
d: Dictionary Nat Bool
d = dictionary_new

-- insert (0, False)
d': Dictionary Nat Bool
d' = dictionary_insert d (MkPair nat_zero False)

-- insert (1, True) into result of last operation
d'': Dictionary Nat Bool
d'' = dictionary_insert d' (MkPair nat_one True)

-- Now find values for keys in and not in the dictionary
b1: Option Bool
b1 = dictionary_lookup d'' nat_zero
-- Expect (Some False)

b2: Option Bool
b2 = dictionary_lookup d'' nat_one
-- Expect (Some True)

b3: Option Bool
b3 = dictionary_lookup d'' nat_two
-- expect None
