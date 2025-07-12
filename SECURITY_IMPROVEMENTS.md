# Security Improvements Guide

## Overview
This document explains the security improvements made to the InstallOS setup scripts and how to maintain secure practices.

## Key Security Changes

### 1. Eliminated Curl Piping to Shell

**Old (Insecure) Method:**
```bash
curl https://example.com/install.sh | bash  # NEVER DO THIS!
```

**New (Secure) Method:**
```bash
# Download first
curl -fsSL https://example.com/install.sh -o install.sh
# Verify checksum
echo "EXPECTED_SHA256  install.sh" | sha256sum -c
# Review the script
less install.sh
# Then execute
bash install.sh
```

### 2. Created Secure Download Helper

The `secure-download.sh` script provides:
- Checksum verification
- Download error handling
- User confirmation before execution
- Script preview functionality

Usage:
```bash
# Download with checksum verification
./secure-download.sh "https://example.com/file" "sha256_hash" "output_file"

# Execute a script securely
source secure-download.sh
secure_execute "https://example.com/script.sh" "sha256_hash"
```

## How to Get Checksums for Common Tools

### Rust
```bash
# Get the latest checksums from official source
curl -sSL https://forge.rust-lang.org/infra/channel-layout.html

# Or for specific version
curl -sSL https://static.rust-lang.org/version
```

### Node.js / NVM
```bash
# NVM doesn't provide checksums, but you can:
# 1. Download from multiple sources and compare
# 2. Check the GPG signature (if available)
# 3. Review the script manually
```

### Docker
Docker is installed via apt repository (not curl|sh), which uses GPG signing for verification.

## Best Practices for Adding New Tools

### 1. Always Get Official Checksums
```bash
# Example: Getting checksum for a tool
wget https://github.com/user/tool/releases/download/v1.0/tool-linux-amd64
wget https://github.com/user/tool/releases/download/v1.0/checksums.txt
grep "tool-linux-amd64" checksums.txt
```

### 2. Verify GPG Signatures When Available
```bash
# Import the author's public key
gpg --keyserver keyserver.ubuntu.com --recv-keys KEY_ID

# Verify signature
gpg --verify file.sig file
```

### 3. Use Package Managers When Possible
Priority order for installation methods:
1. Official apt/dnf/pacman repositories
2. Official snap/flatpak with verified publishers
3. cargo install / pip install (from official registries)
4. Direct binary download with checksum verification
5. Build from source (after verifying git tags/signatures)

### 4. Script Security Checklist

Before running any script:
- [ ] Download to a file first
- [ ] Verify checksum or signature
- [ ] Review the entire script
- [ ] Run with minimal privileges
- [ ] Use a VM or container for untrusted scripts

## Common Checksum Commands

### SHA256 (Most Common)
```bash
# Verify a file
echo "expected_hash  filename" | sha256sum -c

# Generate checksum
sha256sum filename
```

### SHA512
```bash
sha512sum filename
echo "expected_hash  filename" | sha512sum -c
```

### MD5 (Deprecated, but still used)
```bash
md5sum filename
echo "expected_hash  filename" | md5sum -c
```

## Automated Security Checks

Add to your CI/CD or pre-commit hooks:
```bash
# Check for curl pipes
grep -r "curl.*|.*\(bash\|sh\)" scripts/

# Check for wget pipes
grep -r "wget.*|.*\(bash\|sh\)" scripts/

# Run shellcheck
shellcheck scripts/*.sh
```

## Emergency Response

If you suspect a compromised download:
1. Disconnect from network
2. Check system logs: `sudo journalctl -b`
3. Check for unauthorized SSH keys: `cat ~/.ssh/authorized_keys`
4. Check for new users: `cat /etc/passwd`
5. Check for suspicious processes: `ps aux | less`
6. Check network connections: `ss -tlnp`

## Future Improvements

1. **Implement Signed Commits**: Require GPG signatures for all commits
2. **Add SBOM (Software Bill of Materials)**: Track all dependencies
3. **Use Reproducible Builds**: Ensure builds can be verified
4. **Implement Security Scanning**: Use tools like Trivy, Grype
5. **Add Integrity Monitoring**: Use AIDE or Tripwire

---

Remember: **Never trust, always verify!**