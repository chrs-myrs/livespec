---
specifies: prompts/3-verify/3a-run-validation.md
criticality: CRITICAL
failure_mode: Cannot verify specifications are met
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/functional/five-phases.spec.md
guided-by:
  - specs/2-strategy/phase-workflow.spec.md
  - specs/2-strategy/validation.spec.md
---

# Prompt Behavior: Run Validation

## Requirements
- [!] Prompt actively verifies Phase 2 prerequisites before proceeding, preventing validation without implementation.
  - Checks implementation exists (code files present)
  - Checks tests exist (if missing → guide to 2b-create-tests)
  - Checks specs/3-behaviors/ exists (if missing → guide to 1b-define-behaviors)
  - STOPS execution if any prerequisite missing
  - Outputs clear guidance to missing Phase 0/1/2 prompts

- [!] Prompt guides AI agent to run comprehensive validation (tests, contract validation, constraint verification) and produce validation report.
  - Produces validation report (format: markdown with test results, contract compliance, constraint satisfaction, issues by severity)
  - All tests executed (unit, integration, contract, constraint tests)
  - All CRITICAL behaviors validated
  - All contracts verified against specifications
  - All constraints satisfied
  - Report clearly shows pass/fail status with evidence

## Context

Use when:
- After implementation complete (Phase 2 done)
- Before release/deployment
- Need comprehensive validation of all specifications
- Periodic validation checks (CI/CD, before merges)

## Prerequisites

- Implementation exists (code complete)
- Tests exist (created in Phase 2b or during implementation)
- specs/3-behaviors/ exists (behaviors to validate)
- specs/3-contracts/ exists if applicable (contracts to verify)
- specs/1-requirements/strategic/constraints.spec.md exists (constraints to check)
- Test framework configured and runnable

## Outputs

- Validation report (format: markdown with sections for each validation type, pass/fail status, evidence, issues):
  - Test execution results (all tests run, pass/fail counts, failures detailed)
  - Behavior validation (CRITICAL behaviors verified, evidence of satisfaction)
  - Contract compliance (all contracts validated, schema/API compliance confirmed)
  - Constraint satisfaction (all constraints checked, boundaries respected)
  - Issues summary (grouped by severity: blocker, critical, important)

## Validation

- All tests executed (none skipped unless documented reason)
- All CRITICAL behaviors validated (with evidence)
- All contracts verified (using contract validators)
- All constraints satisfied (with verification evidence)
- Report clearly shows pass/fail status for each validation type
- Failures include actionable details (what failed, why, how to fix)
- Report traceable to specifications (can map failures to specs)

## Success Criteria

- Comprehensive coverage (all validation types executed)
- Clear results (pass/fail immediately obvious)
- Actionable failures (enough detail to fix issues)
- Traceable to specs (can identify which spec failed)
- Automated (repeatable without manual steps)

## Error Handling

**If tests fail to execute:**
- Report test framework issues
- Document environment problems
- Cannot proceed until tests runnable

**If CRITICAL behavior unvalidated:**
- Mark validation as FAILED
- Document which behavior unverified
- Cannot release until CRITICAL validated

**If contract validation fails:**
- Report specific contract violations
- Document API/schema mismatches
- Provide examples of non-compliance

**If constraint violated:**
- Mark validation as BLOCKED
- Report which constraint violated
- Explain impact and required fix

## Constraints

What this prompt should NOT do:
- ❌ Skip failing tests (all failures must be reported)
- ❌ Pass validation with CRITICAL failures (non-negotiable)
- ❌ Ignore constraint violations (boundaries are hard limits)
- ❌ Provide vague failure reports (must be actionable)
- ❌ Validate against outdated specs (ensure specs current)
