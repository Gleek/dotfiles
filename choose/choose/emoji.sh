#!/usr/bin/env bash
export LANG=en_US.UTF-8
chosen=$(grep -v "#" ~/.config/choose/emojidata | ~/.config/choose/choose false)

[ "$chosen" != "" ] || exit

# c=$(echo "$chosen" | sed "s/[\t ].*//") # cut -c 1
c=$(echo "$chosen"|awk '{print $1};')
echo "$c"| pbcopy
osascript -e "display notification \"$c copied to clipboard.\" with title \"Emoji copied\""
