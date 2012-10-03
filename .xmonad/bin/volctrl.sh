#!/bin/bash

notify_command="/usr/bin/notify-send"
amixer_command="/usr/bin/amixer"
icon="/usr/share/icons/Faenza/status/scalable/audio-volume-medium.svg"

if [ ! -x "$notify_command" ]; then
    notify_command=`which notify-send 2> /dev/null`
    [ $? -ne 0 ] && exit 1
fi

if [ ! -x "$amixer_command" ]; then
    amixer_command=`which amixer 2> /dev/null`
    [ $? -ne 0 ] && exit 1
fi

while getopts i:d:t OPTCHR "$@"; do
    case $OPTCHR in
        i) execute="$amixer_command set Master ${OPTARG}dB+";;
        d) execute="$amixer_command set Master ${OPTARG}dB-";;
        t) execute="$amixer_command set Master toggle";;
    esac
done

$notify_command -i $icon "`$execute | tail -n1`"
