#!/usr/bin/env bash
signal=$1

process=$(ps -o pid,comm -e|tail -n +2|~/.config/choose/choose)

[ "$process" != "" ] || exit

kill -$signal $(echo $process|awk '{print $1;}')
osascript -e "display notification \"Killing $process with $signal.\" with title \"Kill $signal\""
