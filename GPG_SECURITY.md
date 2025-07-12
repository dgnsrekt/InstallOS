# GPG Security Best Practices

## Overview
This guide covers GPG (GNU Privacy Guard) security best practices for protecting your cryptographic keys and ensuring secure communications.

## Key Security Principles

### 1. Strong Key Generation
- Use RSA 4096-bit keys (or ECC Curve25519)
- Set expiration dates (2 years recommended)
- Use strong, unique passphrases

### 2. Passphrase Protection
Your GPG key should ALWAYS have a strong passphrase:
```bash
# Check if your key requires a passphrase
echo "test" | gpg --armor --detach-sign

# Add or change passphrase
gpg --edit-key YOUR_KEY_ID passwd save
```

### 3. Secure Storage

#### Master Key Protection
- Keep master key OFFLINE when possible
- Use subkeys for daily operations
- Store on encrypted, air-gapped device

#### Backup Locations
1. **Encrypted USB Drive** - Primary backup
2. **Safety Deposit Box** - Physical security
3. **Encrypted Cloud** - With additional encryption layer
4. **Trusted Friend/Family** - Split key using Shamir's Secret Sharing

## YubiKey Integration

Since you have YubiKey packages installed, here's how to move your GPG key to hardware:

### Moving Keys to YubiKey
```bash
# Install required packages (you already have these)
sudo apt install yubikey-manager yubikey-personalization

# Configure YubiKey for GPG
gpg --edit-key YOUR_KEY_ID
> keytocard
> save

# Test YubiKey signing
gpg --card-status
echo "test" | gpg --armor --detach-sign
```

### YubiKey Benefits
- Private key never leaves the hardware
- PIN protection (3 attempts before lockout)
- Physical possession required for signing
- Immune to software keyloggers

## Daily Usage Security

### 1. GPG Agent Configuration
Your `gpg-agent.conf` should enforce:
- Short cache timeouts (10 minutes)
- Minimum passphrase requirements
- Secure pinentry program

### 2. Git Commit Signing
```bash
# Configure Git to always sign
git config --global commit.gpgsign true
git config --global user.signingkey YOUR_KEY_ID

# Sign previous commit
git commit --amend --no-edit -S
```

### 3. Verification Practices
```bash
# Always verify signatures
git log --show-signature
git verify-commit HEAD

# Verify downloaded files
gpg --verify file.sig file
```

## Emergency Procedures

### Lost Key Recovery
1. Use revocation certificate
2. Upload to keyservers
3. Notify contacts
4. Generate new key

### Compromised Key Response
```bash
# Immediate actions
gpg --import revocation-cert.asc
gpg --send-keys YOUR_KEY_ID

# Generate new key
gpg --full-generate-key
```

## Security Checklist

### Initial Setup
- [ ] Generate 4096-bit RSA key
- [ ] Set 2-year expiration
- [ ] Create strong passphrase (>20 chars)
- [ ] Generate revocation certificate
- [ ] Create secure backups
- [ ] Test restore procedure

### YubiKey Setup
- [ ] Move signing subkey to YubiKey
- [ ] Set PIN and Admin PIN
- [ ] Enable touch requirement
- [ ] Create backup YubiKey
- [ ] Test on different machine

### Ongoing Security
- [ ] Monthly: Check key expiration
- [ ] Quarterly: Rotate subkeys
- [ ] Yearly: Review trust relationships
- [ ] Always: Verify signatures before trusting

## Common Commands

### Key Management
```bash
# List keys with details
gpg --list-keys --with-subkey-fingerprint

# Export for backup
gpg --armor --export-secret-keys KEY_ID > private.asc
gpg --armor --export KEY_ID > public.asc

# Import from backup
gpg --import private.asc
gpg --import-ownertrust < trustdb.txt

# Change expiration
gpg --edit-key KEY_ID expire save
```

### Trust Management
```bash
# Edit trust level
gpg --edit-key KEY_ID trust

# Sign someone's key
gpg --sign-key THEIR_KEY_ID

# Export signed key
gpg --armor --export THEIR_KEY_ID > signed-key.asc
```

## Advanced Security

### Subkey Management
```bash
# Create signing subkey
gpg --edit-key KEY_ID
> addkey
> (choose RSA sign only)
> save

# Revoke compromised subkey
gpg --edit-key KEY_ID
> key 2  # Select subkey
> revkey
> save
```

### Air-Gapped Operations
1. Boot from Live USB (no network)
2. Generate/manage keys
3. Export to encrypted USB
4. Wipe RAM: `sudo smem -ll`

### Key Stretching
Use strong S2K (string-to-key) settings:
```
s2k-cipher-algo AES256
s2k-digest-algo SHA512
s2k-count 65011712  # Very high iteration count
```

## Troubleshooting

### Common Issues

1. **"No secret key available"**
   - Check `gpg --list-secret-keys`
   - Ensure YubiKey is inserted
   - Run `gpg --card-status`

2. **"Bad passphrase"**
   - Check keyboard layout
   - Ensure caps lock is off
   - Try in different terminal

3. **Agent not responding**
   ```bash
   gpgconf --kill gpg-agent
   gpg-connect-agent /bye
   ```

## References

- [GnuPG Documentation](https://gnupg.org/documentation/)
- [YubiKey GPG Guide](https://support.yubico.com/hc/en-us/articles/360013790259)
- [Debian GPG Best Practices](https://wiki.debian.org/GnupgBestPractices)
- [Riseup OpenPGP Best Practices](https://riseup.net/en/security/message-security/openpgp/best-practices)

---

Remember: The security of GPG depends on:
1. **Key secrecy** - Never expose private keys
2. **Passphrase strength** - Use long, unique passphrases
3. **Operational security** - Verify signatures, check fingerprints
4. **Physical security** - Protect your devices and backups