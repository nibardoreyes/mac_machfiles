#!/bin/zsh

# Use the current directory name as the session name
SESH="$(basename "$PWD")"

# Ensure a unique session name
COUNT=1
while tmux has-session -t "$SESH" 2>/dev/null; do
  SESH="${SESH}_${COUNT}"
  ((COUNT++))
done

# Create a new tmux session with a single terminal window
tmux new-session -ds "$SESH" -c "$PWD"

# Rename the first window to "terminal"
tmux rename-window -t "$SESH":0 "terminal"

# Attach to the tmux session
tmux attach -t "$SESH"
