#!/bin/bash
if i3-msg -t get_tree | grep -q '"instance":"todos"'; then
    i3-msg '[instance="todos"] scratchpad show'
else
    st -n todos -e vim "$HOME/todos.md" &
fi
