#!/usr/bin/env bash
set -euo pipefail

if [[ $(id -u) -eq 0 ]]; then
    echo "Don't run this as root"
    exit 1
fi

# passwordless sudo
echo "$USER  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/passwordless

SOURCES=$(cat << EOF
deb http://httpredir.debian.org/debian buster main contrib non-free
# deb-src http://httpredir.debian.org/debian buster main contrib non-free

deb http://httpredir.debian.org/debian buster-updates main contrib non-free
# deb-src http://httpredir.debian.org/debian buster-updates main contrib non-free

deb http://security.debian.org/ buster/updates main contrib non-free
# deb-src http://security.debian.org/ buster/updates main contrib non-free

deb http://httpredir.debian.org/debian unstable main contrib non-free
EOF
       )
echo "$SOURCES" | sudo tee /etc/apt/sources.list

PREFERENCES=$(cat <<EOF
Package: *
Pin: release n=buster
Pin-Priority: 900

Package: *
Pin: release a=unstable
Pin-Priority: 800
EOF
           )
echo "$PREFERENCES" | sudo tee /etc/apt/preferences

sudo apt update
sudo apt full-upgrade -y
sudo apt install -y --purge --reinstall task-xfce-desktop firefox firefox-esr-

sudo apt install -y \
     at \
     baobab \
     bsdgames \
     cdparanoia \
     checkinstall \
     chromium \
     command-not-found \
     curl \
     dnsutils \
     emacs-gtk emacs-common-non-dfsg \
     filezilla \
     fonts-noto unifont fonts-font-awesome \
     gimp gimp-data-extras \
     git \
     gnome-disk-utility \
     gnuplot \
     gparted \
     htop \
     hugo \
     imagemagick \
     jpegoptim \
     jq \
     keepass2 \
     libnotify-bin \
     libreoffice-pdfimport \
     liferea \
     lintian \
     magic-wormhole \
     mosh \
     mpv \
     nautilus-dropbox \
     ntfs-3g \
     p7zip-full \
     pandoc \
     parallel \
     qrencode \
     redshift-gtk \
     ricochet-im \
     rsync \
     scrot \
     shellcheck \
     snapd \
     stow \
     strace \
     syncthing \
     task-print-server \
     telegram-desktop \
     thunar-dropbox-plugin \
     thunderbird xul-ext-compactheader xul-ext-torbirdy enigmail gnupg-curl \
     tor torbrowser-launcher \
     transmission-gtk \
     tree \
     tumbler-plugins-extra \
     unrar \
     whois \
     wireshark \
     xclip \
     xournal \
     youtube-dl \
     zip

sudo apt install -y --no-install-recommends \
     devscripts \
     firejail firejail-profiles \
     mat libimage-exiftool-perl \
     sagemath

# LaTeX
sudo apt install -y --no-install-recommends \
     latexmk \
     python-pygments \
     texlive \
     texlive-generic-recommended \
     texlive-publishers \
     texlive-science \
     texlive-xetex

# i3 Desktop
sudo apt install -y \
     arandr \
     compton \
     feh \
     i3 dunst- \
     j4-dmenu-desktop \
     numlockx \
     unclutter
sudo apt install -y --no-install-recommends lxappearance

# Python
sudo apt install -y \
     flake8 \
     ipython3 \
     isort \
     mypy \
     pypy pypy-dev \
     python2.7-doc \
     python3-doc \
     python3-pip \
     python3-pypandoc \
     twine \
     virtualenv

# Python Science
sudo apt install -y \
     jupyter-notebook \
     python3-matplotlib \
     python3-numpy \
     python3-pandas \
     python3-scipy \
     python3-seaborn \
     python3-sklearn
sudo apt install -y --no-install-recommends python3-sympy python3-gmpy2 isympy3

# JavaScript
sudo apt install -y nodejs-legacy npm

# Haskell
sudo apt install -y haskell-stack libncurses-dev
sudo apt install -y --no-install-recommends hlint

# Rust
sudo apt install -y rustc rust-doc cargo

# Java
sudo apt install -y default-jdk

# Ruby
sudo apt install -y ruby ruby-dev rubygems

# AppArmor
sudo apt -y install apparmor apparmor-profiles apparmor-utils apparmor-notify
# https://bugs.debian.org/702030
if ! grep -q apparmor /etc/default/grub; then
    sudo perl -pi -e 's,GRUB_CMDLINE_LINUX="(.*)"$,GRUB_CMDLINE_LINUX="$1 apparmor=1 security=apparmor",' /etc/default/grub
fi
# Disable AppArmor for Thunderbird
sudo ln -sf /etc/apparmor.d/usr.bin.thunderbird /etc/apparmor.d/disable
sudo apparmor_parser -R /etc/apparmor.d/usr.bin.thunderbird || :

# grant user read permissions for many logs in /var/log/
sudo adduser "$USER" adm

# Firejail
wget https://github.com/rahiel/firectl/releases/download/1.1.0/firectl_1.1.0-1_all.deb -O /tmp/firectl.deb
sudo apt install -y /tmp/firectl.deb
sudo firectl enable chromium dropbox evince firefox keepassx thunderbird transmission-gtk
rm /tmp/firectl.deb

# http://popcon.debian.org
echo 'popularity-contest	popularity-contest/participate	boolean	true' | sudo debconf-set-selections
sudo apt install -y popularity-contest

# Firewall
sudo apt install -y ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22000/tcp && sudo ufw allow 21027/udp # Syncthing
sudo ufw enable

# signal-desktop
curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install -y signal-desktop

# brave browser
curl -s https://s3-us-west-2.amazonaws.com/brave-apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://s3-us-west-2.amazonaws.com/brave-apt jessie main" | sudo tee /etc/apt/sources.list.d/brave-jessie.list
sudo apt update && sudo apt install -y brave

# enable user namespaces (https://superuser.com/questions/1094597/enable-user-namespaces-in-debian-kernel)
echo 'kernel.unprivileged_userns_clone=1' > /etc/sysctl.d/00-local-userns.conf
sudo sysctl kernel.unprivileged_userns_clone=1

# Laptop
if dpkg --get-selections | grep "^task-laptop[[:space:]]*install$" &>/dev/null; then
    sudo apt install -y tlp
fi

# microcode
if grep -q GenuineIntel /proc/cpuinfo; then
    sudo apt install intel-microcode
fi

# command-not-found
sudo update-command-not-found

# LightDM autologin
sudo sed -i "s/#autologin-user=/autologin-user=$USER/" /etc/lightdm/lightdm.conf

# Grub shorter timeout
sudo sed -i "s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/" /etc/default/grub
sudo update-grub

sudo apt --purge -y autoremove

# remove passwordless sudo
sudo rm /etc/sudoers.d/passwordless
sudo -K

# Syncthing
systemctl --user enable syncthing.service
systemctl --user start syncthing.service

pip3 install -r https://github.com/rahiel/dotfiles/raw/master/requirements.txt

mkdir -p ~/.npm-global
npm install -g --prefix ~/.npm-global/ npm
npm install -g --prefix ~/.npm-global/ \
    eslint \
    tern \
    tldr \
    typescript \
    webpack

CRATES="pwds racer ripgrep fd-find"
for crate in $CRATES; do
    cargo install -f $crate
done

gem install --user-install --no-document fpm

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

# Spacemacs
if [[ ! -d ~/.emacs.d ]]; then
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi
