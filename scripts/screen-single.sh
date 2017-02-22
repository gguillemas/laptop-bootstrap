#!/bin/sh
int=$(xrandr | grep -oP "(.*?)(?= connected)" | sed -n 1p)
ext=$(xrandr | grep -oP "(.*?)(?= connected)" | sed -n 2p)
xrandr --output $ext --off --output $int --auto
