#!/bin/bash

pretend="no"
rsync_command="rsync -av"

__main__() {

    while getopts ph OPTCHR "$@"; do
        case $OPTCHR in
            p) rsync_command="$rsync_command --list-only";;
            h) usage_exit 0;;
        esac
    done

    shift $(( $OPTIND - 1 ))
    unset OPTIND OPTARG OPTCHR

    install_targets "$@"

}

usage() {
    echo "Usage: ${0##.*/} [option] target..."
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
        case $i in
            emacs) files="$files .emacs.d";;
            zsh) files="$files .zshrc .zsh";;
            xmonad) files="$files .xmonad";;
            tmux) files="$files .tmux.conf";;
            gtkrc) files="$files .gtkrc-2.0";;
            *) usage_exit 2 "$i is unknown target";;
        esac
    done

    $rsync_command $files $HOME

}

__main__ "$@"
