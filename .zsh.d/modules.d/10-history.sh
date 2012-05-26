#!/bin/zsh -f

if [ ! "${SUDO_COMMAND}" ]; then

    HISTFILE="${HOME}"/.zhistory
    HISTSIZE=10000
    SAVEHIST=10000

    setopt hist_ignore_dups
    setopt hist_ignore_all_dups
    setopt share_history

fi

autoload history-search-end
zle -N history-beginning-search-forward-end history-search-end
zle -N history-beginning-search-backward-end history-search-end
