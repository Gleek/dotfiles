#!/usr/bin/env bash

chosen=$(hs -c "require('fns').dump()"| ~/.config/choose/choose)

[ "$chosen" != "" ] || exit

# Incase any window functions are done, they don't happen on the chooser
if [[ $INTERFACE != "GUI" ]]
then
    hs -c "hs.application.frontmostApplication():hide()"
fi

hs -c "require('fns').exec('$chosen')"

