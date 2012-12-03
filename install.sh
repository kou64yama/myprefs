#!/usr/bin/env bash

pretend="no"
rsync_command="rsync -av"

targets_list=("
emacs
fontconfig
gtkrc
tmux
xdefaults
xmonad
zsh
nano
")

declare -A targets_files
targets_files=(
    ["emacs"]=".emacs.d"
    ["fontconfig"]=".fonts.conf"
    ["gtkrc"]=".gtkrc-2.0"
    ["tmux"]=".tmux.conf"
    ["xdefaults"]=".Xdefaults"
    ["xmonad"]=".xmonad"
    ["zsh"]=".zsh .zshrc .zlogout .zprofile"
    ["nano"]=".nanorc .nanorc.d"
)

__main__() {

    while getopts hlp OPTCHR "$@"; do
        case $OPTCHR in
            h) usage_exit 0;;
            l) print_targets_list && exit 0;;
            p) rsync_command="$rsync_command --list-only";;
        esac
    done

    shift $(( $OPTIND - 1 ))
    unset OPTIND OPTARG OPTCHR

    install_targets "$@"

}

usage() {
    echo "Usage: ${0##.*/} [option] target..."
    echo "Targets:"
    for i in $targets_list; do
        echo "    $i: ${targets_files[$i]}"
    done
}

print_targets_list() {
    echo $targets_list
}

usage_exit() {
    local error=$1; shift
    [ $# -gt 0 ] && echo "${0##.*/}: $@"
    if [ $error -gt 0 ]; then
        usage 1>&2
    else
        usage
    fi
    exit $error
}

install_targets() {

    [ $# -eq 0 ] && usage_exit 1 "no targets"

    local files

    for i in "$@"; do
        files="$files ${targets_files[$i]}"
    done

    $rsync_command $files $HOME

}

__main__ "$@"
