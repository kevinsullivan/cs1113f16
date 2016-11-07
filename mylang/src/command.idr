module command

import variable
import nat

-----------------------------------------------------
----------------- SYNTAX ----------------------------
-----------------------------------------------------

-- The syntax of a little imperative programming language!
public export
data Command =
  Skip |
  Assign Variable Nat |
  Seq Command Command
