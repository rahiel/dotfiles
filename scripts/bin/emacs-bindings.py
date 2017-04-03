#!/usr/bin/env python3
from configparser import ConfigParser
from os.path import expanduser
from subprocess import run


gtk3 = expanduser("~/.config/gtk-3.0/settings.ini")
config = ConfigParser()
config.read(gtk3)
config["Settings"]["gtk-key-theme-name"] = "Emacs"
with open(gtk3, "w") as f:
    config.write(f)

gtk2 = expanduser("~/.gtkrc-2.0")
with open(gtk2) as f:
    conf = f.read()
    if "Emacs" not in conf:
        f.write(conf + "gtk-key-theme-name = \"Emacs\"\n")

run("gsettings set org.gnome.desktop.interface gtk-key-theme \"Emacs\"", shell=True)
run("xfconf-query -c xsettings -p /Gtk/KeyThemeName -s Emacs", shell=True)
