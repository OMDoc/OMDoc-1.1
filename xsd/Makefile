PREFIX          = ..
BINDIR          = $(PREFIX)/bin
XSLT		= $(BINDIR)/saxon

BUTFILES	= omobj.xsd XMLSchema.xsd omdoc10.xsd
XSD		= $(filter-out $(BUTFILES), $(shell ls *.xsd))
VXSD		= omdoc.xsd MathML.xsd omobj.xsd
TESTED		= $(patsubst %.xsd,.%.tested, $(XSD))
XSDHTML		= $(patsubst %.xsd,%.html, $(VXSD))
XMLPARSE 	= rxp -V -s -x

all:		$(XSDHTML)

test:		$(TESTED)

$(XSDHTML):	%.html: %.xsd schema2xhtml.xsl
		$(XSLT) -o $@ $(firstword $<) schema2xhtml.xsl

.%.tested:	%.xsd $(DTD)
		$(XMLPARSE) $< && touch $@

test-clean:	
		rm -f .*.tested

clean:		test-clean
		rm -f *~ .*~

distclean:		test-clean
		rm -f *.html

test-all:	test-clean test

