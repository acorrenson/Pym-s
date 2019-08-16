"""
PTYPE Module

This file is part of the Pym-s project,
it is distributed under the MIT license.

AUTHOR : Arthur Correnson
"""

import sys

class BINT:
	"""
		BINT is nothing than a dynamic wrapper arround a new type
	"""
	def __init__(self):
		# BINT should not be used as a constructor
		sys.exit("BINT is a Pym-s name and cant be called as a constructor") 


class NODE(BINT):
	# annotations for type checkers
	a : int
	b : BINT
	c : BINT

	def __init__(self, a : int, b : BINT, c : BINT):
		# OPTIONAL DYNAMIC CHECK
		assert (type(a) == int)
		assert (isinstance(b, BINT))
		assert (isinstance(c, BINT))
		# ----------------------

		self.a = a
		self.b = b


class LEAF(BINT):
	# annotations for type checkers
	a : int

	def __init__(self, a : int):
		# OPTIONAL DYNAMIC CHECK
		assert (type(a) == int)
		# ----------------------
		
		self.a = a