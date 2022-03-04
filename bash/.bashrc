# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=""  # infinite history (https://superuser.com/a/479727)

# append and read new lines from hist after every command
PROMPT_COMMAND="history -a; history -n"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# prepend cd for paths
shopt -s autocd

# autocorrect cd dirs
shopt -s cdspell

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

export EDITOR='emacsclient -c'

if [[ "$OSTYPE" == "darwin"* ]]; then
    export macos=1
else
    export macos=0
fi

# use GNU coreutils on macOS
[[ $macos ]] && PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

## default prompt
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

# all non-printing characters in the prompt should be between \[ and \]
exit_prompt() {
    if [[ $EXIT_STATUS == 0 ]]; then
        printf "\[\e[32;1m\]λ\[\e[m\]"
    else
        printf "\[\e[38;5;161;1m\]λ\[\e[m\]"
    fi
}
# set this variable first in PROMPT_COMMAND, because $? doesn't work reliably
PROMPT_COMMAND='EXIT_STATUS=$?; '$PROMPT_COMMAND

# rightprompt() {
#     printf "%*s" $COLUMNS $(date +%H:%M)
# }
# export PS1='\[$(tput sc; rightprompt; tput rc)\]left prompt > '

[[ $macos ]] && . /usr/local/opt/git/etc/bash_completion.d/git-prompt.sh

PROMPT_COMMAND=$PROMPT_COMMAND'; __git_ps1 "${debian_chroot:+($debian_chroot)}$(basename "$VIRTUAL_ENV") \[\e[38;5;126;1m\]$(pwds)\[\e[0m\]" " $(exit_prompt) "'

# __git_ps1 from  /usr/lib/git-core/git-sh-prompt
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=1

# set terminal title
PROMPT_COMMAND=$PROMPT_COMMAND'; printf "\e]0;${USER}@${HOSTNAME%%.*}: ${PWD}\a"'

# enable color support of ls
LS_COLORS=~/.local/LS_COLORS/LS_COLORS
if [ -x /usr/bin/dircolors ]; then
    test -r $LS_COLORS && eval "$(dircolors -b $LS_COLORS)" || eval "$(dircolors -b)"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# less colors, from: https://wiki.archlinux.org/index.php/Color_output_in_console#less
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\e[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\e[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline

# less syntax highlighting (https://www.gnu.org/software/src-highlite/source-highlight.html#Using-source_002dhighlight-with-less)
if [[ -x "/usr/share/source-highlight/src-hilite-lesspipe.sh" ]]; then
    export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
elif [[ -x "/usr/local/bin/src-hilite-lesspipe.sh" ]]; then # macOS
    export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
fi

sourcy() {
    [ -f "$1" ] && source "$1"
}

# source other files
sourcy ~/.bash_fun
sourcy ~/.bash_priv

# z jumping
sourcy ~/.local/z/z.sh

# fzf
sourcy ~/.fzf.bash

# autoenv
sourcy ~/.local/bin/activate.sh

# virtualenvwrapper; $PATH must be set before this
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Code
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=~/.local/bin/virtualenv
sourcy ~/.local/bin/virtualenvwrapper_lazy.sh

unset sourcy

# pyenv
eval "$(pyenv init -)"

# pipx completions
if hash register-python-argcomplete3 &> /dev/null; then
    eval "$(register-python-argcomplete3 pipx)"
else
    eval "$(register-python-argcomplete pipx)"
fi

# haskell-stack completions
hash stack &> /dev/null && eval "$(stack --bash-completion-script stack)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# C-s for forward search (http://stackoverflow.com/a/791800)
stty -ixon

# language
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# Debian packaging
export DEBFULLNAME="Rahiel Kasim"
export DEBEMAIL="rahielkasim@gmail.com"
export GPGKEY=6B5D2243

# Fix for TRAMP (https://stackoverflow.com/a/8363532/4870246)
if [[ $TERM == "dumb" ]]; then
    PROMPT_COMMAND=""
    PS1="> "
fi

# welcome message
echo -e "\e[01;35m$SHELL\e[m on" "\e[01;37m$(date)\e[m"
