---
implements: specs/behaviors/prompts/0c-identify-constraints.spec.md
generated: '2025-10-10'
phase: 0-define
---

# Prompt Behavior: Identify Constraints

**Purpose**: Define hard boundaries and limitations

## Context

You're in Phase 0 (DEFINE), establishing the problem space and project boundaries before any design or implementation.

## Task

1. Prompt guides AI agent to document hard constraints (technical, business, domain) that cannot be negotiated, distinguishing real constraints from preferences and goals.

## Output

Create or update specification files in specs/ directory with clear, testable requirements.

## Validation

- Prompt produces constraints.spec.md file
- All constraints follow MSL format
- Each constraint has concrete validation criteria
- Constraints are real boundaries (not goals or preferences)
- No design decisions disguised as constraints
- Each constraint would cause project failure if violated

## Success Criteria

**This prompt succeeds when:**
- All requirements from spec are satisfied
- Output is actionable and immediately usable
- No ambiguity in what needs to be done
- Clear path from current state to desired state

---

**Criticality**: CRITICAL
**Failure Mode**: Projects violate boundaries that should have been identified upfront
