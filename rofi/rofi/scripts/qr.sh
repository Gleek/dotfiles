#!/usr/bin/env bash
string=${1:-$(xclip -o)}
echo $string |qrencode -o /tmp/qr.png -s 30;
feh -F /tmp/qr.png
rm /tmp/qr.png
