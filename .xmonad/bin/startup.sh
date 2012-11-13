#!/bin/sh

hsetroot -fill /usr/share/backgrounds/constantine/default/wide/constantine.png
imsettings-switch -x
imsettings-reload
xcompmgr &
