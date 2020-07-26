#!/usr/bin/env bash

chosen=$(grep -v "#" ~/.config/choose/emojidata | ~/.config/choose/choose false)

[ "$chosen" != "" ] || exit

# c=$(echo "$chosen" | sed "s/[\t ].*//")
c=$(echo "$chosen"|cut -c1)
echo "$c" | tr -d '\n' | pbcopy

osascript -e "display notification \"$c copied to clipboard.\" with title \"Emoji copied\""

