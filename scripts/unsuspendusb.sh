#!/bin/bash
for i in /sys/bus/usb/devices/*/power/autosuspend; do echo -1 > $i; done
