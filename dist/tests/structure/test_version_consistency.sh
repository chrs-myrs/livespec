#!/bin/bash
# LiveSpec Version Consistency Test
# Ensures all version references match .livespec-version

set -e

echo "Testing version consistency..."

# Read canonical version
CANONICAL_VERSION=$(cat .livespec-version)
echo "Canonical version: $CANONICAL_VERSION"

# Check each file
ERRORS=0

# 1. Check AGENTS.md frontmatter
AGENTS_VERSION=$(grep "^version:" AGENTS.md | head -1 | sed 's/version: //')
if [ "$AGENTS_VERSION" != "$CANONICAL_VERSION" ]; then
    echo "❌ AGENTS.md version mismatch: $AGENTS_VERSION (expected: $CANONICAL_VERSION)"
    ERRORS=$((ERRORS + 1))
else
    echo "✅ AGENTS.md version correct"
fi

# 2. Check dist/VERSION
DIST_VERSION=$(cat dist/VERSION 2>/dev/null)
if [ "$DIST_VERSION" != "$CANONICAL_VERSION" ]; then
    echo "❌ dist/VERSION mismatch: $DIST_VERSION (expected: $CANONICAL_VERSION)"
    ERRORS=$((ERRORS + 1))
else
    echo "✅ dist/VERSION correct"
fi

# 3. Check README.md title
if ! grep -q "# LiveSpec v$CANONICAL_VERSION" README.md; then
    echo "❌ README.md title missing v$CANONICAL_VERSION"
    ERRORS=$((ERRORS + 1))
else
    echo "✅ README.md title correct"
fi

# 4. Check llms.txt version line
if ! grep -q "Version: $CANONICAL_VERSION" llms.txt; then
    echo "❌ llms.txt version mismatch (expected: $CANONICAL_VERSION)"
    ERRORS=$((ERRORS + 1))
else
    echo "✅ llms.txt version correct"
fi

# 5. Check that root VERSION file doesn't exist (use dist/VERSION instead)
if [ -f VERSION ]; then
    echo "❌ Obsolete root VERSION file exists (should use dist/VERSION for distribution)"
    ERRORS=$((ERRORS + 1))
else
    echo "✅ No obsolete root VERSION file"
fi

# Report results
echo ""
if [ $ERRORS -eq 0 ]; then
    echo "✅ All version references consistent: $CANONICAL_VERSION"
    exit 0
else
    echo "❌ Found $ERRORS version inconsistencies"
    exit 1
fi
