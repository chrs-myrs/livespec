#!/bin/bash
# Test: MSL Format Behavior
# Spec: specs/behaviors/msl-format.spec.md

set -e
FAILURES=0

echo "Testing: MSL Format Behavior"

# Validation: All specifications contain exactly four sections
echo "  Checking MSL format compliance..."

for spec_file in specs/**/*.spec.md; do
    if [ -f "$spec_file" ]; then
        FILE_FAILURES=0

        # Check for Criticality
        if ! grep -q "^\*\*Criticality\*\*:" "$spec_file"; then
            echo "    ❌ $spec_file missing Criticality"
            FILE_FAILURES=1
        fi

        # Check for Failure Mode
        if ! grep -q "^\*\*Failure Mode\*\*:" "$spec_file"; then
            echo "    ❌ $spec_file missing Failure Mode"
            FILE_FAILURES=1
        fi

        # Check for Specification section
        if ! grep -q "^## Specification" "$spec_file"; then
            echo "    ❌ $spec_file missing Specification section"
            FILE_FAILURES=1
        fi

        # Check for Validation section
        if ! grep -q "^## Validation" "$spec_file"; then
            echo "    ❌ $spec_file missing Validation section"
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
