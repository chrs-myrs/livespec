#!/bin/bash
# Test: Specification Traceability
# Spec: specs/workspace/patterns.spec.md

set -e
FAILURES=0

echo "Testing: Specification Traceability"

# Validation: Specifications declare dependencies via YAML frontmatter
echo "  Checking frontmatter dependency declarations..."

SPECS_WITH_FRONTMATTER=0
SPECS_WITHOUT_FRONTMATTER=0

for spec_file in specs/**/*.spec.md; do
    if [ -f "$spec_file" ]; then
        # Check if file has YAML frontmatter
        if head -1 "$spec_file" | grep -q "^---$"; then
            SPECS_WITH_FRONTMATTER=$((SPECS_WITH_FRONTMATTER + 1))

            # Extract frontmatter
            FRONTMATTER=$(sed -n '/^---$/,/^---$/p' "$spec_file")

            # Check for at least one dependency field
            if echo "$FRONTMATTER" | grep -qE "derives_from:|constrained_by:|satisfies:|supports:|applies_to:"; then
                echo "    ✓ $(basename $spec_file) has dependency frontmatter"
            else
                echo "    ⚠️  $(basename $spec_file) has frontmatter but no dependency fields"
            fi
        else
            SPECS_WITHOUT_FRONTMATTER=$((SPECS_WITHOUT_FRONTMATTER + 1))
            # Only warn for non-workspace specs (workspace specs might be exceptions)
            if [[ ! "$spec_file" =~ workspace ]]; then
                echo "    ⚠️  $(basename $spec_file) missing frontmatter (should declare dependencies)"
            fi
        fi
    fi
done

echo "    Found $SPECS_WITH_FRONTMATTER specs with frontmatter, $SPECS_WITHOUT_FRONTMATTER without"

# Validation: Dependency references point to existing files
echo "  Checking dependency references exist..."

BROKEN_REFS=0

for spec_file in specs/**/*.spec.md; do
    if [ -f "$spec_file" ] && head -1 "$spec_file" | grep -q "^---$"; then
        # Extract dependency references
        REFS=$(sed -n '/^---$/,/^---$/p' "$spec_file" | grep -E "^\s*-\s+" | sed 's/^\s*-\s*//' | tr -d ' ')

        for ref in $REFS; do
            # Skip if empty or not a file path
            if [ -z "$ref" ] || [[ ! "$ref" =~ \.(md|spec\.md)$ ]]; then
                continue
            fi

            # Check if referenced file exists
            if [ ! -f "$ref" ]; then
                echo "    ❌ Broken reference in $(basename $spec_file): $ref not found"
                BROKEN_REFS=$((BROKEN_REFS + 1))
                FAILURES=$((FAILURES + 1))
            fi
        done
    fi
done

if [ $BROKEN_REFS -eq 0 ]; then
    echo "    ✓ All dependency references point to existing files"
fi

# Validation: Key specs have expected dependencies
echo "  Checking key spec dependencies..."

# Check architecture.spec.md derives from PURPOSE.md and requirements.spec.md
if [ -f "specs/architecture.spec.md" ]; then
    if grep -A 10 "^---" specs/architecture.spec.md | grep -q "PURPOSE.md"; then
        echo "    ✓ architecture.spec.md derives from PURPOSE.md"
    else
        echo "    ❌ architecture.spec.md should derive from PURPOSE.md"
        FAILURES=$((FAILURES + 1))
    fi

    if grep -A 10 "^---" specs/architecture.spec.md | grep -q "requirements.spec.md"; then
        echo "    ✓ architecture.spec.md derives from requirements.spec.md"
    else
        echo "    ⚠️  architecture.spec.md should derive from requirements.spec.md"
    fi
fi

# Check constraints.spec.md derives from PURPOSE.md
if [ -f "specs/constraints.spec.md" ]; then
    if grep -A 10 "^---" specs/constraints.spec.md | grep -q "PURPOSE.md"; then
        echo "    ✓ constraints.spec.md derives from PURPOSE.md"
    else
        echo "    ❌ constraints.spec.md should derive from PURPOSE.md"
        FAILURES=$((FAILURES + 1))
    fi
fi

# Check requirements.spec.md derives from PURPOSE.md
if [ -f "specs/requirements.spec.md" ]; then
    if grep -A 10 "^---" specs/requirements.spec.md | grep -q "PURPOSE.md"; then
        echo "    ✓ requirements.spec.md derives from PURPOSE.md"
    else
        echo "    ❌ requirements.spec.md should derive from PURPOSE.md"
        FAILURES=$((FAILURES + 1))
    fi
fi

# Validation: No circular dependencies
echo "  Checking for circular dependencies..."

# Simple check: a spec should not derive from itself
CIRCULAR=0

for spec_file in specs/**/*.spec.md; do
    if [ -f "$spec_file" ]; then
        BASENAME=$(basename "$spec_file")
        if grep -A 10 "^---" "$spec_file" | grep -E "derives_from:|constrained_by:" | grep -q "$BASENAME"; then
            echo "    ❌ Circular dependency: $BASENAME references itself"
            CIRCULAR=$((CIRCULAR + 1))
            FAILURES=$((FAILURES + 1))
        fi
    fi
done

if [ $CIRCULAR -eq 0 ]; then
    echo "    ✓ No circular dependencies detected"
fi

# Validation: Foundation exists
echo "  Checking foundation specs exist..."

if [ -f "PURPOSE.md" ]; then
    echo "    ✓ PURPOSE.md exists (root)"
else
    echo "    ❌ PURPOSE.md missing (required root)"
    FAILURES=$((FAILURES + 1))
fi

if [ -f "specs/requirements.spec.md" ]; then
    echo "    ✓ specs/requirements.spec.md exists"
else
    echo "    ❌ specs/requirements.spec.md missing (should define high-level requirements)"
    FAILURES=$((FAILURES + 1))
fi

if [ -f "specs/constraints.spec.md" ]; then
    echo "    ✓ specs/constraints.spec.md exists"
else
    echo "    ⚠️  specs/constraints.spec.md recommended"
fi

if [ -f "specs/architecture.spec.md" ]; then
    echo "    ✓ specs/architecture.spec.md exists"
else
    echo "    ⚠️  specs/architecture.spec.md recommended"
fi

if [ $FAILURES -gt 0 ]; then
    echo "FAILED: $FAILURES traceability test(s) failed"
    echo ""
    echo "Per specs/workspace/patterns.spec.md:"
    echo "  'Specifications declare dependencies via YAML frontmatter'"
    echo ""
    echo "Fix by:"
    echo "  - Add YAML frontmatter to specs (see specs/DEPENDENCIES.md)"
    echo "  - Use: derives_from, constrained_by, satisfies, supports, applies_to"
    echo "  - Ensure all referenced files exist"
    echo "  - Check specs/DEPENDENCIES.md for dependency structure"
    exit 1
else
    echo "✅ All traceability tests passed"
    exit 0
fi
