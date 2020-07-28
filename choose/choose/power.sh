#!/usr/bin/env bash
declare -i index=1

TILES[$index]="Shutdown"
COMMANDS[$index]="osascript -e 'tell app \"System Events\" to shut down'"
index+=1


TILES[$index]="Restart"
COMMANDS[$index]="osascript -e 'tell app \"System Events\" to restart'"
index+=1


TILES[$index]="Sleep"
COMMANDS[$index]="osascript -e 'tell app \"System Events\" to sleep'"
index+=1


function gen_entries {
    for a in $(seq 1 $(( ${#TILES[@]} )))
    do
        echo $a ${TILES[a]}
    done
}

SEL=$( gen_entries | ~/.config/choose/choose | awk '{print $1}' )
eval ${COMMANDS[$SEL]}
