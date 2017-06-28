ifndef PETALINUX
$(error "Error: PETALINUX environment variable not set.  Change to the root of your PetaLinux install, and source the settings.sh file")
endif

include apps.common.mk

HOOK = userhook.sh

all: build install

build:

clean:

.PHONY: install image

install: automount userhook env fbcon

automount:
	# Automount SD partition to /media/card
	mkdir -p $(TARGETDIR)/media/card
	$(TARGETINST) -a "/dev/mmcblk0p1 /media/card auto defaults,sync  0  0" /etc/fstab

userhook:
	# Add user hook to execute autostart.sh from SD FAT partition
	$(TARGETINST) -d -p 0755 $(HOOK) /etc/init.d/$(HOOK)
	$(TARGETINST) -s /etc/init.d/$(HOOK) /etc/rcS.d/S99$(HOOK)

env:
	# Add SD card bin directory to PATH
	$(TARGETINST) -a "export PATH=\$$PATH:/media/card/bin" /etc/profile
	# Set Qt environment variables
	$(TARGETINST) -a "export QT_QPA_FONTDIR=/usr/local/lib/fonts" /etc/profile
	$(TARGETINST) -a "export QT_QPA_PLATFORM_PLUGIN_PATH=/usr/local/lib/plugins" /etc/profile
	$(TARGETINST) -a "export QT_QPA_PLATFORM=linuxfb" /etc/profile
	$(TARGETINST) -a "export QT_QPA_GENERIC_PLUGINS=evdevmouse,evdevkeyboard" /etc/profile
	$(TARGETINST) -a "export QT_QPA_ENABLE_TERMINAL_KEYBOARD=1" /etc/profile
	# Restore terminal property after login
	$(TARGETINST) -a "echo -e '\033[?25h'" /etc/profile
	# Add library search path
	$(TARGETINST) -a "/usr/local/lib" /etc/ld.so.conf

fbcon:
	$(TARGETINST) -a "1:2345:respawn:/sbin/getty -L 115200 tty1" /etc/inittab

help:
	@echo ""
	@echo "Quick reference for various supported build targets for $(INSTANCE)."
	@echo "----------------------------------------------------"
	@echo "  all                    build $(INSTANCE) and install to rootfs host copy"
	@echo "  install                install built objects to rootfs host copy"
