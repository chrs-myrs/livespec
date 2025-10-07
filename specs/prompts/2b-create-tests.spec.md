---
specifies: prompts/2-build/2b-create-tests.md
criticality: CRITICAL
failure_mode: Specifications cannot be validated
constrained_by:
  - .livespec/specs/metaspecs/behavior.spec.md
---

# Prompt Behavior: Create Tests

## Requirements
- [!] Prompt guides AI agent to create tests that validate all behavior specifications, with test names and assertions mapping directly to validation criteria.
  - All CRITICAL behaviors have passing tests
  - All contracts validated by tests
  - All constraints verified by tests
  - Test names map to specification language
  - Tests serve as executable documentation

## Prompt Outputs

- Test files validating all CRITICAL behaviors
- Test files validating contracts
- Test files validating constraints

## Validation

- All CRITICAL behaviors have passing tests
- All contracts validated by tests
- All constraints verified by tests
- Test names map to specification language
- Tests serve as executable documentation
