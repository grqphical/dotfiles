#! /bin/zsh

DIR=$(pwd)

SESSION_NAME=$(basename "$DIR")

# Create tmux session with first window running neovim
tmux new-session -d -s "$SESSION_NAME" -c "$DIR" "nvim"

# Create second window with shell in same directory
tmux new-window -t "$SESSION_NAME" -c "$DIR"

tmux attach -t "$SESSION_NAME"
