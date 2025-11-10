#!/usr/bin/env bash
#
# Workspace Scope Audit
#
# Audits workspace/ directory to ensure all files are portable methodology (not product-specific).
# Applies portability test: "Could I use this in ANY project?"
#
# Usage:
#   ./scripts/audit-workspace-scope.sh
#
# Exit codes:
#   0 - All workspace files pass portability test
#   1 - Product-specific content found in workspace/

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Product-specific indicators (case-insensitive)
FAIL_PATTERNS=(
    "TMP projects"
    "TMP-specific"
    "organization-specific"
    "Lambda function"
    "Lambda-specific"
    "React component"
    "React-specific"
    "authentication feature"
    "payment processing"
    "user registration"
)

# Portable methodology indicators
PASS_PATTERNS=(
    "spec-first"
    "TDD"
    "MSL format"
    "validation"
    "development principle"
    "naming convention"
    "file pattern"
)

# Counters
files_checked=0
files_passed=0
files_flagged=0

echo "Auditing workspace/ scope..."
echo ""

# Check if workspace directory exists
if [[ ! -d "specs/workspace" ]]; then
    echo -e "${YELLOW}⚠${NC} No specs/workspace/ directory found"
    echo "Nothing to audit."
    exit 0
fi

# Create temp file to store flagged files
flagged_file=$(mktemp)
trap "rm -f $flagged_file" EXIT

echo "Applying portability test: \"Could I use this in ANY project?\""
echo ""

# Check each file in workspace/
find specs/workspace/ -name "*.spec.md" -type f | while read -r spec_file; do
    files_checked=$((files_checked + 1))
    violations_found=0

    echo "Checking: $spec_file"

    # Read file content (skip frontmatter)
    content=$(sed '/^---$/,/^---$/d' "$spec_file")

    # Check for product-specific indicators
    for pattern in "${FAIL_PATTERNS[@]}"; do
        if echo "$content" | grep -qi "$pattern"; then
            violations_found=1
            echo -e "  ${RED}✗${NC} Found product-specific indicator: \"$pattern\""
            echo "$spec_file|$pattern" >> "$flagged_file"
        fi
    done

    if [[ $violations_found -eq 0 ]]; then
        echo -e "  ${GREEN}✓${NC} Passes portability test"
        files_passed=$((files_passed + 1))
    else
        files_flagged=$((files_flagged + 1))
    fi

    echo ""
done

# Count results
total_count=$(find specs/workspace/ -name "*.spec.md" -type f 2>/dev/null | wc -l)
flagged_count=$(cut -d'|' -f1 "$flagged_file" 2>/dev/null | sort -u | wc -l)
passed_count=$((total_count - flagged_count))

echo "==================================================================="
echo "Workspace Scope Audit Results"
echo "==================================================================="
echo "Files checked: $total_count"
echo "Files passed: $passed_count"
echo "Files flagged: $flagged_count"
echo ""

if [[ $flagged_count -gt 0 ]]; then
    echo -e "${YELLOW}⚠ WARNING: $flagged_count file(s) contain product-specific content${NC}"
    echo ""
    echo "Flagged files and violations:"

    # Group by file
    cut -d'|' -f1 "$flagged_file" | sort -u | while read -r file; do
        echo ""
        echo "  $file"
        grep "^$file|" "$flagged_file" | cut -d'|' -f2 | while read -r pattern; do
            echo "    - Contains: \"$pattern\""
        done
    done

    echo ""
    echo "Remediation:"
    echo "  1. Review flagged files for product-specific content"
    echo "  2. Apply portability test: \"Could I use this in ANY project?\""
    echo "  3. Move product-specific content to:"
    echo "     - specs/1-requirements/functional/ (feature requirements)"
    echo "     - specs/2-strategy/ (architecture decisions)"
    echo "     - specs/3-behaviors/ (product behaviors)"
    echo "  4. Keep only portable methodology in workspace/"
    echo ""
    echo "Example:"
    echo "  ✗ TMP project taxonomy → specs/2-strategy/project-classification.spec.md"
    echo "  ✗ Lambda patterns → specs/2-strategy/lambda-architecture.spec.md"
    echo "  ✓ Spec-first principle → specs/workspace/constitution.spec.md"
    echo ""
    # Exit with warning (0 for now, consider 1 if you want blocking)
    exit 1
else
    echo -e "${GREEN}✓ PASS: All workspace files are portable methodology${NC}"
    echo ""
    echo "Workspace boundary is clean."
    exit 0
fi
