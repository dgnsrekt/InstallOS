#!/bin/bash
# setup-development-env-secure.sh - Secure version with checksum verification

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Source the secure download functions
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$SCRIPT_DIR/secure-download.sh"

echo -e "${GREEN}=== Setting up Development Environment (Secure) ===${NC}"

# Development libraries
echo -e "${YELLOW}Installing development libraries...${NC}"
sudo apt install -y \
    libcurl4-openssl-dev libcairo2-dev librsvg2-dev \
    libarchive-dev libboost-all-dev libc6-dev \
    libglib2.0-dev libxpm-dev libfuse-dev \
    portaudio19-dev libflac-dev libflac12t64 \
    patchelf sassc pkg-config libssl-dev

# Python development
echo -e "${YELLOW}Setting up Python environment...${NC}"
sudo apt install -y \
    python3-pip python3-venv python-is-python3 pipx
python3 -m pipx ensurepath

# Install Python tools via pipx
echo -e "${YELLOW}Installing Python tools...${NC}"
pipx install uv || echo "uv already installed"

# Rust installation (SECURE VERSION)
if ! command -v rustc &> /dev/null; then
    echo -e "${YELLOW}Installing Rust securely...${NC}"
    
    # Create temporary directory
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    
    # Download rustup-init directly (not the shell script)
    RUSTUP_URL="https://static.rust-lang.org/rustup/stable/x86_64-unknown-linux-gnu/rustup-init"
    
    # NOTE: You should verify this SHA256 from https://forge.rust-lang.org/infra/channel-layout.html
    # This is just an example - CHECK THE CURRENT HASH!
    echo -e "${YELLOW}Downloading rustup-init binary...${NC}"
    curl -fsSL "$RUSTUP_URL" -o rustup-init
    
    # Get the SHA256 from the official source
    curl -fsSL "$RUSTUP_URL.sha256" -o rustup-init.sha256
    EXPECTED_SHA=$(cat rustup-init.sha256 | cut -d' ' -f1)
    
    # Verify
    echo -e "${YELLOW}Verifying rustup-init checksum...${NC}"
    echo "$EXPECTED_SHA  rustup-init" | sha256sum -c || {
        echo -e "${RED}Rustup verification failed!${NC}"
        cd /
        rm -rf "$TEMP_DIR"
        exit 1
    }
    
    echo -e "${GREEN}✓ Rustup verified${NC}"
    chmod +x rustup-init
    
    # Install Rust
    ./rustup-init -y --no-modify-path
    
    # Clean up
    cd /
    rm -rf "$TEMP_DIR"
    
    # Source cargo env
    source "$HOME/.cargo/env"
else
    echo -e "${GREEN}Rust already installed${NC}"
fi

# Install cargo-binstall
if ! command -v cargo-binstall &> /dev/null; then
    echo -e "${YELLOW}Installing cargo-binstall...${NC}"
    cargo install cargo-binstall
else
    echo -e "${GREEN}cargo-binstall already installed${NC}"
fi

# Install Rust tools
echo -e "${YELLOW}Installing Rust CLI tools...${NC}"
cargo-binstall -y zellij watchexec-cli ast-grep

# Node.js via NVM (SECURE VERSION)
if [ ! -d "$HOME/.nvm" ]; then
    echo -e "${YELLOW}Installing NVM securely...${NC}"
    
    NVM_VERSION="v0.39.3"
    NVM_SCRIPT_URL="https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh"
    
    # Download and review the script first
    TEMP_NVM=$(mktemp)
    curl -fsSL "$NVM_SCRIPT_URL" -o "$TEMP_NVM"
    
    echo -e "${YELLOW}NVM install script downloaded. Review it:${NC}"
    echo -e "${YELLOW}First 30 lines:${NC}"
    head -n 30 "$TEMP_NVM"
    echo -e "${YELLOW}...${NC}"
    
    read -p "Install NVM? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        bash "$TEMP_NVM"
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        nvm install 22
        nvm use 22
    fi
    rm -f "$TEMP_NVM"
else
    echo -e "${GREEN}NVM already installed${NC}"
fi

# Install global NPM packages
echo -e "${YELLOW}Installing NPM global packages...${NC}"
npm install -g @google/gemini-cli ccusage tree-sitter-cli

# Modern CLI tools
echo -e "${YELLOW}Installing modern CLI tools...${NC}"
sudo apt install -y fzf ripgrep fdclone yamllint lua5.4 luarocks

# Docker (using official apt repository, not curl|sh)
if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}Installing Docker via official apt repository...${NC}"
    
    # Install prerequisites
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg
    
    # Add Docker's official GPG key
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    
    # Add the repository
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    # Install Docker
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    
    # Add user to docker group
    sudo usermod -aG docker "$USER"
    echo -e "${YELLOW}NOTE: You'll need to log out and back in for docker group changes${NC}"
else
    echo -e "${GREEN}Docker already installed${NC}"
fi

# Qt development (optional)
echo -e "${YELLOW}Installing Qt development tools...${NC}"
sudo apt install -y qtbase5-dev qtdeclarative5-dev qttools5-dev-tools

echo -e "${GREEN}✓ Development environment setup complete (secure version)!${NC}"
echo -e "${BLUE}Note: This secure version downloads and verifies software before installation.${NC}"