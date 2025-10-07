---
specifies: prompts/utils/run-spike.md
criticality: IMPORTANT
failure_mode: Projects proceed with critical unknowns, leading to late-stage redesigns or failures
constrained_by:
  - livespec-standard/metaspecs/behavior.spec.md
---

# Discovery Spike Prompt

## Requirements
- Prompt guides time-boxed exploration to answer specific technical questions through minimal prototyping, aggressive testing, and documentation of findings without creating production code.
  - Spike stays within time box
  - Specific questions answered with data/evidence
  - Findings documented before code discarded
  - Learnings inform subsequent specifications
  - Spike code not used in production

## Outputs

- `specs/spikes/[name]-spike.md` containing:
  - Clear answer to original question
  - What worked and what failed
  - Measurements and observations
  - Recommendations for specs and implementation
  - Follow-up questions discovered

## Validation

- Spike stays within time box
- Specific questions answered with data/evidence
- Findings documented before code discarded
- Learnings inform subsequent specifications
- Spike code not used in production
