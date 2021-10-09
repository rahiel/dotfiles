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
     fd \
     git \
     node \
     pipx \
     ripgrep \
     rust \
     source-highlight \
     stow

pipx install poetry

cargo install pwds

mkdir -p ~/.npm-global
npm install -g --prefix ~/.npm-global/ npm
npm install -g --prefix ~/.npm-global/ \
    eslint \
    tern \
    tldr \
    typescript \
    webpack

# fzf
if [[ ! -d ~/.local/fzf ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/fzf
fi
~/.local/fzf/install --key-bindings --completion --no-update-rc

# z
if [[ ! -d ~/.local/z ]]; then
    git clone https://github.com/rupa/z.git ~/.local/z
fi

# LS_COLORS
if [[ ! -d ~/.local/LS_COLORS ]]; then
    git clone https://github.com/trapd00r/LS_COLORS.git ~/.local/LS_COLORS
fi
