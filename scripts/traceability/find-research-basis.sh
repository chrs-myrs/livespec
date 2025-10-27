#!/usr/bin/env bash
# Find research artifacts that inform a given requirement
# Usage: ./find-research-basis.sh specs/requirements/functional/feature.spec.md

set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

REQUIREMENT_SPEC="${1:-}"

if [[ -z "$REQUIREMENT_SPEC" ]]; then
  echo "Usage: $0 <requirement-spec-path>"
  echo ""
  echo "Example:"
  echo "  $0 specs/requirements/functional/loan-accuracy.spec.md"
  exit 1
fi

if [[ ! -f "$REQUIREMENT_SPEC" ]]; then
  echo "Error: Requirement spec not found: $REQUIREMENT_SPEC"
  exit 1
fi

echo -e "${BLUE}Finding research artifacts that inform:${NC} $REQUIREMENT_SPEC"
echo ""

# Check if requirement has informed-by frontmatter
INFORMED_BY=$(awk '/^informed-by:/,/^[a-z_-]+:/ {print}' "$REQUIREMENT_SPEC" | grep "^  - " || true)

if [[ -z "$INFORMED_BY" ]]; then
  echo -e "${YELLOW}⚠${NC} No 'informed-by:' frontmatter found in requirement spec"
  echo ""
  echo "To link research to this requirement, add frontmatter:"
  echo "---"
  echo "informed-by:"
  echo "  - research/insights/user-interviews.md"
  echo "  - research/personas/primary-user.md"
  echo "---"
  exit 0
fi

echo -e "${GREEN}Research artifacts informing this requirement:${NC}"
echo ""

# Extract and display each research artifact
echo "$INFORMED_BY" | while read -r line; do
  # Remove leading spaces and dash
  RESEARCH_PATH=$(echo "$line" | sed 's/^[[:space:]]*-[[:space:]]*//')

  if [[ -f "$RESEARCH_PATH" ]]; then
    echo -e "  ${GREEN}✓${NC} $RESEARCH_PATH"

    # Extract research type from path
    if [[ "$RESEARCH_PATH" =~ research/personas/ ]]; then
      TYPE="Persona"
    elif [[ "$RESEARCH_PATH" =~ research/journeys/ ]]; then
      TYPE="User Journey"
    elif [[ "$RESEARCH_PATH" =~ research/flows/ ]]; then
      TYPE="UX Flow"
    elif [[ "$RESEARCH_PATH" =~ research/insights/ ]]; then
      TYPE="Research Insights"
    else
      TYPE="Research"
    fi

    # Extract title from file
    TITLE=$(grep "^# " "$RESEARCH_PATH" | head -1 | sed 's/^# //')
    echo -e "    ${BLUE}Type:${NC} $TYPE"
    echo -e "    ${BLUE}Title:${NC} $TITLE"

    # Extract creation date if available
    CREATED=$(grep "^created:" "$RESEARCH_PATH" | head -1 | sed 's/^created:[[:space:]]*//' || echo "")
    if [[ -n "$CREATED" ]]; then
      echo -e "    ${BLUE}Created:${NC} $CREATED"
    fi

    echo ""
  else
    echo -e "  ${YELLOW}⚠${NC} $RESEARCH_PATH ${YELLOW}(file not found)${NC}"
    echo ""
  fi
done

echo ""
echo -e "${BLUE}To view a research artifact:${NC}"
echo "  cat $RESEARCH_PATH"
echo ""
echo -e "${BLUE}To find all requirements informed by research:${NC}"
echo "  ./scripts/traceability/find-requirements-from-research.sh $RESEARCH_PATH"
