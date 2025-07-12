#!/bin/bash
# verify-installation.sh - Verify system setup and installations

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== System Installation Verification ===${NC}"
echo ""

# Function to check if command exists
check_command() {
    if command -v "$1" &> /dev/null; then
        echo -e "${GREEN}✓${NC} $1 is installed"
        return 0
    else
        echo -e "${RED}✗${NC} $1 is NOT installed"
        return 1
    fi
}

# Function to check gsettings value
check_setting() {
    local schema="$1"
    local key="$2"
    local expected="$3"
    local actual=$(gsettings get "$schema" "$key" 2>/dev/null || echo "ERROR")
    
    if [ "$actual" = "$expected" ] || [ "$actual" = "'$expected'" ]; then
        echo -e "${GREEN}✓${NC} $key is set correctly"
    else
        echo -e "${YELLOW}!${NC} $key: expected $expected, got $actual"
    fi
}

echo -e "${YELLOW}=== Core System Tools ===${NC}"
check_command git
check_command curl
check_command wget
check_command zsh
check_command htop

echo -e "\n${YELLOW}=== Development Tools ===${NC}"
check_command python3
check_command pip3
check_command pipx
check_command cargo
check_command rustc
check_command node
check_command npm
check_command docker

echo -e "\n${YELLOW}=== Modern CLI Tools ===${NC}"
check_command fzf
check_command rg  # ripgrep
check_command zellij
check_command nvim
check_command starship

echo -e "\n${YELLOW}=== Theme Configuration ===${NC}"
check_setting org.gnome.desktop.interface gtk-theme "Pop-dark"
check_setting org.gnome.desktop.interface icon-theme "Pop"
check_setting org.gnome.desktop.interface cursor-theme "Pop"
check_setting org.gnome.desktop.interface monospace-font-name "Mononoki Nerd Font 13"

echo -e "\n${YELLOW}=== Keyboard Shortcuts ===${NC}"
check_setting org.gnome.desktop.input-sources xkb-options "['caps:escape']"
check_setting org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Super>Down']"
check_setting org.gnome.settings-daemon.plugins.media-keys terminal "['<Super>t']"

echo -e "\n${YELLOW}=== Package Counts ===${NC}"
echo "APT packages: $(dpkg --get-selections | grep -v deinstall | wc -l)"
echo "Snap packages: $(snap list 2>/dev/null | tail -n +2 | wc -l || echo "0")"
echo "Flatpak apps: $(flatpak list --app 2>/dev/null | wc -l || echo "0")"
echo "Cargo tools: $(cargo install --list 2>/dev/null | grep -E "^[a-zA-Z]" | wc -l || echo "0")"
echo "NPM global: $(npm list -g --depth=0 2>/dev/null | tail -n +2 | wc -l || echo "0")"

echo -e "\n${YELLOW}=== Directory Structure ===${NC}"
for dir in ~/bin ~/Development ~/Applications ~/.config/nvim; do
    if [ -d "$dir" ]; then
        echo -e "${GREEN}✓${NC} $dir exists"
    else
        echo -e "${RED}✗${NC} $dir missing"
    fi
done

echo -e "\n${YELLOW}=== Symlinks ===${NC}"
for link in ~/.zshrc ~/.bashrc ~/.config/nvim; do
    if [ -L "$link" ]; then
        target=$(readlink "$link")
        echo -e "${GREEN}✓${NC} $link -> $target"
    else
        echo -e "${YELLOW}!${NC} $link is not a symlink"
    fi
done

echo -e "\n${BLUE}=== Verification Complete ===${NC}"