#!/bin/bash

emacs --daemon
# emacs --daemon && emacsclient --no-wait -c -e "(find-file \"~/Sync/Notes/todo.org\")"
# setxkbmap -rules evdev -model evdev -layout us -variant altgr-intl
~/bin/clickpad
xmodmap ~/.config/xmodmaprc
numlockx on
bluetooth off
sleep 2.5

# turn off wifi when wired
if grep -q 1 /sys/class/net/enp2s0f1/carrier; then
    wifi off
    ~/bin/screen-home.sh
    sleep 0.5
    ~/bin/set-wallpaper
else
    wifi on
fi
