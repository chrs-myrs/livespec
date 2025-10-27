---
implements: specs/3-behaviors/prompts/3a-run-validation.spec.md
generated: '2025-10-10'
phase: 3-verify
estimated_time: "15-30 minutes"
---

# Prompt Behavior: Run Validation

**Purpose**: Verify implementation matches specifications

## Context

You're in Phase 3 (VERIFY), validating that implementation matches specifications and meets requirements.

## Before This Prompt

⚠️ **STOP: Verify Phase 2 prerequisites. Cannot validate without implementation and tests.**

**Check these exist:**
- [ ] Implementation code exists (actual code files)
- [ ] Tests exist (test files corresponding to behaviors)
- [ ] `specs/3-behaviors/` directory - Specifications to validate against

**If ANY is missing → STOP:**
- Missing implementation → "Use `.livespec/2-build/2a-implement-from-specs.md` to implement first"
- Missing tests → "Use `.livespec/2-build/2b-create-tests.md` to create tests first"
- Missing specs → "Use `.livespec/1-design/1b-define-behaviors.md` - need specs to validate"

**Only proceed when implementation and tests exist.** Validation requires something to validate.

## Task

1. Prompt guides AI agent to run comprehensive validation (tests, contract validation, constraint verification) and produce validation report.

## Output

Generate validation report showing spec compliance.

## Validation

- All tests executed
- All CRITICAL behaviors validated
- All contracts verified
- All constraints satisfied
- Report clearly shows pass/fail status

## Success Criteria

**This prompt succeeds when:**
- All requirements from spec are satisfied
- Output is actionable and immediately usable
- No ambiguity in what needs to be done
- Clear path from current state to desired state

---

**Criticality**: CRITICAL
**Failure Mode**: Cannot verify specifications are met
