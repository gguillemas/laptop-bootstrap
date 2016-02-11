#!/bin/bash

USERNAME="$USER"

# Elevate privileges.
if [ $EUID != 0 ]; then
    su -c "bash $0" "$@"
    exit $?
fi

# Switch release to testing.
sed -i -e 's/ \(stable\|jessie\|wheezy\)/ testing/ig' /etc/apt/sources.list
sed -i -e 's/ main$/ main contrib non-free/ig' /etc/apt/sources.list

# Update the system.
apt-get update
apt-get --download-only dist-upgrade
apt-get dist-upgrade

# Install packages.
apt-get install -y \
sudo vim xorg tmux bash-completion \
wicd-curses chromium curl wget \
pepperflashplugin-nonfree icedtea-plugin \
git gcc golang ruby python build-essential \
vlc feh \
libreoffice evince \
xfonts-terminus ttf-freefont ttf-mscorefonts-installer ttf-bitstream-vera ttf-dejavu ttf-liberation

# Add user to sudoers.
sed "s/root ALL=(ALL) ALL/&\n$USERNAME ALL=(ALL) ALL/" /etc/sudoers

# Install Suckless tools.
make -C sources/dwm/ && make install clean -C sources/dwm/
make -C sources/dmemu/ && make install clean -C sources/dmenu/
make -C sources/slock/ && make install clean -C sources/slock/
