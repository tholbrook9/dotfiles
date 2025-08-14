#!/bin/bash
# Simple tmux setup - no dotfiles repo needed

# Install tmux if not present
if ! command -v tmux &> /dev/null; then
    echo "Installing tmux..."
    sudo apt update && sudo apt install -y tmux
fi

# Download config directly
echo "Downloading tmux config..."
curl -sSL https://raw.githubusercontent.com/tholbrook9/dotfiles/main/.config/tmux/tmux.conf -o ~/.tmux.conf

# Install TPM for plugins
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo "✓ Simple setup complete!"
echo "  1. Start tmux"
echo "  2. Press Prefix + I to install plugins"