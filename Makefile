ifndef DESTDIR
DESTDIR=/usr/
endif
ifndef CONFDIR
CONFDIR=/etc
endif

install:
	install -v -m 644 qlgc-fastlinq-kmod-lib.sh $(DESTDIR)/lib/kvc/
	install -v -m 644 qlgc-fastlinq-kmod.conf $(CONFDIR)/kvc/
	install -v -m 755 qlgc-fastlinq-kmod-wrapper.sh $(DESTDIR)/lib/kvc/
	ln -sf ../lib/kvc/qlgc-fastlinq-kmod-wrapper.sh $(DESTDIR)/bin/spkut
