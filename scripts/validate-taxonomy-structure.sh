#!/usr/bin/env bash
#
# Taxonomy Structure Validation
#
# Validates that taxonomy.spec.md contains all required sections per the taxonomy metaspec:
# - Project Domain
# - Workspace Scope
# - Specs Boundary
# - AI agents must
#
# Usage:
#   ./scripts/validate-taxonomy-structure.sh
#
# Exit codes:
#   0 - Taxonomy structure complete
#   1 - Missing required sections

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Required section headings (case-insensitive patterns)
REQUIRED_SECTIONS=(
    "Project Domain"
    "Workspace Scope"
    "Specs Boundary"
    "AI agents must"
)

# Counters
sections_found=0
sections_missing=0

echo "Validating taxonomy structure..."
echo ""

# Check if taxonomy.spec.md exists
TAXONOMY_FILE="specs/workspace/taxonomy.spec.md"

if [[ ! -f "$TAXONOMY_FILE" ]]; then
    echo -e "${RED}✗ FAIL: $TAXONOMY_FILE not found${NC}"
    echo ""
    echo "Taxonomy spec is required for project classification and agent guidance."
    echo "Create using:"
    echo "  Use .livespec/prompts/0-define/0b-customize-workspace.md"
    exit 1
fi

echo -e "${GREEN}✓${NC} $TAXONOMY_FILE exists"
echo ""
echo "Checking required sections..."

# Create temp file to store missing sections
missing_file=$(mktemp)
trap "rm -f $missing_file" EXIT

# Check for each required section
for section in "${REQUIRED_SECTIONS[@]}"; do
    # Case-insensitive grep for section heading
    if grep -qi "^## .*${section}" "$TAXONOMY_FILE"; then
        echo -e "${GREEN}✓${NC} Found: $section"
        sections_found=$((sections_found + 1))
    else
        echo -e "${RED}✗${NC} Missing: $section"
        echo "$section" >> "$missing_file"
        sections_missing=$((sections_missing + 1))
    fi
done

echo ""
echo "==================================================================="
echo "Taxonomy Structure Validation Results"
echo "==================================================================="
echo "Sections required: ${#REQUIRED_SECTIONS[@]}"
echo "Sections found: $sections_found"
echo "Sections missing: $sections_missing"
echo ""

if [[ $sections_missing -gt 0 ]]; then
    echo -e "${RED}✗ FAIL: $TAXONOMY_FILE incomplete${NC}"
    echo ""
    echo "Missing sections:"
    while IFS= read -r section; do
        echo "  - $section"
    done < "$missing_file"
    echo ""
    echo "Remediation:"
    echo "  1. Read dist/standard/metaspecs/taxonomy.spec.md for requirements"
    echo "  2. Add missing sections to $TAXONOMY_FILE"
    echo "  3. Or regenerate: Use .livespec/prompts/0-define/0b-customize-workspace.md"
    echo ""
    echo "See LiveSpec's own taxonomy as example: https://github.com/chrs-myrs/livespec/blob/master/specs/workspace/taxonomy.spec.md"
    exit 1
else
    echo -e "${GREEN}✓ PASS: All required sections present${NC}"
    echo ""
    echo "Note: This validation checks structure only, not content quality."
    echo "Verify each section has substantive content."
    exit 0
fi
