PREFIX          = ../../..
LIBDIR          = $(PREFIX)/lib
XSLDIR          = $(PREFIX)/xsl
BINDIR          = $(PREFIX)/bin
XSLT		= $(BINDIR)/saxon

LATEX		= latex
DVIPS		= dvips
XMLPARSE 	= rxp -V -s

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

HTMLFILES	= $(patsubst %.omdoc, %.html,$(OMDOCFILES))
TEXFILES	= $(patsubst %.omdoc, %.tex,$(OMDOCFILES))
PMMLFILES	= $(patsubst %.omdoc, %.xml,$(OMDOCFILES))

PSFILES		= $(patsubst %.omdoc, %.ps,$(OMDOCFILES))
DVIFILES	= $(patsubst %.omdoc, %.dvi,$(OMDOCFILES))
CDFILES		= $(patsubst %.omdoc, %.ocd,$(OMDOCFILES))
OMDOCS_TESTED	= $(patsubst %.omdoc,.%.tested, $(OMDOCFILES))

MMLXSL		= ctop.xsl mathml.xsl pmathml.xsl pmathmlcss.xsl

all:		$(4XSLFILES) $(IXSLFILES) $(2XSLFILES) $(HTMLFILES) $(PMMLFILES) $(PSFILES) #missing.html  index.html 

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
		rm -f *.aux *.log *.bbl *.blg *~

distclean:      clean test-clean
		rm -f *.tex *.ps *.dvi *.html *.xml *.xsl omdoc.sty

$(IXSLFILES):	%-incl.xsl: %.omdoc $(XSLDIR)/exincl.xsl 
		$(XSLT) -o $@ $(firstword $<) $(XSLDIR)/exincl.xsl 

$(4XSLFILES): %-tmpl.xsl: %.omdoc $(XSLDIR)/expres.xsl 
		$(XSLT) -o $@ $(firstword $<) $(XSLDIR)/expres.xsl 

$(2HXSLFILES):	$(BINDIR)/make2files
		$(BINDIR)/make2files '$(XSLDIR)/omdoc2html.xsl' '$(patsubst %2html.xsl, %-incl.xsl, $@)' > $@
$(2TXSLFILES):	$(BINDIR)/make2files
		$(BINDIR)/make2files '$(XSLDIR)/omdoc2tex.xsl' '$(patsubst %2TeX.xsl, %-incl.xsl, $@)' > $@
$(2PXSLFILES):	$(BINDIR)/make2files
		$(BINDIR)/make2files '$(XSLDIR)/omdoc2pmml.xsl' '$(patsubst %2pmml.xsl, %-incl.xsl, $@)' > $@

$(HTMLFILES): %.html: %.omdoc %-incl.xsl %2html.xsl %-tmpl.xsl $(XSLDIR)/omdoc2html.xsl $(XSLDIR)/omdoc2share.xsl
		$(XSLT) -o $@ $(firstword $<) $(basename $(firstword $<))2html.xsl
$(TEXFILES): %.tex: %.omdoc %-incl.xsl %2TeX.xsl %-tmpl.xsl $(XSLDIR)/omdoc2tex.xsl $(XSLDIR)/omdoc2share.xsl
		$(XSLT) -o $@ $(firstword $<) $(basename $(firstword $<))2TeX.xsl 
$(PMMLFILES): %.xml: %.omdoc %-incl.xsl %2pmml.xsl %-tmpl.xsl $(XSLDIR)/omdoc2pmml.xsl $(XSLDIR)/omdoc2share.xsl $(XSLDIR)/omdoc2html.xsl $(MMLXSL)
		$(XSLT) -o $@ $(firstword $<) $(basename $(firstword $<))2pmml.xsl

$(DVIFILES): %.dvi: %.tex omdoc.sty
		$(LATEX) "\nonstopmode\input $(firstword $<)"
		$(LATEX) "\nonstopmode\input $(firstword $<)"

$(PSFILES): %.ps: %.dvi
		$(DVIPS) -o $@ $<

omdoc.sty:    
		ln -s $(LIBDIR)/omdoc.sty .	

$(MMLXSL): %.xsl:   
		ln -s $(LIBDIR)/$@ .
