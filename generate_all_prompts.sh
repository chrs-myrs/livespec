#!/bin/bash
# Regenerate all LiveSpec prompts from specs
# This script will be used by Claude to systematically generate each prompt

set -e

PROJECT_ROOT="/home/chris/projects/livespec"
cd "$PROJECT_ROOT"

echo "LiveSpec Prompt Regeneration"
echo "============================================================"
echo "Reading specs and generating prompts..."
echo ""

# List all spec files to process
find specs/behaviors/prompts/ -name "*.spec.md" | sort

echo ""
echo "Total specs found: $(find specs/behaviors/prompts/ -name '*.spec.md' | wc -l)"
echo ""
echo "Ready for Claude to generate prompts from these specs."
