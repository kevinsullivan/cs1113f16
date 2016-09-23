module nat

export
data Nat = Z | S Nat

-- Always a good idea to define a few constants, for testing, to be refactored

nat0: Nat
nat0 = Z

nat1: Nat
nat1 = S Z

nat1': Nat
nat1' = S nat0

nat2: Nat
nat2 = S nat1

nat3: Nat
nat3 = S nat2

-- We can define a successor function, succ: Nat -> Nat
export
nat_succ: Nat -> Nat
nat_succ n = S n

-- Crucial idea: a Nat can be only a Z or an S with a one-smaller Nat inside!

-- Getting the smaller Nat inside gives us the predecessor, except for Z, and
-- for now we'll just define the predecessor of Z to be Z

export
nat_pred: Nat -> Nat
nat_pred Z = Z
nat_pred (S n') = n'

-- And here it comes -- a real mind-blower -- addition!

export
nat_plus: Nat -> Nat -> Nat
nat_plus Z m = m
nat_plus (S n') m = S (nat_plus n' m)
