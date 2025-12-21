#!/usr/bin/env bash
#
# Workspace Scope Audit
#
# Audits workspace/ directory to ensure all files are operating context (not deliverables).
# Applies "about vs in" test: "Is this ABOUT the workspace or IN the workspace?"
#
# Usage:
#   ./scripts/audit-workspace-scope.sh
#
# Exit codes:
#   0 - All workspace files pass "about vs in" test
#   1 - Deliverable content found in workspace/

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Deliverable indicators (content that is IN the workspace, not ABOUT it)
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

# Operating context indicators (content that is ABOUT the workspace)
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

echo "Applying \"about vs in\" test: \"Is this ABOUT the workspace or IN it?\""
echo ""

# Check each file in workspace/
find specs/workspace/ -name "*.spec.md" -type f | while read -r spec_file; do
    files_checked=$((files_checked + 1))
    violations_found=0

    echo "Checking: $spec_file"

    # Read file content (skip frontmatter)
    content=$(sed '/^---$/,/^---$/d' "$spec_file")

    # Check for deliverable indicators
    for pattern in "${FAIL_PATTERNS[@]}"; do
        if echo "$content" | grep -qi "$pattern"; then
            violations_found=1
            echo -e "  ${RED}✗${NC} Found deliverable indicator: \"$pattern\""
            echo "$spec_file|$pattern" >> "$flagged_file"
        fi
    done

    if [[ $violations_found -eq 0 ]]; then
        echo -e "  ${GREEN}✓${NC} Passes \"about vs in\" test (operating context)"
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
    echo -e "${YELLOW}⚠ WARNING: $flagged_count file(s) contain deliverable content${NC}"
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
    echo "  1. Review flagged files for deliverable content"
    echo "  2. Apply \"about vs in\" test: \"Is this ABOUT the workspace or IN it?\""
    echo "  3. Move deliverable content to:"
    echo "     - specs/1-requirements/functional/ (feature requirements)"
    echo "     - specs/2-strategy/ (architecture decisions)"
    echo "     - specs/3-behaviors/ (product behaviors)"
    echo "  4. Keep only operating context in workspace/"
    echo ""
    echo "Example:"
    echo "  ✗ TMP project taxonomy → specs/2-strategy/project-classification.spec.md"
    echo "  ✗ Lambda patterns → specs/2-strategy/lambda-architecture.spec.md"
    echo "  ✓ Spec-first principle → specs/workspace/constitution.spec.md"
    echo ""
    # Exit with warning (0 for now, consider 1 if you want blocking)
    exit 1
else
    echo -e "${GREEN}✓ PASS: All workspace files are operating context${NC}"
    echo ""
    echo "Workspace boundary is clean."
    exit 0
fi
