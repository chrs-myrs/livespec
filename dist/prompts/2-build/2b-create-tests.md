---
implements: specs/3-behaviors/prompts/2b-create-tests.spec.md
generated: '2025-10-10'
phase: 2-build
estimated_time: "30-60 minutes per feature"
---

# Prompt Behavior: Create Tests

**Purpose**: Create tests that validate specifications

## Context

You're in Phase 2 (BUILD), implementing features based on existing specifications. All behaviors should already be specified.

## Before This Prompt

⚠️ **STOP: Verify specifications exist before creating tests. Tests without specs test the wrong thing.**

**Check these artifacts exist:**
- [ ] `specs/3-behaviors/` directory with behavior specs - What to test
- [ ] `specs/workspace/workflows.spec.md` - Testing approach and patterns

**If ANY is missing → STOP:**
- Missing specs/3-behaviors/ → "Use `.livespec/1-design/1b-define-behaviors.md` to create behavior specs first"
- Missing workspace workflows → "Use `.livespec/0-define/0a-setup-workspace.md` to define testing patterns first"

**Only proceed when specifications exist.** Tests validate specs - can't test without them.

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
