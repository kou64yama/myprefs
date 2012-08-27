#!/bin/bash

icon="/usr/share/icons/Faenza/status/scalable/audio-volume-medium.svg"

percent=`amixer set Master toggle | tail -n1 | sed "s/.*\[\(on\|off\)\].*/\1/"`
echo $percent

notify-send -i "$icon" -a volctrl "Volume $percent"
