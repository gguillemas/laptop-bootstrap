#!/bin/sh

# Extend display when an external monitor is connected.
# Turn off external output when the monitor is disconnected.
# This script is ment to be run automatically by an udev rule.
# Only considers the case of a single external monitor.

# Configure:
user="gerard"
position="right"

# Drop privileges if executed as root.
# Will be run as root when triggered by udev.
if [ `id -u` = "0" ]; then
	sudo -u $user $0
else
	int=$(xrandr | grep -oP "(.*?)(?= connected)" | sed -n 1p)
	ext=$(xrandr | grep -oP "(.*?)(?= connected)" | sed -n 2p)

	if [ $(xrandr | grep -oP "(.*?)(?= connected)" | wc -l) -gt 1 ]; then
		xrandr --output $int --auto --${position}-of $ext --output $ext --auto
	else
		xrandr --output $ext --off --output $int --auto
	fi

	sh ~/.fehbg
fi
