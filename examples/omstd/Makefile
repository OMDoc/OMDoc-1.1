PREFIX          = ../..
BUTFILES 	= catalogue.omdoc collection.omdoc index.omdoc
#CSS		= css='omdoccd.css'
include $(PREFIX)/lib/Makefile.vars

all:		4 i html ps mml index.html missing.html

include $(PREFIX)/lib/Makefile.general

%.imports:	%.omdoc imports.xsl
		$(XSLT) -o $@ $(firstword $<) imports.xsl
imports:	$(patsubst %.omdoc, %.imports, $(OMDOCFILES))
