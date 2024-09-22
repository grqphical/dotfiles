#!/bin/zsh
# This script allows me to create development environments using TMUX in any folder I want
# if the session already exists, TMUX attaches to it

cd ~

# Prompt the user to select a directory using fzf
SELECTED_DIR=$(find ~/development -type d | fzf --header "Choose folder to create environment in")

if [ -z "$SELECTED_DIR" ]; then
    echo "No directory selected, exiting."
    exit 1
fi

SESH=$(basename "$SELECTED_DIR")

tmux has-session -t "$SESH" 2>/dev/null

if [ $? != 0 ]; then
    tmux new-session -d -s $SESH -n "editor"

    tmux send-keys -t "$SESH:0" "cd \"$SELECTED_DIR\"" C-m
    tmux send-keys -t "$SESH:0" "nvim ." C-m

    tmux new-window -t "$SESH" -n "shell"
    tmux send-keys -t "$SESH:1" "cd \"$SELECTED_DIR\"" C-m
    tmux send-keys -t "$SESH:1" "clear" C-m

    tmux select-window -t "$SESH:0"
fi

tmux attach-session -t $SESH
