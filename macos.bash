#!/bin/bash


if ! hash brew; then
    echo "First install Homebrew!"
    exit 1
fi

# upgrade bash
brew install bash
if ! grep -q '/usr/local/bin/bash' /etc/shells; then
    echo "/usr/local/bin/bash" | sudo tee -a '/etc/shells'
fi
chsh -s /usr/local/bin/bash

brew tap railwaycat/emacsmacport
brew install --cask emacs-mac

brew install --cask firefox
brew install \
     coreutils \
     ripgrep \
     stow
