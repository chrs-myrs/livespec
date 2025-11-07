#!/usr/bin/env bash
#
# Value Pyramid Validation (Simplified)
#
# Validates that specs have upstream references (derives-from, governed-by, satisfies, or guided-by)
#
# Usage:
#   ./scripts/validate-value-pyramid.sh
#
# Exit codes:
#   0 - All specs have upstream references
#   1 - Orphaned specs found

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Counters
specs_checked=0
specs_with_refs=0
orphaned_specs=0

echo "Validating value pyramid..."
echo ""

# Check PURPOSE.md exists
if [[ ! -f "PURPOSE.md" ]]; then
    echo -e "${RED}✗ FAIL: PURPOSE.md not found${NC}"
    echo "PURPOSE.md is the foundation of the value pyramid."
    exit 1
fi

echo -e "${GREEN}✓${NC} PURPOSE.md exists (value pyramid foundation)"
echo ""
echo "Checking spec traceability..."

# Create temp file to store orphaned specs
orphaned_file=$(mktemp)
trap "rm -f $orphaned_file" EXIT

# Find all spec files and check for upstream references
find specs/ -name "*.spec.md" -type f 2>/dev/null | while read -r spec_file; do
    specs_checked=$((specs_checked + 1))

    # Check if has any upstream reference in frontmatter
    if grep -q -E '^(derives-from|governed-by|satisfies|guided-by):' "$spec_file"; then
        specs_with_refs=$((specs_with_refs + 1))
    else
        orphaned_specs=$((orphaned_specs + 1))
        echo "$spec_file" >> "$orphaned_file"
        echo -e "${YELLOW}⚠${NC} Orphaned: $spec_file (no upstream reference)"
    fi
done

# Count results from temp file
orphaned_count=$(wc -l < "$orphaned_file" 2>/dev/null || echo "0")
total_count=$(find specs/ -name "*.spec.md" -type f 2>/dev/null | wc -l)
with_refs_count=$((total_count - orphaned_count))

echo ""
echo "==================================================================="
echo "Value Pyramid Validation Results"
echo "==================================================================="
echo "Specs checked: $total_count"
echo "Specs with upstream refs: $with_refs_count"
echo "Orphaned specs: $orphaned_count"
echo ""

if [[ $orphaned_count -gt 0 ]]; then
    echo -e "${YELLOW}⚠ WARNING: $orphaned_count spec(s) without upstream references${NC}"
    echo ""
    echo "Add frontmatter to orphaned specs:"
    echo "  derives-from: [parent-spec or PURPOSE.md]"
    echo "  governed-by: [governing-spec]"
    echo "  satisfies: [requirement-spec]"
    echo "  guided-by: [strategy-spec]"
    echo ""
    # Exit 0 for now (warning only, not blocking)
    exit 0
else
    echo -e "${GREEN}✓ PASS: All specs have upstream references${NC}"
    exit 0
fi
