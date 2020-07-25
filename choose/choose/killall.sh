#!/usr/bin/env bash

chosen=$(ps -o comm -e|tail -n +2|rev|cut -d/ -f1|rev|sort -u|~/.config/choose/choose)
[ "$chosen" != "" ] || exit
osascript -e "display notification \"Killing all instances of $chosen\" with title \"Killall\""
killall "$chosen"
