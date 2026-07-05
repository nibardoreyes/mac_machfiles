#!/bin/zsh
# Fuzzy find recent directories and run the startup script
selected_dir=$(zoxide query -l | fzf --preview 'tree -C {}')

if [ -n "$selected_dir" ]; then
    cd "$selected_dir" || exit
    # startup_tmux.sh  # Run your custom startup script
else
    echo "No directory selected."
fi
