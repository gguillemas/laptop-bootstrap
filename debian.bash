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
make -C src/dwm/ && make install clean -C src/dwm/
make -C src/dmenu/ && make install clean -C src/dmenu/
make -C src/slock/ && make install clean -C src/slock/
make -C src/wmname/ && make install clean -C src/wmname/

# Fix xinit permissions.
chmod u+s /usr/bin/xinit
