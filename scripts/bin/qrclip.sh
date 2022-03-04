#!/bin/sh
if [[ $macos ]]; then
    filename="/tmp/qrcode-$RANDOM"
    pbpaste | qrencode --size=10 -o "$filename" | qlmanage -p "$filename"
    rm -f "$filename"
else
    wl-paste | qrencode --size=10 -o - | imv-wayland -
fi
