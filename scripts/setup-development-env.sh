#!/bin/bash
# setup-development-env.sh - Install development tools and languages

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Setting up Development Environment ===${NC}"

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
# Ensure pipx path is in PATH
python3 -m pipx ensurepath

# Install Python tools via pipx
echo -e "${YELLOW}Installing Python tools...${NC}"
pipx install uv || echo "uv already installed"

# Rust installation
if ! command -v rustc &> /dev/null; then
    echo -e "${YELLOW}Installing Rust...${NC}"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
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

# Node.js via NVM
if [ ! -d "$HOME/.nvm" ]; then
    echo -e "${YELLOW}Installing NVM and Node.js...${NC}"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install 22
    nvm use 22
else
    echo -e "${GREEN}NVM already installed${NC}"
fi

# Install global NPM packages
echo -e "${YELLOW}Installing NPM global packages...${NC}"
npm install -g @google/gemini-cli ccusage tree-sitter-cli

# Lua
echo -e "${YELLOW}Installing Lua...${NC}"
sudo apt install -y lua5.4 luarocks

# Modern CLI tools
echo -e "${YELLOW}Installing modern CLI tools...${NC}"
sudo apt install -y fzf ripgrep fdclone yamllint

# Docker
if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}Installing Docker...${NC}"
    # Add Docker's official GPG key
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

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

echo -e "${GREEN}✓ Development environment setup complete!${NC}"