#!/usr/bin/env bash
orientation=$(echo "Single
Dual - horizontal
Dual - vertical" |rofi -dmenu -i -font 'Hack 10')
echo $orientation;
case $orientation in
    "Single")
        ~/.config/i3/screen-single.sh
        ;;
    "Dual - horizontal")
        ~/.config/i3/screen-dual.sh
        ;;
    "Dual - vertical")
        ~/.config/i3/screen-vertical.sh
        ;;
esac
