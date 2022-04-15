#!/bin/bash
i3-msg 'workspace 2: vim'
sleep 1
i3-msg 'exec kitty --config $HOME/GIT/personal/dotfiles/kitty/kitty.conf'
sleep 1
i3-msg 'layout tabbed'
sleep 1
i3-msg 'workspace 3: browser'
sleep 1
i3-msg 'exec brave-browser'
sleep 1
i3-msg 'layout tabbed'
sleep 1
i3-msg 'workspace 4: discord'
sleep 1
i3-msg 'exec discord'
sleep 1
i3-msg 'workspace 2: vim'
