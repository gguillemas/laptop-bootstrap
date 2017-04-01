#!/bin/sh

if [ $(xrandr | grep -oP "(.*?)(?= connected)" | wc -l) -gt 2 ]; then
	~/scripts/screen-dual.sh
else
	~/scripts/screen-single.sh
fi

sh ~/.fehbg
