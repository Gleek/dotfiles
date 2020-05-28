#!/usr/bin/env bash

chosen=$(grep -v "#" ~/.config/rofi/scripts/emoji-data | rofi -dmenu -i -p "Emoji")

[ "$chosen" != "" ] || exit

c=$(echo "$chosen" | sed "s/[\t ].*//")
echo "$c" | tr -d '\n' | xclip -selection clipboard
notify-send "'$c' copied to clipboard."
