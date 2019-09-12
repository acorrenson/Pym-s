# Pym-s

> Python with a sweet functionnal taste

Pyms is a transpiler. It produces clean and reliable python modules from OCaml-like type definitions. Pym-s is mainly designed to make symbolic manipulations easier and safer in python3.

Python modules generated with Pym-s are annotated according to the [PEP 484](https://www.python.org/dev/peps/pep-0484/) making them well suited for use with modern linters or type checkers such as [pyre](https://pyre-check.org/). Future versions of Pym-s will also include an option to generate dynamic type verification.

**Example** :

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
    _, child1, child2 = bt
    return count_leafs(child1) + count_leafs(child2)

# outputs 2
print(count_leafs(Node(0, Leaf(1), Leaf(2))))
```

The preceding exemple need to be compiled down to pure python prior to execution :

```
$ pyms -i bintree.pyms -o bintree.py
$ python3 main.py
```

# Install

Installing Pyms requires opam and a working ocaml environnement. While waiting for Pyms to be published on Opam, it is still possible to install it easily.

To install ocaml and opam, please visit [this link](https://ocaml.org/docs/install.html)


## If you just have opam installed :

```
git clone git@github.com:jdrprod/Pym-s.git
cd Pym-s
opam pin .
opam install .
```

## If you already use dune :

```
git clone git@github.com:jdrprod/Pym-s.git
cd Pym-s
dune build @install
dune install
```
