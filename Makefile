
build:
	@ dune build @install

run:
	@ echo "transpiling input ..."
	@ ./_build/default/main.exe -i ./examples/bintree.pyms
	@ echo "interpreting python output ..."
	@ python3 ./examples/main.py

install:
	@ dune install Pyms

clean:
	@ rm -rf ./src/*.cmi ./src/*.cmo