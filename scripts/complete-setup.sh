#!/bin/bash
# complete-setup.sh - Master setup script that runs all modular scripts

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${BLUE}=== Complete System Setup ===${NC}"
echo -e "${YELLOW}This will set up your entire system with all configurations.${NC}"
echo -e "${YELLOW}Make sure you have reviewed all scripts before running!${NC}"
echo ""
read -p "Continue? (y/n) " -n 1 -r
echo ""
if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
    echo "Setup cancelled."
    exit 1
fi

# Function to run a script with error handling
run_script() {
    local script_name="$1"
    echo ""
    echo -e "${BLUE}Running $script_name...${NC}"
    if "$SCRIPT_DIR/$script_name"; then
        echo -e "${GREEN}✓ $script_name completed successfully${NC}"
    else
        echo -e "${RED}✗ $script_name failed!${NC}"
        echo "Fix the issue and run this script again."
        exit 1
    fi
}

# Run setup scripts in order
run_script "setup-base-system.sh"
run_script "setup-development-env.sh"
run_script "setup-themes.sh"
run_script "apply-shortcuts.sh"

# Set up configuration symlinks
echo ""
echo -e "${BLUE}Setting up configuration symlinks...${NC}"
"$SCRIPT_DIR/../setup-symlinks.sh" || echo -e "${YELLOW}Note: Run setup-symlinks.sh manually if needed${NC}"

# Run verification
echo ""
run_script "verify-installation.sh"

echo ""
echo -e "${GREEN}=== Setup Complete! ===${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Log out and back in for all changes to take effect"
echo "2. Run additional manual installations as needed:"
echo "   - Install Snap packages: code, gitkraken, etc."
echo "   - Install Flatpak applications"
echo "   - Download and install AppImages"
echo "   - Install GNOME extensions"
echo "3. Set up SSH keys and GPG keys"
echo "4. Configure any additional applications"
echo ""
echo -e "${GREEN}Enjoy your configured system!${NC}"