#!/usr/bin/env bash
# Find requirements informed by a research artifact
# Usage: ./find-requirements-from-research.sh research/insights/user-interviews.md

set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

RESEARCH_ARTIFACT="${1:-}"

if [[ -z "$RESEARCH_ARTIFACT" ]]; then
  echo "Usage: $0 <research-artifact-path>"
  echo ""
  echo "Example:"
  echo "  $0 research/insights/checkout-friction-study.md"
  exit 1
fi

if [[ ! -f "$RESEARCH_ARTIFACT" ]]; then
  echo "Error: Research artifact not found: $RESEARCH_ARTIFACT"
  exit 1
fi

echo -e "${BLUE}Finding requirements informed by:${NC} $RESEARCH_ARTIFACT"
echo ""

# Get relative path (remove leading ./ if present)
RESEARCH_RELPATH="${RESEARCH_ARTIFACT#./}"

# Method 1: Check informs: frontmatter in research artifact
echo -e "${GREEN}From research artifact frontmatter (informs:):${NC}"
echo ""

INFORMS=$(awk '/^informs:/,/^[a-z_-]+:/ {print}' "$RESEARCH_ARTIFACT" | grep "^  - " || true)

if [[ -n "$INFORMS" ]]; then
  echo "$INFORMS" | while read -r line; do
    # Remove leading spaces and dash
    REQ_PATH=$(echo "$line" | sed 's/^[[:space:]]*-[[:space:]]*//')

    if [[ -f "$REQ_PATH" ]]; then
      echo -e "  ${GREEN}✓${NC} $REQ_PATH"

      # Extract requirement title
      TITLE=$(grep "^# " "$REQ_PATH" | head -1 | sed 's/^# //')
      echo -e "    ${BLUE}Title:${NC} $TITLE"

      # Extract criticality if available
      CRITICALITY=$(grep "^criticality:" "$REQ_PATH" | head -1 | sed 's/^criticality:[[:space:]]*//' || echo "")
      if [[ -n "$CRITICALITY" ]]; then
        echo -e "    ${BLUE}Criticality:${NC} $CRITICALITY"
      fi

      echo ""
    else
      echo -e "  ${YELLOW}⚠${NC} $REQ_PATH ${YELLOW}(file not found)${NC}"
      echo ""
    fi
  done
else
  echo -e "  ${YELLOW}⚠${NC} No 'informs:' frontmatter found in research artifact"
  echo ""
fi

# Method 2: Search for requirements that reference this research in informed-by:
echo -e "${GREEN}From requirements referencing this research (informed-by:):${NC}"
echo ""

FOUND_REQUIREMENTS=false

# Get basename for matching
RESEARCH_BASENAME=$(basename "$RESEARCH_ARTIFACT")

# Search all requirement specs
for req_spec in specs/requirements/**/*.spec.md; do
  if [[ ! -f "$req_spec" ]]; then
    continue
  fi

  # Extract informed-by block
  INFORMED_BY_BLOCK=$(awk '/^informed-by:/,/^[a-z_-]+:/ {print}' "$req_spec" | grep "^  -" || true)

  # Check if this research is referenced (by basename or relative path)
  if echo "$INFORMED_BY_BLOCK" | grep -qE "(${RESEARCH_BASENAME}|${RESEARCH_RELPATH})"; then
    echo -e "  ${GREEN}✓${NC} $req_spec"

    # Extract title
    TITLE=$(grep "^# " "$req_spec" | head -1 | sed 's/^# //')
    echo -e "    ${BLUE}Title:${NC} $TITLE"

    # Extract criticality
    CRITICALITY=$(grep "^criticality:" "$req_spec" | head -1 | sed 's/^criticality:[[:space:]]*//' || echo "")
    if [[ -n "$CRITICALITY" ]]; then
      echo -e "    ${BLUE}Criticality:${NC} $CRITICALITY"
    fi

    echo ""
    FOUND_REQUIREMENTS=true
  fi
done

if [[ "$FOUND_REQUIREMENTS" == "false" ]]; then
  echo -e "  ${YELLOW}⚠${NC} No requirements found referencing this research"
  echo ""
  echo "To link this research to requirements, add to requirement frontmatter:"
  echo "---"
  echo "informed-by:"
  echo "  - $RESEARCH_RELPATH"
  echo "---"
  echo ""
fi

echo -e "${BLUE}To view research artifact:${NC}"
echo "  cat $RESEARCH_ARTIFACT"
echo ""
echo -e "${BLUE}To find research basis for a requirement:${NC}"
echo "  ./scripts/traceability/find-research-basis.sh <requirement-spec-path>"
