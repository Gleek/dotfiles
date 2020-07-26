#!/usr/bin/env bash
cd ~
chosen=$(fd --type f | ~/.config/choose/choose)
[ "$chosen" != "" ] || exit
open "$chosen"
