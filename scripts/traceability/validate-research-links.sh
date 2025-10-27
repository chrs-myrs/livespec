#!/usr/bin/env bash
# Validate bidirectional linkage between research artifacts and requirements
# Usage: ./validate-research-links.sh

set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Validating Research → Requirements Linkage ===${NC}"
echo ""

ISSUES_FOUND=0

# Check if research folder exists
if [[ ! -d "research" ]]; then
  echo -e "${YELLOW}⚠${NC} No research/ folder found - skipping validation"
  exit 0
fi

# Check if requirements folder exists
if [[ ! -d "specs/requirements" ]]; then
  echo -e "${YELLOW}⚠${NC} No specs/requirements/ folder found - skipping validation"
  exit 0
fi

# Validate 1: Research artifacts should link to requirements (informs:)
echo -e "${GREEN}1. Checking research artifacts link to requirements (informs:)${NC}"
echo ""

RESEARCH_FILES=$(find research -name "*.md" -type f 2>/dev/null || true)

if [[ -z "$RESEARCH_FILES" ]]; then
  echo -e "  ${YELLOW}⚠${NC} No research artifacts found"
  echo ""
else
  for research_file in $RESEARCH_FILES; do
    # Check if informs: frontmatter exists
    INFORMS=$(awk '/^informs:/,/^[a-z_-]+:/ {print}' "$research_file" | grep "^  - " || true)

    if [[ -z "$INFORMS" ]]; then
      echo -e "  ${YELLOW}⚠${NC} $research_file"
      echo -e "    ${YELLOW}Missing 'informs:' frontmatter - research not linked to requirements${NC}"
      echo ""
      ((ISSUES_FOUND++))
    else
      # Validate each linked requirement exists
      LINKS_VALID=true
      echo "$INFORMS" | while read -r line; do
        REQ_PATH=$(echo "$line" | sed 's/^[[:space:]]*-[[:space:]]*//')
        if [[ ! -f "$REQ_PATH" ]]; then
          if [[ "$LINKS_VALID" == "true" ]]; then
            echo -e "  ${YELLOW}⚠${NC} $research_file"
            LINKS_VALID=false
          fi
          echo -e "    ${YELLOW}Broken link:${NC} $REQ_PATH (file not found)"
          ((ISSUES_FOUND++))
        fi
      done

      if [[ "$LINKS_VALID" == "true" ]]; then
        echo -e "  ${GREEN}✓${NC} $research_file"
      fi
      echo ""
    fi
  done
fi

# Validate 2: Requirements with informed-by: should reference existing research
echo -e "${GREEN}2. Checking requirements with informed-by: reference existing research${NC}"
echo ""

REQUIREMENT_FILES=$(find specs/requirements -name "*.spec.md" -type f 2>/dev/null || true)

if [[ -z "$REQUIREMENT_FILES" ]]; then
  echo -e "  ${YELLOW}⚠${NC} No requirement specs found"
  echo ""
else
  for req_file in $REQUIREMENT_FILES; do
    # Check if informed-by: frontmatter exists
    INFORMED_BY=$(awk '/^informed-by:/,/^[a-z_-]+:/ {print}' "$req_file" | grep "^  - " || true)

    if [[ -n "$INFORMED_BY" ]]; then
      # Validate each research link exists
      LINKS_VALID=true
      echo "$INFORMED_BY" | while read -r line; do
        RESEARCH_PATH=$(echo "$line" | sed 's/^[[:space:]]*-[[:space:]]*//')
        if [[ ! -f "$RESEARCH_PATH" ]]; then
          if [[ "$LINKS_VALID" == "true" ]]; then
            echo -e "  ${YELLOW}⚠${NC} $req_file"
            LINKS_VALID=false
          fi
          echo -e "    ${YELLOW}Broken link:${NC} $RESEARCH_PATH (file not found)"
          ((ISSUES_FOUND++))
        fi
      done

      if [[ "$LINKS_VALID" == "true" ]]; then
        echo -e "  ${GREEN}✓${NC} $req_file"
      fi
      echo ""
    fi
  done
fi

# Validate 3: Bidirectional consistency (research informs: X, X has informed-by: research)
echo -e "${GREEN}3. Checking bidirectional linkage consistency${NC}"
echo ""

if [[ -n "$RESEARCH_FILES" ]]; then
  for research_file in $RESEARCH_FILES; do
    INFORMS=$(awk '/^informs:/,/^[a-z_-]+:/ {print}' "$research_file" | grep "^  - " || true)

    if [[ -n "$INFORMS" ]]; then
      RESEARCH_RELPATH="${research_file#./}"
      RESEARCH_BASENAME=$(basename "$research_file")

      echo "$INFORMS" | while read -r line; do
        REQ_PATH=$(echo "$line" | sed 's/^[[:space:]]*-[[:space:]]*//')

        if [[ -f "$REQ_PATH" ]]; then
          # Check if requirement references this research back
          INFORMED_BY_BLOCK=$(awk '/^informed-by:/,/^[a-z_-]+:/ {print}' "$REQ_PATH" | grep "^  -" || true)

          if ! echo "$INFORMED_BY_BLOCK" | grep -qE "(${RESEARCH_BASENAME}|${RESEARCH_RELPATH})"; then
            echo -e "  ${YELLOW}⚠${NC} One-way linkage:"
            echo -e "    ${BLUE}Research:${NC} $research_file → informs → $REQ_PATH"
            echo -e "    ${YELLOW}But requirement doesn't have informed-by: $research_file${NC}"
            echo ""
            ((ISSUES_FOUND++))
          fi
        fi
      done
    fi
  done
fi

# Summary
echo ""
echo -e "${BLUE}=== Validation Summary ===${NC}"
echo ""

if [[ $ISSUES_FOUND -eq 0 ]]; then
  echo -e "${GREEN}✓ All research linkages valid!${NC}"
  echo ""
  exit 0
else
  echo -e "${RED}✗ Found $ISSUES_FOUND issues${NC}"
  echo ""
  echo "To fix issues:"
  echo "1. Add 'informs:' frontmatter to research artifacts listing requirements"
  echo "2. Add 'informed-by:' frontmatter to requirements listing research"
  echo "3. Ensure bidirectional consistency (research ↔ requirement)"
  echo "4. Remove broken links to non-existent files"
  echo ""
  exit 1
fi
