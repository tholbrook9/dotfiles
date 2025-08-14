#!/bin/bash
# Remove simple tmux setup

echo "Removing tmux setup..."

# Remove config
[ -f "$HOME/.tmux.conf" ] && rm "$HOME/.tmux.conf"

# Remove plugins
[ -d "$HOME/.tmux" ] && rm -rf "$HOME/.tmux"

# Uninstall tmux
if command -v tmux &> /dev/null; then
    sudo apt remove -y tmux
    sudo apt autoremove -y
fi

echo "✓ Tmux removed!"