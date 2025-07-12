#!/bin/bash
# security-check.sh - Check for common security issues in scripts

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Security Check for InstallOS Scripts ===${NC}"
echo ""

ISSUES_FOUND=0

# Check for curl/wget piping to shell
echo -e "${YELLOW}Checking for curl/wget pipes to shell...${NC}"
if grep -r "curl.*|.*\(bash\|sh\)" scripts/ 2>/dev/null | grep -v "security-check.sh" | grep -v "^[[:space:]]*#"; then
    echo -e "${RED}✗ Found curl piping to shell!${NC}"
    ((ISSUES_FOUND++))
else
    echo -e "${GREEN}✓ No curl pipes found${NC}"
fi

if grep -r "wget.*|.*\(bash\|sh\)" scripts/ 2>/dev/null | grep -v "^[[:space:]]*#"; then
    echo -e "${RED}✗ Found wget piping to shell!${NC}"
    ((ISSUES_FOUND++))
else
    echo -e "${GREEN}✓ No wget pipes found${NC}"
fi

# Check for unquoted variables
echo -e "\n${YELLOW}Checking for unquoted variables...${NC}"
UNQUOTED=$(grep -r '\$[A-Za-z_][A-Za-z0-9_]*' scripts/ 2>/dev/null | \
    grep -v '\$(' | \
    grep -v '".*\$.*"' | \
    grep -v "'" | \
    grep -v "^[[:space:]]*#" | \
    grep -v "security-check.sh" || true)

if [ -n "$UNQUOTED" ]; then
    echo -e "${YELLOW}⚠ Potential unquoted variables found:${NC}"
    echo "$UNQUOTED" | head -5
    echo "..."
    echo -e "${YELLOW}Run shellcheck for detailed analysis${NC}"
else
    echo -e "${GREEN}✓ No obvious unquoted variables${NC}"
fi

# Check for eval usage
echo -e "\n${YELLOW}Checking for eval usage...${NC}"
if grep -r "eval" scripts/ 2>/dev/null | grep -v "^[[:space:]]*#" | grep -v "security-check.sh"; then
    echo -e "${RED}✗ Found eval usage - this can be dangerous!${NC}"
    ((ISSUES_FOUND++))
else
    echo -e "${GREEN}✓ No eval usage found${NC}"
fi

# Check for hardcoded passwords/secrets
echo -e "\n${YELLOW}Checking for potential secrets...${NC}"
if grep -r -i -E "(password|passwd|secret|api_key|apikey|token).*=" scripts/ 2>/dev/null | \
    grep -v "^[[:space:]]*#" | \
    grep -v "security-check.sh"; then
    echo -e "${RED}✗ Found potential hardcoded secrets!${NC}"
    ((ISSUES_FOUND++))
else
    echo -e "${GREEN}✓ No obvious secrets found${NC}"
fi

# Check for proper error handling
echo -e "\n${YELLOW}Checking for proper error handling...${NC}"
NO_ERREXIT=$(grep -L "set -e" scripts/*.sh 2>/dev/null || true)
if [ -n "$NO_ERREXIT" ]; then
    echo -e "${YELLOW}⚠ Scripts without 'set -e':${NC}"
    echo "$NO_ERREXIT"
else
    echo -e "${GREEN}✓ All scripts use 'set -e'${NC}"
fi

# Check for shellcheck if available
echo -e "\n${YELLOW}Running shellcheck (if available)...${NC}"
if command -v shellcheck &> /dev/null; then
    SHELLCHECK_ISSUES=0
    for script in scripts/*.sh; do
        if ! shellcheck -x "$script" > /dev/null 2>&1; then
            ((SHELLCHECK_ISSUES++))
        fi
    done
    
    if [ $SHELLCHECK_ISSUES -eq 0 ]; then
        echo -e "${GREEN}✓ Shellcheck found no issues${NC}"
    else
        echo -e "${YELLOW}⚠ Shellcheck found issues in $SHELLCHECK_ISSUES scripts${NC}"
        echo "Run 'shellcheck scripts/*.sh' for details"
    fi
else
    echo -e "${YELLOW}⚠ Shellcheck not installed - run: sudo apt install shellcheck${NC}"
fi

# Summary
echo -e "\n${BLUE}=== Summary ===${NC}"
if [ $ISSUES_FOUND -eq 0 ]; then
    echo -e "${GREEN}✓ No critical security issues found!${NC}"
else
    echo -e "${RED}✗ Found $ISSUES_FOUND critical security issues that need attention${NC}"
fi

echo -e "\n${BLUE}Recommendations:${NC}"
echo "1. Use secure-download.sh for all external downloads"
echo "2. Always quote variables: \"\$VAR\" not \$VAR"
echo "3. Never pipe curl/wget directly to shell"
echo "4. Use 'set -euo pipefail' in all scripts"
echo "5. Run shellcheck regularly: shellcheck scripts/*.sh"

exit $ISSUES_FOUND