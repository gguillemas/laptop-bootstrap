#!/bin/bash

set -e

# Copy to home.
cp -rf "$(dirname "$0")/." ~ && cd ~

# Elevate privileges.
if [ $EUID -ne 0 ]; then
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
xorg sudo build-essential \
pulseaudio pulseaudio-module-bluetooth bluez-firmware \
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

# Install Go.
curl https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz | tar -C /usr/local -xz

# Install Iosevka font.
mkdir -p /home/$USER/.fonts
wget https://github.com/be5invis/Iosevka/releases/download/v1.12.1/01-iosevka-1.12.1.zip -P .fonts
wget https://github.com/be5invis/Iosevka/releases/download/v1.12.1/02-iosevka-term-1.12.1.zip -P .fonts
unzip '.fonts/*.zip' -d /home/$USER/.fonts
mkfontscale /home/$USER/.fonts
mkfontdir /home/$USER/.fonts
fc-cache /home/$USER/.fonts
xset +fp /home/$USER/.fonts || true # TODO: Fix. Can't be done without X running.

# Add user to sudo group.
adduser "$USER" sudo

# Install Suckless tools.
apt-get install -y libx11-dev libxinerama-dev libxft-dev libxrandr-dev
make -C src/dwm/ && make install clean -C src/dwm/
make -C src/dmenu/ && make install clean -C src/dmenu/
make -C src/slock/ && make install clean -C src/slock/
make -C src/wmname/ && make install clean -C src/wmname/

# Setup screen autoconfiguration.
echo -n "SUBSYSTEM==\"drm\", ACTION==\"change\", RUN+=\"sudo -u $USER /home/$USER/.scripts/screen-auto.sh\"" > /etc/udev/rules.d/screen-auto.rules
udevadm control --reload-rules

# Fix xinit permissions.
chmod u+s /usr/bin/xinit
