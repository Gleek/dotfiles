#!/usr/bin/env bash

app=$(fd '.*\.app$' \
         "/Applications" \
         "/System/Applications" \
         "$HOME/Applications" \
         "/Developer/Applications" \
         "/Applications/Xcode.app/Contents/Applications" \
         "/System/Library/PreferencePanes" \
         "/Library/PreferencePanes" \
         "$HOME/Library/PreferencePanes" \
         "/System/Library/CoreServices/Applications" \
         "/System/Library/CoreServices/" \
         "/usr/local/Cellar" \
         "/Library/Scripts" \
         "$HOME/Library/Scripts" 2> /dev/null|stdbuf -oL rev|stdbuf -oL cut -d/ -f1|stdbuf -oL cut -d. -f2-|stdbuf -oL rev|~/.config/choose/choose)
[ "$app" != "" ] || exit
osascript -e "display notification \"Running $app.\" with title \"App\""
open -a "$app"
