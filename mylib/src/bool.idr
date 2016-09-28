||| Abstract data type simulating Boolean algebra
module bool

public export
data Bool =
  ||| Term representing Boolean true
  True |
  ||| Term representing Boolean false
  False

-- Unary functions

||| Representation of identity function on Boolean values
public export
bool_id: Bool -> Bool
bool_id b = b

||| Representation of negation function on Boolean values
public export
bool_not: Bool -> Bool
bool_not True = False
bool_not _ = True

||| Representation of constant true function of one Bool
public export
bool_true: Bool -> Bool
bool_true _ = True

||| Representation of constant false function of one Bool
public export
bool_false: Bool -> Bool
bool_false _ = False


-- Binary functions

{-
The rules for evaluating these functions are
either direct, or more compact, translations
of their truth tables.
-}

||| Representation of Boolean "and" function
public export
bool_and: Bool -> Bool -> Bool
bool_and True True = True
bool_and True False = False
bool_and False True = False
bool_and False False = False

{-
Next we implement the Boolean "or"
function. Rather than writing out
the whole truth table, we give one
rule for the case where both of the
arguments are "False," and one that
matches all the remaining cases. It
is important to understand that when
evaluating a function application,
Idris tries to match rules from the
top down, and it applies the first
rule that matches.
-}

||| Representation of Boolean "or" function
public export
bool_or: Bool -> Bool -> Bool
bool_or False False = False
bool_or _ _ = True

{-
This next example introduces two important
new ideas. First we see the general form of
rules for evaluating function applications.
The "pattern" parts of such rules can contain
variables that the process of pattern matching
tries to match (or "unify") with parts of the
function application expression. Second, the
result that a matching rule returns can be
given not just by a literal expression but by
a function application, and it, in turn,
can use variables bound during pattern matching.

The evaluation of a function application thus
proceeds in several steps: (1) find a rule that
matches, and in the process bind variables to
parts of the function application expression,
(2) evaluate the expression on the right in the
context of the bindings established by pattern
matching.
-}

||| Representation of Boolean "nand" function
public export
bool_nand: Bool -> Bool -> Bool
bool_nand b1 b2 = bool_not (bool_and b1 b2)

||| Representation of Boolean "xor" function
public export
bool_xor: Bool -> Bool -> Bool
bool_xor True True = False
bool_xor False False = False
bool_xor _ _ = True

||| Representation of the Boolean implies function
public export
bool_implies: Bool -> Bool -> Bool
bool_implies True False = False
bool_implies _ _ = True

||| Representation of the Boolean equiv function
public export
bool_equiv: Bool -> Bool -> Bool
bool_equiv True True = True
bool_equiv False False = True
bool_equiv _ _ = False

{-
Next we introduce a special case of one of
the most fundamental concepts in computing:
that of conditional evaluation. The idea is
that you're giving a condition in the form
of a Boolean expression and then two possible
results, each again given by an expression.
If the condition evaluates to true the result
is obtained by evaluating the first result
expression, otherwise the result is obtained
by evaluating the second expression. You can
think of this graphically like this:

              condition
              /       \
     if true /         \ if false
            /           \
       expression     expression

We call such a construct a "conditional." To
evaluate a conditional expression, you first
evaluate the condition, then you return the
result of evaluating either the expression for
the "true branch" or for the "false branch"
accordingly.

We can build ourselves a capability to compute
conditionally by defining a ternary function.
Here we build the special case where the type
of the return result is always Bool.
-}

||| Representation of if-then-else returning a Bool
bool_if_then_else: Bool -> Bool -> Bool -> Bool
bool_if_then_else True t _ = t
bool_if_then_else False _ f = f

-- Theorems and proofs (okay, not this semester, but here's
-- a tiny taste).

{-
Here it'd be great to check to see that our data type
really does simulate properties of "The Booleans." For
example, we might want to check that the following is
true: if b is any value of type Bool, then (bool_equiv
b (bool_not (bool_not b))) is true.
-}

{-
||| Theorem: bool_not repeated cancels out
doubleNeg: (b: Bool) ->
            (bool_equiv
              (bool_not (bool_not b))
              b) = true
doubleNeg = ?dnProof
-}
