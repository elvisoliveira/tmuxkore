#!/bin/bash
# Bootstrap.
session="kore"

# Select profile.
declare -a profiles=($(ls ../profiles))
echo "Select profile:"
for ((i = 0; i < ${#profiles[@]}; ++i)); do echo "[$i] ${profiles[i]}"; done
read -p "Which one? " profile
while [[ -z "$profile" ]]; do exit; done

# Setup Tmux: Session.
if [[ $(tmux ls -F "#{session_name}") != $session ]]; then
	tmux new-session -d -n ${profiles[profile]} -s $session
fi

# Setup Tmux: Window.
if [[ $(tmux display-message -p '#W') != ${profiles[profile]} ]]; then
	tmux new-window -t $session -n ${profiles[profile]}
fi

# Start app.
declare -a accounts=($(ls ../profiles/${profiles[profile]}/ | grep .txt))
for ((i = 0; i < ${#accounts[@]}; ++i)); do
	if [[ ${i} < $(expr ${#accounts[@]} - 1) ]]; then
		tmux splitw -t $session
	fi
	tmux send -t $session:$(tmux display -pt ${profiles[profile]} '#{window_index}').${i} "perl ./openkore.pl \
		--config=\"../profiles/${profiles[profile]}/${accounts[i]}\" \
		--control=\"../profiles/${profiles[profile]}/control\" \
		--plugins=\"../plugins\" \
		--logs=\"../logs\"" C-m
	# tmux selectp -t $session:0.0
	tmux selectl -t $session tiled
done

tmux a -t $session
