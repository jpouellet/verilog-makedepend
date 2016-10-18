INSTALL_PROGRAM=install -m 755
DESTDIR=
prefix=/usr/local
bindir=$(prefix)/bin

all:

install:
	$(INSTALL_PROGRAM) vmakedep.sh $(DESTDIR)$(bindir)/vmakedep
