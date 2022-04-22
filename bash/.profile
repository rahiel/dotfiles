# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

echo "$OSTYPE" | grep -q -E '^darwin'
if [ $? -eq 0 ]; then
    export macos=1
else
    export macos=0
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# Emacs
export PATH="$HOME/.emacs.d/bin:$PATH"

# pip
export PATH="$HOME/.local/bin:$PATH"

# node.js
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="/usr/local/opt/node@14/bin:$PATH"

# homebrew
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

# cargo / rust
export PATH="$HOME/.cargo/bin:$PATH"
export RUST_SRC_PATH="$HOME/Code/rust/src"

export XDG_SCREENSHOTS_DIR="$HOME/Pictures/Screenshots"

# Wayland
if [ $macos -eq 0 ]; then
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM=wayland
fi

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
