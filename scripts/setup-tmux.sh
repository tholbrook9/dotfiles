#!/bin/bash
# Quick tmux setup for servers - removes unnecessary files

# Ensure we have dotfiles
if [ ! -d "$HOME/dotfiles" ]; then
    echo "Cloning dotfiles..."
    git clone https://github.com/tholbrook9/dotfiles.git "$HOME/dotfiles"
fi

# Install tmux if not present
if ! command -v tmux &> /dev/null; then
    echo "Installing tmux..."
    sudo apt update && sudo apt install -y tmux
fi

# Create symlink for tmux config
echo "Linking tmux config..."
ln -sf "$HOME/dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Remove bash directory - not needed on servers
if [ -d "$HOME/dotfiles/bash" ]; then
    echo "Removing bash directory (WSL-specific)..."
    rm -rf "$HOME/dotfiles/bash"
fi

# Install TPM if not present
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo "✓ Setup complete!"
echo "  1. Start tmux"
echo "  2. Press Prefix + I to install plugins"
