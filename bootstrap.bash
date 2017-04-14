#!/bin/bash

set -e

# Copy to home.
cp -rf "$(dirname "$0")/." ~ && cd ~

# Elevate privileges.
if [ $EUID -ne 0 ]; then
    su -c "bash $0" "$@"
    exit $?
fi

# Add user to sudo group.
adduser "$USER" sudo

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
xorg sudo build-essential bluez-firmware \
pulseaudio pulseaudio-module-bluetooth pavucontrol \
ttf-mscorefonts-installer ttf-bitstream-vera \
ttf-dejavu ttf-liberation ttf-freefont \
tlp xbacklight uswsusp xclip autocutsel \
rxvt-unicode feh imagemagick scrot curl wget git \
vim mc dunst newsbeuter wicd-curses rtorrent acpi \
libreoffice mupdf vlc chromium keepassx

# Uncomment if wanted.
# apt-get install -y pepperflashplugin-nonfree icedtea-plugin

# Depends on rxvt-unicode in a weird way.
apt-get install -y rxvt-unicode-256color

# Configure chromium.
echo 'export CHROMIUM_FLAGS="$CHROMIUM_FLAGS --enable-remote-extensions"' > /etc/chromium.d/enable-remote-extensions

# Install go.
curl https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz | tar -C /usr/local -xz

# Configure vim.
sh boostrap/vim.sh

# Install Iosevka font.
sh boostrap/iosevka.sh

# Install Suckless tools.
sh bootstrap/suckless.sh

# Allow "~/.scripts/backlight" to work.
chmod o+w /sys/class/backlight/intel_backlight/brightness

# Setup screen autoconfiguration.
git clone --recursive https://github.com/Ventto/mons src && make install -C src/mons/
echo -n "SUBSYSTEM==\"drm\", ACTION==\"change\", RUN+=\"sudo -u $USER /home/$USER/.scripts/screen-auto.sh\"" > /etc/udev/rules.d/screen-auto.rules
udevadm control --reload-rules
