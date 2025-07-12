# Configuration Files and Symlink Management

This document details all configuration files in the repository and provides commands to set up symlinks for proper dotfile management.

## Current Configuration Files

### Shell Configuration
- `.zshrc` - ZSH shell configuration with Oh-My-ZSH, aliases, and path management
- `.bashrc` - Bash shell configuration (backup/compatibility)
- `.gitconfig` - Git configuration with GPG signing

### Terminal and CLI Tools
- `.config/ghostty/config` - Ghostty terminal emulator configuration
- `.config/neofetch/config.conf` - System information display configuration

### Text Editors and IDEs
- `.config/nvim/` - Complete LazyVim/Neovim configuration
  - `init.lua` - Main Neovim configuration entry point
  - `lazy-lock.json` - Plugin version lock file
  - `lazyvim.json` - LazyVim specific configuration
  - `lua/config/` - Core configuration files
  - `lua/plugins/` - Plugin configurations
  - `stylua.toml` - Lua code formatter configuration

### Desktop Environment
- `.config/gnome-shell-extensions/shortcuts/shortcuts.json` - GNOME keyboard shortcuts reference

### Legacy/Unused Configurations
- `.SpaceVim.d/init.toml` - **OUTDATED**: SpaceVim configuration (replaced by LazyVim)

## Symlink Setup Commands

### Prerequisites

```bash
# Backup existing config files (if any)
mkdir -p ~/config-backup
cp ~/.zshrc ~/config-backup/ 2>/dev/null || true
cp ~/.bashrc ~/config-backup/ 2>/dev/null || true
cp -r ~/.config/nvim ~/config-backup/ 2>/dev/null || true
cp -r ~/.config/ghostty ~/config-backup/ 2>/dev/null || true
cp -r ~/.config/neofetch ~/config-backup/ 2>/dev/null || true

# Remove existing files to prepare for symlinks
rm -f ~/.zshrc ~/.bashrc
rm -rf ~/.config/nvim ~/.config/ghostty ~/.config/neofetch
```

### Shell Configuration Symlinks

```bash
# ZSH configuration
ln -s ~/InstallOS/.zshrc ~/.zshrc

# Bash configuration (for compatibility)
ln -s ~/InstallOS/.bashrc ~/.bashrc

# Git configuration
ln -s ~/InstallOS/.gitconfig ~/.gitconfig
```

### Application Configuration Symlinks

```bash
# Ghostty terminal
mkdir -p ~/.config/ghostty
ln -s ~/InstallOS/.config/ghostty/config ~/.config/ghostty/config

# Neofetch system info
mkdir -p ~/.config/neofetch
ln -s ~/InstallOS/.config/neofetch/config.conf ~/.config/neofetch/config.conf

# Neovim/LazyVim
ln -s ~/InstallOS/.config/nvim ~/.config/nvim

# GNOME Extensions shortcuts (optional reference)
mkdir -p ~/.config/gnome-shell-extensions/shortcuts
ln -s ~/InstallOS/.config/gnome-shell-extensions/shortcuts/shortcuts.json ~/.config/gnome-shell-extensions/shortcuts/shortcuts.json
```

## Complete Symlink Setup Script

```bash
#!/bin/bash
# setup-symlinks.sh

set -e  # Exit on any error

REPO_DIR="$HOME/InstallOS"
BACKUP_DIR="$HOME/config-backup-$(date +%Y%m%d-%H%M%S)"

echo "Setting up configuration symlinks..."
echo "Repository directory: $REPO_DIR"
echo "Backup directory: $BACKUP_DIR"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Function to backup and symlink
backup_and_link() {
    local source="$1"
    local target="$2"
    local target_dir=$(dirname "$target")
    
    # Create target directory if it doesn't exist
    mkdir -p "$target_dir"
    
    # Backup existing file/directory
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo "Backing up existing $target"
        mv "$target" "$BACKUP_DIR/"
    fi
    
    # Create symlink
    echo "Creating symlink: $target -> $source"
    ln -s "$source" "$target"
}

# Shell configurations
backup_and_link "$REPO_DIR/.zshrc" "$HOME/.zshrc"
backup_and_link "$REPO_DIR/.bashrc" "$HOME/.bashrc"
backup_and_link "$REPO_DIR/.gitconfig" "$HOME/.gitconfig"

# Application configurations
backup_and_link "$REPO_DIR/.config/ghostty/config" "$HOME/.config/ghostty/config"
backup_and_link "$REPO_DIR/.config/neofetch/config.conf" "$HOME/.config/neofetch/config.conf"
backup_and_link "$REPO_DIR/.config/nvim" "$HOME/.config/nvim"
backup_and_link "$REPO_DIR/.config/gnome-shell-extensions/shortcuts/shortcuts.json" "$HOME/.config/gnome-shell-extensions/shortcuts/shortcuts.json"

echo ""
echo "Symlink setup complete!"
echo "Backup files stored in: $BACKUP_DIR"
echo ""
echo "Next steps:"
echo "1. Restart your terminal or run: exec zsh"
echo "2. Verify configurations are working properly"
echo "3. Remove backup directory if everything works: rm -rf $BACKUP_DIR"
```

## Verification Commands

### Check Symlink Status

```bash
#!/bin/bash
# check-symlinks.sh

echo "Checking symlink status..."

configs=(
    "$HOME/.zshrc"
    "$HOME/.bashrc"
    "$HOME/.gitconfig"
    "$HOME/.config/ghostty/config"
    "$HOME/.config/neofetch/config.conf"
    "$HOME/.config/nvim"
    "$HOME/.config/gnome-shell-extensions/shortcuts/shortcuts.json"
)

for config in "${configs[@]}"; do
    if [ -L "$config" ]; then
        target=$(readlink "$config")
        if [ -e "$target" ]; then
            echo "✓ $config -> $target (valid)"
        else
            echo "✗ $config -> $target (broken link)"
        fi
    elif [ -e "$config" ]; then
        echo "! $config (exists but not a symlink)"
    else
        echo "✗ $config (missing)"
    fi
done
```

## Configuration File Details

### .zshrc Configuration Features

- **Path Management**: Custom `update_path()` function for clean PATH handling
- **Package Manager Integration**: NVM, SDKMAN, Bun, PNPM support
- **Oh-My-ZSH**: Framework with git, uv, ssh, starship plugins
- **Aliases**: 
  - Editor shortcuts (`vim -> nvim`, config aliases)
  - Modern CLI replacements (`tmux -> zellij`)
  - Custom functions (`play_movie()`, `checkpath()`)
- **Environment Variables**: GPG, visual editor, PATH extensions
- **Startup**: Auto-clear and neofetch display with lolcat

### .bashrc Configuration Features

- **Standard bash setup**: History, completion, colors
- **PATH management**: User bin directories
- **GPG integration**: TTY setup for signing
- **Tool integration**: NVM, Starship, Cargo
- **Compatibility**: Works as fallback for bash users

### Neovim Configuration (LazyVim)

- **Base**: LazyVim distribution for modern Neovim
- **Plugins**: Formatting, LSP configuration, Mason package pinning
- **Language Support**: Python, Lua, TypeScript, etc.
- **Customizations**: See individual plugin files in `lua/plugins/`

### Ghostty Terminal Configuration

- **Minimal setup**: Currently using template with basic newline keybind
- **Customization potential**: Font, colors, keybinds can be added

### Neofetch Configuration

- **Comprehensive system info**: OS, hardware, packages, etc.
- **Custom additions**: Python version display
- **Visual customization**: Colors, layout, progress bars

## Maintenance

### Updating Configurations

```bash
# After making changes to configs in the repo
cd ~/InstallOS
git add .
git commit -m "Update configuration files"
git push

# Changes will be immediately available since files are symlinked
```

### Adding New Configuration Files

1. Add the new config file to the repository
2. Update this document with symlink commands
3. Update the setup script
4. Test the symlink setup

### Removing Outdated Configurations

```bash
# Remove SpaceVim configuration (example)
rm -rf ~/InstallOS/.SpaceVim.d/
rm -f ~/.SpaceVim.d/init.toml  # Remove symlink if it exists
```

## Troubleshooting

### Common Issues

1. **Permission Denied**: Ensure the repository files have correct permissions
   ```bash
   chmod 644 ~/InstallOS/.zshrc ~/InstallOS/.bashrc
   chmod -R 644 ~/InstallOS/.config/
   ```

2. **Broken Symlinks**: Usually caused by moving the repository
   ```bash
   # Re-run the symlink setup script
   ./setup-symlinks.sh
   ```

3. **Configuration Not Loading**: Check file syntax and restart shell
   ```bash
   # Test shell configuration
   zsh -n ~/.zshrc  # Check for syntax errors
   exec zsh         # Restart shell
   ```

### Rollback to Backup

```bash
# If something goes wrong, restore from backup
rm ~/.zshrc ~/.bashrc ~/.config/nvim ~/.config/ghostty ~/.config/neofetch
cp -r ~/config-backup/* ~/
```

---

*Remember to test symlink setup on a backup or virtual machine first.*
*Always backup existing configurations before setting up symlinks.*