module bool

public export
data Bool = True | False

public export
bool_id: Bool -> Bool
bool_id b = b

{-
bool_id True = True
bool_id False = False
-}

public export
bool_not: Bool -> Bool
bool_not True = False
bool_not _ = True

public export
bool_true: Bool -> Bool
bool_true _ = True

public export
bool_false: Bool -> Bool
bool_false _ = False

{-
Next for the first time we meet
a "binary" function, Boolean "and."
The rules for evaluating this function
are simply the truth table for "and."
-}
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
public export
bool_nand: Bool -> Bool -> Bool
bool_nand True True = False
bool_nand _ _ = True
{-
bool_nand b1 b2 = bool_not (bool_and b1 b2)
-}

public export
bool_xor: Bool -> Bool -> Bool
bool_xor True True = False
bool_xor False False = False
bool_xor _ _ = True

public export
bool_implies: Bool -> Bool -> Bool
bool_implies True False = False
bool_implies _ _ = True
{-
bool_implies False _ = True
bool_implies _ b = b
-}

public export
bool_equiv: Bool -> Bool -> Bool
bool_equiv True True = True
bool_equiv False False = True
bool_equiv _ _ = False
