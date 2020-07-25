#!/usr/bin/env bash

app=$(( ls -1 /Applications; ls -1 /System/Applications )|sort -u|rev|cut -d. -f2-|rev|~/.config/choose/choose)
[ "$app" != "" ] || exit
osascript -e "display notification \"Running $app.\" with title \"App\""
open -a "$app"
