#!/usr/bin/env bash
mkdir -p "$1"/"$1" && mv ~/.config/"$1"/* "$1"/"$1"/. && rm -r ~/.config/"$1" && stow -t ~/.config "$1"
