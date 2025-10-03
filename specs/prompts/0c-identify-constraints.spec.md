---
specifies: prompts/0-define/0c-identify-constraints.md
---

# Prompt Behavior: Identify Constraints

**Criticality**: CRITICAL
**Failure Mode**: Projects violate boundaries that should have been identified upfront

## Specification

Prompt guides AI agent to document hard constraints (technical, business, domain) that cannot be negotiated, distinguishing real constraints from preferences and goals.

## Prompt Outputs

- `specs/constraints.spec.md` - Non-negotiable project boundaries following MSL format

## Validation

- Prompt produces constraints.spec.md file
- All constraints follow MSL format
- Each constraint has concrete validation criteria
- Constraints are real boundaries (not goals or preferences)
- No design decisions disguised as constraints
- Each constraint would cause project failure if violated
