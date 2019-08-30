class binary_tree:
    def __init__(self):
         pass

class Node(binary_tree):
    field_0 : int
    field_1 : binary_tree
    field_2 : binary_tree
    def __init__(self, arg_0 : int , arg_1 : binary_tree , arg_2 : binary_tree ):
        self.field_0 = arg_0
        self.field_1 = arg_1
        self.field_2 = arg_2

class Leaf(binary_tree):
    field_0 : int
    def __init__(self, arg_0 : int ):
        self.field_0 = arg_0

