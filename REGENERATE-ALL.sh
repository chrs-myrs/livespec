#!/bin/bash
#
# Master script: Regenerate ALL LiveSpec prompts from behavior specs
#
# Usage: ./REGENERATE-ALL.sh
#
# What this does:
#   1. Reads all 21 specs from specs/behaviors/prompts/
#   2. Generates fresh prompts following best practices
#   3. Outputs to dist/prompts-NEW/ for review
#   4. Provides instructions for finalization
#

set -e

cd /home/chris/projects/livespec

echo "=========================================="
echo "LiveSpec Prompt Regeneration"
echo "=========================================="
echo ""
echo "Generating 21 prompts from specs..."
echo ""

# Use the comprehensive Python generator
python3 .tmp/full_regeneration.py

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ SUCCESS"
    echo ""
    echo "Review prompts in: dist/prompts-NEW/"
    echo ""
    echo "To finalize:"
    echo "  rm -rf dist/prompts/ && mv dist/prompts-NEW/ dist/prompts/"
    echo ""
fi
