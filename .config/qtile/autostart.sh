#!/bin/sh
# processes to run in the background

# randomize the wallpaper
randomize-wallpaper
# network manager applet
nm-applet &
# notifications
dunst &
# cache lock screen pixelated image
lock-screen -b &
# hide mouse after 2 seconds
unclutter --timeout 2 &
# start discord
discord --start-minimized &
# sync todo.txt up to server whenever it changes
bash "${HOME}/code/todotxt_deadline_notify/copy_todotxt_to_server" &
# warn me if battery goes low
warn-battery BAT0 &
# start emacs server
systemctl --user start emacs
