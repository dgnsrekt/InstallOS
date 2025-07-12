#!/bin/bash
# apply-shortcuts.sh - Apply custom keyboard shortcuts

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Applying Custom Keyboard Shortcuts ===${NC}"

# Caps Lock to Escape
echo -e "${YELLOW}Setting Caps Lock as Escape...${NC}"
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']"

# Window Management
echo -e "${YELLOW}Configuring window management shortcuts...${NC}"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Super>Down']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Super>Up']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>Left']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>Right']"

# Maximize/Unmaximize
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Control><Shift><Super>Up']"
gsettings set org.gnome.desktop.wm.keybindings unmaximize "['<Control><Shift><Super>Down', '<Alt>F5']"

# Application launching
echo -e "${YELLOW}Setting application launch shortcuts...${NC}"
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Super>t']"
gsettings set org.gnome.settings-daemon.plugins.media-keys www "['<Super>b']"

# Message tray
gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Super>v', '<Super>m']"

# Optional: Add custom application shortcuts
# Uncomment and modify as needed:
# gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'VS Code'
# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'code'
# gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>c'

echo -e "${GREEN}✓ Keyboard shortcuts applied!${NC}"
echo -e "${YELLOW}Note: Some shortcuts may require logging out or restarting GNOME Shell${NC}"