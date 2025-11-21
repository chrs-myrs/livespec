#!/usr/bin/env bash
# Validate LiveSpec installation integrity
# Checks for required directories, files, and .livespec immutability

set -e

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
errors=0
warnings=0
checks_passed=0

# Helper functions
info() {
  echo -e "${BLUE}ℹ${NC} $1"
}

success() {
  echo -e "${GREEN}✓${NC} $1"
  checks_passed=$((checks_passed + 1))
}

warning() {
  echo -e "${YELLOW}⚠${NC} $1"
  warnings=$((warnings + 1))
}

error() {
  echo -e "${RED}✗${NC} $1"
  errors=$((errors + 1))
}

# Check if .livespec exists
check_livespec_exists() {
  if [[ -L ".livespec" ]]; then
    success ".livespec/ exists (symlink)"
    return 0
  elif [[ -d ".livespec" ]]; then
    success ".livespec/ exists (directory)"
    return 0
  else
    error ".livespec/ directory not found"
    return 1
  fi
}

# Check .livespec framework directories
check_livespec_structure() {
  local required_dirs=("prompts" "standard" "templates")

  for dir in "${required_dirs[@]}"; do
    if [[ -d ".livespec/$dir" ]]; then
      success ".livespec/$dir/ present"
    else
      error ".livespec/$dir/ missing"
    fi
  done
}

# Check .livespec immutability (submodule method)
check_livespec_immutability() {
  if [[ -d ".livespec-repo/.git" ]]; then
    # This is a submodule installation
    info "Checking .livespec-repo submodule status..."

    local submodule_status=$(git -C .livespec-repo status --porcelain 2>/dev/null)

    if [[ -z "$submodule_status" ]]; then
      success ".livespec-repo is clean (no modifications)"
    else
      error ".livespec-repo has modifications:"
      echo "$submodule_status" | sed 's/^/    /'
      warning "Framework should not be modified - customize via specs/workspace/ instead"
    fi
  else
    info ".livespec-repo not found (copy installation method - skipping immutability check)"
  fi
}

# Check specs directory structure
check_specs_structure() {
  local required_dirs=(
    "specs/workspace"
    "specs/1-requirements/strategic"
    "specs/1-requirements/functional"
    "specs/2-strategy"
    "specs/3-behaviors"
    "specs/3-contracts"
  )

  for dir in "${required_dirs[@]}"; do
    if [[ -d "$dir" ]]; then
      success "$dir/ present"
    else
      error "$dir/ missing"
    fi
  done
}

# Check bootstrap AGENTS.md
check_agents_md() {
  if [[ -f "AGENTS.md" ]]; then
    success "AGENTS.md present"

    # Check if it contains bootstrap notice
    if grep -q "bootstrap" "AGENTS.md"; then
      warning "AGENTS.md appears to be bootstrap version - regenerate after Phase 0"
    fi
  else
    error "AGENTS.md missing (bootstrap agent context not installed)"
  fi
}

# Check PURPOSE.md
check_purpose_md() {
  if [[ -f "PURPOSE.md" ]]; then
    success "PURPOSE.md present"

    # Check if it's still the template
    if grep -q "\[Describe the core problem" "PURPOSE.md"; then
      warning "PURPOSE.md contains template text - edit to describe your project"
    fi
  else
    warning "PURPOSE.md missing (not critical but recommended)"
  fi
}

# Main validation
main() {
  echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
  echo -e "${BLUE}  LiveSpec Installation Validation${NC}"
  echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
  echo ""

  info "Checking .livespec framework..."
  check_livespec_exists
  check_livespec_structure
  check_livespec_immutability

  echo ""
  info "Checking specs structure..."
  check_specs_structure

  echo ""
  info "Checking bootstrap files..."
  check_agents_md
  check_purpose_md

  echo ""
  echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
  echo -e "${BLUE}  Validation Summary${NC}"
  echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"

  if [[ $errors -eq 0 && $warnings -eq 0 ]]; then
    echo -e "${GREEN}✓${NC} All checks passed ($checks_passed/$checks_passed)"
    echo -e "${GREEN}✓${NC} Installation is valid"
    exit 0
  elif [[ $errors -eq 0 ]]; then
    echo -e "${GREEN}✓${NC} Core checks passed ($checks_passed checks)"
    echo -e "${YELLOW}⚠${NC} $warnings warning(s) - non-critical issues"
    echo ""
    info "Installation is functional but review warnings above"
    exit 0
  else
    echo -e "${RED}✗${NC} $errors error(s) detected"
    echo -e "${YELLOW}⚠${NC} $warnings warning(s)"
    echo -e "${GREEN}✓${NC} $checks_passed checks passed"
    echo ""
    error "Installation has critical issues - please fix errors above"
    exit 1
  fi
}

main "$@"
