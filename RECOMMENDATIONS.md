# System Setup Recommendations

Based on comprehensive analysis of your Ubuntu 24.04 system with Pop!_OS themes, here are recommendations to optimize your setup.

## 🎯 Priority Recommendations

### 1. **Automate Your Setup Further**
```bash
# Create executable setup scripts in your scripts/ directory
cd ~/InstallOS/scripts
# Split the monolithic install scripts into smaller, testable components:
- setup-base-system.sh
- setup-development-env.sh
- setup-themes.sh
- apply-shortcuts.sh
- verify-installation.sh
```

### 2. **Add Missing Critical Configurations**

#### Git Configuration Management
```bash
# Add to CONFIG_SYMLINKS.md and create symlink:
ln -s ~/InstallOS/.gitconfig ~/.gitconfig
```
Your Git config with GPG signing should be version controlled.

#### SSH Config Template
```bash
# Create .ssh/config template
cat > ~/InstallOS/.ssh/config.template << EOF
Host *
    AddKeysToAgent yes
    IdentityFile ~/.ssh/id_rsa
    
Host github.com
    HostName github.com
    User git
EOF
```

### 3. **Optimize Your Development Workflow**

#### Add Modern CLI Tools You're Missing
```bash
# You have ripgrep and fzf, but consider:
cargo-binstall eza          # Better ls (you alias ll frequently)
cargo-binstall bat          # Better cat with syntax highlighting
cargo-binstall delta        # Better git diff
cargo-binstall tokei        # Code statistics
cargo-binstall just         # Better make
```

#### Enhance Your Zellij Setup
```bash
# Create session layouts for common workflows
mkdir -p ~/.config/zellij/layouts
# Create development.kdl, monitoring.kdl, etc.
```

### 4. **System Performance & Maintenance**

#### Storage Management
- Your Videos directory is 66GB - consider moving to external/cloud storage
- Set up automated cleanup for Downloads (8.8GB)
```bash
# Add to crontab: Clean downloads older than 30 days
0 0 * * 0 find ~/Downloads -mtime +30 -type f -delete
```

#### Backup Strategy
```bash
# Create backup script for critical configs
#!/bin/bash
# backup-configs.sh
rsync -av --delete \
  ~/.config \
  ~/.ssh \
  ~/.gnupg \
  /backup/location/
```

### 5. **Security Enhancements**

#### GPG Key Backup
```bash
# Your GPG key (13B9E6608B47E060...) needs backup
gpg --export-secret-keys -a > ~/InstallOS/private/gpg-secret-backup.asc
gpg --export -a > ~/InstallOS/gpg-public.asc
# Add private/ to .gitignore!
```

#### YubiKey Integration
You have YubiKey packages installed but no documented setup:
```bash
# Document YubiKey configuration
- SSH authentication setup
- GPG signing with YubiKey
- 2FA configurations
```

### 6. **Missing Useful Tools**

Based on your development focus:
```bash
# Container tools
sudo apt install podman podman-compose  # Docker alternative

# Database clients (you have Beekeeper but consider CLI)
cargo-binstall sqlx-cli

# API testing (complement to your Postman)
sudo apt install httpie  # Already in your list but worth highlighting

# Note-taking for development
sudo apt install obsidian  # Or logseq
```

### 7. **Keyboard Shortcuts Additions**

Add these productivity boosters:
```bash
# Custom shortcuts for frequent tasks
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'VS Code'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'code'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>c'
```

### 8. **Repository Improvements**

#### Add Pre-commit Hooks
```bash
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    hooks:
      - id: check-yaml
      - id: end-of-file-fixer
      - id: trailing-whitespace
```

#### Create Update Script
```bash
#!/bin/bash
# update-system.sh
# Pull latest configs
git pull
# Update all package managers
sudo apt update && sudo apt upgrade
flatpak update
snap refresh
cargo install-update -a
npm update -g
```

### 9. **Documentation Additions**

Create these missing docs:
- `TROUBLESHOOTING.md` - Common issues and fixes
- `PRIVACY.md` - Privacy-focused configurations
- `DEVELOPMENT_SETUP.md` - Language-specific setups

### 10. **Quick Wins**

1. **Enable Wayland for all Electron apps** (better performance):
   ```bash
   # Add to .zshrc
   export ELECTRON_OZONE_PLATFORM_HINT=wayland
   ```

2. **Fix your TODO comments** in README.md:
   - Super+L locking is in `org.gnome.settings-daemon.plugins.media-keys screensaver`
   - All TODOs are already completed (Ghostty, LazyVim, etc.)

3. **Optimize startup**:
   ```bash
   # Check what's slowing down boot
   systemd-analyze blame
   systemd-analyze critical-chain
   ```

## 🚀 Next Steps Priority Order

1. **Immediate**: Backup GPG/SSH keys, create .gitconfig symlink
2. **This Week**: Create modular setup scripts, add missing CLI tools
3. **This Month**: Implement backup strategy, document YubiKey setup
4. **Ongoing**: Keep documentation updated as you add tools

## Additional Optimizations

### Terminal Enhancements
```bash
# Add to .zshrc for better history
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
HISTSIZE=50000
SAVEHIST=50000
```

### Development Environment
```bash
# Global .gitignore
git config --global core.excludesfile ~/.gitignore_global
echo ".DS_Store" >> ~/.gitignore_global
echo "*.swp" >> ~/.gitignore_global
echo ".idea/" >> ~/.gitignore_global
echo ".vscode/" >> ~/.gitignore_global
```

### System Monitoring
```bash
# Install better system monitoring
cargo-binstall ytop         # Better than htop
sudo apt install iotop      # IO monitoring
sudo apt install nethogs    # Network monitoring per process
```

### Productivity Aliases
```bash
# Add to .zshrc
alias update-all='sudo apt update && sudo apt upgrade && flatpak update && snap refresh'
alias clean-system='sudo apt autoremove && sudo apt autoclean && docker system prune -a'
alias backup-configs='~/InstallOS/scripts/backup-configs.sh'
```

## Performance Tuning

### SSD Optimization
```bash
# Reduce swappiness for SSD
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf

# Enable TRIM for SSD
sudo systemctl enable fstrim.timer
```

### Memory Management
```bash
# Clear memory cache (when needed)
alias drop-caches='sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches'
```

## Final Recommendations

1. **Version Control Everything**: Your setup is good, but add `.gitconfig`, SSH configs (sanitized), and create private backups
2. **Automate Repetitive Tasks**: Use the `just` command runner or Makefiles
3. **Monitor Resource Usage**: Your 66GB Videos folder needs attention
4. **Security First**: Implement YubiKey for SSH/GPG, enable 2FA everywhere
5. **Keep Learning**: Your diverse toolset shows growth - continue exploring modern alternatives

Your setup is already very solid - these recommendations would take it from good to exceptional!

---

*Generated: 2025-01-12*
*System: Ubuntu 24.04.2 LTS with Pop!_OS themes*