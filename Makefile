# MyPrefs
# https://github.com/kou64yama/myprefs
# Copyright 2013 Koji YAMADA; Licensed MIT.

.PHONY: usage emacs install_emacs nano install_nano

PREFIX = $(HOME)

usage:
	@echo "Usage: make (all|install|<package_name>|install_<package_name>)"

all: emacs nano
install: install_emacs install_nano

emacs:
install_emacs: emacs
	install -m 0644 emacs.d/init.el $(PREFIX)/.emacs.d/init.el

nano:
install_nano: nano
	install -m 0644 nanorc $(PREFIX)/.nanorc
	install -m 0755 -d $(PREFIX)/.nanorc.d
	install -m 0644 nanorc.d/*.nanorc $(PREFIX)/.nanorc.d
