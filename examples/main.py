from bintree import *

def count_leafs(bt : binary_tree):
  if isinstance(bt, Leaf):
    return 1
  else:
    return count_leafs(bt.field_1) + count_leafs(bt.field_2)

print(count_leafs(Node(0, Leaf(1), Leaf(2))))