---
specifies: prompts/utils/run-spike.md
---

# Discovery Spike Prompt

**Criticality**: IMPORTANT
**Failure Mode**: Projects proceed with critical unknowns, leading to late-stage redesigns or failures

## Specification

Prompt guides time-boxed exploration to answer specific technical questions through minimal prototyping, aggressive testing, and documentation of findings without creating production code.

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
