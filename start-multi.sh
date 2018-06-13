#!/bin/bash
# @TODO: Profiles folder must be on previous folder.
declare -a functions=($(ls ../profiles))
echo "Select function:"
for ((i = 0; i < ${#functions[@]}; ++i)); do
	echo "[$i] ${functions[i]}"
done
read -p "Which one? " function
while [[ -z "$function" ]]; do
	exit
done
# TMUX
tmux start-server
tmux attach -d -s $function || tmux new -d -s $function
# Account
declare -a accounts=($(ls ../profiles/${functions[function]}/ | grep .txt))
for ((i = 0; i < ${#accounts[@]}; ++i)); do
	tmux splitw -t $function -l 1
	tmux send -t $function:0.1 "perl ./openkore.pl --config=\"../profiles/${functions[function]}/${accounts[i]}\" \
								                   --control=\"../profiles/${functions[function]}/control\" \
								                   --plugins=\"../plugins\" \
								                   --logs=\"../logs\"" C-m
	tmux selectp -t $function:0.0
	tmux selectl -t $function tiled
done
tmux a -t $function
