prefix  ?= /usr
bindir  ?= $(prefix)/bin
datadir ?= $(prefix)/share

APPDATADIR ?= $(datadir)/appdata
DESKTOPDIR ?= $(datadir)/applications
ICONDIR    ?= $(datadir)/icons/hicolor
PIXMAPDIR  ?= $(datadir)/pixmaps

FLAKE8  ?= /usr/bin/flake8
INSTALL ?= /usr/bin/install -p
RM      ?= /usr/bin/rm
SED     ?= /usr/bin/sed
TOUCH   ?= /bin/touch

APPNAME = gnome-password-generator
DESTDIR =


.PHONY: all build clean install lint


all: build


$(APPNAME):
	$(SED) 's|/usr/share/pixmaps|$(PIXMAPDIR)|' < $@.py > $@
	$(TOUCH) -r $@.py $@


build: $(APPNAME)


install: build
	$(INSTALL) -d -pm0755 $(DESTDIR)$(bindir)
	$(INSTALL) -pm0755 $(APPNAME) $(DESTDIR)$(bindir)
	$(INSTALL) -d -pm0755 $(DESTDIR)$(APPDATADIR)
	$(INSTALL) -pm0644 data/$(APPNAME).appdata.xml $(DESTDIR)$(APPDATADIR)
	$(INSTALL) -d -pm0755 $(DESTDIR)$(DESKTOPDIR)
	$(INSTALL) -pm0644 data/$(APPNAME).desktop $(DESTDIR)$(DESKTOPDIR)
	$(INSTALL) -d -pm0755 $(DESTDIR)$(ICONDIR)/96x96/apps
	$(INSTALL) -pm0644 data/$(APPNAME).png $(DESTDIR)$(ICONDIR)/96x96/apps
	$(INSTALL) -d -pm0755 $(DESTDIR)$(ICONDIR)/scalable/apps
	$(INSTALL) -pm0644 data/$(APPNAME).svg $(DESTDIR)$(ICONDIR)/scalable/apps
	$(INSTALL) -d -pm0755 $(DESTDIR)$(PIXMAPDIR)
	$(INSTALL) -pm0644 data/$(APPNAME).png $(DESTDIR)$(PIXMAPDIR)


clean:
	$(RM) -fr $(APPNAME)


lint:
	$(FLAKE8) $(APPNAME).py
