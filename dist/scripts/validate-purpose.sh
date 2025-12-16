#!/bin/bash
# LiveSpec PURPOSE.md Boundary Validator
# Usage: ./scripts/validate-purpose.sh [path/to/PURPOSE.md]
# Returns: 0 if valid, 1 if violations found

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Configuration
MAX_LINES=20
WARN_LINES=15

# Default to PURPOSE.md in current directory
PURPOSE_FILE="${1:-PURPOSE.md}"

# Check file exists
if [ ! -f "$PURPOSE_FILE" ]; then
    echo -e "${RED}Error: $PURPOSE_FILE not found${NC}"
    exit 1
fi

echo -e "${BLUE}Validating: $PURPOSE_FILE${NC}"
echo ""

ERRORS=0
WARNINGS=0

# Count content lines (excluding blank lines and markdown headers)
# Headers are OK, we count content excluding them
content_lines=$(grep -v "^$" "$PURPOSE_FILE" | grep -v "^#" | wc -l)
total_lines=$(wc -l < "$PURPOSE_FILE")

echo -e "Total lines: $total_lines"
echo -e "Content lines (excluding headers/blanks): $content_lines"
echo ""

# Check line count
if [ "$content_lines" -gt "$MAX_LINES" ]; then
    echo -e "${RED}FAIL: Content lines ($content_lines) exceed maximum ($MAX_LINES)${NC}"
    ERRORS=$((ERRORS + 1))
elif [ "$content_lines" -gt "$WARN_LINES" ]; then
    echo -e "${YELLOW}WARN: Content lines ($content_lines) approaching limit ($MAX_LINES)${NC}"
    WARNINGS=$((WARNINGS + 1))
else
    echo -e "${GREEN}PASS: Content lines ($content_lines) within limit${NC}"
fi

# Check for prohibited patterns indicating content that belongs elsewhere

echo ""
echo -e "${BLUE}Checking for content that belongs elsewhere...${NC}"

# Pattern 1: Constraints/requirements language
if grep -qiE "(must comply|must not|required to|shall not|constraint|regulation|compliance)" "$PURPOSE_FILE"; then
    echo -e "${YELLOW}WARN: Found constraint language - consider moving to specs/1-requirements/strategic/constraints.spec.md${NC}"
    grep -inE "(must comply|must not|required to|shall not|constraint|regulation|compliance)" "$PURPOSE_FILE" | head -3
    WARNINGS=$((WARNINGS + 1))
fi

# Pattern 2: Technical architecture
if grep -qiE "(architecture|database|api|microservice|technology stack|framework|library|implementation)" "$PURPOSE_FILE"; then
    echo -e "${YELLOW}WARN: Found technical language - consider moving to specs/2-strategy/architecture.spec.md${NC}"
    grep -inE "(architecture|database|api|microservice|technology stack|framework|library|implementation)" "$PURPOSE_FILE" | head -3
    WARNINGS=$((WARNINGS + 1))
fi

# Pattern 3: Detailed feature lists (more than 6 bullet items in a row)
bullet_count=$(grep -c "^- " "$PURPOSE_FILE" || true)
if [ "$bullet_count" -gt 6 ]; then
    echo -e "${YELLOW}WARN: Found $bullet_count bullet items - consider moving detailed lists to specs/1-requirements/strategic/outcomes.spec.md${NC}"
    WARNINGS=$((WARNINGS + 1))
fi

# Pattern 4: Process/workflow language
if grep -qiE "(workflow|process|procedure|step [0-9]|phase [0-9])" "$PURPOSE_FILE"; then
    echo -e "${YELLOW}WARN: Found process language - consider moving to specs/workspace/workflows.spec.md${NC}"
    grep -inE "(workflow|process|procedure|step [0-9]|phase [0-9])" "$PURPOSE_FILE" | head -3
    WARNINGS=$((WARNINGS + 1))
fi

# Pattern 5: Extra sections beyond Why/What
section_count=$(grep -c "^## " "$PURPOSE_FILE" || true)
if [ "$section_count" -gt 2 ]; then
    echo -e "${YELLOW}WARN: Found $section_count sections (expected 2: 'Why' and 'What Success')${NC}"
    grep "^## " "$PURPOSE_FILE"
    WARNINGS=$((WARNINGS + 1))
fi

# Check required structure
echo ""
echo -e "${BLUE}Checking required structure...${NC}"

if grep -q "^## Why" "$PURPOSE_FILE"; then
    echo -e "${GREEN}PASS: 'Why' section found${NC}"
else
    echo -e "${RED}FAIL: Missing 'Why [Project] Exists' section${NC}"
    ERRORS=$((ERRORS + 1))
fi

if grep -qE "^## What Success|^## Success" "$PURPOSE_FILE"; then
    echo -e "${GREEN}PASS: 'Success' section found${NC}"
else
    echo -e "${RED}FAIL: Missing 'What Success Looks Like' section${NC}"
    ERRORS=$((ERRORS + 1))
fi

# Check for YAML frontmatter (shouldn't have any)
if head -1 "$PURPOSE_FILE" | grep -q "^---"; then
    echo -e "${RED}FAIL: PURPOSE.md should not have YAML frontmatter (it's not a spec)${NC}"
    ERRORS=$((ERRORS + 1))
fi

# Summary
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}PURPOSE.md validation PASSED${NC}"
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}PURPOSE.md validation PASSED with $WARNINGS warning(s)${NC}"
    echo ""
    echo -e "${BLUE}Content Routing Guide:${NC}"
    echo -e "  Constraints/requirements → specs/1-requirements/strategic/constraints.spec.md"
    echo -e "  Detailed outcomes        → specs/1-requirements/strategic/outcomes.spec.md"
    echo -e "  Technical architecture   → specs/2-strategy/architecture.spec.md"
    echo -e "  Process/workflows        → specs/workspace/workflows.spec.md"
    exit 0
else
    echo -e "${RED}PURPOSE.md validation FAILED ($ERRORS error(s), $WARNINGS warning(s))${NC}"
    echo ""
    echo -e "${BLUE}To fix:${NC}"
    echo -e "  1. Keep only 'Why [Project] Exists' (1-3 sentences)"
    echo -e "  2. Keep only 'What Success Looks Like' (3-6 bullets)"
    echo -e "  3. Move other content to appropriate specs"
    echo -e "  4. Target <15 content lines (max 20)"
    exit 1
fi
