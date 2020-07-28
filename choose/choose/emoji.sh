#!/usr/bin/env bash

chosen=$(grep -v "#" ~/.config/choose/emojidata | ~/.config/choose/choose false)

[ "$chosen" != "" ] || exit

# c=$(echo "$chosen" | sed "s/[\t ].*//") # cut -c 1
c=$(echo "$chosen"|awk '{print $1};')
echo "$c" | tr -d '\n' | pbcopy

osascript -e "display notification \"$c copied to clipboard.\" with title \"Emoji copied\""

