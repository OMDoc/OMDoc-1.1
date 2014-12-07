PREFIX		= .
MAKEDIRS 	= examples doc projects xsd emacs
TESTDIRS 	= $(MAKEDIRS) xsd 
CLEANDIRS 	= $(TESTDIRS)
include $(PREFIX)/lib/Makefile.subdirs
