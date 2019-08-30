
build:
	@ cd src ; dune build main.exe

run:
	@ ./src/_build/default/main.exe test.pyms

install:
	@ cd src ; dune install pyms

clean:
	@ rm -rf ./src/*.cmi ./src/*.cmo