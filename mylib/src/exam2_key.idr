module exam2

import nat
import bool
import list
import dictionary
import pair

-----------------------------------------
-- #1: TUPLES AND PROJECTION FUNCTIONS --
-----------------------------------------

{-
Here is a data type definition for a tuple type called FunTuple,
where a value of this type represents a tuple with a first component
of type Nat and a second component of type Bool.
-}

data Tuple = MkTuple Nat Bool

-- Here's an example of a value of this type

mt1: Tuple
mt1 = MkTuple nat_one True

{-
Write two projection functions. The first, called tuple_nat, takes
a Tuple and returns the value of its Nat component. The second, called
tuple_bool, takes a Tuple and returns its Bool component. You need to
fill in the types of these functions and their implementations.
-}

tuple_nat: Tuple -> Nat
tuple_nat (MkTuple n _) = n

tuple_bool: Tuple -> Bool
tuple_bool (MkTuple _ b) = b


-------------------
-- #2: SUBSCRIPTING
-------------------

{-
Refer back to our list module and in particular to the list_sub
function. Remind yourself how it works. Now, given the following
list of natural numbers, complete the expression using the list_sub
function so that the value of aNat is set to the third element in
the list (i.e., to nat_one). Remember that we start indexing at
zero. You can use the REPL to make sure you've got it right.
-}

aList: List Nat
aList = (Cons nat_three (Cons nat_two (Cons nat_one Nil)))

aNat: Nat
aNat = list_sub nat_two aList nat_zero
-- Expect nat_one; be sure to check that you get the right answer


----------------------------
-- #3: POLYMORPHIC FUNCTIONS
----------------------------

-- Consider this function definition

foo: { a: Type } -> (val: a) -> Nat
foo v = nat_one

{-
In a sentence, state precisely what this function does. In
a second sentence or two explain the purpose and the effect
of the curly braces around "a: Type." Then write code to test
the application of foo to the arguments nat_one and False,
respectively. What is the result in each case?
-}

-- This function takes a single argument of any type and
-- always returns the natural number 1 (nat_one).


-----------------------------
-- #4: POLYMORPHIC DATA TYPES
-----------------------------

{-
Write a type constructor called Foo with two type arguments,
a and b, and two constructors, Left a and Right b, and then
write code showing how you would assign values of this type
to variables, g and h, using the Left and Right constructors.
Pick different types for a and b to make it more interesting.
-}

data Foo a b = Left a | Right b

g: Foo Nat Bool
g = Left nat_zero

h: Foo Nat Bool
h = Right False



---------------------------
-- #5: INDUCTIVE DATA TYPES
---------------------------

{-
A "Tree of values of type, a,"" is either Empty or it is a
Node with a value of type a and two smaller "Trees of values
of type a". The Tree type is thus defined inducively.

Write an Idris data type definition for a polymorphic type,
Tree a, accordingly.

Hint: It will have two constructors; you should call them Empty
and Node; and the Node constructor will take three arguments.
-}

data Tree a = Empty | Node a (Tree a) (Tree a)

{-
Next, write Idris code that binds an empty tree of natural
numbers to the variable, et, and a non-empty tree of natural
numbers to the variable, ft. Your non-empty tree may have
only one Node, though more would be ok as well.
-}

et: Tree Nat
et = Empty

ft: Tree Nat
ft = Node nat_one Empty Empty

--------------------------
-- #6: RECURSIVE FUNCTIONS
--------------------------

{-
Write the implementation of a recursive function called
tree_size that takes a value of type (Tree a) and that
returns the number of Nodes in the tree. Hint the number
of Nodes in an Empty tree is zero, while the number of
Nodes is a non-empty tree is one (for the current Node)
plus the number of nodes in each of the two sub-trees.
-}

tree_size: Tree a -> Nat
tree_size Empty = nat_zero
tree_size (Node a left right) =
  nat_succ (nat_plus (tree_size left) (tree_size right))

------------------
-- #7: Termination
------------------

-- Part A. Why should you NOT evaluate badfun, below, in your REPL?

badfun: Nat -> Nat
badfun n = badfun n

-- Evaluation of this function never terminates.

{-
Part B. Is it true that a function that calls itself recursively
on the tail of a list argument will always terminate? Explain (as
text inside this comment).
-}

-- It's true. Every list is finite in length. Therefore one takes
-- recurse on its tail only a finite number of times before reaching
-- Nil, for which an answer is produced without further recursion.

-----------------------------
-- #8: HIGHER-ORDER FUNCTIONS
-----------------------------

{-
Write a function called applyfun that takes a function of type
Nat -> Nat and a value of type Nat and that returns the result of
applying the given function to the given value. Then write one
test case showing that it works. Document the expected answer and
use your REPL to confirm that that's the answer you're obtaining.
-}

applyfun: (Nat -> Nat) -> Nat -> Nat
applyfun f n = f n

n: Nat
n = applyfun nat_succ nat_zero
-- expect nat_one



-----------------------------------------
-- #9: THE MAP, FILTER AND FOLD FUNCTIONS
-----------------------------------------

{-
Part A. Define a value of type (List Nat) representing the list,
[1, 2, 3, 4]. Note: If you don't have a definition of nat_four,
you can always apply nat_succ to a smaller value, such as nat_three,
to construct the value you need.
-}

l: List Nat
l = (Cons nat_one
      (Cons nat_two
        (Cons nat_three
          (Cons (nat_succ nat_three)
            Nil))))

{-
Part B: Define s to be a variable of type Nat, and use the
list_fold_right to assign to s the value that is the sum of
the elements of the list you just defined.
-}

s: Nat
s = list_fold_right nat_plus nat_zero l

{-
Part C: Define q to be a variable of type (List Bool), and
use the list_map function to assign to q a list of Bool values,
one for each element of the list you defined, namely True if
the element is even and False otherwise. Hint: use nat_evenb
in your answer. Use the REPL to check the answer (False, True,
False, True).
-}

q: List Bool
q = list_map nat_evenb l

------------------------------
-- #10: EXTRA CREDIT FOR AN A+
------------------------------

{-
Write code to bind to a variable d a value of type
(Dictionary Nat Bool) containing the following three
key-value pairs, followed by two test cases where you
lookup the values for the keys zero and three respectively.
Check that you're getting the expected answers. Here are
the key-value pairs: 0:True, 1:False, 2:True. Note: You can
write the code that produces the required dictionary in one
big expression, or you can assign smaller dictionaries to
other variables to build up to the dictionary you assign to
the variable d. Final hint: dictionary_insert takes a
dictionary as an argument but also returns a dictionary as
a result. That returned dictionary can be an argument to
another dictionary_insert operation.
-}

d: Dictionary Nat Bool
d = dictionary_insert
      (dictionary_insert
        (dictionary_insert
          dictionary_new
          (MkPair nat_zero True))
        (MkPair nat_one False))
      (MkPair nat_two False)

o1: Option Bool
o1 = dictionary_lookup d nat_zero

o2: Option Bool
o2 = dictionary_lookup d nat_three
