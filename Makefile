
build:
	@ dune build @install

run:
	@ ./src/_build/default/main.exe test.pyms

install:
	@ dune install Pyms

clean:
	@ rm -rf ./src/*.cmi ./src/*.cmo