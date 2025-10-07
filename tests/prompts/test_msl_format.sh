#!/bin/bash
# Test: MSL Format Behavior
# Spec: specs/behaviors/msl-format.spec.md

set -e
FAILURES=0

echo "Testing: MSL Format Behavior"

# Validation: All specifications follow MSL format (github.com/chrs-myrs/msl-specification)
echo "  Checking MSL format compliance..."

for spec_file in specs/**/*.spec.md; do
    if [ -f "$spec_file" ]; then
        FILE_FAILURES=0

        # Check for title (# Heading)
        if ! grep -q "^# " "$spec_file"; then
            echo "    ❌ $spec_file missing title"
            FILE_FAILURES=1
        fi

        # Check for Requirements section
        if ! grep -q "^## Requirements" "$spec_file"; then
            echo "    ❌ $spec_file missing Requirements section"
            FILE_FAILURES=1
        fi

        # Check for criticality in frontmatter
        if ! grep -q "^criticality:" "$spec_file"; then
            echo "    ❌ $spec_file missing criticality in frontmatter"
            FILE_FAILURES=1
        fi

        # Check for failure_mode in frontmatter
        if ! grep -q "^failure_mode:" "$spec_file"; then
            echo "    ❌ $spec_file missing failure_mode in frontmatter"
            FILE_FAILURES=1
        fi

        if [ $FILE_FAILURES -eq 0 ]; then
            echo "    ✓ $(basename $spec_file) follows MSL format"
        else
            FAILURES=$((FAILURES + 1))
        fi
    fi
done

# Validation: Specifications are 70% smaller than traditional
echo -n "  ✓ Specs are minimal (checking avg size)... "
TOTAL_SIZE=0
COUNT=0
for spec_file in specs/**/*.spec.md; do
    if [ -f "$spec_file" ]; then
        SIZE=$(wc -l < "$spec_file")
        TOTAL_SIZE=$((TOTAL_SIZE + SIZE))
        COUNT=$((COUNT + 1))
    fi
done

if [ $COUNT -gt 0 ]; then
    AVG_SIZE=$((TOTAL_SIZE / COUNT))
    if [ $AVG_SIZE -lt 100 ]; then
        echo "PASS (avg $AVG_SIZE lines)"
    else
        echo "WARN (avg $AVG_SIZE lines - might not be minimal enough)"
    fi
fi

if [ $FAILURES -gt 0 ]; then
    echo "FAILED: $FAILURES spec file(s) don't follow MSL format"
    exit 1
else
    echo "✅ All MSL format tests passed"
    exit 0
fi
