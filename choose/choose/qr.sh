#!/usr/bin/env bash
string=${1:-$(pbpaste)}

echo $string |qrencode -o $TMPDIR/qr.png -s 30;
kitty --single-instance -T fullscreen-term ~/.config/kitty/icat $TMPDIR/qr.png &
read
rm $TMPDIR/qr.png
