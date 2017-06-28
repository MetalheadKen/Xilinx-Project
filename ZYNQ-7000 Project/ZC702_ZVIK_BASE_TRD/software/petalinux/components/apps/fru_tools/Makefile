ifndef PETALINUX
$(error "Error: PETALINUX environment variable not set.  Change to the root of your PetaLinux install, and source the settings.sh file")
endif

include apps.common.mk

BUILD_NUMBER_FILE = .version
DESTDIR=/usr/local

VERSION = 0
PATCHLEVEL = 8
SUBLEVEL = 1
EXTRALEVEL = $(shell cat $(BUILD_NUMBER_FILE))

CFLAGS+= -O2 -g -Wall -Wextra -ansi -pedantic
MING_CC=i586-mingw32msvc-gcc
MING_INSTALL = $(shell expr `which $(MING_CC) | wc -l` \>= 1)
INSTALLER = makensis
INSTALLER_INSTALLED =  $(shell expr `which $(INSTALLER) | wc -l` \>= 1)

MAIN_VERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL))).$(EXTRALEVEL)

BUILD_FLAGS = -DVERSION=\"$(MAIN_VERSION)\" -DVERSION_DATE=\"$(shell date '+%d%b%Y')\"

APP = fru-dump

all: build install

build: $(APP)

$(APP):
	@if ! test -f $(BUILD_NUMBER_FILE); then echo 0 > $(BUILD_NUMBER_FILE); fi
	@echo $$(($$(cat $(BUILD_NUMBER_FILE)) + 1)) > $(BUILD_NUMBER_FILE)
	$(CC) $(CFLAGS) $(BUILD_FLAGS) fru.c operating-system.c -o $(APP)$(EXE)

win:
ifeq "$(MING_INSTALL)" "1"
	$(MING_CC) $(CFLAGS)  $(BUILD_FLAGS) fru.c operating-system.c -o $(APP).exe
ifeq "$(INSTALLER_INSTALLED)" "1"
	$(INSTALLER) -V2 -DVERSION=$(MAIN_VERSION) fru-tools.nsi
	mv fru-tools_installer.exe fru-tools-$(MAIN_VERSION)_installer.exe
	chmod +x  fru-tools-$(MAIN_VERSION)_installer.exe
endif
else
	echo "Couldn't find mingw32 toolchain"
endif

test: all
	valgrind --leak-check=full ./fru-dump -h
	valgrind --leak-check=full ./fru-dump -b -v ./masterfiles/AD-FMCOMMS2-EBZ-FRU.bin
	valgrind --leak-check=full ./fru-dump -2 -v ./masterfiles/AD-FMCOMMS2-EBZ-FRU.bin
	valgrind --leak-check=full ./fru-dump -c -v ./masterfiles/AD-FMCOMMS2-EBZ-FRU.bin
	valgrind --leak-check=full ./fru-dump -p -v ./masterfiles/AD-FMCOMMS2-EBZ-FRU.bin
	valgrind --leak-check=full ./fru-dump ./masterfiles/AD-FMCOMMS2-EBZ-FRU.bin -o ./foo2.bar
	valgrind --leak-check=full ./fru-dump ./masterfiles/AD-FMCOMMS2-EBZ-FRU.bin -6 -o ./foo2.bar
	valgrind --leak-check=full ./fru-dump -b -v ./foo2.bar
	valgrind --leak-check=full ./fru-dump -2 -v ./foo2.bar
	valgrind --leak-check=full ./fru-dump -c -v ./foo2.bar
	valgrind --leak-check=full ./fru-dump -p -v ./foo2.bar

clean:
	rm -f $(APP) $(APP).exe fru-tools-*_installer.exe *.gdb *.o
	rm -f *~

.PHONY: install image

install: $(APP)
	$(TARGETINST) -d $(APP) $(DESTDIR)/bin/$(APP)
	$(TARGETINST) -d masterfiles $(DESTDIR)/lib/fmc-tools

help:
	@echo ""
	@echo "Quick reference for various supported build targets for $(INSTANCE)."
	@echo "----------------------------------------------------"
	@echo "  clean                  clean out build objects"
	@echo "  all                    build $(INSTANCE) and install to rootfs host copy"
	@echo "  build                  build subsystem"
	@echo "  install                install built objects to rootfs host copy"
