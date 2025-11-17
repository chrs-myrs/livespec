---
derives-from:
  - specs/2-strategy/architecture.spec.md
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
specifies:
  - prompts/utils/generate-self-improvement.md
criticality: IMPORTANT
failure_mode: Without generator, projects create generic self-improvement prompts that don't adapt to project specifics
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
guided-by:
  - specs/2-strategy/phase-workflow.spec.md
---

# Generate Self-Improvement Prompt

## Requirements
- [!] LiveSpec provides generator prompt that creates customized self-improve.md tailored to project's PURPOSE, principles, and constraints, enabling project-specific systematic improvement analysis.
  - Generator reads spec hierarchy top-down (PURPOSE.md → mission/ → strategy/ → workspace/)
  - Generator uses template from dist/templates/utils/self-improve.md.template
  - Generated prompt written to prompts/generated/self-improve.md
  - Generated prompt includes ultrathink for deep analysis (graceful degradation if unsupported)
  - Customization based on:
    - PURPOSE.md (project vision and success criteria)
    - specs/1-requirements/strategic/outcomes.spec.md (what must be achieved)
    - specs/1-requirements/strategic/constraints.spec.md (hard boundaries)
    - specs/workspace/constitution.spec.md (core principles)
    - specs/workspace/patterns.spec.md (conventions)
  - Generated prompt focuses on project's stated priorities
  - Analysis framework adapted to detected domain (software/governance/ops/planning)
  - Generator prompts user before overwriting existing self-improve.md
  - Generated prompt includes generation metadata (timestamp, sources)

## Validation
- Generator reads all required specs successfully
- Template customization reflects project specifics (not generic)
- Generated prompt includes project-specific analysis sections
- Generated ultrathink block references actual project context
- Generation fails gracefully if required specs missing
- User prompted before overwriting existing prompts
