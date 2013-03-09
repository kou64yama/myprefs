# -*- shell-script -*-
# Copyright (c) 2013 YAMADA Koji; Licensed MIT

fpath=($HOME/.zsh/functions $fpath)
HISTFILE=$HOME/.zhistory HISTSIZE=1024 SAVEHIST=8192

autoload -U compinit && compinit
autoload -U history-search-end

if [[ $TERM =~ '^(linux|screen|xterm.*|.*color|rxvt.*)$' ]]; then
    autoload myprompt && myprompt
fi

zle -N history-beginning-search-forward-end history-search-end
zle -N history-beginning-search-backward-end history-search-end

bindkey -e
bindkey '^N' history-beginning-search-forward-end
bindkey '^P' history-beginning-search-backward-end
