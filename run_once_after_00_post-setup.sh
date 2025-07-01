#!/bin/sh
echo "Running post dotfiles setup.."

cd $(chezmoi source-path)

# Fishery - Fish plugin manager
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# Set fish as the default shell
chsh -s /bin/fish

# Allow Flatpak apps to be styled
sudo flatpak override --filesystem=$HOME/.themes
sudo flatpak override --filesystem=$HOME/.icons
# And apply the theme settings
sudo flatpak override --env=GTK_THEME=Colloid-Orange-Dark-Gruvbox
sudo flatpak override --env=ICON_THEME=Colloid-yellow-dark

# Install dependencies for the config scripts
pnpm install

# Mange keyd config
sudo mkdir -p /etc/keyd/
sudo rm /etc/keyd/default.conf 2>/dev/null
sudo ln -s ~/.local/share/chezmoi/.outside/etc/keyd/default.conf /etc/keyd/default.conf 
sudo systemctl enable --now keyd
sudo keyd reload

# Git stuff
# git config --global user.name "VDawg"
# git config --global user.email "vdawg@tuta.io"


# For WireGuard
# sudo systemctl enable --now systemd-resolved