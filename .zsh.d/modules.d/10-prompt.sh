#!/bin/zsh -f

# detect the color terminal.
case "${TERM}" in
    linux|xterm-*color|screen-*color|rxvt*)
        color_prompt=yes;;
esac

if [ "${color_prompt}" ]; then

    case `uname` in
        Linux|Darwin)
            alias ls="ls --color=auto";;
        FreeBSD)
            alias ls="ls -G";;
    esac
    alias grep="grep --color=auto"
    alias fgrep="fgrep --color=auto"
    alias egrep="egrep --color=auto"

    if [ "${UID}" = 0 ]; then
        prompt_type=root
    elif [ "${SSH_CONNECTION}" ]; then
        prompt_type=ssh
    else
        prompt_type=color
    fi

fi

# fancy prompt.
case "${prompt_type}" in
    color)
        autoload colors && colors
        PROMPT="%B%F{green}%n@%m%f%b:%F{blue}%c%f %F{magenta}%1v%f"
        PROMPT2="%F{blue}%_%f"
        RPTOMPT="%F{blue}%d %T%f"
        ;;
    root)
        autoload colors && colors
        PROMPT="%B%F{red}%n@%m%f%b:%F{blue}%c%f %F{magenta}%1v%f"
        PROMPT2="%F{blue}%_%f"
        RPTOMPT="%F{blue}%d %T%f"
        ;;
    ssh)
        autoload colors && colors
        PROMPT="%B%F{yellow}[ssh]%f%b %B%F{green}%n@%m%f%b:%F{blue}%c%f %F{magenta}%1v%f"
        PROMPT2="%F{blue}%_%f"
        RPTOMPT="%F{blue}%d %T%f"
        ;;
    *)
        PROMPT="%B%n@%m%b:%c %1v"
        PROMPT2="%_"
        RPTOMPT="%d %T"
        ;;
esac

# VCS infomation.

autoload -Uz vcs_info
zstyle ":vcs_info:*" formats "(%s:%b)"
zstyle ":vcs_info:*" actionformats "(%s:%b %a)"

precmd () {
    psvar=()
    LANG="en_US.UTF-8" vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

PROMPT="${PROMPT}
%% "
PROMPT2="${PROMPT2}> "
RPROMPT="[${RPTOMPT}]"

unset color_prompt prompt_type
