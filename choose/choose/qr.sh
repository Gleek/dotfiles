#!/usr/bin/env bash
string=${1:-$(pbpaste)}

echo $string |qrencode -o $TMPDIR/qr.png -s 30;
qlmanage -p $TMPDIR/qr.png
rm $TMPDIR/qr.png
