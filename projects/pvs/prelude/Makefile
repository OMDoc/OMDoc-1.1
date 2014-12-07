PREFIX          = ../../..
LIBDIR          = $(PREFIX)/lib
XSLDIR          = $(PREFIX)/xsl
BINDIR          = $(PREFIX)/bin
XSLT		= $(BINDIR)/saxon

LATEX		= latex
DVIPS		= dvips
XMLPARSE 	= xmlnorm -V -s

BUTFILES 	= catalogue.omdoc
OMDOCFILES	= $(filter-out $(BUTFILES),$(shell ls *.omdoc))

# we will need three kinds of files for all OMDoc documents
# 2XSLFILES that can be used to translate the .omdoc files 
# IXSLFILES that have the include statements for 2?XSL
# 4XSLFILES that have the templates for 2?XSL
IXSLFILES	= $(patsubst %.omdoc, %-incl.xsl,$(OMDOCFILES))
4XSLFILES	= $(patsubst %.omdoc, %-tmpl.xsl,$(OMDOCFILES))
2HXSLFILES	= $(patsubst %.omdoc, %2html.xsl,$(OMDOCFILES))
2TXSLFILES	= $(patsubst %.omdoc, %2TeX.xsl,$(OMDOCFILES))
2PXSLFILES	= $(patsubst %.omdoc, %2pmml.xsl,$(OMDOCFILES))
2PVSXSLFILES	= $(patsubst %.omdoc, %2pvs.xsl,$(OMDOCFILES))

HTMLFILES	= $(patsubst %.omdoc, %.html,$(OMDOCFILES))
TEXFILES	= $(patsubst %.omdoc, %.tex,$(OMDOCFILES))
PMMLFILES	= $(patsubst %.omdoc, %.xml,$(OMDOCFILES))
PVSFILES	= $(patsubst %.omdoc, %.pvs,$(OMDOCFILES))

PSFILES		= $(patsubst %.omdoc, %.ps,$(OMDOCFILES))
DVIFILES	= $(patsubst %.omdoc, %.dvi,$(OMDOCFILES))
CDFILES		= $(patsubst %.omdoc, %.ocd,$(OMDOCFILES))
OMDOCS_TESTED	= $(patsubst %.omdoc,.%.tested, $(OMDOCFILES))

all:		$(4XSLFILES) $(IXSLFILES) $(2XSLFILES) $(PVSFILES) $(HTMLFILES) $(PMMLFILES) $(PSFILES) 

html: 		$(HTMLFILES)
ps: 		$(PSFILES)
mml:            $(PMMLFILES)
i: 		$(IXSLFILES)
2: 		$(2XSLFILES)
4: 		$(4XSLFILES)
test:		$(OMDOCS_TESTED)

.%.tested:	%.omdoc
		$(XMLPARSE) $< && touch $@

test-clean:	
		-rm -f .*.tested

test-all:	test-clean test

clean:
		rm -f *.xsl *.aux *.log *.bbl *.blg *.dvi 



$(IXSLFILES):	%-incl.xsl: %.omdoc $(XSLDIR)/exincl.xsl 
		$(XSLT) -o $@ $(firstword $<) $(XSLDIR)/exincl.xsl 

$(4XSLFILES): %-tmpl.xsl: %.omdoc $(XSLDIR)/expres.xsl 
		$(XSLT) -o $@ $(firstword $<) $(XSLDIR)/expres.xsl 

$(2HXSLFILES):	%2html.xsl: %.omdoc Makefile $(BINDIR)/make2files
		$(BINDIR)/make2files '$(XSLDIR)/omdoc2html.xsl' '$(basename $(firstword $<))-incl.xsl' > $@
$(2TXSLFILES):	%2TeX.xsl: %.omdoc Makefile $(BINDIR)/make2files
		$(BINDIR)/make2files '$(XSLDIR)/omdoc2tex.xsl' '$(basename $(firstword $<))-incl.xsl' > $@
$(2PXSLFILES):	%2pmml.xsl: %.omdoc Makefile $(BINDIR)/make2files
		$(BINDIR)/make2files '$(XSLDIR)/omdoc2pmml.xsl' '$(basename $(firstword $<))-incl.xsl' > $@
$(2PVSXSLFILES): %2pvs.xsl: %.omdoc Makefile $(BINDIR)/make2files
		$(BINDIR)/make2files '$(XSLDIR)/omdoc2pvs.xsl' '$(basename $(firstword $<))-incl.xsl' > $@

$(HTMLFILES): %.html: %.omdoc %-incl.xsl %2html.xsl %-tmpl.xsl $(XSLDIR)/omdoc2html.xsl $(XSLDIR)/omdoc2share.xsl
		$(XSLT) -o $@ $(firstword $<) $(basename $(firstword $<))2html.xsl 
$(TEXFILES): %.tex: %.omdoc %-incl.xsl %2TeX.xsl %-tmpl.xsl $(XSLDIR)/omdoc2tex.xsl $(XSLDIR)/omdoc2share.xsl
		$(XSLT) -o $@ $(firstword $<) $(basename $(firstword $<))2TeX.xsl 
$(PMMLFILES): %.xml: %.omdoc %-incl.xsl %2pmml.xsl %-tmpl.xsl $(XSLDIR)/omdoc2pmml.xsl $(XSLDIR)/omdoc2share.xsl $(XSLDIR)/omdoc2html.xsl
		$(XSLT) -o $@ $(firstword $<) $(basename $(firstword $<))2pmml.xsl
$(PVSFILES): %.pvs: %.omdoc %-incl.xsl %2pvs.xsl %-tmpl.xsl $(XSLDIR)/omdoc2pvs.xsl $(XSLDIR)/omdoc2sys.xsl 
		$(XSLT) -o $@ $(firstword $<) $(basename $(firstword $<))2pvs.xsl


$(DVIFILES): %.dvi: %.tex %.omdoc omdoc.sty
		$(LATEX) "\nonstopmode\input $(firstword $<)"
		$(LATEX) "\nonstopmode\input $(firstword $<)"
		$(LATEX) "\nonstopmode\input $(firstword $<)"

$(PSFILES): %.ps: %.dvi
		$(DVIPS) -o $@ $<

index.html: $(XSLDIR)/cat2index.xsl catalogue.omdoc
		$(XSLT) -o index.html catalogue.omdoc $(XSLDIR)/cat2index.xsl

missing.html: $(XSLDIR)/nopres.xsl catalogue.omdoc $(OMDOCFILES)
		$(XSLT) -o missing.html catalogue.omdoc $(XSLDIR)/nopres.xsl

omdoc.sty:    
		ln -s $(LIBDIR)/omdoc.sty .	
