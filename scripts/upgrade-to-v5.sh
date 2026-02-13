#!/usr/bin/env bash
set -euo pipefail

# LiveSpec v5 Upgrade Script
# Migrates legacy installations (submodule/copy/symlink) to v5 plugin architecture.
# Usage: upgrade-to-v5.sh [--detect-only] [--dry-run]

DRY_RUN=false
DETECT_ONLY=false
CHANGES_MADE=0

for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=true ;;
    --detect-only) DETECT_ONLY=true ;;
    --help|-h)
      echo "Usage: upgrade-to-v5.sh [--detect-only] [--dry-run]"
      echo "  --detect-only  Report current state, make no changes"
      echo "  --dry-run      Show what would change without changing it"
      exit 0
      ;;
  esac
done

# --- Detection ---

echo "=== LiveSpec Installation Detection ==="

HAS_SUBMODULE=false
HAS_LEGACY_LIVESPEC=false
LEGACY_LIVESPEC_TYPE=""
HAS_VERSION_FILE=false
HAS_NUMBERED_SPECS=false
HAS_PLUGIN=false

if [ -d ".livespec-repo" ]; then
  echo "FOUND: .livespec-repo/ (legacy submodule)"
  HAS_SUBMODULE=true
fi

if [ -L ".livespec" ]; then
  echo "FOUND: .livespec (symlink)"
  HAS_LEGACY_LIVESPEC=true
  LEGACY_LIVESPEC_TYPE="symlink"
elif [ -d ".livespec" ]; then
  echo "FOUND: .livespec/ (copy directory)"
  HAS_LEGACY_LIVESPEC=true
  LEGACY_LIVESPEC_TYPE="directory"
elif [ -f ".livespec" ]; then
  echo "FOUND: .livespec (file)"
  HAS_LEGACY_LIVESPEC=true
  LEGACY_LIVESPEC_TYPE="file"
fi

if [ -f ".livespec-version" ]; then
  echo "FOUND: .livespec-version (legacy version file)"
  HAS_VERSION_FILE=true
fi

if ls -d specs/[0-9]-*/ 2>/dev/null | head -1 > /dev/null 2>&1; then
  echo "FOUND: Numbered spec folders (need migration)"
  HAS_NUMBERED_SPECS=true
fi

if [ -d ".claude-plugin" ] || [ -d "$HOME/.claude/plugins/livespec" ]; then
  echo "FOUND: v5 plugin installed"
  HAS_PLUGIN=true
fi

# Summarise state
if ! $HAS_SUBMODULE && ! $HAS_LEGACY_LIVESPEC && ! $HAS_VERSION_FILE && ! $HAS_NUMBERED_SPECS; then
  if $HAS_PLUGIN; then
    echo ""
    echo "STATUS: Already on v5. Nothing to migrate."
    exit 0
  else
    echo ""
    echo "STATUS: No LiveSpec installation detected. Use /livespec:init to set up."
    exit 0
  fi
fi

echo ""
echo "=== Migration Plan ==="

if $HAS_LEGACY_LIVESPEC; then
  echo "  REMOVE: .livespec ($LEGACY_LIVESPEC_TYPE)"
fi
if $HAS_SUBMODULE; then
  echo "  REMOVE: .livespec-repo/ (git submodule)"
fi
if $HAS_VERSION_FILE; then
  echo "  REMOVE: .livespec-version"
fi
if $HAS_NUMBERED_SPECS; then
  echo "  MIGRATE: specs/ numbered folders -> semantic names"
  for dir in specs/[0-9]-*/; do
    [ -d "$dir" ] && echo "    $dir"
  done
fi

if $DETECT_ONLY; then
  exit 0
fi

if $DRY_RUN; then
  echo ""
  echo "(dry run - no changes made)"
  exit 0
fi

# --- Remove Legacy .livespec ---

if $HAS_LEGACY_LIVESPEC; then
  echo ""
  echo "Removing .livespec ($LEGACY_LIVESPEC_TYPE)..."
  case "$LEGACY_LIVESPEC_TYPE" in
    symlink) rm .livespec ;;
    directory) rm -rf .livespec ;;
    file) rm .livespec ;;
  esac
  echo "  Done."
  CHANGES_MADE=$((CHANGES_MADE + 1))
fi

# --- Remove Legacy Submodule ---

if $HAS_SUBMODULE; then
  echo ""
  echo "Removing .livespec-repo/ submodule..."
  git submodule deinit -f .livespec-repo 2>/dev/null || true
  git rm -f .livespec-repo 2>/dev/null || git rm --cached .livespec-repo 2>/dev/null || true
  rm -rf .git/modules/.livespec-repo 2>/dev/null || true
  if [ -f .gitmodules ]; then
    git config -f .gitmodules --remove-section submodule..livespec-repo 2>/dev/null || true
    git add .gitmodules 2>/dev/null || true
  fi
  # Clean up directory if still present
  rm -rf .livespec-repo 2>/dev/null || true
  echo "  Done."
  CHANGES_MADE=$((CHANGES_MADE + 1))
fi

# --- Remove Legacy Version File ---

if $HAS_VERSION_FILE; then
  echo ""
  echo "Removing .livespec-version..."
  rm -f .livespec-version
  echo "  Done."
  CHANGES_MADE=$((CHANGES_MADE + 1))
fi

# --- Migrate Spec Folders ---

if $HAS_NUMBERED_SPECS; then
  echo ""
  echo "Migrating specs/ to semantic folder names..."

  mkdir -p specs/{workspace,foundation,strategy,features,interfaces}

  # 1-requirements -> foundation
  if [ -d "specs/1-requirements" ]; then
    for subdir in specs/1-requirements/*/; do
      [ -d "$subdir" ] && mv "$subdir"* specs/foundation/ 2>/dev/null || true
    done
    # Direct files too
    mv specs/1-requirements/*.spec.md specs/foundation/ 2>/dev/null || true
    # Clean up
    find specs/1-requirements -type d -empty -delete 2>/dev/null || true
    rmdir specs/1-requirements 2>/dev/null || true
  fi

  # 2-strategy -> strategy
  if [ -d "specs/2-strategy" ]; then
    mv specs/2-strategy/* specs/strategy/ 2>/dev/null || true
    rmdir specs/2-strategy 2>/dev/null || true
  fi

  # 3-behaviors -> features (specs) + interfaces (contracts subfolder)
  if [ -d "specs/3-behaviors" ]; then
    if [ -d "specs/3-behaviors/contracts" ]; then
      mv specs/3-behaviors/contracts/* specs/interfaces/ 2>/dev/null || true
      rmdir specs/3-behaviors/contracts 2>/dev/null || true
    fi
    mv specs/3-behaviors/*.spec.md specs/features/ 2>/dev/null || true
    find specs/3-behaviors -type d -empty -delete 2>/dev/null || true
    rmdir specs/3-behaviors 2>/dev/null || true
  fi

  # 3-contracts -> interfaces (top-level contracts folder)
  if [ -d "specs/3-contracts" ]; then
    mv specs/3-contracts/*.spec.md specs/interfaces/ 2>/dev/null || true
    # Move any non-spec files too
    mv specs/3-contracts/* specs/interfaces/ 2>/dev/null || true
    find specs/3-contracts -type d -empty -delete 2>/dev/null || true
    rmdir specs/3-contracts 2>/dev/null || true
  fi

  echo "  Done."
  CHANGES_MADE=$((CHANGES_MADE + 1))

  # Update cross-references
  echo ""
  echo "Updating cross-references in spec frontmatter..."
  STALE_REFS=$(grep -rl "specs/1-requirements\|specs/2-strategy\|specs/3-behaviors\|specs/3-contracts" specs/ 2>/dev/null || true)
  if [ -n "$STALE_REFS" ]; then
    for f in $STALE_REFS; do
      sed -i \
        -e 's|specs/1-requirements/strategic/|specs/foundation/|g' \
        -e 's|specs/1-requirements/functional/|specs/foundation/|g' \
        -e 's|specs/1-requirements/|specs/foundation/|g' \
        -e 's|specs/2-strategy/|specs/strategy/|g' \
        -e 's|specs/3-behaviors/contracts/|specs/interfaces/|g' \
        -e 's|specs/3-behaviors/|specs/features/|g' \
        -e 's|specs/3-contracts/|specs/interfaces/|g' \
        "$f"
      echo "  Updated: $f"
    done
  else
    echo "  No stale references found."
  fi
fi

# --- Summary ---

echo ""
echo "=== Migration Complete ==="
echo "Changes made: $CHANGES_MADE"

# Verify
echo ""
echo "=== Verification ==="
PASS=true
if [ -d ".livespec-repo" ]; then echo "FAIL: .livespec-repo/ still exists"; PASS=false; else echo "PASS: No submodule"; fi
if [ -e ".livespec" ]; then echo "FAIL: .livespec still exists"; PASS=false; else echo "PASS: No legacy .livespec"; fi
if [ -f ".livespec-version" ]; then echo "FAIL: .livespec-version still exists"; PASS=false; else echo "PASS: No version file"; fi
if ls -d specs/[0-9]-*/ 2>/dev/null | head -1 > /dev/null 2>&1; then echo "FAIL: Numbered spec folders remain"; PASS=false; else echo "PASS: No numbered folders"; fi

REMAINING=$(grep -rl "specs/1-requirements\|specs/2-strategy\|specs/3-behaviors" specs/ 2>/dev/null || true)
if [ -n "$REMAINING" ]; then
  echo "WARN: Stale cross-references remain in:"
  echo "$REMAINING"
else
  echo "PASS: No stale cross-references"
fi

if $PASS; then
  echo ""
  echo "All checks passed. Ready to commit."
  exit 0
else
  echo ""
  echo "Some checks failed. Review manually."
  exit 1
fi
