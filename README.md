# Pym-s

Python with a sweet functionnal taste

Pyms is a transpiler. It produces clean and reliable python modules from OCaml type definitions.

More than a transpiler, Pyms is also a language extension built on top of python allowing you to define OCaml-like variants and use them from a classical python source code.

Example (Hypothetical, not implemented yet) :

```python
# bintree.pyms

typedef binary_tree =
	| Node of int * binary_tree * binary_tree
	| Leaf of int

def count_leafs(bt):
	match bt:
	| Leaf(_) -> 1
	| Node(_, a, b) -> count_leafs(a) + count_leafs(b)
```

Examle (Demo, works fine with the current version) :

```python
# bintree.pyms

typedef binary_tree =
  | Node of int * binary_tree * binary_tree
  | Leaf of int
```

```python
# main.py
from bintree import *

def count_leafs(bt : binary_tree):
  if isinstance(bt, Leaf):
    return 1
  else:
    return count_leafs(bt.field_1) + count_leafs(bt.field_2)

# outputs 2
print(count_leafs(Node(0, Leaf(1), Leaf(2))))
```

The preceding exemple need to be compiled down to pure python prior to execution :

```
$ pyms bintree.pyms 1> bintree.py
$ python main.py
```

# Focus on the generated code

Pyms generated python code is annoted according to the [PEP 484](https://www.python.org/dev/peps/pep-0484/). It makes generated code well suited for use with python linter or type checker such as [pyre](https://pyre-check.org/). Future versions of Pym-s will also include an option to generate dynamic type assertions.

