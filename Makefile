TALKSOURCE = byop.md

.PHONY: pdf
pdf: $(TALKSOURCE)
	pandoc -s -t beamer -H preamble.tex $(TALKSOURCE) -o byop.pdf

.PHONY: clean
clean:
	rm *.pdf
