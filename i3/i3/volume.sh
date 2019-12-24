#!/usr/bin/env bash
SINK=$(pacmd list-sinks|grep "* index:"|cut -d: -f2)
echo $SINK
echo $1
if [[ $1 == "inc" ]]
then
    pactl set-sink-volume $SINK +5%
fi

if [[ $1 == "dec" ]]
then
    pactl set-sink-volume $SINK -5%
fi

if [[ $1 == "mute" ]]
then
    pactl set-sink-mute $SINK toggle
fi
