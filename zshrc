# -*- shell-script -*-
# MyPrefs
# https://github.com/kou64yama/myprefs
# Copyright 2013 Koji YAMADA; Licensed MIT

fpath=($HOME/.zsh/functions $fpath)

eval `dircolors $HOME/.zsh/colors`

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
color_prompt="^(linux|screen|xterm.*|.*color|rxvt.*)$"
wchar_prompt="^(screen|xterm.*|rxvt.*)$"
for file in $HOME/.zsh/rc/*.rc; do
    source $file
done
unset file color_prompt wchar_prompt
