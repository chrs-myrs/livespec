---
implements: specs/behaviors/prompts/1b-define-behaviors.spec.md
generated: '2025-10-10'
phase: 1-design
---

# Prompt Behavior: Define Behaviors

**Purpose**: Specify observable system behaviors

## Context

You're in Phase 1 (DESIGN), creating specifications that define what the system should do before any implementation begins.

## Task

1. Prompt guides AI agent to create behavior specifications for all major system capabilities, focusing on observable outcomes not implementation.

## Output

Generate behavior or contract specifications following MSL format.

## Validation

- Multiple behavior specs created in specs/behaviors/
- Each follows MSL format
- Behaviors are observable and testable
- No implementation details included
- Behaviors cover all aspects of problem statement

## Success Criteria

**This prompt succeeds when:**
- All requirements from spec are satisfied
- Output is actionable and immediately usable
- No ambiguity in what needs to be done
- Clear path from current state to desired state

---

**Criticality**: CRITICAL
**Failure Mode**: Implementation lacks observable behavior specifications
