#!/usr/bin/env bash

app=$(fd '.*\.app$' /Applications /usr/local/Cellar /System/Applications |stdbuf -oL rev|stdbuf -oL cut -d/ -f1|stdbuf -oL cut -d. -f2-|stdbuf -oL rev|~/.config/choose/choose)
[ "$app" != "" ] || exit
osascript -e "display notification \"Running $app.\" with title \"App\""
open -a "$app"
