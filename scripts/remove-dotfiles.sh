#!/bin/bash
# Remove complete dotfiles setup

echo "Removing full dotfiles setup..."

# Unstow everything (removes symlinks for bashrc, tmux config, etc.)
if [ -d "$HOME/dotfiles" ]; then
    echo "  - Unstowing dotfiles"
    cd "$HOME/dotfiles"
    stow -D . 2>/dev/null
fi

# Restore original bashrc if backup exists
if [ -f "$HOME/.bashrc.backup" ]; then
    echo "  - Restoring original .bashrc"
    mv "$HOME/.bashrc.backup" "$HOME/.bashrc"
elif [ ! -f "$HOME/.bashrc" ]; then
    echo "  - Restoring default .bashrc"
    cp /etc/skel/.bashrc "$HOME/.bashrc" 2>/dev/null
fi

# Remove tmux plugins
if [ -d "$HOME/.config/tmux" ]; then
    echo "  - Removing tmux plugins"
    rm -rf "$HOME/.config/tmux"
fi

# Remove packages (optional)
read -p "Remove tmux and stow packages? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo apt remove -y tmux stow
    sudo apt autoremove -y
fi

# Remove dotfiles repo
if [ -d "$HOME/dotfiles" ]; then
    echo "  - Removing dotfiles repository"
    rm -rf "$HOME/dotfiles"
fi

echo "✓ Complete removal finished!"
echo "  - All symlinks removed"
echo "  - Original bashrc restored (or default created)"
echo "  - Restart shell to load restored bash config"