#!/usr/bin/env python3
"""
Regenerate all LiveSpec prompts from their behavior specs.
"""

import os
import yaml
from pathlib import Path
from datetime import datetime

# Mapping of spec files to output prompt files
PROMPT_MAPPING = {
    # Phase 0 - DEFINE
    'specs/behaviors/prompts/0a-setup-workspace.spec.md': 'dist/prompts/0-define/0a-setup-workspace.md',
    'specs/behaviors/prompts/0b-define-problem.spec.md': 'dist/prompts/0-define/0b-define-problem.md',
    'specs/behaviors/prompts/0c-identify-constraints.spec.md': 'dist/prompts/0-define/0c-identify-constraints.md',
    'specs/behaviors/prompts/0d-assess-complexity.spec.md': 'dist/prompts/0-define/0d-assess-complexity.md',

    # Phase 1 - DESIGN
    'specs/behaviors/prompts/1a-design-architecture.spec.md': 'dist/prompts/1-design/1a-design-architecture.md',
    'specs/behaviors/prompts/1b-define-behaviors.spec.md': 'dist/prompts/1-design/1b-define-behaviors.md',
    'specs/behaviors/prompts/1c-create-contracts.spec.md': 'dist/prompts/1-design/1c-create-contracts.md',

    # Phase 2 - BUILD
    'specs/behaviors/prompts/2a-implement-from-specs.spec.md': 'dist/prompts/2-build/2a-implement-from-specs.md',
    'specs/behaviors/prompts/2b-create-tests.spec.md': 'dist/prompts/2-build/2b-create-tests.md',

    # Phase 3 - VERIFY
    'specs/behaviors/prompts/3a-run-validation.spec.md': 'dist/prompts/3-verify/3a-run-validation.md',
    'specs/behaviors/prompts/3b-acceptance-review.spec.md': 'dist/prompts/3-verify/3b-acceptance-review.md',

    # Phase 4 - EVOLVE
    'specs/behaviors/prompts/4a-detect-drift.spec.md': 'dist/prompts/4-evolve/4a-detect-drift.md',
    'specs/behaviors/prompts/4b-extract-specs.spec.md': 'dist/prompts/4-evolve/4b-extract-specs.md',
    'specs/behaviors/prompts/4c-sync-complete.spec.md': 'dist/prompts/4-evolve/4c-sync-complete.md',
    'specs/behaviors/prompts/4d-regenerate-agents.spec.md': 'dist/prompts/4-evolve/4d-regenerate-agents.md',
    'specs/behaviors/prompts/4e-validate-extractions.spec.md': 'dist/prompts/4-evolve/4e-validate-extractions.md',

    # Utils
    'specs/behaviors/prompts/analyze-failure.spec.md': 'dist/prompts/utils/analyze-failure.md',
    'specs/behaviors/prompts/next-steps.spec.md': 'dist/prompts/utils/next-steps.md',
    'specs/behaviors/prompts/run-spike.spec.md': 'dist/prompts/utils/run-spike.md',
    'specs/behaviors/prompts/utils-upgrade.spec.md': 'dist/prompts/utils/upgrade-methodology.md',
}

def read_spec(spec_path):
    """Read spec file and extract key information."""
    with open(spec_path, 'r') as f:
        content = f.read()

    # Parse frontmatter if exists
    frontmatter = {}
    if content.startswith('---'):
        parts = content.split('---', 2)
        if len(parts) >= 3:
            frontmatter = yaml.safe_load(parts[1])
            content = parts[2]

    return frontmatter, content

def extract_phase(output_path):
    """Extract phase from output path."""
    parts = output_path.split('/')
    if 'utils' in parts:
        return 'utils'
    for part in parts:
        if part.startswith('0-') or part.startswith('1-') or part.startswith('2-') or part.startswith('3-') or part.startswith('4-'):
            return part
    return None

def generate_prompt(spec_path, output_path):
    """Generate prompt from spec file."""

    frontmatter, spec_content = read_spec(spec_path)
    phase = extract_phase(output_path)

    # Get relative spec path from project root
    rel_spec_path = spec_path

    # Build prompt frontmatter
    prompt_frontmatter = {
        'spec': rel_spec_path,
        'generated': datetime.now().strftime('%Y-%m-%d')
    }
    if phase and phase != 'utils':
        prompt_frontmatter['phase'] = phase

    # Generate prompt content based on spec
    # This is a simplified template - you'll enhance based on spec content

    frontmatter_yaml = yaml.dump(prompt_frontmatter, default_flow_style=False, sort_keys=False)

    prompt = f"""---
{frontmatter_yaml.strip()}
---

# [Prompt Title from Spec]

**Purpose**: [Extract from spec]

## Context

[Background information]

## Task

[Main instructions from spec requirements]

## Output

[Expected deliverables]

## Validation

[Success criteria from spec]
"""

    return prompt

def main():
    """Regenerate all prompts."""
    project_root = Path(__file__).parent

    print(f"LiveSpec Prompt Regeneration")
    print(f"{'='*60}")
    print(f"Project root: {project_root}")
    print(f"Prompts to generate: {len(PROMPT_MAPPING)}")
    print()

    generated = 0
    errors = []

    for spec_path, output_path in PROMPT_MAPPING.items():
        spec_full = project_root / spec_path
        output_full = project_root / output_path

        if not spec_full.exists():
            errors.append(f"Spec not found: {spec_path}")
            continue

        try:
            # Create output directory
            output_full.parent.mkdir(parents=True, exist_ok=True)

            # Generate prompt
            prompt_content = generate_prompt(spec_path, output_path)

            # Write prompt
            with open(output_full, 'w') as f:
                f.write(prompt_content)

            print(f"✓ Generated: {output_path}")
            generated += 1

        except Exception as e:
            errors.append(f"Error generating {output_path}: {e}")

    print()
    print(f"{'='*60}")
    print(f"Generated: {generated}/{len(PROMPT_MAPPING)}")

    if errors:
        print(f"\nErrors:")
        for error in errors:
            print(f"  ✗ {error}")
        return 1

    print(f"\n✓ All prompts regenerated successfully")
    return 0

if __name__ == '__main__':
    exit(main())
