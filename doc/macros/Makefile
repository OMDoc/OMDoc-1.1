HERE	        = $(shell pwd)
EXAMPLESDIR     = $(HERE)/examples

ECHO		= /bin/echo
COPY            = /bin/cp
CVS             = cvs

all:
		(cd $(EXAMPLESDIR) && $(MAKE))
commit:
		$(CVS) commit -m "updated from source"
		chmod u+w *


