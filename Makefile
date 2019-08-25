
build:
	@ cd src ; dune build main.exe

run:
	@ ./src/_build/default/main.exe

clean:
	@ rm -rf ./src/*.cmi ./src/*.cmo