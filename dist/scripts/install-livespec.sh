#!/usr/bin/env bash
# Install LiveSpec using the best available method (sparse submodule > full submodule > copy)
# Usage: ./scripts/install-livespec.sh [--method <sparse|full|copy>] [--repo <url>]

set -e

# Default configuration
REPO_URL="${LIVESPEC_REPO_URL:-https://github.com/chrs-myrs/livespec}"
METHOD="${1:-auto}"
SUBMODULE_PATH=".livespec-repo"
SYMLINK_PATH=".livespec"
DIST_SUBPATH="dist"

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --method)
      METHOD="$2"
      shift 2
      ;;
    --repo)
      REPO_URL="$2"
      shift 2
      ;;
    --help)
      echo "Usage: $0 [--method <sparse|full|copy>] [--repo <url>]"
      echo ""
      echo "Install LiveSpec using the best available method."
      echo ""
      echo "Options:"
      echo "  --method <type>   Force installation method (sparse, full, copy, auto)"
      echo "  --repo <url>      Override repository URL (default: https://github.com/chrs-myrs/livespec)"
      echo "  --help            Show this help message"
      echo ""
      echo "Methods:"
      echo "  sparse  - Use git sparse-checkout (only fetch dist/, requires git 2.25+)"
      echo "  full    - Use full git submodule (fetch entire repo)"
      echo "  copy    - Copy files directly (no git integration)"
      echo "  auto    - Automatically select best available method (default)"
      exit 0
      ;;
    *)
      echo -e "${RED}Unknown option: $1${NC}"
      exit 1
      ;;
  esac
done

# Helper functions
info() {
  echo -e "${BLUE}ℹ${NC} $1"
}

success() {
  echo -e "${GREEN}✓${NC} $1"
}

warning() {
  echo -e "${YELLOW}⚠${NC} $1"
}

error() {
  echo -e "${RED}✗${NC} $1"
}

# Check if git-partial-submodule is available
has_git_partial_submodule() {
  command -v git-partial-submodule.py &> /dev/null
}

# Check git version supports sparse-checkout
has_sparse_checkout() {
  local git_version=$(git --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
  local major=$(echo "$git_version" | cut -d. -f1)
  local minor=$(echo "$git_version" | cut -d. -f2)

  # Sparse checkout with cone mode introduced in git 2.25
  if [[ $major -gt 2 || ($major -eq 2 && $minor -ge 25) ]]; then
    return 0
  else
    return 1
  fi
}

# Install using git-partial-submodule
install_sparse_with_tool() {
  info "Installing using git-partial-submodule (sparse checkout with tool)..."

  git-partial-submodule.py add \
    --sparse-patterns "$DIST_SUBPATH/*" \
    "$REPO_URL" \
    "$SUBMODULE_PATH"

  ln -sf "$SUBMODULE_PATH/$DIST_SUBPATH" "$SYMLINK_PATH"

  success "Installed via git-partial-submodule (only $DIST_SUBPATH/ fetched)"
  info "Update with: git submodule update --remote $SUBMODULE_PATH"
}

# Install using native git sparse-checkout
install_sparse_native() {
  info "Installing using native git sparse-checkout..."

  git submodule add "$REPO_URL" "$SUBMODULE_PATH"
  git -C "$SUBMODULE_PATH" sparse-checkout init --cone
  git -C "$SUBMODULE_PATH" sparse-checkout set "$DIST_SUBPATH"

  ln -sf "$SUBMODULE_PATH/$DIST_SUBPATH" "$SYMLINK_PATH"

  success "Installed via native sparse-checkout (only $DIST_SUBPATH/ fetched)"
  info "Update with: git submodule update --remote $SUBMODULE_PATH"
}

# Install using full submodule
install_full_submodule() {
  warning "Installing using full submodule (entire repository will be fetched)..."

  git submodule add "$REPO_URL" "$SUBMODULE_PATH"

  ln -sf "$SUBMODULE_PATH/$DIST_SUBPATH" "$SYMLINK_PATH"

  success "Installed via full submodule"
  info "Update with: git submodule update --remote $SUBMODULE_PATH"
  warning "Consider upgrading git to 2.25+ for sparse checkout support"
}

# Install using directory copy
install_copy() {
  info "Installing using directory copy..."

  if [[ ! -d "../livespec" ]]; then
    error "livespec repository not found at ../livespec"
    error "Please clone it first: git clone $REPO_URL ../livespec"
    exit 1
  fi

  mkdir -p "$SYMLINK_PATH"
  cp -r "../livespec/$DIST_SUBPATH/"* "$SYMLINK_PATH/"

  success "Installed via directory copy"
  warning "Updates require manual copy: cp -r ../livespec/$DIST_SUBPATH/* $SYMLINK_PATH/"
}

# Detect best installation method
detect_method() {
  if has_git_partial_submodule; then
    echo "sparse-tool"
  elif has_sparse_checkout; then
    echo "sparse-native"
  else
    echo "full"
  fi
}

# Main installation logic
main() {
  # Check if already installed
  if [[ -e "$SYMLINK_PATH" ]]; then
    error "$SYMLINK_PATH already exists"
    error "Remove it first or choose a different location"
    exit 1
  fi

  # Determine installation method
  case "$METHOD" in
    sparse)
      if has_sparse_checkout; then
        if has_git_partial_submodule; then
          install_sparse_with_tool
        else
          install_sparse_native
        fi
      else
        error "Sparse checkout requires git 2.25+. Current version: $(git --version)"
        error "Use --method full or --method copy instead"
        exit 2
      fi
      ;;
    full)
      install_full_submodule
      ;;
    copy)
      install_copy
      ;;
    auto)
      local detected_method=$(detect_method)
      info "Auto-detected method: $detected_method"

      case "$detected_method" in
        sparse-tool)
          install_sparse_with_tool
          ;;
        sparse-native)
          install_sparse_native
          ;;
        full)
          install_full_submodule
          ;;
      esac
      ;;
    *)
      error "Unknown method: $METHOD"
      error "Use: sparse, full, copy, or auto"
      exit 1
      ;;
  esac

  echo ""
  success "LiveSpec installed successfully at $SYMLINK_PATH"
  info "Next steps:"
  echo "  1. Create specs structure: mkdir -p specs/{workspace,1-requirements,2-strategy,3-behaviors,3-contracts}"
  echo "  2. Start Phase 0: Use .livespec/prompts/0-define/0a-quick-start.md"
}

main "$@"
