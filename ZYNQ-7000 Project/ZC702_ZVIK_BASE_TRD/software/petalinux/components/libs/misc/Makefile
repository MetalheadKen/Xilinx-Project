ifndef PETALINUX
$(error "Error: PETALINUX environment variable not set.  Change to the root of your PetaLinux install, and source the settings.sh file")
endif

include libs.common.mk

DESTDIR = /usr/local

LIB_EXT = so

install:
	for f in `find ./lib/ -name "*.$(LIB_EXT)*"`; do \
		if [ -h $$f ]; then \
			$(TARGETINST) -d -s $$(basename $$(readlink -f $$f)) $(DESTDIR)/lib/`basename $$f` ; \
		else \
			$(TARGETINST) -d $$f $(DESTDIR)/lib/ ; \
		fi; \
	done
	$(TARGETINST) -d ./lib/fonts $(DESTDIR)/lib/fonts
	$(TARGETINST) -d ./lib/libv4l $(DESTDIR)/lib/libv4l
	$(TARGETINST) -d ./lib/libv4l/plugins $(DESTDIR)/lib/libv4l/plugins
	$(TARGETINST) -d ./lib/plugins $(DESTDIR)/lib/plugins

help:
	@echo ""
	@echo "Quick reference for various supported build targets for $(INSTANCE)."
	@echo "----------------------------------------------------"
	@echo "  install                install built objects to rootfs host copy"
