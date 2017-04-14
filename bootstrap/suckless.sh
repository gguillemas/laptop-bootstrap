#!/bin/sh

mkdir src

apt-get install -y libx11-dev libxinerama-dev libxft-dev libxrandr-dev

git clone http://git.suckless.org/dwm src/dwm
git -C src/dwm/ checkout 6.1
patch -d src/dwm < patches/dwm.patch
make -C src/dwm/ && make install clean -C src/dwm/

git clone http://git.suckless.org/dmenu src/dmenu
git -C src/dmenu/ checkout 4.6
make -C src/dmenu/ && make install clean -C src/dmenu/

git clone http://git.suckless.org/slock src/slock
git -C src/slock/ checkout 1.4
patch -d src/dwm < patches/slock.patch
make -C src/slock/ && make install clean -C src/slock/

git clone http://git.suckless.org/wmname src/wmname
git -C src/wmname/ checkout 0.2
make -C src/wmname/ && make install clean -C src/wmname/
