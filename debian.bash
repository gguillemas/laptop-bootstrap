#!/bin/bash

set -e

# Copy to home.
cp -rf "$(dirname $0)/." ~ && cd ~

# Elevate privileges.
if [ $EUID != 0 ]; then
    su -c "bash $0" "$@"
    exit $?
fi

# Switch to testing release and add "contrib" and "non-free" repositories.
sed -i -e 's/ \(stable\|jessie\|wheezy\)/ testing/ig' /etc/apt/sources.list
sed -i -e 's/ main$/ main contrib non-free/ig' /etc/apt/sources.list

# Update the system.
apt-get update
apt-get upgrade
apt-get --download-only dist-upgrade
apt-get dist-upgrade

# Install packages.
apt-get install -y \
sudo vim xorg tmux \
build-essential git golang ruby \
wicd-curses curl wget chromium \
vlc feh imagemagick scrot dunst \
alsa-base alsa-utils \
libreoffice evince xclip newsbeuter \
pepperflashplugin-nonfree icedtea-plugin \
xfonts-terminus ttf-freefont \
ttf-mscorefonts-installer ttf-bitstream-vera \
ttf-dejavu ttf-liberation \
laptop-mode-tools xbacklight uswsusp \
keepassx

# Add user to sudo group.
adduser "$USER" sudo

# Install Suckless tools.
apt-get install -y libx11-dev libxinerama-dev
make -C sources/dwm/ && make install clean -C sources/dwm/
make -C sources/dmenu/ && make install clean -C sources/dmenu/
make -C sources/slock/ && make install clean -C sources/slock/
make -C sources/wmname/ && make install clean -C sources/wmname/

# Fix xinit permissions.
chmod u+s /usr/bin/xinit
