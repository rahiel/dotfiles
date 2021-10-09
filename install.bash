#!/bin/bash
set -euo pipefail

# to make sure not the whole directory is linked
mkdir -p ~/.emacs.d
mkdir -p ~/.gnupg
mkdir -p ~/.local/share/applications/
mkdir -p ~/.local/share/fonts/
mkdir -p ~/.stack
mkdir -p ~/.cargo
mkdir -p ~/.config
mkdir -p ~/.mozilla/


if [[ $1 == "firefox"* ]]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        profile=$(realpath ~/Library/Application' 'Support/Firefox/Profiles/*.default-release)
    else
        profile=$(realpath ~/.mozilla/firefox/*.default-release)
    fi
    mkdir -p "$profile"/chrome/
    cp --remove-destination ${PWD}/firefox/userChrome.css "$profile"/chrome/
elif [[ $1 == "mako" ]]; then
    mkdir -p ~/.config/mako/
    cp mako/.config/mako/config ~/.config/mako/config
else
    stow -R -t ~ "$@"
fi
