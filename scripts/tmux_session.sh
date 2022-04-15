#!/bin/bash


selected=$(find ~/GIT/ -mindepth 1 -maxdepth 3 -type d | fzy -l 25)

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)

names_list=$(echo "$selected_name" | tr '-' ' ')


split_names=($(echo $names_list | tr " " "\n"))

name=${split_names[6]}

if [[ -z $name ]]; then
    name=$selected_name
fi

tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $name -c $selected
    exit 0
fi

if ! tmux has-session -t $name 2> /dev/null; then
    tmux new-session -ds $name -c $selected
    tmux send-keys -t $name 'vim .' C-m
fi

if [[ -z $TMUX ]]; then
    tmux attach-session -t $name
else
    tmux switch-client -t $name
fi
