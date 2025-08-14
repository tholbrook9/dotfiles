#!/bin/bash
# Full dotfiles setup for main machines (with stow)

# Clone dotfiles if needed
if [ ! -d "$HOME/dotfiles" ]; then
    echo "Cloning dotfiles..."
    git clone https://github.com/tholbrook9/dotfiles.git "$HOME/dotfiles"
fi

# Install required packages
echo "Installing packages..."
sudo apt update
sudo apt install -y tmux stow git

# Backup existing bashrc if it exists and isn't a symlink
if [ -f "$HOME/.bashrc" ] && [ ! -L "$HOME/.bashrc" ]; then
    echo "Backing up existing .bashrc to .bashrc.backup"
    cp "$HOME/.bashrc" "$HOME/.bashrc.backup"
fi

# Use stow to symlink everything (including bash)
echo "Stowing dotfiles..."
cd "$HOME/dotfiles"
stow .

# Install TPM (for .config/tmux location)
if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"
fi

# Source the new bashrc
echo "Sourcing new bashrc..."
source "$HOME/.bashrc"

echo "✓ Full setup complete!"
echo "  - All dotfiles linked with stow (tmux, bash, etc.)"
echo "  - Original bashrc backed up to .bashrc.backup (if it existed)"
echo "  - Start tmux and press Prefix + I to install plugins"
echo "  - Restart shell or run 'source ~/.bashrc' to load bash config"