#!/bin/bash
# Check if LiveSpec is properly installed in the current project
# Exit codes: 0 = ready, 1 = not installed, 2 = incomplete installation

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

ERRORS=0
WARNINGS=0

echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}LiveSpec Installation Check${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo ""

# Check 1: .livespec directory exists
echo -n "Checking for .livespec directory... "
if [ -e ".livespec" ]; then
    if [ -L ".livespec" ]; then
        echo -e "${GREEN}✓${NC} (symlink)"
        SYMLINK_TARGET=$(readlink .livespec)
        echo "  → Points to: $SYMLINK_TARGET"
    elif [ -d ".livespec" ]; then
        echo -e "${GREEN}✓${NC} (directory)"
    else
        echo -e "${RED}✗${NC}"
        echo "  .livespec exists but is neither directory nor symlink"
        ERRORS=$((ERRORS + 1))
    fi
else
    echo -e "${RED}✗${NC}"
    echo "  .livespec not found - LiveSpec not installed"
    echo ""
    echo -e "${YELLOW}To install LiveSpec:${NC}"
    echo "  1. bash /path/to/livespec/scripts/install-livespec.sh"
    echo "  2. OR see https://github.com/chrs-myrs/livespec for installation instructions"
    exit 1
fi

# Check 2: VERSION file exists
echo -n "Checking for VERSION file... "
if [ -f ".livespec/VERSION" ]; then
    VERSION=$(cat .livespec/VERSION)
    echo -e "${GREEN}✓${NC} (v$VERSION)"
else
    echo -e "${RED}✗${NC}"
    echo "  .livespec/VERSION missing - incomplete installation"
    ERRORS=$((ERRORS + 1))
fi

# Check 3: Required directories exist
echo "Checking required directories:"

REQUIRED_DIRS=(
    "prompts/0-define"
    "prompts/1-design"
    "prompts/2-build"
    "prompts/3-verify"
    "prompts/4-evolve"
    "prompts/utils"
    "scripts"
    "templates"
    "tests/structure"
    "guides"
)

for dir in "${REQUIRED_DIRS[@]}"; do
    echo -n "  $dir... "
    if [ -d ".livespec/$dir" ]; then
        echo -e "${GREEN}✓${NC}"
    else
        echo -e "${RED}✗${NC}"
        ERRORS=$((ERRORS + 1))
    fi
done

# Check 4: Key files exist
echo "Checking key files:"

KEY_FILES=(
    "AGENTS.md"
    "README.md"
    "prompts/utils/regenerate-contexts.md"
    "scripts/setup-hooks.sh"
    "tests/structure/test_full_validation.sh"
)

for file in "${KEY_FILES[@]}"; do
    echo -n "  $file... "
    if [ -f ".livespec/$file" ]; then
        echo -e "${GREEN}✓${NC}"
    else
        echo -e "${YELLOW}⚠${NC}"
        echo "    Missing (non-critical)"
        WARNINGS=$((WARNINGS + 1))
    fi
done

# Check 5: Scripts are executable
echo "Checking script permissions:"
SCRIPT_COUNT=0
NON_EXECUTABLE=0

if [ -d ".livespec/scripts" ]; then
    while IFS= read -r script; do
        SCRIPT_COUNT=$((SCRIPT_COUNT + 1))
        if [ ! -x "$script" ]; then
            if [ $NON_EXECUTABLE -eq 0 ]; then
                echo -e "  ${YELLOW}⚠${NC} Some scripts not executable:"
            fi
            echo "    $(basename "$script")"
            NON_EXECUTABLE=$((NON_EXECUTABLE + 1))
        fi
    done < <(find .livespec/scripts -name "*.sh" -type f)

    if [ $NON_EXECUTABLE -eq 0 ]; then
        echo -e "  ${GREEN}✓${NC} All $SCRIPT_COUNT scripts executable"
    else
        echo "  Fix with: chmod +x .livespec/scripts/*.sh"
        WARNINGS=$((WARNINGS + 1))
    fi
fi

# Check 6: If symlink, verify target exists
if [ -L ".livespec" ]; then
    echo -n "Checking symlink target... "
    SYMLINK_TARGET=$(readlink .livespec)
    if [ -d "$SYMLINK_TARGET" ]; then
        echo -e "${GREEN}✓${NC}"
    else
        echo -e "${RED}✗${NC}"
        echo "  Symlink points to non-existent directory: $SYMLINK_TARGET"
        ERRORS=$((ERRORS + 1))
    fi
fi

# Check 7: Version tracking file (.livespec-version in project root)
echo -n "Checking version tracking (.livespec-version)... "
if [ -f ".livespec-version" ]; then
    PROJECT_VERSION=$(cat .livespec-version)
    echo -e "${GREEN}✓${NC} (v$PROJECT_VERSION)"

    # Compare versions if both exist
    if [ -f ".livespec/VERSION" ]; then
        if [ "$PROJECT_VERSION" != "$VERSION" ]; then
            echo -e "  ${YELLOW}⚠${NC} Version mismatch:"
            echo "    Project: v$PROJECT_VERSION"
            echo "    Framework: v$VERSION"
            echo "    Consider updating: cp .livespec/VERSION .livespec-version"
            WARNINGS=$((WARNINGS + 1))
        fi
    fi
else
    echo -e "${YELLOW}⚠${NC}"
    echo "  .livespec-version missing - version tracking not enabled"
    echo "  Create with: cp .livespec/VERSION .livespec-version"
    WARNINGS=$((WARNINGS + 1))
fi

# Summary
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo "Summary:"
echo -e "  ${RED}Errors:${NC}   $ERRORS"
echo -e "  ${YELLOW}Warnings:${NC} $WARNINGS"
echo ""

if [ $ERRORS -eq 0 ]; then
    if [ $WARNINGS -eq 0 ]; then
        echo -e "${GREEN}✓ LiveSpec installation is complete and healthy${NC}"
        exit 0
    else
        echo -e "${YELLOW}⚠ LiveSpec installation is functional but has warnings${NC}"
        echo "  Review warnings above and fix if needed"
        exit 0
    fi
else
    echo -e "${RED}✗ LiveSpec installation is incomplete or broken${NC}"
    echo "  Fix errors above or reinstall using:"
    echo "    bash /path/to/livespec/scripts/install-livespec.sh"
    exit 2
fi
