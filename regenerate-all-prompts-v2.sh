#!/bin/bash
#
# Regenerate ALL LiveSpec prompts from behavior specs
# This is the master script that coordinates the regeneration process
#

set -e

PROJECT_ROOT="/home/chris/projects/livespec"
cd "$PROJECT_ROOT"

echo "============================================================"
echo "LiveSpec Complete Prompt Regeneration"
echo "============================================================"
echo ""
echo "This will regenerate all 21 prompts from specs/behaviors/prompts/"
echo ""

# Run the Python regeneration script
python3 .tmp/full_regeneration.py

EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    echo ""
    echo "============================================================"
    echo "✓ Generation Complete"
    echo "============================================================"
    echo ""
    echo "All prompts generated in: dist/prompts-NEW/"
    echo ""
    echo "Next steps:"
    echo "  1. Review generated prompts for quality"
    echo "  2. Test a few prompts to ensure they're actionable"
    echo "  3. When satisfied, finalize with:"
    echo ""
    echo "     rm -rf dist/prompts/"
    echo "     mv dist/prompts-NEW/ dist/prompts/"
    echo "     git add dist/prompts/"
    echo "     git commit -m 'Regenerate all prompts from consolidated specs'"
    echo ""
else
    echo ""
    echo "============================================================"
    echo "✗ Generation Failed"
    echo "============================================================"
    echo ""
    echo "Check errors above and fix issues in specs or generator"
    echo ""
    exit $EXIT_CODE
fi
