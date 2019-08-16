"""
BINTREE Module

This file is part of the Pym-s project,
it is distributed under the MIT license.

AUTHOR : Arthur Correnson
"""

import sys

# EXEMPLE OF A GENERATED TYPE DEFINITION

class BINTREE:
	"""
		BINTREE is nothing than a dynamic wrapper arround a new type
	"""
	def __init__(self):
		# BINTREE should not be used as a constructor
		sys.exit("BINTREE is a Pym-s type name and cant be called as a constructor") 


class NODE(BINTREE):
	# annotations for type checkers
	a : int
	b : BINTREE
	c : BINTREE

	def __init__(self, a : int, b : BINTREE, c : BINTREE):
		# OPTIONAL DYNAMIC CHECK
		assert (type(a) == int)
		assert (isinstance(b, BINTREE)) 
		assert (isinstance(c, BINTREE))
		# ----------------------

		self.a = a
		self.b = b


class LEAF(BINTREE):
	# annotations for type checkers
	a : int

	def __init__(self, a : int):
		# OPTIONAL DYNAMIC CHECK
		assert (type(a) == int)
		# ----------------------
		
		self.a = a


bt = NODE(1, LEAF(2), LEAF(3))
bt = NODE(1, LEAF('a'), LEAF(3))

