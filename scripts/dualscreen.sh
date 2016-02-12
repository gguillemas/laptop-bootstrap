#!/bin/bash
main=$(xrandr | grep -oP "(.*?)(?= connected)" | sed -n 1p)
secondary=$(xrandr | grep -oP "(.*?)(?= connected)" | sed -n 2p)
xrandr --output $secondary --auto --right-of $main
