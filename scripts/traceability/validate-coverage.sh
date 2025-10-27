#!/usr/bin/env bash
#
# validate-coverage.sh
#
# Validate that all requirements have at least one implementation
#
# Usage: ./validate-coverage.sh [--detailed]
#
# Flags:
#   --detailed    Show detailed information for each requirement

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

DETAILED=false
if [ $# -gt 0 ] && [ "$1" = "--detailed" ]; then
    DETAILED=true
fi

echo -e "${BLUE}=== Requirements Coverage Analysis ===${NC}"
echo ""

# Check if specs/requirements exists
if [ ! -d "specs/requirements" ]; then
    echo -e "${RED}Error: specs/requirements/ directory not found${NC}"
    echo "This project may not use the three-layer architecture pattern"
    exit 1
fi

TOTAL_REQUIREMENTS=0
SATISFIED_REQUIREMENTS=0
UNSATISFIED_REQUIREMENTS=0

# Arrays to store results
declare -a SATISFIED_SPECS
declare -a UNSATISFIED_SPECS

# Process each requirement
while IFS= read -r req; do
    TOTAL_REQUIREMENTS=$((TOTAL_REQUIREMENTS + 1))
    REQ_BASENAME=$(basename "$req")
    REQ_RELPATH="${req#specs/}"  # Remove specs/ prefix if present

    # Count implementations satisfying this requirement
    # Match both basename and relative path in satisfies blocks
    COUNT=0

    # Search behaviors/
    if [ -d "specs/behaviors" ]; then
        while IFS= read -r spec; do
            SATISFIES_BLOCK=$(awk '/^satisfies:/,/^[a-z_-]+:/ {print}' "$spec" 2>/dev/null | grep "^  -")
            if echo "$SATISFIES_BLOCK" | grep -qE "(${REQ_BASENAME}|${REQ_RELPATH})"; then
                COUNT=$((COUNT + 1))
            fi
        done < <(find specs/behaviors -name "*.spec.md" 2>/dev/null)
    fi

    # Search contracts/
    if [ -d "specs/contracts" ]; then
        while IFS= read -r spec; do
            SATISFIES_BLOCK=$(awk '/^satisfies:/,/^[a-z_-]+:/ {print}' "$spec" 2>/dev/null | grep "^  -")
            if echo "$SATISFIES_BLOCK" | grep -qE "(${REQ_BASENAME}|${REQ_RELPATH})"; then
                COUNT=$((COUNT + 1))
            fi
        done < <(find specs/contracts -name "*.spec.md" 2>/dev/null)
    fi

    if [ "$COUNT" -eq 0 ]; then
        UNSATISFIED_REQUIREMENTS=$((UNSATISFIED_REQUIREMENTS + 1))
        UNSATISFIED_SPECS+=("$req")

        if [ "$DETAILED" = true ]; then
            echo -e "${RED}⚠️  NO IMPLEMENTATION:${NC} $req"

            # Check criticality
            if grep -q "criticality: CRITICAL" "$req" 2>/dev/null; then
                echo -e "  ${RED}Criticality: CRITICAL${NC}"
            elif grep -q "criticality: IMPORTANT" "$req" 2>/dev/null; then
                echo -e "  ${YELLOW}Criticality: IMPORTANT${NC}"
            fi
            echo ""
        fi
    else
        SATISFIED_REQUIREMENTS=$((SATISFIED_REQUIREMENTS + 1))
        SATISFIED_SPECS+=("$req:$COUNT")

        if [ "$DETAILED" = true ]; then
            echo -e "${GREEN}✓  $COUNT implementation(s):${NC} $req"
            echo ""
        fi
    fi
done < <(find specs/requirements -name "*.spec.md" 2>/dev/null)

# Summary
echo -e "${BLUE}=== Coverage Summary ===${NC}"
echo ""
echo "Total requirements:      $TOTAL_REQUIREMENTS"
echo -e "Satisfied requirements:  ${GREEN}$SATISFIED_REQUIREMENTS${NC}"
echo -e "Unsatisfied requirements: ${RED}$UNSATISFIED_REQUIREMENTS${NC}"
echo ""

if [ "$TOTAL_REQUIREMENTS" -gt 0 ]; then
    COVERAGE=$((SATISFIED_REQUIREMENTS * 100 / TOTAL_REQUIREMENTS))
    echo -e "Coverage: ${BLUE}${COVERAGE}%${NC}"
    echo ""
fi

# List unsatisfied requirements
if [ "$UNSATISFIED_REQUIREMENTS" -gt 0 ]; then
    echo -e "${RED}=== Unsatisfied Requirements ===${NC}"
    echo ""

    for spec in "${UNSATISFIED_SPECS[@]}"; do
        # Check if CRITICAL
        if grep -q "criticality: CRITICAL" "$spec" 2>/dev/null; then
            echo -e "${RED}  [CRITICAL]${NC} $spec"
        elif grep -q "criticality: IMPORTANT" "$spec" 2>/dev/null; then
            echo -e "${YELLOW}  [IMPORTANT]${NC} $spec"
        else
            echo -e "  $spec"
        fi
    done
    echo ""

    # Check for CRITICAL unsatisfied requirements
    CRITICAL_UNSATISFIED=0
    for spec in "${UNSATISFIED_SPECS[@]}"; do
        if grep -q "criticality: CRITICAL" "$spec" 2>/dev/null; then
            CRITICAL_UNSATISFIED=$((CRITICAL_UNSATISFIED + 1))
        fi
    done

    if [ "$CRITICAL_UNSATISFIED" -gt 0 ]; then
        echo -e "${RED}⚠️  WARNING: $CRITICAL_UNSATISFIED CRITICAL requirement(s) have no implementation${NC}"
        echo ""
        exit 1
    fi
fi

# Success exit
if [ "$UNSATISFIED_REQUIREMENTS" -eq 0 ]; then
    echo -e "${GREEN}✓ All requirements have implementations${NC}"
    exit 0
else
    echo -e "${YELLOW}⚠️  Some requirements lack implementations${NC}"
    exit 1
fi
