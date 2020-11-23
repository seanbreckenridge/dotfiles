#!/bin/sh
# automatically fixes my screen layout, depending on whether or not HDMI is plugged in
if xrandr | grep -q 'HDMI-A-0 connected'; then
	"${HOME}/.config/screenlayout/desk_dual_monitor.sh"
else
	"${HOME}/.config/screenlayout/single_laptop_screen.sh"
fi
