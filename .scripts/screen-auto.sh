#!/bin/sh

# Extend display when an external monitor is connected.
# Turn off external output when the monitor is disconnected.
# This script is meant to be triggered by an udev rule.
# Only considers the case of a single external monitor.

# Position of the monitor relative to the laptop.
position="left"

if [ `xrandr | grep -oP "(.*?)(?= connected)" | wc -l` -gt 1 ]; then
	mons -e $position
else
	mons -o
fi

sh ~/.fehbg
