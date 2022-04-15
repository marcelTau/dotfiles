#!/bin/bash

source /home/mtaubert/GIT/personal/dotfiles/scripts/startup.sh

sleep 2

source /home/mtaubert/GIT/personal/dotfiles/scripts/startup.sh

xset r rate 250 60

#python ~/timer.py &
#sh ~/timer.sh &

sleep 1

/home/mtaubert/Synergy/synergy_1.14.2-stable.c6918b74.fc34/usr/bin/synergy &

source /home/mtaubert/GIT/personal/dotfiles/scripts/setupi3.sh
