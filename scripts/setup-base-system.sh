#!/bin/bash
# setup-base-system.sh - Install base system packages and configure Ubuntu

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Setting up Base System ===${NC}"

# Update system
echo -e "${YELLOW}Updating system packages...${NC}"
sudo apt update && sudo apt upgrade -y

# Create common directories
echo -e "${YELLOW}Creating directory structure...${NC}"
mkdir -p ~/bin ~/Development/{python,javascript,rust,docker,projects,ai,lua,services,prompts} ~/Applications

# Install essential system packages
echo -e "${YELLOW}Installing essential system tools...${NC}"
sudo apt install -y \
    curl wget git \
    build-essential gcc-multilib g++-multilib \
    cmake make meson \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg lsb-release

# Install system utilities
echo -e "${YELLOW}Installing system utilities...${NC}"
sudo apt install -y \
    htop neo-htop glances \
    tree neofetch lolcat \
    xclip xsel \
    openssh-server \
    lvm2

# Install desktop environment tools
echo -e "${YELLOW}Installing desktop environment...${NC}"
sudo apt install -y \
    ubuntu-desktop-minimal \
    ubuntu-gnome-desktop \
    gnome-tweaks \
    gnome-shell-extension-manager \
    gnome-browser-connector \
    gnome-software \
    gnome-software-plugin-flatpak

# Install multimedia tools
echo -e "${YELLOW}Installing multimedia tools...${NC}"
sudo apt install -y \
    ffmpeg vlc \
    flameshot gnome-screenshot grim \
    imagemagick \
    pavucontrol

# Enable Flatpak
echo -e "${YELLOW}Setting up Flatpak...${NC}"
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Clean up
echo -e "${YELLOW}Cleaning up...${NC}"
sudo apt autoremove -y
sudo apt autoclean

echo -e "${GREEN}✓ Base system setup complete!${NC}"