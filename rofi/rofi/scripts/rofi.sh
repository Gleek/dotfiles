#!/usr/bin/env bash

declare -i index=1

TILES[$index]="Monitor setup"
COMMANDS[$index]="~/.config/rofi/scripts/monitor.sh"
index+=1

TILES[$index]="Calculator"
COMMANDS[$index]="urxvt -title small_floating_term -e qalc"
index+=1

TILES[$index]="Command"
COMMANDS[$index]="rofi -show run"
index+=1

TILES[$index]="Emoji"
COMMANDS[$index]="~/.config/rofi/scripts/emoji.sh"
index+=1

TILES[$index]="QR Show"
COMMANDS[$index]="~/.config/rofi/scripts/qr.sh"
index+=1

TILES[$index]="NES Games"
COMMANDS[$index]="~/.config/rofi/scripts/nestopia.sh"
index+=1


function gen_entries {
    for a in $(seq 1 $(( ${#TILES[@]} )))
    do
        echo $a ${TILES[a]}
    done
}

SEL=$( gen_entries | rofi -dmenu -i -p "Options" -no-custom  | awk '{print $1}' )
exec ${COMMANDS[$SEL]}
