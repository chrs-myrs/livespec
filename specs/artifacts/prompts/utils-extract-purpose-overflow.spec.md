---
criticality: IMPORTANT
failure_mode: Existing projects cannot migrate oversized PURPOSE.md files without guidance
specifies: dist/prompts/utils/extract-purpose-overflow.md
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
---

# Extract PURPOSE Overflow Prompt

## Requirements
- [!] Prompt guides extraction of oversized PURPOSE.md content to appropriate specs.
  - Validates current PURPOSE.md state using `scripts/validate-purpose.sh`
  - Categorizes content by type (constraints, outcomes, architecture, behaviors, workflows)
  - Routes content to correct spec locations
  - Creates target specs if missing (with proper MSL format)
  - Trims PURPOSE.md to <20 content lines
  - Maintains traceability via derives-from references
  - Validates final result passes PURPOSE boundary checks

## Notes

This is a migration utility for existing projects. New projects should use active content routing at capture time (in 0c-define-problem.md) rather than extracting after accumulation.

Target state after extraction:
- PURPOSE.md: Vision only (<20 lines, 2 sections)
- specs/foundation/: Constraints and outcomes
- specs/strategy/: Technical decisions
- specs/features/: Observable system behaviors
- specs/workspace/: Processes and principles
