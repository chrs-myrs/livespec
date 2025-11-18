#!/usr/bin/env bash
#
# find-satisfying-specs.sh
#
# Find all implementation specs that satisfy a given requirement
#
# Usage: ./find-satisfying-specs.sh <requirement-spec-path>
#
# Example:
#   ./find-satisfying-specs.sh specs/requirements/functional/loan-accuracy.spec.md

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check arguments
if [ $# -eq 0 ]; then
    echo -e "${RED}Error: No requirement spec provided${NC}"
    echo "Usage: $0 <requirement-spec-path>"
    echo ""
    echo "Example:"
    echo "  $0 specs/requirements/functional/loan-accuracy.spec.md"
    exit 1
fi

REQUIREMENT_SPEC="$1"
REQUIREMENT_BASENAME=$(basename "$REQUIREMENT_SPEC")

# Check if file exists
if [ ! -f "$REQUIREMENT_SPEC" ]; then
    echo -e "${RED}Error: File not found: $REQUIREMENT_SPEC${NC}"
    exit 1
fi

# Check if it's a requirement spec
if [[ ! "$REQUIREMENT_SPEC" =~ specs/requirements/ ]]; then
    echo -e "${YELLOW}Warning: File is not in specs/requirements/ directory${NC}"
    echo "This script is designed for requirement specs"
    echo ""
fi

echo -e "${BLUE}=== Implementations Satisfying: $REQUIREMENT_BASENAME ===${NC}"
echo ""

# Find all specs that reference this requirement in satisfies: field
# Need to handle both basename and relative path references
REQUIREMENT_RELPATH="${REQUIREMENT_SPEC#specs/}"  # Remove specs/ prefix if present
FOUND=0

# Search in behaviors/
if [ -d "specs/behaviors" ]; then
    while IFS= read -r spec; do
        # Check if this spec contains the requirement in its satisfies field
        # Extract satisfies block and search for basename or relative path
        SATISFIES_BLOCK=$(awk '/^satisfies:/,/^[a-z_-]+:/ {print}' "$spec" 2>/dev/null | grep "^  -")
        if echo "$SATISFIES_BLOCK" | grep -qE "(${REQUIREMENT_BASENAME}|${REQUIREMENT_RELPATH})"; then
            FOUND=$((FOUND + 1))
            echo -e "${GREEN}✓${NC} $spec"

            # Extract the satisfies block to show what else it satisfies
            echo -e "  ${BLUE}Also satisfies:${NC}"
            echo "$SATISFIES_BLOCK" | grep -vE "(${REQUIREMENT_BASENAME}|${REQUIREMENT_RELPATH})" | sed 's/^/    /' || echo "    (only this requirement)"
            echo ""
        fi
    done < <(find specs/behaviors -name "*.spec.md" 2>/dev/null)
fi

# Search in contracts/
if [ -d "specs/contracts" ]; then
    while IFS= read -r spec; do
        SATISFIES_BLOCK=$(awk '/^satisfies:/,/^[a-z_-]+:/ {print}' "$spec" 2>/dev/null | grep "^  -")
        if echo "$SATISFIES_BLOCK" | grep -qE "(${REQUIREMENT_BASENAME}|${REQUIREMENT_RELPATH})"; then
            FOUND=$((FOUND + 1))
            echo -e "${GREEN}✓${NC} $spec"

            echo -e "  ${BLUE}Also satisfies:${NC}"
            echo "$SATISFIES_BLOCK" | grep -vE "(${REQUIREMENT_BASENAME}|${REQUIREMENT_RELPATH})" | sed 's/^/    /' || echo "    (only this requirement)"
            echo ""
        fi
    done < <(find specs/contracts -name "*.spec.md" -o -name "*.yaml" 2>/dev/null)
fi

echo -e "${BLUE}=== Summary ===${NC}"
if [ $FOUND -eq 0 ]; then
    echo -e "${RED}⚠️  No implementations found satisfying this requirement${NC}"
    echo ""
    echo "This requirement may be:"
    echo "  - Not yet implemented"
    echo "  - Implemented but missing frontmatter"
    echo "  - A strategic requirement satisfied indirectly"
    exit 1
else
    echo -e "${GREEN}✓ Found $FOUND implementation(s) satisfying this requirement${NC}"
fi
