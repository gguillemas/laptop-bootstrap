#!/bin/sh
int=$(xrandr | grep -oP "(.*?)(?= connected)" | sed -n 1p)
ext=$(xrandr | grep -oP "(.*?)(?= connected)" | sed -n 2p)
xrandr --output $int --auto --right-of $ext --output $ext --auto
sh ~/.fehbg
