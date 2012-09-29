#
# This file is written by
# Koji Yamada, <kou64yama@gmail.com>
# Written since Sep 2012

fpath=($HOME/.zsh/functions $fpath)

if [ $SHELL = $HOME/Gentoo/bin/zsh ]; then
    eval `dircolors $HOME/.zsh/colors`
fi

if [ $USER != "root" ]; then
    umask 077
fi

autoload -U zutil
autoload -U compinit && compinit
autoload -U complist
autoload -U history-search-end

zle -N history-beginning-search-forward-end history-search-end
zle -N history-beginning-search-backward-end history-search-end

bindkey -e
bindkey '^N' history-beginning-search-forward-end
bindkey '^P' history-beginning-search-backward-end

# Resource files
color_prompt="^(linux|.*color|rxvt.*)$"
for file in $HOME/.zsh/rc/*.rc; do
    source $file
done
unset file color_prompt
