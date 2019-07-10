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


if [[ $1 == "firefox" ]]; then
    profile=$(realpath ~/.mozilla/firefox/*.default)
    mkdir -p "$profile"/chrome/
    cp --remove-destination ${PWD}/firefox/userChrome.css "$profile"/chrome/
else
    stow -R -t ~ "$@"
fi
