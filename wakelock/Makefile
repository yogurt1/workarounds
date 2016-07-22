SERVICES = $(wildcard *.service)
SCRIPTS = $(wildcard *.sh)
RULES = $(wildcard *.rules)
FILES = $(SERVICES) $(SCRIPTS) $(RULES)

all: install
suinstall: $(SERVICES) $(SCRIPTS) $(RULES)
suuninstall:
	@echo $(FILES)

install:
	@sudo $(MAKE) suinstall
	@echo Installed successfuly

uninstall:
	@sudo $(MAKE) suuninstall
	@echo Uninstalled successfuly

services: $(SERVICES)
	@echo servicss: $^
	@cp $@ /etc/systemd/system/
	@systemctl daemon-reload

rules: $(RULES)
	@echo rules: $^
	@cp $^ /etc/udev/rules.d/
	@udevadm control -R

scripts: $(SCRIPTS)
	@echo scripts: $^
	@cp $^ /usr/local/bin/wakelock
	@chcon -t bin_t /usr/local/bin/wakelock

.PHONY: suuninstall suinstall install uninstall all rules scripts services
