import nat
import bit

foo: { a: Type } -> (val: a) -> Nat
foo v = nat_one

n: Nat
n = foo True

m: Nat
m = foo B0
