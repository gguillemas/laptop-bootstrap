#!/bin/sh

mkdir -p ~/.fonts
wget https://github.com/be5invis/Iosevka/releases/download/v1.12.1/01-iosevka-1.12.1.zip -P ~/.fonts
wget https://github.com/be5invis/Iosevka/releases/download/v1.12.1/02-iosevka-term-1.12.1.zip -P ~/.fonts
unzip "$(echo ~)/.fonts/*.zip" -d ~/.fonts
mkfontscale ~/.fonts
mkfontdir ~/.fonts
fc-cache ~/.fonts
# FIXME: Can't be done without X running.
xset +fp ~/.fonts || true
