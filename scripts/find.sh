#!/bin/bash

#working cd $(find ~/GIT/ -mindepth 1 -maxdepth 3 -type d | fzy -l 25 -p "-> ")

# cd $(find ~/GIT/tek2 -mindepth 1 -maxdepth 2 -type d | grep "B-" | fzf -e )

#directories=$(find ~/git -mindepth 1 -maxdepth 5 -name .git -type d | sed 's|\.git||g')
#directories=$(find ~/git -mindepth 1 -maxdepth 5 -name .git -type d | replace '.git' '')


#set directories $(find ~/git -mindepth 1 -maxdepth 5 -name .git -type d | sed 's|\.git||g')
#cd $(string split ' ' $directories | fzf)
#echo $(echo $directories | tr ' ' '\n')
#cd $(echo -e "$directories" | fzf)

#echo "$directories"


cd $(find ~/git/ -mindepth 1 -maxdepth 3 -type d | fzf -e )
