#!/usr/bin/env bash
set -euo pipefail
url=${1-}
qutepath=$HOME/.qutebrowser
quteexec="open -na qutebrowser --args"
quteprofiles=$(ls -1 $qutepath/profiles/)
quteprofiles="${quteprofiles}
default"
chosen=$(echo "$quteprofiles" | ~/.config/choose/choose)
if [ "$chosen" = "" ]
then
    exit
fi
paramDir=""
if [ "$chosen" != "default" ]
then
    paramDir="--basedir=$qutepath/profiles/$chosen"
fi
[ -n "$url" ] && paramDir="$paramDir $url"
$quteexec $paramDir

# If running via shell script directly
# nohup $quteexec $paramDir &
# sleep 0.3
