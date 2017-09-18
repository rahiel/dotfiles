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
    mkdir -p ~/.mozilla/firefox/*.default/chrome/
    FIREFOX_CHROME=$(realpath ~/.mozilla/firefox/*.default/chrome/)
    cp --remove-destination ${PWD}/firefox/userChrome.css "$FIREFOX_CHROME"
    ln -sf ${PWD}/firefox/.keysnail.js ~
else
    stow -R -t ~ "$@"
fi
