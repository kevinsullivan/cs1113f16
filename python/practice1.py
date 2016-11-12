# A python module should start with a
# documentation string (like the inline
# documentation we put in Idris modules.)
# Start and end docstrings with """.
"""A few examples for practice"""

# Function names should be lower case and can contain _
# And the same goes for the names of arguments
# Use descriptive names to document intended meanings
def quad(a_coeff, b_coeff, c_coeff, x_value):
    # Each function should also have a docstring
    # Such a docstring goes right after the #def line
    # Intervening comments like this one are ignored
    """Evaluate quadratic function at x = v"""
    return ((a_coeff * x_value * x_value) +
            b_coeff * x_value +
            c_coeff)
    # Expressions in parenthesis can be broken across lines

# A little test case, expect 1.
print(quad(3, 2, 1, 0))
