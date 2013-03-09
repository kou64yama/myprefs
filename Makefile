# MyPrefs
# https://github.com/kou64yama/myprefs
# Copyright 2013 Koji YAMADA; Licensed MIT.

.PHONY: usage \
emacs install_emacs \
nano install_nano \
zsh install_zsh \
xmonad install_xmonad \
xdefaults install_xdefaults

PREFIX = $(HOME)

usage:
	@echo "Usage: make (all|install|<package_name>|install_<package_name>)"

all: emacs nano zsh xmonad xdefaults
install: install_emacs install_nano install_zsh install_xmonad \
install_xdefaults

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
	install -m 0755 -d $(PREFIX)/.zsh/functions
	install -m 0644 zsh/functions/* $(PREFIX)/.zsh/functions

xmonad:
install_xmonad: xmonad
	install -m 0755 -d $(PREFIX)/.xmonad
	install -m 0644 xmonad/xmonad.hs $(PREFIX)/.xmonad

xdefaults:
install_xdefaults: xdefaults
	install -m 0644 Xdefaults $(PREFIX)/.Xdefaults
