module eq

import public bool

public export
interface Eq a where
    eq: a -> a -> Bool
    neq: a -> a -> Bool

||| Implementation of Eq interface for Bool
||| We provide this implementation here to avoid
||| an "include cycle," where this file imports
||| bool and bool imports this file. That doesn't
||| work and needs to be avoided.
export
implementation Eq Bool where
  eq b1 b2 = bool_eq b1 b2
  neq b1 b2 = bool_not (eq b1 b2)
