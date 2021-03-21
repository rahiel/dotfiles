#!/bin/bash
xmodmap ~/.config/xmodmaprc
~/bin/clickpad
bluetooth off
sleep 2.5

# turn off wifi when wired
if grep -q 1 /sys/class/net/enp2s0f1/carrier; then
    wifi off
else
    wifi on
fi
