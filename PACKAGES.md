# Complete Software Inventory

This document contains a comprehensive list of all software currently installed on the system, organized by installation method and category.

## APT Packages (System Package Manager)

### Development Tools & Languages

```bash
# Core development tools
sudo apt install gcc-multilib g++-multilib cmake make meson build-essential
sudo apt install git curl wget

# Python development
sudo apt install python3-pip python3-venv python-is-python3 pipx

# Development libraries
sudo apt install libcurl4-openssl-dev libcairo2-dev librsvg2-dev libarchive-dev 
sudo apt install libboost-all-dev libc6-dev libglib2.0-dev libxpm-dev
sudo apt install libfuse-dev portaudio19-dev libflac-dev libflac12t64

# Lua
sudo apt install lua5.4 luarocks

# Qt development
sudo apt install qtbase5-dev qtdeclarative5-dev qttools5-dev-tools

# Other dev tools
sudo apt install patchelf sassc
```

### Terminal & CLI Tools

```bash
# Shell and terminal tools
sudo apt install zsh tree

# System monitoring
sudo apt install htop neo-htop glances

# Modern CLI replacements
sudo apt install fzf ripgrep fdclone

# System information
sudo apt install neofetch lolcat

# Clipboard and selection
sudo apt install xclip xsel

# File and text processing
sudo apt install yamllint
```

### Desktop Environment & GNOME

```bash
# Desktop environments
sudo apt install ubuntu-desktop-minimal ubuntu-gnome-desktop

# GNOME tools and extensions
sudo apt install gnome-tweaks gnome-shell-extension-manager gnome-browser-connector
sudo apt install gnome-software gnome-software-plugin-flatpak

# Screenshots and screen capture
sudo apt install flameshot gnome-screenshot grim

# Desktop utilities
sudo apt install redshift pavucontrol
```

### Media & Entertainment

```bash
# Video and audio processing
sudo apt install ffmpeg vlc

# Music and audio
sudo apt install mopidy mpg123

# Image processing
sudo apt install imagemagick
```

### Security & Privacy

```bash
# Encryption and security
sudo apt install veracrypt

# YubiKey support
sudo apt install yubikey-manager yubikey-personalization pcscd scdaemon

# SSH and networking
sudo apt install openssh-server
```

### Hardware & System Support

```bash
# NVIDIA drivers and CUDA support
sudo apt install nvidia-driver-550 nvidia-container-toolkit

# Video loopback support
sudo apt install v4l2loopback-dkms

# Mobile device support
sudo apt install libimobiledevice6 ifuse

# Storage management
sudo apt install lvm2
```

### Containers & Virtualization

```bash
# Docker
sudo apt install docker-ce docker-ce-cli docker-compose-plugin docker-buildx-plugin containerd.io
```

### Language Input & Fonts

```bash
# Chinese input methods
sudo apt install ibus-table-cangjie3 ibus-table-cangjie5 ibus-table-cangjie-big
sudo apt install libchewing3 libchewing3-data libpinyin15 libpinyin-data

# Multilingual support
sudo apt install libopencc1.1 libopencc-data libotf1 libm17n-0 m17n-db

# Text processing
sudo apt install libttspico-utils espeak

# Language packs
sudo apt install language-pack-en language-pack-en-base
sudo apt install language-pack-gnome-en language-pack-gnome-en-base
sudo apt install wbritish
```

### Web Browsers & Applications

```bash
# Browsers
sudo apt install google-chrome-stable librewolf

# Applications
sudo apt install kdeconnect rpi-imager yt-dlp
```

### Specialized Applications

```bash
# Trading and finance
sudo apt install tradingview webulldesktop windsurf

# System utilities
sudo apt install ubuntu-restricted-addons ubuntu-wallpapers
sudo apt install flatpak xdg-desktop-portal xdg-desktop-portal-gtk
sudo apt install software-properties-common
```

## Snap Packages

### Development Tools

```bash
# Editors and IDEs
sudo snap install code --classic
sudo snap install nvim --classic
sudo snap install gitkraken --classic
```

### Applications

```bash
# Web browsers
sudo snap install firefox

# Communication
sudo snap install telegram-desktop
sudo snap install thunderbird

# System monitoring
sudo snap install nvtop
```

### System Components

Note: These are automatically installed dependencies:
- Various core snaps (core18, core20, core22, core24)
- GNOME theming (gnome-3-28-1804, gnome-42-2204, gtk-common-themes)
- System utilities (snap-store, snapd-desktop-integration)

## Flatpak Applications

```bash
# Translation and productivity
flatpak install flathub app.drey.Dialect

# Security
flatpak install flathub com.bitwarden.desktop

# Communication
flatpak install flathub com.discordapp.Discord
flatpak install flathub com.rtosta.zapzap

# Development and utilities
flatpak install flathub com.obsproject.Studio
flatpak install flathub com.github.ADBeveridge.Raider
flatpak install flathub com.ranfdev.Notify
flatpak install flathub me.iepure.devtoolbox

# Media
flatpak install flathub com.spotify.Client

# System utilities
flatpak install flathub com.system76.Popsicle
```

## Rust/Cargo Tools

```bash
# Install Rust first
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install cargo-binstall for faster binary installations
cargo install cargo-binstall

# Terminal and development tools
cargo-binstall zellij        # Terminal multiplexer
cargo-binstall watchexec-cli # File watcher
cargo-binstall ast-grep      # Code search and manipulation
```

### Standard Rust Toolchain

Installed with rustup:
- cargo (package manager)
- rustc (compiler)
- rust-analyzer (language server)
- clippy (linter)
- rustfmt (formatter)
- rust-gdb, rust-lldb (debuggers)

## Python Tools (pipx)

```bash
# Modern Python tooling
pipx install uv  # Fast Python package installer and resolver
```

### Additional Python Tools in ~/.local/bin

- ruff (Python linter and formatter)
- huggingface-cli (Hugging Face model management)
- watchfiles (Python file watcher)

## Node.js / NPM Global Packages

```bash
# First install Node via NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
nvm install 22
nvm use 22

# Global packages
npm install -g @google/gemini-cli    # Google Gemini AI CLI
npm install -g ccusage               # Creative Cloud usage tracker
npm install -g tree-sitter-cli       # Tree-sitter parser generator
```

## AppImage Applications

Located in `~/Applications/`:

- **LM Studio** (v0.3.17) - Local AI model runner
- **Beekeeper Studio Ultimate** (v4.6.8) - Database management
- **Cursor** (v0.49.6) - AI-powered code editor
- **Immersed** - VR workspace application
- **LocalSend** (v1.17.0) - Local file sharing
- **Msty** - AI chat interface
- **slowmoUI** (v0.6.1) - Video processing tool

## GNOME Shell Extensions

```bash
# Extensions can be installed via:
# 1. GNOME Extensions website: https://extensions.gnome.org/
# 2. Extension Manager application
# 3. Manual installation from GitHub

# Currently installed extensions:
```

- **Caffeine** (@patapon.info) - Prevent system sleep
- **GSConnect** (@andyholmes.github.io) - KDE Connect integration
- **Vitals** (@CoreCoding.com) - System monitoring in top bar
- **Vertical Workspaces** (@G-dH.github.com) - Workspace layout customization
- **IP Indicator** (@phoenixcreation) - Show IP address in top bar
- **Emoji Copy** (@felipeftn) - Easy emoji access
- **World Clock Lite** (@ailin.nemui) - Multiple timezone display
- **Shortcuts** (@kyle.aims.ac.za) - Keyboard shortcut display
- **WinTile** (@nowsci.com) - Window tiling
- **Notification Configurator** (@exposedcat) - Notification management
- **Desktop Icons NG** (@rastersoft.com) - Desktop icons support
- **Tiling Assistant** (@ubuntu.com) - Window tiling helper
- **Ubuntu AppIndicators** (@ubuntu.com) - System tray support
- **Ubuntu Dock** (@ubuntu.com) - Enhanced dock
- **Binu** (@ctadel) - Custom extension

## Manual Installations & Special Cases

### Starship Cross-Shell Prompt

```bash
# Install Starship prompt
curl -sS https://starship.rs/install.sh | sh
```

Current version: 1.20.1 (installed in `/usr/local/bin/starship`)

### Oh My Zsh

```bash
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Bun JavaScript Runtime

```bash
# Install Bun
curl -fsSL https://bun.sh/install | bash
```

### PNPM Package Manager

```bash
# Install PNPM
curl -fsSL https://get.pnpm.io/install.sh | sh
```

## Version Managers

### NVM (Node Version Manager)

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
```

Current Node version: v22.9.0

### Rustup (Rust Toolchain Manager)

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Current toolchain: stable-x86_64-unknown-linux-gnu

## System Statistics

- **Total APT packages**: 2,559 packages installed
- **Manually installed APT packages**: ~150 packages
- **Snap packages**: 20 packages
- **Flatpak applications**: 10 applications
- **Cargo tools**: 4 main tools + standard Rust toolchain
- **NPM global packages**: 4 packages
- **AppImages**: 7 applications
- **GNOME extensions**: 17 extensions

---

*Last updated: $(date)*
*Generated from system inventory on: $(hostname)*