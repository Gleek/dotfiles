#!/usr/bin/env bash
xclip -o |qrencode -o /tmp/qr.png -s 30;
feh -F /tmp/qr.png
rm /tmp/qr.png
