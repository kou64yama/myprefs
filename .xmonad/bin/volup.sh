#!/bin/bash

icon="/usr/share/icons/Faenza/status/scalable/audio-volume-medium.svg"

percent=`amixer set Master 1.5dB+ | tail -n1 | sed "s/.*\[\(.*\)\%\].*/\1/"`
echo $percent

notify-send -i "$icon" -a volctrl "Volume $percent%"
