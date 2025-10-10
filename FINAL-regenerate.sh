#!/bin/bash
# Regenerate ALL LiveSpec prompts from behavior specs
# Final clean version

cd /home/chris/projects/livespec

# Execute the Python generator (already created in .tmp/)
python3 .tmp/full_regeneration.py

echo ""
echo "Review: dist/prompts-NEW/"
echo "Finalize: rm -rf dist/prompts/ && mv dist/prompts-NEW/ dist/prompts/"
