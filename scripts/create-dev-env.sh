#!/bin/bash
# This script allows me to create development environments using TMUX in any folder I want
# if the session already exists, TMUX attaches to it
# 
# Copyright 2024 grqphical
# This script is licensed under the MIT license

function template_go() {
    tmux new-session -d -s $1 -n "editor"

    tmux send-keys -t "$1:0" "cd \"$2\"" C-m
    tmux send-keys -t "$1:0" "nvim ." C-m

    tmux new-window -t "$1" -n "shell"
    tmux send-keys -t "$1:1" "cd \"$2\"" C-m
    tmux send-keys -t "$1:1" "go mod init \"$2\"" C-m
    tmux send-keys -t "$1:1" "clear" C-m

    tmux select-window -t "$1:0"
}

function template_rust() {
    tmux new-session -d -s $1 -n "editor"

    tmux send-keys -t "$1:0" "cd \"$2\"" C-m
    tmux send-keys -t "$1:0" "cargo init --name $1" C-m
    tmux send-keys -t "$1:0" "nvim ." C-m

    tmux new-window -t "$1" -n "shell"
    tmux send-keys -t "$1:1" "cd \"$2\"" C-m
    tmux send-keys -t "$1:1" "clear" C-m

    tmux select-window -t "$1:0"
}

function template_python() {
    tmux new-session -d -s $1 -n "editor"

    tmux send-keys -t "$1:0" "cd \"$2\"" C-m
    tmux send-keys -t "$1:0" "nvim ." C-m

    tmux new-window -t "$1" -n "shell"
    tmux send-keys -t "$1:1" "cd \"$2\"" C-m
    tmux send-keys -t "$1:1" "python3 -m venv venv" C-m
    tmux send-keys -t "$1:1" ". venv/bin/activate" C-m
    tmux send-keys -t "$1:1" "clear" C-m

    tmux select-window -t "$1:0"
}

function template_js() {
    tmux new-session -d -s $1 -n "editor"
    
    tmux send-keys -t "$1:0" "cd \"$2\"" C-m
    tmux send-keys -t "$1:0" "npm create vite@latest ." C-m
    tmux send-keys -t "$1:0" "nvim ." C-m

    tmux new-window -t "$1" -n "shell"
    tmux send-keys -t "$1:1" "cd \"$2\"" C-m
    tmux send-keys -t "$1:1" "clear" C-m

    tmux new-window -t "$1" -n "server"
    tmux send-keys -t "$1:2" "cd \"$2\"" C-m
    tmux send-keys -t "$1:2" "npm install" C-m
    tmux send-keys -t "$1:2" "npm run dev" C-m

    tmux select-window -t "$1:0"
}

cd ~

if [[ "$1" == "new" ]]; then
    # Prompt the user to select a directory using fzf
    SELECTED_DIR=$(find ~/development -type d | fzf --header "Choose folder to create environment in")

    if [ -z "$SELECTED_DIR" ]; then
        echo "No directory selected, exiting."
        exit 1
    fi

    SESH=$(basename "$SELECTED_DIR")

    tmux has-session -t "$SESH" 2>/dev/null

    if [ $? != 0 ]; then
        TEMPLATE=$(echo -e "go\nrust\npython\njs" | fzf --header "Choose template")

        if [[ -z "$TEMPLATE" ]]; then
            echo "No template was chosen"
            exit 1
        fi

        if [[ "$TEMPLATE" == "go" ]]; then
            template_go $SESH $SELECTED_DIR
        elif [[ "$TEMPLATE" == "rust" ]]; then
            template_rust $SESH $SELECTED_DIR
        elif [[ "$TEMPLATE" == "python" ]]; then
            template_python $SESH $SELECTED_DIR
        elif [[ "$TEMPLATE" == "js" ]]; then
            template_js $SESH $SELECTED_DIR
        fi
    fi
    tmux attach-session -t $SESH

elif [[ "$1" == "attach" ]]; then
    SESH=$(tmux list-sessions | cut -d':' -f1 | fzf --header "Choose a session")

    if [ -z "$SESH" ]; then
        echo "No session was chosen"
        exit 1
    fi
    tmux attach-session -t "$SESH"
else
    echo "create-dev-env.sh by grqphical. A tool to create a TMUX session based on a template and/or folder"
    echo ""
    echo "Dependencies: tmux, fzf, cargo, npm, python3, go"
    echo ""
    echo "Commands: "
    echo "  - help: Prints this message"
    echo "  - new: Creates a new session"
    echo "  - attach: Attaches to an existing session"
    echo ""
    echo "LICENSE: create-dev-env.sh is licensed under the MIT license"
fi


