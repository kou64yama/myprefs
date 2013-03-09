#!/bin/bash

extra() {
    while true; do
        echo "$(LANG=C date) "
        sleep 1
    done
}

cat | dzen2 -w 600 -ta l "$@"&
conky -c ~/.xmonad/conky.conf | dzen2 -x 600 -ta r "$@"
