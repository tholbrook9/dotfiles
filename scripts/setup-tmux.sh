#!/bin/bash
# Quick tmux setup for servers

# Check if dotfiles already cloned
if [ ! -d "$HOME/dotfiles" ]; then
    echo "Cloning dotfiles..."
    git clone https://github.com/tholbrook9/dotfiles.git "$HOME/dotfiles"
fi

# Link tmux config
echo "Linking tmux config..."
ln -sf "$HOME/dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Install TPM if not present
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo "✓ Setup complete! Open tmux and press Prefix + I to install plugins"
