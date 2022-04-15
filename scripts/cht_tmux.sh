#!/bin/bash

languages=`echo "rust cpp c bash python javascript haskell" | tr ' ' '\n'`

selected=`printf "$languages" | fzf`

read -p "query: " query

query=`echo $query | tr ' ' '+'`

tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
