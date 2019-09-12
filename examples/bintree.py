class binary_tree:
    def __init__(self):
         pass

class Node(binary_tree):
    __field_0 : int
    __field_1 : binary_tree
    __field_2 : binary_tree
    def __init__(self, arg_0 : int , arg_1 : binary_tree , arg_2 : binary_tree ):
        self.__field_0 = arg_0
        self.__field_1 = arg_1
        self.__field_2 = arg_2
    def __iter__(self):
        yield self.__field_0
        yield self.__field_1
        yield self.__field_2

class Leaf(binary_tree):
    __field_0 : int
    def __init__(self, arg_0 : int ):
        self.__field_0 = arg_0
    def __iter__(self):
        yield self.__field_0

