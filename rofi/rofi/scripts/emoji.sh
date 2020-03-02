#!/usr/bin/env bash

chosen=$(grep -v "#" ~/.emoji | rofi -dmenu -i -p "Emoji")

[ "$chosen" != "" ] || exit

c=$(echo "$chosen" | sed "s/ .*//")
echo "$c" | tr -d '\n' | xclip -selection clipboard
notify-send "'$c' copied to clipboard."
