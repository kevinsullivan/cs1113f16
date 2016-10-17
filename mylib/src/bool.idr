||| Abstract data type simulating Boolean algebra
module bool

||| A data type the values of which represent Boolean true and false
public export
data Bool =
  ||| Term representing Boolean true
  True |
  ||| Term representing Boolean false
  False

{-
Note that here we've made the judgment that it's ok to export
the two constructors for direct use by clients. They're simple
and already perfectly named, so we just let clients use them.
The public export makes the constructors as well as the Bool
type visible in clients that import this module.
-}


-- Unary functions

||| Representation of identity function on Boolean values
export
bool_id: Bool -> Bool
bool_id b = b


||| Representation of negation function on Boolean values
export
bool_not: Bool -> Bool
bool_not True = False
bool_not _ = True


||| Representation of constant true function of one Bool
export
bool_true: Bool -> Bool
bool_true _ = True


||| Representation of constant false function of one Bool
export
bool_false: Bool -> Bool
bool_false _ = False

-- Binary functions

||| Representation of Boolean "and" function
export
bool_and: Bool -> Bool -> Bool
bool_and True True = True
bool_and True False = False
bool_and False True = False
bool_and False False = False


||| Representation of Boolean "or" function
export
bool_or: Bool -> Bool -> Bool
bool_or False False = False
bool_or _ _ = True


||| Representation of Boolean "nand" function
export
bool_nand: Bool -> Bool -> Bool
bool_nand b1 b2 = bool_not (bool_and b1 b2)


||| Representation of Boolean "xor" function
export
bool_xor: Bool -> Bool -> Bool
bool_xor True True = False
bool_xor False False = False
bool_xor _ _ = True


||| Representation of the Boolean implies function
export
bool_implies: Bool -> Bool -> Bool
bool_implies True False = False
bool_implies _ _ = True


||| Representation of the Boolean equiv function
export
bool_equiv: Bool -> Bool -> Bool
bool_equiv True True = True
bool_equiv False False = True
bool_equiv _ _ = False

||| Boolean equality
export
bool_eq: Bool -> Bool -> Bool
bool_eq b1 b2 = bool_equiv b1 b2


||| Representation of if-then-else returning a Bool
export
bool_if_then_else: Bool -> Bool -> Bool -> Bool
bool_if_then_else True t _ = t
bool_if_then_else False _ f = f

{-
Here it'd be great to check to see that our data type
really does simulate properties of "The Booleans." For
example, we might want to check that the following is
true: if b is any value of type Bool, then (bool_equiv
b (bool_not (bool_not b))) is true. We could do this by
exhaustive testing in this case. But the approach that
is needed when exhaustive testing is infeasible is what
we call theorem proving. A theorem is just a type and a
proof is just a value of that type. Here's an example:

||| Theorem: bool_not cancels itself (it's "involutive")


doubleNeg: (b: Bool) ->
            (bool_equiv
              (bool_not (bool_not b))
              b) = true
doubleNeg = ?dnProof
-}
