module variableTest

import variable
import nat

-- A few test cases for var_eq (refactor)

public export
X: Variable
X = variable_new nat_zero

public export
Y: Variable
Y = variable_new nat_one

public export
Z: Variable
Z = variable_new nat_two

-- Tests of bool_eq

b1: Bool
b1 = var_eq X X

b2: Bool
b2 = var_eq X Y


-- Tests of eq (for Bool)

b3: Bool
b3 = eq X Y

b4: Bool
b4 = eq Y Y