module list


public export
append: List t -> List t -> List t
append l1 l2 = ?append_hole












{-
append Nil l2 = l2
append (Cons hd tl) l2 = Cons hd (append tl l2)
-}


-- Ignore for now

export
list_empty: (A: Type ) -> List A
list_empty ty = Nil { a = ty }


||| Identity function for list_nat_cons
export
list_cons: { T: Type } -> T -> List T -> List T
list_cons head tail = Cons head tail
