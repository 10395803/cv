.PHONY: all clean clean-aux

LATEX = pdflatex
LATEX_OPTIONS = --shell-escape
TARGET_EN = cv.pdf
TARGET = $(TARGET_EN)
TARGET_BASE = $(basename $(TARGET))
SOURCES_EN = cv.tex
INC = 

CLEANFILES = $(TARGET_BASE).pdf \
	*.ps *.log *.bak *.bbl *.aux *.blg *.dvi *.toc *.out *.nav *.snm *.vrb \
	*.listing
AUXFILES = *.aux *.blg *.log *.nav *.out *.snm *.toc *.vrb

RM = /bin/rm -f
figs = \
	img/passport.pdf
	img/selfie_0.jpg

all: $(TARGET) clean-aux

$(TARGET): $(TARGET_BASE).tex $(figs) $(INC)
	outfile=`mktemp .tex.XXXXXX`; \
	echo 'Rerun' > $$outfile; \
	until ! grep 'Rerun' $$outfile; do \
		$(LATEX) $(LATEX_OPTIONS) $(TARGET_BASE).tex | tee $$outfile; \
	done; \
	$(RM) $$outfile

$(TARGET_BASE).bbl: $(TARGET_BASE).bib
	$(LATEX) $(LATEX_OPTIONS) $(TARGET_BASE).tex && bibtex $(TARGET_BASE); \
	outfile=`mktemp .tex.XXXXXX`; \
	echo 'Rerun' > $$outfile; \
	until ! grep 'Rerun' $$outfile; do \
		$(LATEX) $(LATEX_OPTIONS) $(TARGET_BASE).tex | tee $$outfile; \
	done; \
	$(RM) $$outfile

clean:
	$(RM) $(CLEANFILES)

clean-aux:
	$(RM) $(AUXFILES)
