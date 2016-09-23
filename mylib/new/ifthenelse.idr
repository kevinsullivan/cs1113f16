module ifthenelse
import bool

ifthenelse: (A: Type) -> Bool -> A -> A -> A
ifthenelse a True t f = t
ifthenelse a False t f = f
