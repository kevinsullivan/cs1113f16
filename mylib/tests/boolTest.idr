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
-- expect b3 = True

b4: Bool
b4 = bool_false b
-- expect b4 = False

b5: Bool
b5 = bool_and True True
-- expect b5 = True

b6: Bool
b6 = bool_and True False
-- expect b6 = False
