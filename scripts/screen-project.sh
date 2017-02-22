#!/bin/sh
int=$(xrandr | grep -oP "(.*?)(?= connected)" | sed -n 1p)
ext=$(xrandr | grep -oP "(.*?)(?= connected)" | sed -n 2p)
xrandr --output $ext --mode 1024x768 --same-as $int --output $int --mode 1024x768
