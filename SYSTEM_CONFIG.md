# System Configuration Documentation

This document details the complete system configuration for Ubuntu 24.04 LTS with Pop!_OS theming.

## System Information

### Base System
- **OS**: Ubuntu 24.04.2 LTS (Noble Numbat)
- **Desktop Environment**: GNOME on Wayland
- **Session Type**: gnome-wayland
- **Desktop Type**: ubuntu-desktop + ubuntu-desktop-minimal

### Theme Configuration

#### Pop!_OS Theme Installation
The Pop!_OS themes are installed via Snap:
```bash
# Pop GTK theme is installed as a snap
sudo snap install gtk-theme-pop
```

#### Applied Themes
- **GTK Theme**: Pop-dark
- **Icon Theme**: Pop
- **Cursor Theme**: Pop
- **Window Manager Theme**: Adwaita (default GNOME)
- **Shell Theme**: Default (user-theme extension not enabled)

#### Theme Locations
- System themes: `/usr/share/themes/Pop` and `/usr/share/themes/Pop-dark`
- Theme applied via GNOME Settings (gsettings)

### Font Configuration
- **System Font**: Cantarell 11
- **Document Font**: Cantarell 11
- **Monospace Font**: Mononoki Nerd Font 13
- **Text Scaling**: 1.0
- **Font Antialiasing**: grayscale
- **Font Hinting**: slight

## Home Directory Structure

### Main Directories
```
~/
├── Applications/        # AppImage applications
├── bin/                 # User scripts and binaries
├── Development/         # Development projects (14GB)
│   ├── ai/
│   ├── lua/
│   ├── projects/
│   ├── prompts/
│   ├── python/
│   ├── services/
│   └── udemy/
├── Documents/           # Documents (301MB)
├── Downloads/           # Downloads (8.8GB)
├── InstallOS/           # This repository
├── Music/               # Music files (4.0KB)
├── Pictures/            # Images (89MB)
└── Videos/              # Videos (66GB)
```

### Hidden Directories (36 total)
Key development and configuration directories:
```
~/.android               # Android SDK/tools
~/.bun                   # Bun JavaScript runtime
~/.cache                 # Application cache
~/.cargo                 # Rust/Cargo
~/.claude                # Claude AI CLI
~/.cmake                 # CMake build system
~/.codeium               # Codeium AI assistant
~/.config/               # Main configuration directory
~/.cursor                # Cursor editor
~/.docker                # Docker configuration
~/.gemini                # Gemini AI
~/.gitkraken             # GitKraken
~/.gnupg                 # GPG keys
~/.java                  # Java configuration
~/.librewolf             # LibreWolf browser
~/.local/                # Local applications/data
~/.mozilla               # Firefox/Mozilla
~/.npm                   # NPM packages
~/.nvm                   # Node Version Manager
~/.oh-my-zsh             # Oh-My-ZSH framework
~/.pnpm                  # PNPM package manager
~/.rustup                # Rust toolchain
~/.ssh                   # SSH keys
~/.vscode                # VS Code settings
~/.zellij                # Zellij multiplexer
```

## Configuration Management

### Symlinked Configurations
Configurations managed via InstallOS repository:
- `~/.zshrc` → `~/InstallOS/.zshrc`
- `~/.bashrc` → `~/InstallOS/.bashrc`
- `~/.config/nvim` → `~/InstallOS/.config/nvim`
- `~/.config/ghostty/config` → `~/InstallOS/.config/ghostty/config`
- `~/.config/neofetch/config.conf` → `~/InstallOS/.config/neofetch/config.conf`

### Development Tools Configuration
Located in `~/.config/`:
- `Code/` - VS Code configuration
- `git/` - Git configuration
- `nvim/` - Neovim (symlinked)
- `zellij/` - Terminal multiplexer

### Git Configuration
- **User**: dgnsrekt
- **Email**: dgnsrekt@pm.me
- **GPG Signing Key**: 13B9E6608B47E060083EE7E289FD2302CA358D60
- **Commit Signing**: Enabled

## Desktop Environment

### GNOME Extensions (via ubuntu-desktop)
- gnome-shell-extension-appindicator
- gnome-shell-extension-desktop-icons-ng
- gnome-shell-extension-ubuntu-dock
- gnome-shell-extension-ubuntu-tiling-assistant
- Plus custom extensions (see PACKAGES.md)

### Autostart Applications
- Notify (Flatpak notification app)
- GNOME Clocks

### User Services (systemd)
Key enabled services:
- appimagelauncherd - AppImage integration
- pipewire/wireplumber - Audio system
- gnome-keyring - Password/secret management
- gcr-ssh-agent - SSH key agent
- tracker-miner - File indexing
- Various GNOME/desktop integration services

## Application Data

### Local Application Data (`~/.local/share/`)
Contains:
- Application desktop files
- Custom backgrounds
- Evolution mail data
- Flatpak app data
- Font installations
- GNOME Shell extensions data
- Various application configurations

### Custom Desktop Entries
14 custom `.desktop` files in `~/.local/share/applications/`

## Installation Commands

### Setting Up Pop!_OS Theme on Ubuntu 24.04

```bash
# Install Pop!_OS GTK theme via snap
sudo snap install gtk-theme-pop

# Apply themes via GNOME Tweaks or command line
gsettings set org.gnome.desktop.interface gtk-theme 'Pop-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Pop'
gsettings set org.gnome.desktop.interface cursor-theme 'Pop'

# Install GNOME Tweaks to easily manage themes
sudo apt install gnome-tweaks

# Optional: Install Pop fonts
sudo apt install fonts-firacode
```

### Alternative: Install Pop themes from System76 PPA

```bash
# Add System76 PPA (for more Pop!_OS components)
sudo add-apt-repository ppa:system76/pop
sudo apt update

# Install Pop theme packages
sudo apt install pop-theme pop-icon-theme pop-fonts

# Note: The snap method is simpler and what's currently used
```

## System Maintenance

### Theme Updates
Pop themes installed via snap auto-update. Check with:
```bash
snap refresh gtk-theme-pop
```

### Configuration Backup
All dotfiles are version controlled in the InstallOS repository.
Pull latest changes to sync configurations across machines.

### Storage Usage Summary
- Total home directory items: 83 (including hidden)
- Development: 14GB (largest directory)
- Videos: 66GB (media storage)
- Downloads: 8.8GB
- System configurations: Minimal space

## Notes

1. **Wayland Session**: Running GNOME on Wayland for better performance
2. **Theme Mixing**: Using Pop!_OS themes on Ubuntu provides the Pop aesthetic without full Pop!_OS
3. **Snap Theme**: The gtk-theme-pop snap is the easiest way to get Pop themes on Ubuntu
4. **Font Choice**: Mononoki Nerd Font for terminal/code editing
5. **Development Focus**: Heavy development setup with multiple language environments

---

*Generated on: 2025-01-12*
*System: Ubuntu 24.04.2 LTS with Pop!_OS themes*