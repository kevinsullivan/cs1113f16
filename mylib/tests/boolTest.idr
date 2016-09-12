module boolTest

import bool

b: Bool
b = bool_id True
-- expect b = True

b2: Bool
b2 = bool_not b
-- expect b = False

b3: Bool
b3 = bool_true b
-- expect True

b4: Bool
b4 = bool_false b
-- expect Not
