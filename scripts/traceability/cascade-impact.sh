#!/usr/bin/env bash
#
# cascade-impact.sh
#
# Analyze cascade impact when a spec changes
#
# Usage: ./cascade-impact.sh <changed-spec-path>
#
# Example:
#   ./cascade-impact.sh specs/requirements/functional/loan-accuracy.spec.md
#   ./cascade-impact.sh specs/strategy/calculation-approach.spec.md
#   ./cascade-impact.sh specs/behaviors/interest-calculation.spec.md

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Check arguments
if [ $# -eq 0 ]; then
    echo -e "${RED}Error: No spec file provided${NC}"
    echo "Usage: $0 <changed-spec-path>"
    echo ""
    echo "Examples:"
    echo "  $0 specs/requirements/functional/loan-accuracy.spec.md"
    echo "  $0 specs/strategy/calculation-approach.spec.md"
    echo "  $0 specs/behaviors/interest-calculation.spec.md"
    exit 1
fi

CHANGED_SPEC="$1"
SPEC_BASENAME=$(basename "$CHANGED_SPEC")

# Check if file exists
if [ ! -f "$CHANGED_SPEC" ]; then
    echo -e "${RED}Error: File not found: $CHANGED_SPEC${NC}"
    exit 1
fi

# Determine spec type based on path
SPEC_TYPE="unknown"
if [[ "$CHANGED_SPEC" =~ specs/requirements/ ]]; then
    SPEC_TYPE="requirement"
elif [[ "$CHANGED_SPEC" =~ specs/strategy/ ]]; then
    SPEC_TYPE="strategy"
elif [[ "$CHANGED_SPEC" =~ specs/behaviors/ ]] || [[ "$CHANGED_SPEC" =~ specs/contracts/ ]]; then
    SPEC_TYPE="implementation"
elif [[ "$CHANGED_SPEC" =~ research/ ]]; then
    SPEC_TYPE="research"
fi

echo -e "${BLUE}=== Cascade Impact Analysis ===${NC}"
echo ""
echo -e "Changed spec: ${CYAN}$CHANGED_SPEC${NC}"
echo -e "Spec type:    ${CYAN}$SPEC_TYPE${NC}"
echo ""

# Analyze impact based on spec type
case $SPEC_TYPE in
    research)
        echo -e "${YELLOW}=== Downward Impact (What This Affects) ===${NC}"
        echo ""

        # Find requirements informed by this research
        RESEARCH_RELPATH="${CHANGED_SPEC#./}"
        RESEARCH_BASENAME=$(basename "$CHANGED_SPEC")
        echo -e "${BLUE}Requirements Informed By This Research:${NC}"
        REQ_COUNT=0

        # Method 1: Check informs: in research artifact
        INFORMS=$(awk '/^informs:/,/^[a-z_-]+:/ {print}' "$CHANGED_SPEC" 2>/dev/null | grep "^  -" || true)
        if [[ -n "$INFORMS" ]]; then
            while read -r line; do
                REQ_PATH=$(echo "$line" | sed 's/^[[:space:]]*-[[:space:]]*//')
                if [[ -f "$REQ_PATH" ]]; then
                    REQ_COUNT=$((REQ_COUNT + 1))
                    echo -e "${GREEN}  ✓${NC} $REQ_PATH (via informs:)"
                fi
            done <<< "$INFORMS"
        fi

        # Method 2: Find requirements with informed-by: referencing this
        if [ -d "specs/requirements" ]; then
            while IFS= read -r spec; do
                INFORMED_BY_BLOCK=$(awk '/^informed-by:/,/^[a-z_-]+:/ {print}' "$spec" 2>/dev/null | grep "^  -" || true)
                if echo "$INFORMED_BY_BLOCK" | grep -qE "(${RESEARCH_BASENAME}|${RESEARCH_RELPATH})"; then
                    # Check if already counted via informs:
                    if [[ -z "$INFORMS" ]] || ! echo "$INFORMS" | grep -q "$spec"; then
                        REQ_COUNT=$((REQ_COUNT + 1))
                        echo -e "${GREEN}  ✓${NC} $spec (via informed-by:)"
                    fi
                fi
            done < <(find specs/requirements -name "*.spec.md" 2>/dev/null)
        fi

        [ "$REQ_COUNT" -eq 0 ] && echo "  (none - research not linked to requirements)"
        echo ""

        echo -e "${CYAN}=== Action Items ===${NC}"
        [ "$REQ_COUNT" -gt 0 ] && echo -e "  • Review $REQ_COUNT requirement spec(s) informed by this research"
        [ "$REQ_COUNT" -gt 0 ] && echo -e "  • Verify requirements still align with updated research findings"
        [ "$REQ_COUNT" -gt 0 ] && echo -e "  • Consider if new insights require new requirements"
        echo -e "  • Document what changed in research and why"
        echo -e "  • Update research artifact date/version if applicable"
        ;;

    requirement)
        echo -e "${YELLOW}=== Upward Impact (What This Depends On) ===${NC}"
        echo ""

        # Find research that informed this requirement
        echo -e "${BLUE}Research Informing This Requirement:${NC}"
        if grep -q "^informed-by:" "$CHANGED_SPEC" 2>/dev/null; then
            RESEARCH_COUNT=0
            awk '/^informed-by:/,/^[a-z_-]+:/ {print}' "$CHANGED_SPEC" | grep "^  -" | while read -r line; do
                RESEARCH_PATH=$(echo "$line" | sed 's/^  - //')
                if [[ -f "$RESEARCH_PATH" ]]; then
                    echo -e "${GREEN}  ✓${NC} $RESEARCH_PATH"
                    RESEARCH_COUNT=$((RESEARCH_COUNT + 1))
                else
                    echo -e "${YELLOW}  ⚠${NC} $RESEARCH_PATH (file not found)"
                fi
            done
        else
            echo "  (none - requirement not linked to research)"
        fi
        echo ""

        echo -e "${YELLOW}=== Downward Impact (What This Affects) ===${NC}"
        echo ""

        # Find strategies deriving from this requirement
        echo -e "${BLUE}Strategies Deriving From This:${NC}"
        STRATEGY_COUNT=0
        if [ -d "specs/strategy" ]; then
            while IFS= read -r spec; do
                if grep -q "derives-from:.*$SPEC_BASENAME" "$spec" 2>/dev/null; then
                    STRATEGY_COUNT=$((STRATEGY_COUNT + 1))
                    echo -e "${GREEN}  ✓${NC} $spec"
                fi
            done < <(find specs/strategy -name "*.spec.md" 2>/dev/null)
        fi
        [ "$STRATEGY_COUNT" -eq 0 ] && echo "  (none)"
        echo ""

        # Find implementations satisfying this requirement
        SPEC_RELPATH="${CHANGED_SPEC#specs/}"
        echo -e "${BLUE}Implementations Satisfying This:${NC}"
        IMPL_COUNT=0

        if [ -d "specs/behaviors" ]; then
            while IFS= read -r spec; do
                SATISFIES_BLOCK=$(awk '/^satisfies:/,/^[a-z_-]+:/ {print}' "$spec" 2>/dev/null | grep "^  -")
                if echo "$SATISFIES_BLOCK" | grep -qE "(${SPEC_BASENAME}|${SPEC_RELPATH})"; then
                    IMPL_COUNT=$((IMPL_COUNT + 1))
                    echo -e "${GREEN}  ✓${NC} $spec"
                fi
            done < <(find specs/behaviors -name "*.spec.md" 2>/dev/null)
        fi

        if [ -d "specs/contracts" ]; then
            while IFS= read -r spec; do
                SATISFIES_BLOCK=$(awk '/^satisfies:/,/^[a-z_-]+:/ {print}' "$spec" 2>/dev/null | grep "^  -")
                if echo "$SATISFIES_BLOCK" | grep -qE "(${SPEC_BASENAME}|${SPEC_RELPATH})"; then
                    IMPL_COUNT=$((IMPL_COUNT + 1))
                    echo -e "${GREEN}  ✓${NC} $spec"
                fi
            done < <(find specs/contracts -name "*.spec.md" 2>/dev/null)
        fi

        [ "$IMPL_COUNT" -eq 0 ] && echo "  (none - requirement may be unimplemented)"
        echo ""

        echo -e "${CYAN}=== Action Items ===${NC}"
        [ "$STRATEGY_COUNT" -gt 0 ] && echo -e "  • Review $STRATEGY_COUNT strategy spec(s) - do they still derive correctly?"
        [ "$IMPL_COUNT" -gt 0 ] && echo -e "  • Review $IMPL_COUNT implementation spec(s) - do they still satisfy requirement?"
        [ "$IMPL_COUNT" -gt 0 ] && echo -e "  • Update code in implementations"
        [ "$IMPL_COUNT" -gt 0 ] && echo -e "  • Update tests to reflect new requirement"
        ;;

    strategy)
        echo -e "${YELLOW}=== Upward Impact (What This Depends On) ===${NC}"
        echo ""

        # Find requirements this derives from
        echo -e "${BLUE}Requirements This Derives From:${NC}"
        if grep -q "^derives-from:" "$CHANGED_SPEC" 2>/dev/null; then
            awk '/^derives-from:/,/^[a-z_-]+:/ {print}' "$CHANGED_SPEC" | grep "^  -" | sed 's/^  - /  /' | sed "s|^|${GREEN}  ✓${NC} specs/requirements/|"
        else
            echo "  (none specified)"
        fi
        echo ""

        echo -e "${YELLOW}=== Downward Impact (What This Affects) ===${NC}"
        echo ""

        # Find implementations guided by this strategy
        SPEC_RELPATH="${CHANGED_SPEC#specs/}"
        echo -e "${BLUE}Implementations Guided By This:${NC}"
        IMPL_COUNT=0

        if [ -d "specs/behaviors" ]; then
            while IFS= read -r spec; do
                GUIDED_BLOCK=$(awk '/^guided-by:/,/^[a-z_-]+:/ {print}' "$spec" 2>/dev/null | grep "^  -")
                if echo "$GUIDED_BLOCK" | grep -qE "(${SPEC_BASENAME}|${SPEC_RELPATH})"; then
                    IMPL_COUNT=$((IMPL_COUNT + 1))
                    echo -e "${GREEN}  ✓${NC} $spec"
                fi
            done < <(find specs/behaviors -name "*.spec.md" 2>/dev/null)
        fi

        if [ -d "specs/contracts" ]; then
            while IFS= read -r spec; do
                GUIDED_BLOCK=$(awk '/^guided-by:/,/^[a-z_-]+:/ {print}' "$spec" 2>/dev/null | grep "^  -")
                if echo "$GUIDED_BLOCK" | grep -qE "(${SPEC_BASENAME}|${SPEC_RELPATH})"; then
                    IMPL_COUNT=$((IMPL_COUNT + 1))
                    echo -e "${GREEN}  ✓${NC} $spec"
                fi
            done < <(find specs/contracts -name "*.spec.md" 2>/dev/null)
        fi

        [ "$IMPL_COUNT" -eq 0 ] && echo "  (none - strategy may not be applied yet)"
        echo ""

        echo -e "${CYAN}=== Action Items ===${NC}"
        echo -e "  • Verify change still satisfies requirements this derives from"
        [ "$IMPL_COUNT" -gt 0 ] && echo -e "  • Update $IMPL_COUNT implementation spec(s) to follow new strategy"
        [ "$IMPL_COUNT" -gt 0 ] && echo -e "  • Refactor code to match new approach"
        [ "$IMPL_COUNT" -gt 0 ] && echo -e "  • Verify implementations still satisfy their requirements"
        ;;

    implementation)
        echo -e "${YELLOW}=== Upward Impact (What This Depends On) ===${NC}"
        echo ""

        # Find requirements this satisfies
        echo -e "${BLUE}Requirements This Satisfies:${NC}"
        if grep -q "^satisfies:" "$CHANGED_SPEC" 2>/dev/null; then
            awk '/^satisfies:/,/^[a-z_-]+:/ {print}' "$CHANGED_SPEC" | grep "^  -" | sed 's/^  - /  /' | sed "s|^|${GREEN}  ✓${NC} specs/|"
        else
            echo "  (none specified - should add satisfies: field)"
        fi
        echo ""

        # Find strategies this is guided by
        echo -e "${BLUE}Strategies Guiding This:${NC}"
        if grep -q "^guided-by:" "$CHANGED_SPEC" 2>/dev/null; then
            awk '/^guided-by:/,/^[a-z_-]+:/ {print}' "$CHANGED_SPEC" | grep "^  -" | sed 's/^  - /  /' | sed "s|^|${GREEN}  ✓${NC} specs/|"
        else
            echo "  (none specified)"
        fi
        echo ""

        echo -e "${CYAN}=== Action Items ===${NC}"
        echo -e "  • Verify change still satisfies all requirements"
        echo -e "  • Verify change still follows strategy guidance"
        echo -e "  • Update code implementation"
        echo -e "  • Update tests"
        echo -e "  • If validation criteria changed, verify against requirements"
        ;;

    *)
        echo -e "${YELLOW}Unknown spec type - unable to determine impact${NC}"
        echo "Spec should be in:"
        echo "  - research/ (research artifacts)"
        echo "  - specs/requirements/ (requirements layer)"
        echo "  - specs/strategy/ (strategy layer)"
        echo "  - specs/behaviors/ or specs/contracts/ (implementation layer)"
        exit 1
        ;;
esac

echo ""
echo -e "${BLUE}=== Impact Summary ===${NC}"
case $SPEC_TYPE in
    research)
        echo "This is a RESEARCH change - upstream impact on requirements"
        echo "All requirements informed by this research need review"
        echo "Consider if new insights require new requirements"
        ;;
    requirement)
        echo "This is a REQUIREMENT change - potentially high impact"
        echo "All implementations satisfying this requirement need review"
        echo "Check if research basis is still aligned"
        ;;
    strategy)
        echo "This is a STRATEGY change - moderate impact"
        echo "All implementations guided by this strategy need review"
        ;;
    implementation)
        echo "This is an IMPLEMENTATION change - localized impact"
        echo "Verify it still satisfies requirements and follows strategy"
        ;;
esac
