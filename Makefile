TEX = platex
DVIPDF = $(shell if type dvipdfmx 2>&1 >>/dev/null; then echo "dvipdfmx"; else echo "dvipdf"; fi)

PDFS = $(shell ls *.tex 2>/dev/null | sed "s/.tex/.pdf/")
DVIS = $(shell ls *.tex 2>/dev/null | sed "s/.tex/.dvi/")
PLOTTERS = $(shell ls *.plt 2>/dev/null)

PLOTS = $(shell grep output *.plt 2>/dev/null | grep -o '".*"' | sed -e 's/"//g')
GRAPHICS = $(shell grep includegraphics *.tex | grep -o '{.*}' | sed -e 's/[{}]//g')
DEPENDENCIES = $(shell python -c 'print(" ".join(set("${GRAPHICS}".split(" ")) - set("${PLOTS}".split(" "))))')

.PHONY: all
all: environ ${PDFS};

.PHONY: help
help:
	@echo report template
	@echo '        MIT License (c)2015 MacRat'
	@echo
	@echo make all : make report file.
	@echo make clean : cleanup temporary files.
	@echo make cleanall : cleanup all compiled file.
	@echo make environ : show directory information.
	@echo make help : show this.

.PHONY: environ
environ:
	@echo TEX: ${TEX}
	@echo DVIPDF: ${DVIPDF}
	@echo PLOTTERS: $(PLOTTERS)
	@echo
	@echo graph with gnuplot: ${PLOTS}
	@echo dependency graphics: ${DEPENDENCIES}
	@echo output: ${PDFS}
	@echo

.SUFFIXES: .tex .dvi .pdf

${PDFS}: ${DVIS} ${DEPENDENCIES}
	${DVIPDF} $*

${DVIS}: ${PLOTS} $(shell ls *.tex 2>/dev/null)
	${TEX} $*
	${TEX} $*
	${TEX} $*

${PLOTS}: $(PLOTTERS)
	gnuplot $(PLOTTERS)

.PHONY: clean
clean:
	-rm *.{dvi,log,aux}

.PHONY: cleanall
cleanall: clean
	-rm *.pdf ${PLOTS}
