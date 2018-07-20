# file_stats build process

FPC ?= fpc

BINDIR := bin
BINARY := file_stats

$(BINDIR)/$(BINARY):
	if [ ! -d $(BINDIR) ]; then mkdir $(BINDIR); fi
	$(FPC) $(BINARY).pas -o$(BINDIR)/$(BINARY)

.PHONY:
clean:
	rm -f $(BINDIR)/*
