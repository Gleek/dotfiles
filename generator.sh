#!/usr/bin/env bash
mkdir -p "$1" && mv ~/.config/"$1" "$1"/. && stow -t ~/.config "$1"
