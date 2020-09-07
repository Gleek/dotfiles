#!/usr/bin/env bash

declare -i index=1

# TILES[$index]="Monitor setup"
# COMMANDS[$index]="~/.config/rofi/scripts/monitor.sh"
# index+=1

# TILES[$index]="Calculator"
# COMMANDS[$index]="urxvt -title small_floating_term -e qalc"
# index+=1

# TILES[$index]="Command"
# COMMANDS[$index]="rofi -show run"
# index+=1

TILES[$index]="Emoji"
COMMANDS[$index]="~/.config/choose/emoji.sh"
index+=1


TILES[$index]="Find file"
COMMANDS[$index]="~/.config/choose/findfile.sh"
index+=1


TILES[$index]="Killall"
COMMANDS[$index]="~/.config/choose/killall.sh"
index+=1


TILES[$index]="QR Show"
COMMANDS[$index]="~/.config/choose/qr.sh"
index+=1

TILES[$index]="Launch app"
COMMANDS[$index]="~/.config/choose/applaunch.sh"
index+=1

TILES[$index]="Shutdown"
COMMANDS[$index]="osascript -e 'tell app \"System Events\" to shut down'"
index+=1


TILES[$index]="Restart"
COMMANDS[$index]="osascript -e 'tell app \"System Events\" to restart'"
index+=1


TILES[$index]="Sleep"
COMMANDS[$index]="osascript -e 'tell app \"System Events\" to sleep'"
index+=1

TILES[$index]="Restart Yabai"
COMMANDS[$index]='brew services restart yabai'
index+=1

TILES[$index]="Hammerspoon console"
COMMANDS[$index]='kitty --single-instance hs'
index+=1

TILES[$index]="Hammerspoon functions"
COMMANDS[$index]='~/.config/choose/hammerspoon.sh'
index+=1

# TILES[$index]="Kill - SIGTERM"
# COMMANDS[$index]="~/.config/choose/kill.sh 15"
# index+=1

# TILES[$index]="Kill - SIGKILL"
# COMMANDS[$index]="~/.config/choose/kill.sh 9"
# index+=1

# TILES[$index]="TERM"
# COMMANDS[$index]="~/.config/choose/term.sh"
# index+=1

function gen_entries {
    for a in $(seq 1 $(( ${#TILES[@]} )))
    do
        echo -e "$a\\t${TILES[a]}"
    done
}

SEL=$( gen_entries | ~/.config/choose/choose | awk '{print $1}' )
exec ${COMMANDS[$SEL]}
