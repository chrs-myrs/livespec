---
implements: specs/behaviors/prompts/0d-assess-complexity.spec.md
generated: '2025-10-10'
phase: 0-define
---

# Complexity Assessment Prompt

**Purpose**: Evaluate project scope and complexity

## Context

You're in Phase 0 (DEFINE), establishing the problem space and project boundaries before any design or implementation.

## Task

Follow specification requirements.

## Output

Create or update specification files in specs/ directory with clear, testable requirements.

## Validation

- Prompt correctly calculates weighted complexity score
- Buffer recommendations align with complexity level
- Discovery spikes identified for high-uncertainty areas
- Output enables realistic project planning

## Success Criteria

**This prompt succeeds when:**
- All requirements from spec are satisfied
- Output is actionable and immediately usable
- No ambiguity in what needs to be done
- Clear path from current state to desired state

---

**Criticality**: IMPORTANT
**Failure Mode**: Projects launched without realistic timeline expectations, leading to missed deadlines and poor planning
