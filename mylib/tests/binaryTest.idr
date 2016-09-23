import binary
import byte2


sum0: Byte2
sum0 = full_adder B0 B0 B0
-- expect (B0, B0)


{-
 Fill in the remaining test cases
 Exhaustive testing is tantamount to a proof
 It shows that "FORALL argument values of the specified types,
 the program produces a correct result"
-}


sum7: Byte2
sum7 = full_adder B1 B1 B1
-- expect (B1 B1)
