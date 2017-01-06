#!/bin/bash

# to make sure not the whole directory is linked
mkdir -p ~/.emacs.d
mkdir -p ~/.gnupg
mkdir -p ~/.local/share/applications/
mkdir -p ~/.local/share/fonts/
mkdir -p ~/.stack
mkdir -p ~/.cargo
mkdir -p ~/.config

stow -R -t ~ "$@"
