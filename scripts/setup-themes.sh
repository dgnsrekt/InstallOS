#!/bin/bash
# setup-themes.sh - Install and configure Pop!_OS themes

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Setting up Pop!_OS Themes ===${NC}"

# Install Pop GTK theme via snap
echo -e "${YELLOW}Installing Pop!_OS theme...${NC}"
sudo snap install gtk-theme-pop

# Install fonts
echo -e "${YELLOW}Installing fonts...${NC}"
# Install Mononoki Nerd Font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
if [ ! -f "MononokiNerdFont-Regular.ttf" ]; then
    wget -q https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Mononoki/Regular/MononokiNerdFont-Regular.ttf
    echo -e "${GREEN}✓ Mononoki Nerd Font installed${NC}"
else
    echo -e "${GREEN}Mononoki Nerd Font already installed${NC}"
fi

# Refresh font cache
fc-cache -f -v

# Apply themes
echo -e "${YELLOW}Applying Pop!_OS themes...${NC}"
gsettings set org.gnome.desktop.interface gtk-theme 'Pop-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Pop'
gsettings set org.gnome.desktop.interface cursor-theme 'Pop'

# Set fonts
echo -e "${YELLOW}Configuring fonts...${NC}"
gsettings set org.gnome.desktop.interface font-name 'Cantarell 11'
gsettings set org.gnome.desktop.interface document-font-name 'Cantarell 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Mononoki Nerd Font 13'

# Font rendering settings
gsettings set org.gnome.desktop.interface font-antialiasing 'grayscale'
gsettings set org.gnome.desktop.interface font-hinting 'slight'

echo -e "${GREEN}✓ Themes setup complete!${NC}"
echo -e "${YELLOW}Note: You may need to restart GNOME Shell (Alt+F2, type 'r') to see all changes${NC}"