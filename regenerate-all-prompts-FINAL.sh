#!/bin/bash
#
# Regenerate ALL LiveSpec prompts from their behavior specs
# Requested in: DRY improvements after spec consolidation
#
# Context:
#   - 21 prompt specs in specs/behaviors/prompts/
#   - Recently consolidated (down from 24)
#   - Need fresh prompts following best practices
#
# This script generates prompts to dist/prompts-NEW/ for review
#

set -e

PROJECT_ROOT="/home/chris/projects/livespec"
SCRIPT_DIR="$PROJECT_ROOT/.tmp"
GENERATOR="$SCRIPT_DIR/full_regeneration.py"

cd "$PROJECT_ROOT"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}============================================================${NC}"
echo -e "${BLUE}LiveSpec Complete Prompt Regeneration${NC}"
echo -e "${BLUE}============================================================${NC}"
echo ""

# Check generator exists
if [ ! -f "$GENERATOR" ]; then
    echo -e "${YELLOW}Generator script not found. Creating it...${NC}"
    cat > "$GENERATOR" << 'GENERATOR_EOF'
#!/usr/bin/env python3
"""Complete LiveSpec prompt regeneration - inline version"""
import os, re, yaml
from pathlib import Path
from datetime import datetime

class PromptGenerator:
    def __init__(self, root):
        self.root = Path(root)
        self.count = 0

    def gen(self, mapping):
        print(f"Generating {len(mapping)} prompts...\n")
        for spec, out in mapping.items():
            try:
                # Read spec
                with open(self.root / spec) as f:
                    c = f.read()
                fm = {}
                if c.startswith('---'):
                    p = c.split('---', 2)
                    fm = yaml.safe_load(p[1]) or {}
                    c = p[2].strip()

                # Extract
                title = re.search(r'^#\s+(.+)$', c, re.M).group(1)
                phase = re.search(r'/(\d-[^/]+)/', out)
                phase = phase.group(1) if phase and '/utils/' not in out else None

                # Build
                pfm = {'spec': spec, 'generated': datetime.now().strftime('%Y-%m-%d')}
                if phase: pfm['phase'] = phase

                content = f"""---
{yaml.dump(pfm, default_flow_style=False, sort_keys=False).strip()}
---

# {title}

[Generated from spec - customize as needed]

## Requirements

{c}

"""
                # Write
                new_out = self.root / out.replace('dist/prompts/', 'dist/prompts-NEW/')
                new_out.parent.mkdir(parents=True, exist_ok=True)
                with open(new_out, 'w') as f:
                    f.write(content)
                print(f"✓ {out}")
                self.count += 1
            except Exception as e:
                print(f"✗ {out}: {e}")
        return self.count

# Mapping
mapping = {
    'specs/behaviors/prompts/0a-setup-workspace.spec.md': 'dist/prompts/0-define/0a-setup-workspace.md',
    'specs/behaviors/prompts/0b-define-problem.spec.md': 'dist/prompts/0-define/0b-define-problem.md',
    'specs/behaviors/prompts/0c-identify-constraints.spec.md': 'dist/prompts/0-define/0c-identify-constraints.md',
    'specs/behaviors/prompts/0d-assess-complexity.spec.md': 'dist/prompts/0-define/0d-assess-complexity.md',
    'specs/behaviors/prompts/1a-design-architecture.spec.md': 'dist/prompts/1-design/1a-design-architecture.md',
    'specs/behaviors/prompts/1b-define-behaviors.spec.md': 'dist/prompts/1-design/1b-define-behaviors.md',
    'specs/behaviors/prompts/1c-create-contracts.spec.md': 'dist/prompts/1-design/1c-create-contracts.md',
    'specs/behaviors/prompts/2a-implement-from-specs.spec.md': 'dist/prompts/2-build/2a-implement-from-specs.md',
    'specs/behaviors/prompts/2b-create-tests.spec.md': 'dist/prompts/2-build/2b-create-tests.md',
    'specs/behaviors/prompts/3a-run-validation.spec.md': 'dist/prompts/3-verify/3a-run-validation.md',
    'specs/behaviors/prompts/3b-acceptance-review.spec.md': 'dist/prompts/3-verify/3b-acceptance-review.md',
    'specs/behaviors/prompts/4a-detect-drift.spec.md': 'dist/prompts/4-evolve/4a-detect-drift.md',
    'specs/behaviors/prompts/4b-extract-specs.spec.md': 'dist/prompts/4-evolve/4b-extract-specs.md',
    'specs/behaviors/prompts/4c-sync-complete.spec.md': 'dist/prompts/4-evolve/4c-sync-complete.md',
    'specs/behaviors/prompts/4d-regenerate-agents.spec.md': 'dist/prompts/4-evolve/4d-regenerate-agents.md',
    'specs/behaviors/prompts/4e-validate-extractions.spec.md': 'dist/prompts/4-evolve/4e-validate-extractions.md',
    'specs/behaviors/prompts/analyze-failure.spec.md': 'dist/prompts/utils/analyze-failure.md',
    'specs/behaviors/prompts/next-steps.spec.md': 'dist/prompts/utils/next-steps.md',
    'specs/behaviors/prompts/run-spike.spec.md': 'dist/prompts/utils/run-spike.md',
    'specs/behaviors/prompts/utils-upgrade.spec.md': 'dist/prompts/utils/upgrade-methodology.md',
}

g = PromptGenerator('/home/chris/projects/livespec')
count = g.gen(mapping)
print(f"\n✓ Generated {count}/{len(mapping)} prompts in dist/prompts-NEW/")
GENERATOR_EOF
    chmod +x "$GENERATOR"
fi

# Run generator
echo -e "${GREEN}Executing regeneration...${NC}"
echo ""
python3 "$GENERATOR"

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${BLUE}============================================================${NC}"
    echo -e "${GREEN}✓ Generation Complete${NC}"
    echo -e "${BLUE}============================================================${NC}"
    echo ""
    echo "All prompts generated in: ${YELLOW}dist/prompts-NEW/${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Review generated prompts"
    echo "  2. Customize as needed (they're templates)"
    echo "  3. When satisfied, finalize:"
    echo ""
    echo -e "     ${BLUE}rm -rf dist/prompts/${NC}"
    echo -e "     ${BLUE}mv dist/prompts-NEW/ dist/prompts/${NC}"
    echo -e "     ${BLUE}git add dist/prompts/${NC}"
    echo -e "     ${BLUE}git commit -m 'Regenerate prompts from consolidated specs'${NC}"
    echo ""
else
    echo -e "${YELLOW}Generation had issues - check output above${NC}"
    exit 1
fi
