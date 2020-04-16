#!/bin/sh
# processes to run in the background

# network manager applet
nm-applet &
# notifications
dunst &
# cache lock screen pixelated image
lock_screen -b &
# compositor
# disable for now, seems to crash/cause visual issues on qtile on my machine
# picom -b &
# hide mouse after 2 seconds
unclutter --timeout 2 &
# start discord
discord --start-minimized &
# start emacs server
systemctl --user start emacs
# randomize the wallpaper
randomize_wallpaper
