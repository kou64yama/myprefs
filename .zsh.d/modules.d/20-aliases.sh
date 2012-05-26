#!/bin/zsh -f

if [ -x "/usr/share/vim/vim73/macros/less.sh" ]; then
    alias less="/usr/share/vim/vim73/macros/less.sh"
elif [ -x "${EPREFIX}/usr/share/vim/vim73/macros/less.sh" ]; then
    alias less="${EPREFIX}/usr/share/vim/vim73/macros/less.sh"
fi
