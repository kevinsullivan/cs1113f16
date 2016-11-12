# A single-line comment starts with a hash mark

'''
This is a multi-line comment.
It starts and ends with sequences
of three single quotes in a row.

This program illustrates concepts
of state and assignment operations
that modify state. It also introduces
the print statement. Note: This code
is written in Python version 3, not
in Python 2. The syntax of Python 2
is a little different. Be sure you
know what version you're using when
you program in Python.
'''

# STATE AND ASSIGNMENT Commands

x = 5
y = 6
z = 7

print(x, y, z)

x = 11
y = 13
z = x


print(x, y, z)

# IF THEN ELSE Commands

print("Let's explore conditionals!")

x = 5
if (x == 11):					# if (boolean expr):
	print("It's 11!")			# true branch; "..." is a string
else:							# optional else:
	print("It wasn't 11 ...")	# and the false branch
	x = 11
	print("... but now it is!")


# WHILE Commands

print("Let's loop!")
n = 5					# establish "loop index"
while (n > 0):			# if (boolean expression)
	print(n)			# loop body, executed if True
	n = n - 1			# You must avoid infinite loops!!!


# Exercise: compute the sum of integers from 1 to 10

# Note that this solution starts with 10 and goes to 0
print("Let's sum 1 to n!")
n = 10
sum = 0

while (n > 0):
	sum = sum + n
	n = n - 1
	print("The sum is", sum)

# Here's a version that starts at 0 and goes to 10

end = 10
cur = 0
sum = 0

while (cur <= end):
	sum = sum + cur
	cur = cur + 1
	print ("The sum is", sum)


# Finally, functions and recursion

def sum(n):
	if (n == 0):
		return 0
	else:
		return n + sum (n-1)

print ("The sum is", sum(10))

def fac(n):
	if (n == 0):
		return 1
	else:
		return n * fac(n-1)

print(fac(100))

n = 100
fact = 1

while (n > 0):
	fact = fact * n
	n = n - 1

print(fact)
