#!/bin/bash
screen=$(xrandr | grep -oP "(.*?)(?= connected)" | sed -n 1p)
projector=$(xrandr | grep -oP "(.*?)(?= connected)" | sed -n 2p)
xrandr --output $projector --mode 1024x768 --same-as $screen --output $screen --mode 1024x768
