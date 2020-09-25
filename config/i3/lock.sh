#!/bin/sh
set -e
xset s off dpms 0 10 0
i3lock --color=000000 --ignore-empty-password --show-failed-attempts --nofork
xset s off -dpms
feh --bg-fill ~/.config/i3/wallpaper.jpg
