#!/bin/sh

int=$(xrandr | grep -oP "(.*?)(?= connected)" | sed -n 1p)
ext=$(xrandr | grep -oP "(.*?)(?= connected)" | sed -n 2p)

xrandr --output $ext --same-as $int --output $int

~/.fehbg
