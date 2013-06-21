# Baylor University Master's Thesis LaTeX template
#
# Trash auxiliary files: make clean
# Compile thesis: make

LATEX = pdflatex
BIBTEX = bibtex
MAKEINDEX = makeindex

RERUN = "(There were undefined references|Rerun to get (cross-references|the bars) right)"
RERUNBIB = "No file.*\.bbl|Citation.*undefined"
MAKEIDX = "^[^%]*\\makeindex"

MAIN_TEX := thesis.tex

TARGET = $(MAIN_TEX:%.tex=%.pdf)

COPY = if test -r $(<:%.tex=%.toc); then cp $(<:%.tex=%.toc) $(<:%.tex=%.toc.bak); fi 

all: $(TARGET)

$(TARGET): %.pdf : %.tex *.tex
	$(COPY);$(LATEX) $<
	egrep -q $(MAKEIDX) $< && ($(MAKEINDEX) $(<:%.tex=%);$(COPY);$(LATEX) $<) ; true
	egrep -c $(RERUNBIB) $(<:%.tex=%.log) && ($(BIBTEX) $(<:%.tex=%);$(COPY);$(LATEX) $<) ; true
	egrep -q $(RERUN) $(<:%.tex=%.log) && ($(COPY);$(LATEX) $<) ; true
	egrep -q $(RERUN) $(<:%.tex=%.log) && ($(COPY);$(LATEX) $<) ; true
	if cmp -s $(<:%.tex=%.toc) $(<:%.tex=%.toc.bak); then true ;else $(LATEX) $< ; fi
	rm -f $(<:%.tex=%.toc.bak)
	# Display relevant warnings
	egrep -i "(Reference|Citation).*undefined" $(<:%.tex=%.log) ; true

clean:
	-rm -f $(TARGET) $(PSF) $(PDF) $(MAIN_TEX:%.tex=%.bbl) $(MAIN_TEX:%.tex=%.blg) \
		$(MAIN_TEX:%.tex=%.log) $(MAIN_TEX:%.tex=%.out) $(MAIN_TEX:%.tex=%.lof) \
		$(MAIN_TEX:%.tex=%.lot) $(MAIN_TEX:%.tex=%.toc) *.aux

.PHONY: all clean

