
build:
	@ cd src ; dune build main.exe

run:
	@ ./src/_build/default/main.exe test.pyms

clean:
	@ rm -rf ./src/*.cmi ./src/*.cmo