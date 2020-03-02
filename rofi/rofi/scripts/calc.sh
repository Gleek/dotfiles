#!/usr/bin/env bash
if [ ! -z "$@" ]
then
    QUERY=$@
    echo "$QUERY"|qalc|tail -3|head -1
else
    echo "Type your expression"
fi
