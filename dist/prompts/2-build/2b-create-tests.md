---
implements: specs/behaviors/prompts/2b-create-tests.spec.md
generated: '2025-10-10'
phase: 2-build
---

# Prompt Behavior: Create Tests

**Purpose**: Create tests that validate specifications

## Context

You're in Phase 2 (BUILD), implementing features based on existing specifications. All behaviors should already be specified.

## Task

1. Prompt guides AI agent to create tests that validate all behavior specifications, with test names and assertions mapping directly to validation criteria.

## Output

Produce working code or tests that satisfy specifications.

## Validation

- All CRITICAL behaviors have passing tests
- All contracts validated by tests
- All constraints verified by tests
- Test names map to specification language
- Tests serve as executable documentation

## Success Criteria

**This prompt succeeds when:**
- All requirements from spec are satisfied
- Output is actionable and immediately usable
- No ambiguity in what needs to be done
- Clear path from current state to desired state

---

**Criticality**: CRITICAL
**Failure Mode**: Specifications cannot be validated
