# InstallOS - Personal Development Environment Setup

A comprehensive dotfiles and system configuration repository for setting up Ubuntu/Pop!_OS development environments.

## Quick Start

### For New System Setup

1. **Install Pop!_OS** from [pop.system76.com](https://pop.system76.com/)

2. **Clone this repository**
   ```bash
   cd ~
   git clone https://github.com/dgnsrekt/InstallOS.git
   cd InstallOS
   ```

3. **Run automated installation** (see [INSTALL_SCRIPTS.md](INSTALL_SCRIPTS.md))
   ```bash
   # Run the complete setup (review scripts first!)
   chmod +x scripts/*.sh
   ./scripts/complete-install.sh
   ```

4. **Set up configuration symlinks** (see [CONFIG_SYMLINKS.md](CONFIG_SYMLINKS.md))
   ```bash
   ./scripts/setup-symlinks.sh
   ```

### For Existing Systems

- **Update configurations**: Just pull changes - symlinked files update automatically
- **Add new software**: Check [PACKAGES.md](PACKAGES.md) for installation commands
- **Backup configs**: All dotfiles are version controlled in this repo

## Documentation

- **[PACKAGES.md](PACKAGES.md)** - Complete inventory of 150+ installed packages
- **[INSTALL_SCRIPTS.md](INSTALL_SCRIPTS.md)** - Automated installation scripts and procedures  
- **[CONFIG_SYMLINKS.md](CONFIG_SYMLINKS.md)** - Dotfile management and symlink setup
- **[SYSTEM_CONFIG.md](SYSTEM_CONFIG.md)** - Detailed system configuration and Pop!_OS theme setup
- **[KEYBOARD_SHORTCUTS.md](KEYBOARD_SHORTCUTS.md)** - Complete keyboard shortcuts with all customizations

## What's Included

### Development Environment
- **Languages**: Python, Rust, Node.js, Lua
- **Editors**: Neovim (LazyVim), VS Code, Cursor
- **Tools**: Docker, Git, modern CLI utilities
- **Terminal**: Ghostty, ZSH with Oh-My-ZSH, Starship prompt

### Desktop Environment  
- **OS**: Ubuntu/Pop!_OS with GNOME
- **Extensions**: 17 GNOME extensions for productivity
- **Apps**: Communication, media, development tools
- **Themes**: Pop! theme with Mononoki Nerd Font

### Package Managers
- **System**: APT (150+ packages)
- **Applications**: Snap (20 packages), Flatpak (10 apps), AppImages (7 apps)
- **Development**: Cargo (Rust), NPM (Node.js), pipx (Python)

## Key Features

### Automated Setup
- **One-click installation** of all software packages
- **Automated symlink setup** for dotfiles
- **Verification scripts** to check installation status

### Modern Tooling
- **Fast CLI tools**: ripgrep, fzf, zellij, modern replacements
- **AI Integration**: Claude Code, Gemini CLI, LM Studio
- **Development**: LazyVim, Rust toolchain, modern Python tools

### Cross-Machine Sync
- **Git-based**: All configurations version controlled
- **Symlinked dotfiles**: Changes sync automatically
- **Portable setup**: Works on any Ubuntu/Pop!_OS system

## Manual Configuration Steps

### Initial System Setup

```bash
# Create development directories
mkdir -p ~/bin ~/Development/{python,javascript,rust,docker} ~/Applications

# Update system and install GNOME session
sudo apt update && sudo apt upgrade -y
sudo apt install gnome-session

# Restart and login with GNOME
```

### GNOME Desktop Configuration

#### GNOME Tweaks Settings
- **Appearance**: Change everything to **Pop!** theme
- **Extensions**: Enable System76 Power Management (laptops only)
- **Fonts**: Monospace Text → **Mononoki Nerd Font Bold 14**
- **Keyboard & Mouse**: Additional Layout Options → Caps Lock → **Make Caps Lock an additional Esc**
- **Top Bar**: Enable **Battery Percentage** (laptops), **Weekday**
- **Workspaces**: Enable **Workspaces span displays**

#### System Settings
- **Power**: Set blank screen to 15 minutes
- **Keyboard Shortcuts**:
  - Navigation → Move to Workspace Above: **Super+Up**
  - Navigation → Move to Workspace Below: **Super+Down**  
  - Launchers → Launch terminal: **Super+T**

#### Workspace Navigation (via gsettings)
```bash
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>Right']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>Left']"
```

### Git and GitHub Setup

```bash
# Configure Git
git config --global user.email "dgnsrekt@pm.me"
git config --global user.name "dgnsrekt"
git config --global core.editor "vim"
git config --global commit.gpgsign true

# Generate SSH key
ssh-keygen -t rsa -b 4096 -C "dgnsrekt@pm.me"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# Display public key (add to GitHub)
cat ~/.ssh/id_rsa.pub

# Test SSH connection
ssh -T git@github.com
```

#### GPG Setup
1. Generate GPG key: `gpg --full-generate-key`
2. List keys: `gpg --list-secret-keys --keyid-format LONG`
3. Export public key: `gpg --armor --export YOUR_KEY_ID`
4. Add to GitHub: Settings → SSH and GPG keys
5. Set Git signing key: `git config --global user.signingkey YOUR_KEY_ID`

### Font Installation

```bash
# Install Mononoki Nerd Font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Mononoki/Regular/MononokiNerdFont-Regular.ttf
fc-cache -f -v
fc-list | grep "Mononoki Nerd"  # Verify installation
```

### Cleanup Unwanted Packages

```bash
# Remove LibreOffice
sudo apt remove --purge libreoffice-core
sudo apt clean && sudo apt autoremove

# Remove desktop entries
sudo rm /usr/share/applications/libreoffice-*.desktop
rm ~/.local/share/applications/libreoffice-*.desktop
sudo update-desktop-database
```

## Repository Structure

```
InstallOS/
├── README.md                    # This file
├── PACKAGES.md                  # Complete software inventory
├── INSTALL_SCRIPTS.md           # Automated installation scripts
├── CONFIG_SYMLINKS.md           # Dotfile management guide
├── .zshrc                       # ZSH configuration
├── .bashrc                      # Bash configuration  
├── .config/
│   ├── ghostty/config           # Terminal configuration
│   ├── neofetch/config.conf     # System info configuration
│   ├── nvim/                    # Neovim/LazyVim configuration
│   └── gnome-shell-extensions/  # GNOME shortcuts reference
├── scripts/                     # Installation automation scripts
└── docs/                        # Additional documentation
```

## Contributing

This is a personal dotfiles repository, but feel free to:
- Use as inspiration for your own setup
- Suggest improvements via issues
- Fork and adapt for your needs

## License

Personal configuration files - use as you see fit.

---

*Last updated: 2025-01-12*
