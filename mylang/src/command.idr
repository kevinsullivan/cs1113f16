module command

import variable
import nat
import expression

-----------------------------------------------------
----------------- SYNTAX ----------------------------
-----------------------------------------------------

-- The syntax of a little imperative programming language!
public export
data Command =
  Skip |
  Assign Variable Expr |
  Seq Command Command
