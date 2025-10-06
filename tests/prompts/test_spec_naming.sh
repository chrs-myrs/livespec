#!/bin/bash
# Test: Spec Naming Consistency
# Spec: specs/workspace/patterns.spec.md

set -e
FAILURES=0

echo "Testing: Spec Naming Consistency"

# Validation: All spec references in prompts and docs use .spec.md extension
echo "  Checking spec file references use .spec.md extension..."

# Check prompts/ directory
INCONSISTENT_REFS=$(grep -rn "specs/\(behaviors\|workspace\)/[a-z-][a-z0-9-]*\.md[^.]" prompts/ --include="*.md" || true)

if [ -n "$INCONSISTENT_REFS" ]; then
    echo "    ❌ Found spec references without .spec.md extension in prompts/:"
    echo "$INCONSISTENT_REFS" | while IFS= read -r line; do
        echo "      $line"
    done
    FAILURES=$((FAILURES + 1))
else
    echo "    ✓ All spec references in prompts/ use .spec.md extension"
fi

# Check docs/ directory
INCONSISTENT_DOCS=$(grep -rn "specs/\(behaviors\|workspace\)/[a-z-][a-z0-9-]*\.md[^.]" docs/ --include="*.md" || true)

if [ -n "$INCONSISTENT_DOCS" ]; then
    echo "    ❌ Found spec references without .spec.md extension in docs/:"
    echo "$INCONSISTENT_DOCS" | while IFS= read -r line; do
        echo "      $line"
    done
    FAILURES=$((FAILURES + 1))
else
    echo "    ✓ All spec references in docs/ use .spec.md extension"
fi

# Validation: All actual spec files have .spec.md extension
echo "  Checking actual spec files have .spec.md extension..."

# Find any .md files in specs/ that aren't .spec.md (excluding README.md, DEPENDENCIES.md, and similar)
NON_SPEC_MD=$(find specs/ -type f -name "*.md" ! -name "*.spec.md" ! -name "README.md" ! -name "NOTES.md" ! -name "DEPENDENCIES.md" || true)

if [ -n "$NON_SPEC_MD" ]; then
    echo "    ❌ Found .md files without .spec.md extension in specs/:"
    echo "$NON_SPEC_MD" | while IFS= read -r file; do
        echo "      $file"
    done
    FAILURES=$((FAILURES + 1))
else
    echo "    ✓ All spec files use .spec.md extension"
fi

# Validation: Pattern compliance per specs/workspace/patterns.spec.md
echo "  Checking pattern compliance..."

# Count spec files
SPEC_COUNT=$(find specs/ -type f -name "*.spec.md" | wc -l)

if [ "$SPEC_COUNT" -gt 0 ]; then
    echo "    ✓ Found $SPEC_COUNT spec files following .spec.md pattern"
else
    echo "    ❌ No .spec.md files found in specs/"
    FAILURES=$((FAILURES + 1))
fi

if [ $FAILURES -gt 0 ]; then
    echo "FAILED: $FAILURES spec naming inconsistency test(s) failed"
    echo ""
    echo "Per specs/workspace/patterns.spec.md:"
    echo "  'All specs use MSL format (.spec.md extension with four sections)'"
    echo ""
    echo "Fix by:"
    echo "  - Use .spec.md extension for all MSL specification files"
    echo "  - Update references in prompts/ and docs/ to include .spec.md"
    echo "  - Contract files (.yaml, .json, etc.) don't need .spec.md extension"
    exit 1
else
    echo "✅ All spec naming consistency tests passed"
    exit 0
fi
