SUBDIRS 	= feasibility
all html 4 i 2 clean test test-clean distclean::
	dirs="$(SUBDIRS)"; \
        for i in $$dirs; do \
          if (cd $$i && $(MAKE) -$(MAKEFLAGS) $@); \
          then true; else exit 1; fi; \
        done

