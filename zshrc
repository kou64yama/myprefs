# -*- shell-script -*-
# Copyright (c) 2013 YAMADA Koji; Licensed MIT

fpath=($HOME/.zsh/functions $fpath)
HISTFILE=$HOME/.zhistory HISTSIZE=1024 SAVEHIST=8192

autoload -U compinit && compinit
autoload -U history-search-end
autoload -U vcs_info
bindkey -e

# history search
zle -N history-beginning-search-forward-end history-search-end
zle -N history-beginning-search-backward-end history-search-end

bindkey '^N' history-beginning-search-forward-end
bindkey '^P' history-beginning-search-backward-end

# prompt
zstyle ':vcs_info:*' max-exports 5
zstyle ':vcs_info:*' formats '%s' '%r' '%b' '%S'
zstyle ':vcs_info:*' actionformats '%s' '%r' '%b' '%S' '%a'

precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    local vcss=$vcs_info_msg_0_ vcsr=$vcs_info_msg_1_ vcsb=$vcs_info_msg_2_ \
        vcsS=$vcs_info_msg_3_ vcsa=$vcs_info_msg_4_

    if [ $vcss ]; then
        psvar[1]=$vcss':'
    fi
    psvar[2]=`pwd`
    if [ $vcss ]; then
        psvar[2]=${psvar[2]%%/$vcsS}
        psvar[4]='/'$vcsS
    fi
    if [ $vcsb ]; then
        psvar[3]='-'$vcsb
    fi
    if [ $vcsa ]; then
        psvar[5]=':'$vcsa
    fi
}

if [[ $TERM =~ '^(linux|screen|xterm.*|.*color|rxvt.*)$' ]]; then
    autoload -U myprompt && myprompt
    PROMPT='%F{yellow}%1v%M%F{blue}%2v%F{magenta}%3v%F{cyan}%4v%F{red}%5v%f'$'\n'$PROMPT
fi
