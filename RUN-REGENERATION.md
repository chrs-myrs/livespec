# Prompt Regeneration - How to Run

## Quick Start

```bash
cd /home/chris/projects/livespec
chmod +x regenerate-all-prompts.sh
./regenerate-all-prompts.sh
```

## What Gets Generated

21 prompts will be regenerated from their corresponding specs:

### Phase 0 (DEFINE) - 4 prompts
- 0a-setup-workspace.md
- 0b-define-problem.md
- 0c-identify-constraints.md
- 0d-assess-complexity.md

### Phase 1 (DESIGN) - 3 prompts
- 1a-design-architecture.md
- 1b-define-behaviors.md
- 1c-create-contracts.md

### Phase 2 (BUILD) - 2 prompts
- 2a-implement-from-specs.md
- 2b-create-tests.md

### Phase 3 (VERIFY) - 2 prompts
- 3a-run-validation.md
- 3b-acceptance-review.md

### Phase 4 (EVOLVE) - 5 prompts
- 4a-detect-drift.md
- 4b-extract-specs.md
- 4c-sync-complete.md
- 4d-regenerate-agents.md
- 4e-validate-extractions.md

### Utils - 4 prompts
- analyze-failure.md
- next-steps.md
- run-spike.md
- upgrade-methodology.md

## Output Location

Prompts are generated to `dist/prompts-NEW/` to avoid conflicts.

## Finalization

After reviewing generated prompts:

```bash
rm -rf dist/prompts/
mv dist/prompts-NEW/ dist/prompts/
git add dist/prompts/
git commit -m "Regenerate all prompts from consolidated specs"
```

## Files Created

1. `regenerate-all-prompts.sh` - Main orchestrator
2. `.tmp/full_regeneration.py` - Python generator
3. `dist/prompts-NEW/` - Output directory with new prompts

## Customization

Generated prompts are templates. Customize:
- Purpose statements
- Context sections
- Task instructions
- Output specifications
- Validation criteria

Follow MSL minimalism - keep prompts actionable, not verbose.
