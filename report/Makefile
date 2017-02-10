filename=master
LATEX=pdflatex -shell-escape

pdf:
	$(LATEX) ${filename}.tex

clean:
	rm -f ${filename}.{ps,log,aux,out,dvi,bbl,blg}
	rm -rf _minted-${filename}

all: pdf

.PHONY: all clean pdf
