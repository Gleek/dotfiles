#!/usr/bin/env bash

NES_DIR=/mnt/data/Games/nes
SNES_DIR=/mnt/data/Games/snes

NES_GAMES=$((cd $NES_DIR && ls -1 *.nes) | sed -e 's/^/[NES] /'|sort)
SNES_GAMES=$((cd $SNES_DIR && ls -1 *.smc) | sed -e 's/^/[SNES] /'|sort)
chosen=$(echo -e "$NES_GAMES\n$SNES_GAMES" | rofi -dmenu -i -p "Game")
[ "$chosen" != "" ] || exit
game=$(echo $chosen | sed -e 's/^\[.*\] //')
[[ $(echo "$chosen" | grep -w "^\[NES\]") ]] && nestopia -w "$NES_DIR/$game"
[[ $(echo "$chosen" | grep -w "^\[SNES\]") ]] && snes9x-gtk "$SNES_DIR/$game"

