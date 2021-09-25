#!/usr/bin/env bash
set -euo pipefail

if [[ $(id -u) -eq 0 ]]; then
    echo "Don't run this as root"
    exit 1
fi

# passwordless sudo
echo "$USER  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/passwordless

SOURCES=$(cat << EOF
deb http://httpredir.debian.org/debian bullseye main contrib non-free
# deb-src http://httpredir.debian.org/debian bullseye main contrib non-free

deb http://httpredir.debian.org/debian bullseye-updates main contrib non-free
# deb-src http://httpredir.debian.org/debian bullseye-updates main contrib non-free

deb http://security.debian.org bullseye-security main contrib non-free
# deb-src http://security.debian.org/ bullseye-security main contrib non-free

deb http://httpredir.debian.org/debian unstable main contrib non-free
EOF
       )
echo "$SOURCES" | sudo tee /etc/apt/sources.list

PREFERENCES=$(cat <<EOF
Package: *
Pin: release n=bullseye
Pin-Priority: 900

Package: *
Pin: release a=unstable
Pin-Priority: 800
EOF
           )
echo "$PREFERENCES" | sudo tee /etc/apt/preferences

# harden apt
echo 'APT::Sandbox::Seccomp "true";' | sudo tee /etc/apt/apt.conf.d/40sandbox

sudo apt update
sudo apt full-upgrade -y

# Sway desktop
sudo apt install -y --no-install-recommends \
     brightnessctl \
     gammastep \
     gdm3 \
     grimshot \
     i3status \
     imv \
     j4-dmenu-desktop \
     mako-notifier \
     paper-icon-theme \
     qtwayland5 \
     suckless-tools \
     sway \
     swayidle \
     swaylock \
     wl-clipboard \
     xfce4-settings \
     xwayland

# i3 Desktop
sudo apt install -y --no-install-recommends lxappearance

sudo apt-get install -y -t unstable firefox

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
     docker.io \
     emacs-gtk emacs-common-non-dfsg \
     evince \
     fd-find \
     file-roller unar \
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
     keepassx \
     libnotify-bin \
     libreoffice-writer libreoffice-calc libreoffice-impress libreoffice-gtk3 \
     liferea \
     magic-wormhole \
     mosh \
     mpv \
     network-manager-gnome \
     ntfs-3g \
     pandoc \
     parallel \
     pulseaudio pavucontrol \
     qrencode \
     remmina \
     ripgrep \
     ristretto \
     rsync \
     shellcheck \
     source-highlight \
     stow \
     strace \
     syncthing \
     telegram-desktop \
     thunar thunar-archive-plugin thunar-volman \
     thunderbird gpg-agent \
     tor torbrowser-launcher \
     transmission-gtk \
     trash-cli \
     tree \
     tumbler-plugins-extra \
     whois \
     xfce4-terminal \
     xournal \
     youtube-dl \
     zip

sudo apt install -y --no-install-recommends \
     firejail firejail-profiles \
     mat2 libimage-exiftool-perl \
     # sagemath

# LaTeX
sudo apt install -y --no-install-recommends \
     latexmk \
     python-pygments \
     texlive \
     texlive-fonts-extra \
     texlive-generic-recommended \
     texlive-publishers \
     texlive-science \
     texlive-xetex

# Python
sudo apt install -y \
     flake8 \
     ipython3 \
     isort \
     mypy \
     python2.7-doc \
     python3-doc \
     python3-pip \
     python3-pypandoc \
     twine \
     virtualenv

# Python Science
sudo apt install -y \
     python3-matplotlib \
     python3-numpy \
     python3-scipy

# JavaScript
sudo apt install -y nodejs npm

# Haskell
# sudo apt install -y haskell-stack libncurses-dev
# sudo apt install -y --no-install-recommends hlint

# Rust
sudo apt install -y rustc rust-doc cargo

# AppArmor
sudo apt -y install apparmor-profiles apparmor-utils apparmor-notify
# Disable AppArmor for Thunderbird
sudo ln -sf /etc/apparmor.d/usr.bin.thunderbird /etc/apparmor.d/disable
sudo apparmor_parser -R /etc/apparmor.d/usr.bin.thunderbird || :

# grant user read permissions for many logs in /var/log/
sudo adduser "$USER" adm

# allow docker commands
sudo adduser "$USER" docker

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
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
sudo mv signal-desktop-keyring.gpg /usr/share/keyrings/
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install -y signal-desktop

# brave browser
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update && sudo apt install -y brave-browser brave-keyring

# enable user namespaces (https://superuser.com/questions/1094597/enable-user-namespaces-in-debian-kernel)
echo 'kernel.unprivileged_userns_clone=1' > /etc/sysctl.d/00-local-userns.conf
sudo sysctl kernel.unprivileged_userns_clone=1

# Laptop
if dpkg --get-selections | grep "^task-laptop[[:space:]]*install$" &>/dev/null; then
    sudo apt install -y tlp
fi

# microcode
if grep -q GenuineIntel /proc/cpuinfo; then
    sudo apt install -y intel-microcode
fi

# command-not-found
sudo update-command-not-found

# gdm3 autologin
sudo sed -i "s/#  AutomaticLoginEnable = true/AutomaticLoginEnable = true/" /etc/gdm3/daemon.conf
sudo sed -i "s/#  AutomaticLogin = user1/AutomaticLogin = $USER/" /etc/gdm3/daemon.conf

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

CRATES="pwds"
for crate in $CRATES; do
    cargo install -f $crate
done

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
# if [[ ! -d ~/.emacs.d ]]; then
#     git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
# fi
