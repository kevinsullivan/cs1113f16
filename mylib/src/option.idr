||| A module implementing the option data type
module option

import bool

||| The option type
public export
data Option a = None | Some a


bo: Option Bool
bo = None

bo': Option Bool
bo' = Some True

|||
export
isNone: Option a -> Bool
isNone None = True
isNone _ = False
