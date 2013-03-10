# MyPrefs
# https://github.com/kou64yama/myprefs
# Copyright 2013 Koji YAMADA; Licensed MIT.

.PHONY: usage \
emacs install_emacs \
nano install_nano \
zsh install_zsh \
xmonad install_xmonad \
xdefaults install_xdefaults \
tmux install_tmux

PREFIX = $(HOME)

usage:
	@echo "Usage: make (all|install|<package_name>|install_<package_name>)"

all: emacs nano zsh xmonad xdefaults tmux
install: install_emacs install_nano install_zsh install_xmonad \
install_xdefaults install_tmux

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
	install -m 0755 -d $(PREFIX)/.xmonad{,/bin,/hooks,/icons}
	install -m 0644 xmonad/xmonad.hs $(PREFIX)/.xmonad
	install -m 0644 xmonad/conky.conf $(PREFIX)/.xmonad
	install -m 0755 xmonad/bin/* $(PREFIX)/.xmonad/bin
	install -m 0755 xmonad/hooks/* $(PREFIX)/.xmonad/hooks
	install -m 0644 xmonad/icons/* $(PREFIX)/.xmonad/icons

xdefaults:
install_xdefaults: xdefaults
	install -m 0644 Xdefaults $(PREFIX)/.Xdefaults

tmux:
install_tmux: tmux
	install -m 0644 tmux.conf $(PREFIX)/.tmux.conf
