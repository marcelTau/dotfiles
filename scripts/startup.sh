#!/bin/bash

# xrandr --output eDP-1 --right-of HDMI-2
xrandr --output eDP-1 --below HDMI-2
#xrandr --output eDP-1 --same-as HDMI-2

#xrandr --newmode "2560x1080_60.00" 230.76 2560 2728 3000 3440 1080 1081 1084 1118 -HSync +Vsync
#xrandr --addmode HDMI-2 "2560x1080_60.00"
#xrandr --output HDMI-2 --mode "2560x1080_60.00"

#cvt 3440 1440 60
#xrandr --newmode "3440x1440_60.00"  419.50  3440 3696 4064 4688  1440 1443 1453 1493 -hsync +vsync
#xrandr --addmode HDMI-2 "3440x1440_60.00"
#xrandr --output HDMI-2 --mode "3440x1440_60.00"

#xrandr --newmode "3440x1080_60.00"  309.50  3440 3664 4024 4608  1080 1083 1093 1120 -hsync +vsync
#xrandr --addmode HDMI-2 "3440x1080_60.00"
#xrandr --output HDMI-2 --mode "3440x1080_60.00"

xrandr --newmode "2880x1200_60.00"  290.00  2880 3080 3384 3888  1200 1203 1213 1245 -hsync +vsync
xrandr --addmode HDMI-2 "2880x1200_60.00"
xrandr --output HDMI-2 --mode "2880x1200_60.00"

feh --bg-scale ~/Pictures/linuxWallpaper.jpeg ~/Pictures/BB.png
