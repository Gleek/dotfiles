#!/usr/bin/env bash
FILE="/tmp/gcalcli_agenda.txt"
[ -s $FILE ] || exit
start=$(cat $FILE| tail -1|cut -d$'\t' -f2)
end=$(cat $FILE| tail -1|cut -d$'\t' -f4)
task=$(cat $FILE| tail -1|cut -d$'\t' -f5 | awk -v len=25 '{ if (length($0) > len) print substr($0, 1, len-3) "…"; else print; }')
echo " $start - $end  $task"
