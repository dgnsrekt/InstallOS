#!/bin/bash
# secure-download.sh - Secure download helper with checksum verification

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to securely download and verify a file
secure_download() {
    local url="$1"
    local expected_sha256="$2"
    local output_file="${3:-$(basename "$url")}"
    
    echo -e "${YELLOW}Downloading: $url${NC}"
    
    # Download the file
    if ! curl -fsSL "$url" -o "$output_file"; then
        echo -e "${RED}Failed to download $url${NC}"
        return 1
    fi
    
    # Verify checksum if provided
    if [ -n "$expected_sha256" ]; then
        echo -e "${YELLOW}Verifying checksum...${NC}"
        local actual_sha256=$(sha256sum "$output_file" | cut -d' ' -f1)
        
        if [ "$actual_sha256" != "$expected_sha256" ]; then
            echo -e "${RED}Checksum verification failed!${NC}"
            echo -e "${RED}Expected: $expected_sha256${NC}"
            echo -e "${RED}Actual:   $actual_sha256${NC}"
            rm -f "$output_file"
            return 1
        fi
        echo -e "${GREEN}✓ Checksum verified${NC}"
    else
        echo -e "${YELLOW}⚠ WARNING: No checksum provided for verification${NC}"
    fi
    
    echo -e "${GREEN}✓ Downloaded: $output_file${NC}"
    return 0
}

# Function to download and execute a script securely
secure_execute() {
    local url="$1"
    local expected_sha256="$2"
    local script_args="${3:-}"
    local temp_script=$(mktemp)
    
    if secure_download "$url" "$expected_sha256" "$temp_script"; then
        # Make it executable
        chmod +x "$temp_script"
        
        # Show the script for review (first 50 lines)
        echo -e "${YELLOW}Script preview (first 50 lines):${NC}"
        head -n 50 "$temp_script"
        echo -e "${YELLOW}...${NC}"
        
        # Ask for confirmation
        read -p "Execute this script? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            # Execute the script
            bash "$temp_script" $script_args
            local exit_code=$?
            rm -f "$temp_script"
            return $exit_code
        else
            echo -e "${RED}Script execution cancelled${NC}"
            rm -f "$temp_script"
            return 1
        fi
    else
        return 1
    fi
}

# Export functions for use in other scripts
export -f secure_download
export -f secure_execute

# If called directly with arguments, execute secure_download
if [ $# -ge 2 ]; then
    secure_download "$@"
fi