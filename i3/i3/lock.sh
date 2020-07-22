#!/bin/bash
starttime=$(($(date +%s%N)/1000000))
scrot /tmp/screen.png
endtime=$(($(date +%s%N)/1000000))
echo $((endtime - starttime))
# du -sh /tmp/screen.png
starttime=$(($(date +%s%N)/1000000))
pngquant --force --ext .png --quality=0-10 -s10 --strip /tmp/screen.png
endtime=$(($(date +%s%N)/1000000))
echo $((endtime - starttime))
# du -sh /tmp/screen.png
starttime=$(($(date +%s%N)/1000000))
# convert /tmp/screen.png -paint 1 /tmp/screen.png
# convert /tmp/screen.png -paint 1 -scale 10% -scale 1000% /tmp/screen.png
convert /tmp/screen.png -resize 50%  -blur 0x7 -resize 200% /tmp/screen.png
endtime=$(($(date +%s%N)/1000000))
echo $((endtime - starttime))
starttime=$(($(date +%s%N)/1000000))

# exit
if [[ -f $HOME/.config/i3/lock.png ]]
then
    # placement x/y
    PX=0
    PY=0
    # lockscreen image info
    R=$(file ~/.config/i3/lock.png | grep -o '[0-9]* x [0-9]*')
    RX=$(echo $R | cut -d' ' -f 1)
    RY=$(echo $R | cut -d' ' -f 3)

    SR=$(xrandr --query | grep ' connected'|sed 's/[^0-9x+ ]*//g'| sed 's/  */ /g'|cut -d' ' -f2)
    for RES in $SR
    do
        # monitor position/offset
        SRX=$(echo $RES | cut -d'x' -f 1)                   # x pos
        SRY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 1)  # y pos
        SROX=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 2) # x offset
        SROY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 3) # y offset
        PX=$(($SROX + $SRX/2 - $RX/2))
        PY=$(($SROY + $SRY/2 - $RY/2))

        convert /tmp/screen.png $HOME/.config/i3/lock.png -geometry +$PX+$PY -composite -matte  /tmp/screen.png
        echo "done"
    done
fi
endtime=$(($(date +%s%N)/1000000))
echo $((endtime - starttime))
starttime=$(($(date +%s%N)/1000000))
# exit

# [[ -f /home/umar/.config/i3/lock.png ]] && convert /tmp/screen.png /home/umar/.config/i3/lock.png -gravity center -composite -matte /tmp/screen.png
# Turning off screen, there is some flickering in screen after coming
# back, have to look into it.
# xset dpms force off;
# mpc pause
playerctl pause &
i3lock  -e -n -i /tmp/screen.png
# i3lock  -e -n -c 000000
rm /tmp/screen.png
