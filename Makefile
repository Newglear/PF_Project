
build:
	@echo "\n==== COMPILING ====\n"
	ocamlbuild ftest.native

format:
	ocp-indent --inplace src/*

edit:
	code . -n

demo: build
	@echo "\n==== EXECUTING ====\n"
	./ftest.native graphs/graph1 1 2 outfile
	@echo "\n==== RESULT ==== (content of outfile) \n"
	@cat outfile
	dot -Tsvg graphs/dotgraphoutputgwencador > graphs/dotgraphoutputgwencador.svg

# dot: build
# 	dot -Tsvg graphs/dotgraphoutputgwencador > graphs/dotgraphoutputgwencador.svg
	

clean:
	-rm -rf _build/
	-rm ftest.native
