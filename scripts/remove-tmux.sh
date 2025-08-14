#!/bin/bash
# Fully remove tmux setup from servers

echo "Removing tmux setup completely..."

# Remove tmux config symlink
if [ -L "$HOME/.tmux.conf" ]; then
    echo "  - Removing .tmux.conf symlink"
    rm "$HOME/.tmux.conf"
fi

# Remove TPM and all tmux data
if [ -d "$HOME/.tmux" ]; then
    echo "  - Removing .tmux directory and plugins"
    rm -rf "$HOME/.tmux"
fi

# Remove tmux package
if command -v tmux &> /dev/null; then
    echo "  - Uninstalling tmux package"
    sudo apt remove -y tmux
    sudo apt autoremove -y
fi

# Remove dotfiles repository
if [ -d "$HOME/dotfiles" ]; then
    echo "  - Removing dotfiles repository"
    rm -rf "$HOME/dotfiles"
fi

echo "✓ Complete removal finished!"
echo "  - tmux config removed"
echo "  - tmux plugins removed"
echo "  - tmux package uninstalled"
echo "  - dotfiles repository removed"
