TEXSRC = latex2omdoc.tex omdocex.tex migrationex.tex

all: latex2omdoc.ps

latex2omdoc.dvi: ${TEXSRC} latex2omdoc.bbl latex2omdoc.ind
	latex latex2omdoc

latex2omdoc.idx: 
	latex latex2omdoc

latex2omdoc.ind: latex2omdoc.idx
	makeindex latex2omdoc
 
latex2omdoc.ps: latex2omdoc.dvi 
	dvips -o latex2omdoc.ps latex2omdoc.dvi

bib: latex2omdoc.bbl

latex2omdoc.bbl: 
	latex latex2omdoc
	bibtex latex2omdoc

latex2omdoc.aux: latex2omdoc.dvi

clean:
	rm -f *.aux *.log *.bbl *.blg *.dvi *.ps 
