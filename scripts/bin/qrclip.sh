#!/bin/sh
wl-paste | qrencode --size=10 -o - | imv-wayland -
