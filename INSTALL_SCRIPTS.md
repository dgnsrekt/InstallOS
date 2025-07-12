# Installation Scripts and Automation

This document provides automated installation scripts and step-by-step procedures for setting up a new system with all the documented software.

## Pre-Installation Setup

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Create common directories
mkdir -p ~/bin ~/Development/{python,javascript,rust,docker} ~/Applications
```

## Core System Setup

### 1. Essential Development Tools

```bash
#!/bin/bash
# install-dev-essentials.sh

sudo apt install -y \
    gcc-multilib g++-multilib cmake make meson build-essential \
    git curl wget \
    python3-pip python3-venv python-is-python3 pipx \
    libcurl4-openssl-dev libcairo2-dev librsvg2-dev libarchive-dev \
    libboost-all-dev libc6-dev libglib2.0-dev libxpm-dev \
    libfuse-dev portaudio19-dev libflac-dev libflac12t64 \
    lua5.4 luarocks \
    qtbase5-dev qtdeclarative5-dev qttools5-dev-tools \
    patchelf sassc
```

### 2. Terminal and CLI Tools

```bash
#!/bin/bash
# install-cli-tools.sh

sudo apt install -y \
    zsh tree \
    htop neo-htop glances \
    fzf ripgrep fdclone \
    neofetch lolcat \
    xclip xsel \
    yamllint
```

### 3. Desktop Environment

```bash
#!/bin/bash
# install-desktop.sh

sudo apt install -y \
    ubuntu-desktop-minimal ubuntu-gnome-desktop \
    gnome-tweaks gnome-shell-extension-manager gnome-browser-connector \
    gnome-software gnome-software-plugin-flatpak \
    flameshot gnome-screenshot grim \
    redshift pavucontrol
```

### 4. Media and Entertainment

```bash
#!/bin/bash
# install-media.sh

sudo apt install -y \
    ffmpeg vlc \
    mopidy mpg123 \
    imagemagick
```

### 5. Security and Hardware Support

```bash
#!/bin/bash
# install-security-hardware.sh

# Security tools
sudo apt install -y \
    veracrypt \
    yubikey-manager yubikey-personalization pcscd scdaemon \
    openssh-server

# NVIDIA drivers (adjust version as needed)
sudo apt install -y \
    nvidia-driver-550 nvidia-container-toolkit

# Hardware support
sudo apt install -y \
    v4l2loopback-dkms \
    libimobiledevice6 ifuse \
    lvm2
```

## Language and Runtime Setup

### Install Rust

```bash
#!/bin/bash
# install-rust.sh

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env

# Install cargo-binstall for faster installations
cargo install cargo-binstall

# Install Rust CLI tools
cargo-binstall -y zellij watchexec-cli ast-grep
```

### Install Node.js via NVM

```bash
#!/bin/bash
# install-nodejs.sh

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# Source NVM (or restart terminal)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install latest LTS Node
nvm install 22
nvm use 22

# Install global packages
npm install -g @google/gemini-cli ccusage tree-sitter-cli
```

### Install Python Tools

```bash
#!/bin/bash
# install-python-tools.sh

# Install modern Python tooling
pipx install uv
```

### Install Other Runtimes

```bash
#!/bin/bash
# install-other-runtimes.sh

# Install Bun
curl -fsSL https://bun.sh/install | bash

# Install PNPM
curl -fsSL https://get.pnpm.io/install.sh | sh
```

## Shell and Prompt Setup

### Install Oh My Zsh and Starship

```bash
#!/bin/bash
# install-shell-setup.sh

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Starship prompt
curl -sS https://starship.rs/install.sh | sh

# Note: Shell configuration files (.zshrc, .bashrc) should be symlinked from the repo
```

## Container and Virtualization

### Install Docker

```bash
#!/bin/bash
# install-docker.sh

# Add Docker's official GPG key
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add user to docker group
sudo usermod -aG docker $USER
```

## Snap Packages

```bash
#!/bin/bash
# install-snaps.sh

# Development tools
sudo snap install code --classic
sudo snap install nvim --classic
sudo snap install gitkraken --classic

# Applications
sudo snap install firefox
sudo snap install telegram-desktop
sudo snap install thunderbird
sudo snap install nvtop
```

## Flatpak Applications

```bash
#!/bin/bash
# install-flatpaks.sh

# Enable Flathub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install applications
flatpak install -y flathub app.drey.Dialect
flatpak install -y flathub com.bitwarden.desktop
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub com.rtosta.zapzap
flatpak install -y flathub com.obsproject.Studio
flatpak install -y flathub com.github.ADBeveridge.Raider
flatpak install -y flathub com.ranfdev.Notify
flatpak install -y flathub me.iepure.devtoolbox
flatpak install -y flathub com.spotify.Client
flatpak install -y flathub com.system76.Popsicle
```

## Theme Installation

### Pop!_OS Themes on Ubuntu

```bash
#!/bin/bash
# install-pop-themes.sh

# Method 1: Install via Snap (Recommended - Currently used)
sudo snap install gtk-theme-pop

# Apply the themes
gsettings set org.gnome.desktop.interface gtk-theme 'Pop-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Pop'
gsettings set org.gnome.desktop.interface cursor-theme 'Pop'

# Set fonts
gsettings set org.gnome.desktop.interface font-name 'Cantarell 11'
gsettings set org.gnome.desktop.interface document-font-name 'Cantarell 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Mononoki Nerd Font 13'

# Method 2: Install from System76 PPA (Alternative)
# sudo add-apt-repository ppa:system76/pop
# sudo apt update
# sudo apt install pop-theme pop-icon-theme pop-fonts
```

## Manual Installations

### Web Browsers

```bash
#!/bin/bash
# install-browsers.sh

# Google Chrome
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update
sudo apt install -y google-chrome-stable

# LibreWolf (add their repository first)
# Follow instructions from: https://librewolf.net/installation/debian/
```

### Ghostty Terminal

```bash
#!/bin/bash
# install-ghostty.sh

# Follow instructions from: https://github.com/mkasberg/ghostty-ubuntu
# This typically involves adding a PPA or downloading a .deb file
```

## AppImages Setup

```bash
#!/bin/bash
# setup-appimages.sh

# Install AppImageLauncher for better AppImage integration
sudo apt install -y appimagelauncher

# Download AppImages to ~/Applications/
# Note: These need to be downloaded manually or via specific scripts
echo "Download the following AppImages to ~/Applications/:"
echo "- LM Studio: https://lmstudio.ai/"
echo "- Cursor: https://cursor.sh/"
echo "- Beekeeper Studio: https://www.beekeeperstudio.io/"
echo "- LocalSend: https://localsend.org/"
echo "- And others as needed..."
```

## GNOME Extensions

```bash
#!/bin/bash
# install-gnome-extensions.sh

# Install GNOME Extension Manager
sudo apt install -y gnome-shell-extension-manager

echo "Install GNOME extensions via:"
echo "1. Extension Manager application"
echo "2. https://extensions.gnome.org/"
echo ""
echo "Required extensions:"
echo "- Caffeine"
echo "- GSConnect"
echo "- Vitals"
echo "- Vertical Workspaces"
echo "- IP Indicator"
echo "- Emoji Copy"
echo "- World Clock Lite"
echo "- Shortcuts"
echo "- WinTile"
echo "- Notification Configurator"
echo "- Desktop Icons NG"
echo "- Tiling Assistant"
echo "- Ubuntu AppIndicators"
echo "- Ubuntu Dock"
```

## Complete Installation Script

```bash
#!/bin/bash
# complete-install.sh

set -e  # Exit on any error

echo "Starting complete system setup..."

# Update system first
sudo apt update && sudo apt upgrade -y

# Run all installation scripts
./install-dev-essentials.sh
./install-cli-tools.sh
./install-desktop.sh
./install-media.sh
./install-security-hardware.sh
./install-docker.sh
./install-rust.sh
./install-nodejs.sh
./install-python-tools.sh
./install-other-runtimes.sh
./install-shell-setup.sh
./install-snaps.sh
./install-flatpaks.sh
./install-browsers.sh

echo "Core installation complete!"
echo ""
echo "Manual steps remaining:"
echo "1. Install Ghostty terminal"
echo "2. Download and install AppImages"
echo "3. Install GNOME extensions"
echo "4. Set up configuration symlinks (see CONFIG_SYMLINKS.md)"
echo "5. Configure Git with your credentials"
echo "6. Set up GPG keys"
echo "7. Configure GNOME settings and shortcuts"
echo ""
echo "Reboot recommended after installation."
```

## Post-Installation Configuration

### Git Configuration

```bash
#!/bin/bash
# configure-git.sh

git config --global user.email "dgnsrekt@pm.me"
git config --global user.name "dgnsrekt"
git config --global core.editor "vim"
git config --global commit.gpgsign true
```

### GPG Setup

```bash
#!/bin/bash
# setup-gpg.sh

echo "Follow these steps to set up GPG:"
echo "1. Generate GPG key: gpg --full-generate-key"
echo "2. List keys: gpg --list-secret-keys --keyid-format LONG"
echo "3. Export public key: gpg --armor --export YOUR_KEY_ID"
echo "4. Add to GitHub: Settings > SSH and GPG keys"
echo "5. Set Git signing key: git config --global user.signingkey YOUR_KEY_ID"
```

## Verification Scripts

### Check Installation Status

```bash
#!/bin/bash
# verify-installation.sh

echo "Checking installation status..."

# Check key commands
commands=(
    "git" "curl" "wget" "zsh" "nvim" "code" "docker" "cargo" "node" "npm" 
    "pipx" "flatpak" "snap" "starship" "zellij" "ripgrep" "fzf"
)

for cmd in "${commands[@]}"; do
    if command -v "$cmd" &> /dev/null; then
        echo "✓ $cmd is installed"
    else
        echo "✗ $cmd is NOT installed"
    fi
done

echo ""
echo "Package counts:"
echo "APT packages: $(dpkg --get-selections | grep -v deinstall | wc -l)"
echo "Snap packages: $(snap list | tail -n +2 | wc -l)"
echo "Flatpak apps: $(flatpak list --app | wc -l)"
echo "Cargo tools: $(cargo install --list | grep -E "^[a-zA-Z]" | wc -l)"
echo "NPM global packages: $(npm list -g --depth=0 | tail -n +2 | wc -l)"
```

---

*Note: Make all shell scripts executable with `chmod +x *.sh` before running.*
*Test scripts on a VM or non-production system first.*