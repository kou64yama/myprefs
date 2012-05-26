#!/bin/zsh -f

if [ "${TERM}" = "linux" ]; then

    fbterm() {
        echo -ne "\e[?25l"
        export TERM="fbterm"
        /usr/bin/fbterm
        echo -ne "\e[?25h"
    }

fi
