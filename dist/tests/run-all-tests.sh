#!/bin/bash
# LiveSpec Test Suite Runner

set -e

echo "================================"
echo "LiveSpec v3.1.0 Test Suite"
echo "================================"
echo ""

TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Run all test scripts
for test_file in tests/prompts/*.sh tests/structure/*.sh; do
    if [ -f "$test_file" ] && [ -x "$test_file" ]; then
        TOTAL_TESTS=$((TOTAL_TESTS + 1))
        echo ""
        if "$test_file"; then
            PASSED_TESTS=$((PASSED_TESTS + 1))
        else
            FAILED_TESTS=$((FAILED_TESTS + 1))
        fi
    fi
done

echo ""
echo "================================"
echo "Test Summary"
echo "================================"
echo "Total:  $TOTAL_TESTS"
echo "Passed: $PASSED_TESTS"
echo "Failed: $FAILED_TESTS"
echo ""

if [ $FAILED_TESTS -gt 0 ]; then
    echo "❌ Some tests failed"
    exit 1
else
    echo "✅ All tests passed!"
    exit 0
fi
