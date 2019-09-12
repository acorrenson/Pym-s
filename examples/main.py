from bintree import *

def count_leafs(bt : binary_tree):
  if isinstance(bt, Leaf):
    return 1
  else:
    _, child1, child2 = bt
    return count_leafs(child1) + count_leafs(child2)

print(count_leafs(Node(0, Leaf(1), Leaf(2))))