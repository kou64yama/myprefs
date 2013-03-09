# MyPrefs
# https://github.com/kou64yama/myprefs
# Copyright 2013 Koji YAMADA; Licensed MIT.

.PHONY: usage emacs install_emacs nano install_nano zsh install_zsh

PREFIX = $(HOME)

usage:
	@echo "Usage: make (all|install|<package_name>|install_<package_name>)"

all: emacs nano zsh
install: install_emacs install_nano install_zsh

emacs:
install_emacs: emacs
	install -m 0755 -d $(PREFIX)/.emacs.d
	install -m 0644 emacs.d/init.el $(PREFIX)/.emacs.d

nano:
install_nano: nano
	install -m 0644 nanorc $(PREFIX)/.nanorc
	install -m 0755 -d $(PREFIX)/.nanorc.d
	install -m 0644 nanorc.d/*.nanorc $(PREFIX)/.nanorc.d

zsh:
install_zsh: zsh
	install -m 0644 zshrc $(PREFIX)/.zshrc
	install -m 0755 -d $(PREFIX)/.zsh/rc
	install -m 0644 zsh/rc/* $(PREFIX)/.zsh/rc

xmonad:
install_xmonad: xmonad
	install -m 0755 -d $(PREFIX)/.xmonad
	install -m 0644 xmonad/xmonad.hs $(PREFIX)/.xmonad
