module bool

public export
data Bool = True | False 

public export
bool_id: Bool -> Bool
bool_id True = True
bool_id False = False

public export
bool_not: Bool -> Bool
bool_not True = False
bool_not False = True

public export
bool_true: Bool -> Bool
bool_true True = True
bool_true False = True

public export
bool_false: Bool -> Bool
bool_false _ = False
