#!/bin/bash
# Full dotfiles setup for main WSL machines

# Clone dotfiles if needed
if [ ! -d "$HOME/dotfiles" ]; then
    echo "Cloning dotfiles..."
    git clone https://github.com/tholbrook9/dotfiles.git "$HOME/dotfiles"
fi

# Install required packages
echo "Installing packages..."
sudo apt update
sudo apt install -y tmux stow git fontconfig

# Install JuliaMono Nerd Font
echo "Installing JuliaMono Nerd Font..."
git clone https://github.com/mietzen/juliamono-nerd-font.git /tmp/juliamono-nerd-font 2>/dev/null || true

# Copy fonts to Windows user fonts directory
WINDOWS_USER_FONTS="/mnt/c/Users/$USER/AppData/Local/Microsoft/Windows/Fonts"
mkdir -p "$WINDOWS_USER_FONTS"
cp /tmp/juliamono-nerd-font/*.ttf "$WINDOWS_USER_FONTS/" 2>/dev/null && echo "  - Fonts installed to Windows"

# Backup existing bashrc
if [ -f "$HOME/.bashrc" ] && [ ! -L "$HOME/.bashrc" ]; then
    echo "Backing up existing .bashrc"
    cp "$HOME/.bashrc" "$HOME/.bashrc.backup"
fi

# Use stow for Linux dotfiles (NOT Windows Terminal)
echo "Stowing Linux dotfiles..."
cd "$HOME/dotfiles"

stow .

# Install TPM
if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"
fi

# Handle Windows Terminal settings separately (not with stow)
echo "Setting up Windows Terminal..."
WT_SETTINGS="/mnt/c/Users/$USER/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
if [ -f "$WT_SETTINGS" ]; then
    # Backup current settings
    cp "$WT_SETTINGS" "$WT_SETTINGS.backup.$(date +%Y%m%d)" 2>/dev/null
    echo "  - Backed up current settings"

    # Copy our settings from repo
    if [ -f "$HOME/dotfiles/windowsterminal/settings.json" ]; then
        cp "$HOME/dotfiles/windowsterminal/settings.json" "$WT_SETTINGS"
        echo "  - Applied custom Windows Terminal settings"
    fi
else
    echo "  - Windows Terminal not found, skipping"
fi

echo ""
echo "✓ Full setup complete!"
echo "  - Linux dotfiles linked with stow"
echo "  - JuliaMono Nerd Font installed"
echo "  - Windows Terminal configured"
echo ""
echo "Next steps:"
echo "  1. Restart Windows Terminal to load new font/settings"
echo "  2. Start tmux and press Prefix + I to install plugins"