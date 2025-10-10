---
derives-from:
  - specs/strategy/architecture.spec.md
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
specifies:
  - prompts/utils/generate-internalise-learnings.md
criticality: IMPORTANT
failure_mode: Without generator, projects create generic learning-capture prompts that don't guide spec updates appropriately
---

# Generate Internalise Learnings Prompt

## Requirements
- [!] LiveSpec provides generator prompt that creates customized internalise-learnings.md tailored to project's specification structure, enabling conversation-specific learning capture and spec updates.
  - Generator reads spec hierarchy (PURPOSE.md → mission/ → strategy/ → workspace/ → behaviors/)
  - Generator uses template from dist/templates/utils/internalise-learnings.md.template
  - Generated prompt written to prompts/generated/internalise-learnings.md
  - Generated prompt includes ultrathink for pattern recognition (graceful degradation if unsupported)
  - Customization based on:
    - specs/workspace/constitution.spec.md (what principles to reinforce)
    - specs/workspace/patterns.spec.md (what conventions to validate)
    - specs/workspace/workflows.spec.md (how to update specs)
    - Existing specs/ structure (where to document learnings)
  - Generated prompt guides updates to appropriate spec locations
  - Learning classification adapted to project's spec taxonomy
  - Generator prompts user before overwriting existing internalise-learnings.md
  - Generated prompt includes generation metadata (timestamp, sources)

## Validation
- Generator reads all required specs successfully
- Template customization reflects project's spec structure
- Generated prompt maps learnings to correct spec locations (workspace/ vs behaviors/ vs strategy/)
- Generated ultrathink block references actual conversation context
- Generation fails gracefully if required specs missing
- User prompted before overwriting existing prompts
