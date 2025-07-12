# Complete Keyboard Shortcuts Documentation

This document contains all keyboard shortcuts configured on the system, highlighting modifications from defaults.

## System-Wide Modifications

### Important Global Changes
- **Caps Lock → Escape**: Caps Lock key is remapped to function as Escape
  - Setting: `['caps:escape']` in `org.gnome.desktop.input-sources xkb-options`
  - Great for Vim users and quick escaping

### Modified Window/Workspace Navigation
- **Super + Up**: Switch to previous workspace (modified from default)
- **Super + Down**: Switch to next workspace (modified from default)
- **Super + Left/Right**: Kept for workspace switching (alternative binding)
- **Ctrl + Shift + Super + Up**: Maximize window
- **Ctrl + Shift + Super + Down**: Unmaximize window

### Application Launching
- **Super + T**: Open terminal (Ghostty)
- **Super + B**: Open web browser (Chrome)
- **Super + V**: Toggle message tray/notifications (also Super + M)

## Window Management

### Basic Window Controls
- **Alt + F4**: Close window
- **Alt + F10**: Toggle maximized
- **Alt + F5**: Unmaximize
- **Alt + F7**: Begin move
- **Alt + F8**: Begin resize
- **Alt + Space**: Window menu
- **F11**: Fullscreen toggle

### Window Switching
- **Alt + Tab** / **Super + Tab**: Switch applications
- **Alt + Shift + Tab** / **Super + Shift + Tab**: Switch applications backward
- **Alt + Escape**: Cycle windows
- **Alt + Shift + Escape**: Cycle windows backward
- **Alt + Above_Tab** / **Super + Above_Tab**: Switch within application group

### Window Tiling (Ubuntu Tiling Assistant)
- **Super + Left/Right**: Tile window to left/right half
- **Ctrl + Shift + Super + Left**: Toggle tiled left
- **Ctrl + Shift + Super + Right**: Toggle tiled right

### WinTile Extension (if enabled)
- **Ctrl + Super + Arrow**: Grow tile in direction
- **Ctrl + drag**: Drop tile in specific spot
- **Ctrl + Super + drag**: Draw grid for new tile

### Monitor Management
- **Super + P**: Switch monitor configuration
- **Super + Shift + Arrow**: Move window to monitor in direction

## Workspace Management

### Navigation
- **Super + Up**: Previous workspace (customized)
- **Super + Down**: Next workspace (customized)
- **Super + Page Up**: Previous workspace (alternative)
- **Super + Page Down**: Next workspace (alternative)
- **Super + Home**: First workspace
- **Super + End**: Last workspace

### Moving Windows Between Workspaces
- **Ctrl + Shift + Alt + Up/Down**: Move window to workspace up/down
- **Ctrl + Shift + Alt + Left/Right**: Move window to workspace left/right
- **Super + Shift + Home**: Move to first workspace
- **Super + Shift + End**: Move to last workspace

## Application Shortcuts

### Dock/Launcher (Super + Number)
- **Super + 1-9**: Switch to application 1-9 on dock
- **Super + Ctrl + 1-9**: Open new window of application 1-9

### System Functions
- **Print**: Screenshot UI
- **Shift + Print**: Full screenshot
- **Alt + Print**: Window screenshot
- **Ctrl + Shift + Alt + R**: Screen recording UI
- **Ctrl + Alt + Delete**: Logout/shutdown menu
- **Alt + F2**: Run command dialog
- **Alt + F2, then 'r'**: Restart GNOME Shell

### Accessibility
- **Alt + Super + 8**: Toggle magnifier
- **Alt + Super + =**: Magnifier zoom in
- **Alt + Super + -**: Magnifier zoom out
- **Alt + Super + S**: Toggle screen reader

### Media Keys
- **Volume Up/Down**: Adjust volume
- **Mute**: Toggle mute
- **Play/Pause**: Media control
- **Previous/Next**: Track navigation

## Terminal Shortcuts

### Ghostty Terminal
- **Shift + Enter**: Insert newline (custom binding)
- Standard terminal shortcuts apply

### Zellij (Terminal Multiplexer)
- **Ctrl + G**: Enter/exit locked mode
- **Ctrl + P**: Pane mode
- **Ctrl + Shift + V**: Paste from clipboard
- Navigation uses Vim-style keys (h,j,k,l) in pane mode

## Overview Mode
- **Super**: Enter activities overview
- **Super + Alt + Up/Down**: Navigate overview
- **Super + A**: Show all applications
- **Super + N**: Focus active notification

## Custom Application Shortcuts
- **Super + Q**: Quit current application (custom)
- **Super + H**: Minimize window
- **Super + O**: Rotate video/orientation lock

## Input Source Switching
- **Super + Space**: Switch input source
- **Super + Shift + Space**: Switch input source backward

## Shell Extensions Shortcuts
Based on the shortcuts.json reference file:
- Various extension-specific shortcuts may be active
- Check individual extension settings for additional bindings

## VS Code
- No custom keybindings.json found (using defaults)
- Keyboard dispatch set to "keyCode" mode for Vim compatibility

## Configuration Files

### To modify shortcuts:
```bash
# System shortcuts
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Super>Up']"

# Media keys
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Super>t']"

# Caps Lock to Escape
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']"
```

### Reset to defaults:
```bash
# Reset specific key
gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-up

# Reset all in schema
gsettings reset-recursively org.gnome.desktop.wm.keybindings
```

## Quick Reference Card

### Most Used Custom Shortcuts
| Action | Shortcut | Type |
|--------|----------|------|
| Escape | Caps Lock | Global |
| Terminal | Super + T | Launch |
| Browser | Super + B | Launch |
| Next Workspace | Super + Down | Navigation |
| Previous Workspace | Super + Up | Navigation |
| Notifications | Super + V | System |
| Quit App | Super + Q | Window |

### Workspace Navigation
| Action | Default | Current |
|--------|---------|---------|
| Next Workspace | Ctrl+Alt+Right | Super+Down |
| Previous Workspace | Ctrl+Alt+Left | Super+Up |
| Alternative Next | - | Super+Right |
| Alternative Previous | - | Super+Left |

---

*Note: This configuration prioritizes efficient workspace navigation and terminal/development workflows.*
*Caps Lock as Escape is particularly useful for Vim users across all applications.*