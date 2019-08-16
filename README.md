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

The preceding exemple need to be compiled down to pure python prior to execution :

```
$ pyms bintree.pyms
$ python bintree.py
```

