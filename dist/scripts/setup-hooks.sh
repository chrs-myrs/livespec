#!/bin/bash
# LiveSpec Pre-Commit Hook Setup
# Installs validation hook into .git/hooks/

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}LiveSpec Pre-Commit Hook Setup${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo ""

# Change to repo root
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
if [ -z "$REPO_ROOT" ]; then
    echo -e "${RED}✗ Not in a git repository${NC}"
    exit 1
fi

cd "$REPO_ROOT"

HOOK_PATH=".git/hooks/pre-commit"

# Check if hook already exists
if [ -f "$HOOK_PATH" ]; then
    echo -e "${YELLOW}⚠ Pre-commit hook already exists${NC}"
    echo ""
    read -p "Overwrite existing hook? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Setup cancelled${NC}"
        exit 0
    fi
fi

# Create hook
cat > "$HOOK_PATH" <<'EOF'
#!/bin/bash
# LiveSpec Pre-Commit Validation Hook
# Runs comprehensive validation before allowing commits

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}LiveSpec Pre-Commit Validation${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo ""

# Change to repo root
cd "$(git rev-parse --show-toplevel)" || exit 1

# Detect validation script location (LiveSpec source uses tests/, target projects use .livespec/tests/)
if [ -f "tests/structure/test_full_validation.sh" ]; then
    VALIDATION_SCRIPT="tests/structure/test_full_validation.sh"
elif [ -f ".livespec/tests/structure/test_full_validation.sh" ]; then
    VALIDATION_SCRIPT=".livespec/tests/structure/test_full_validation.sh"
else
    echo -e "${RED}✗ Validation script not found${NC}"
    echo -e "${YELLOW}Expected: tests/structure/test_full_validation.sh or .livespec/tests/structure/test_full_validation.sh${NC}"
    exit 1
fi

# Run full validation
if bash "$VALIDATION_SCRIPT"; then
    echo ""
    echo -e "${GREEN}✓ Validation passed - proceeding with commit${NC}"
    echo ""
    exit 0
else
    echo ""
    echo -e "${RED}✗ Validation failed - commit blocked${NC}"
    echo ""
    echo -e "${YELLOW}Fix validation errors and try again, or use:${NC}"
    echo -e "  ${YELLOW}git commit --no-verify${NC}    (skip validation - use carefully)"
    echo ""
    exit 1
fi
EOF

# Make executable
chmod +x "$HOOK_PATH"

echo -e "${GREEN}✓ Pre-commit hook installed successfully${NC}"
echo ""
echo "The hook will now run automatically before every commit."
echo "It validates:"
echo "  - Spec ↔ Implementation coverage"
echo "  - Dependency graph integrity"
echo "  - Bidirectional links"
echo "  - Test coverage"
echo "  - MSL compliance"
echo ""
echo "To bypass validation when needed:"
echo "  ${YELLOW}git commit --no-verify${NC}"
echo ""
