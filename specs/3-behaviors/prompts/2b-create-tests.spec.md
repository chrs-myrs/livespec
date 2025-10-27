---
specifies: prompts/2-build/2b-create-tests.md
criticality: CRITICAL
failure_mode: Specifications cannot be validated
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/functional/five-phases.spec.md
guided-by:
  - specs/2-strategy/phase-workflow.spec.md
---

# Prompt Behavior: Create Tests

## Requirements
- [!] Prompt actively verifies Phase 0 and Phase 1 prerequisites before proceeding, preventing premature test creation.
  - Checks specs/3-behaviors/ exists with behavior specs (if missing → guide to 1b-define-behaviors)
  - Checks specs/workspace/workflows.spec.md exists (if missing → guide to 0a-setup-workspace)
  - STOPS execution if any prerequisite missing
  - Outputs clear guidance to missing Phase 0/1 prompts

- [!] Prompt guides AI agent to create tests that validate all behavior specifications, with test names and assertions mapping directly to validation criteria.
  - Produces test files in test directory (format: follows workspace testing patterns, one test per validation criterion)
  - All CRITICAL behaviors have tests
  - All contracts validated by tests
  - All constraints verified by tests
  - Test names map to specification language (traceability)
  - Tests serve as executable documentation

## Context

Use when:
- After specifications defined (behaviors, contracts, constraints exist)
- Before or during implementation (TDD) or after implementation (validation)
- Need executable validation of specifications
- Need regression protection

## Prerequisites

- specs/3-behaviors/ exists (defines testable behaviors)
- specs/3-contracts/ exists if applicable (API/data contracts to validate)
- specs/1-requirements/strategic/constraints.spec.md exists (boundaries to verify)
- specs/workspace/workflows.spec.md defines testing approach (TDD, test-after, etc.)
- Test framework available (per workspace patterns)
- Agent understands project testing conventions

## Outputs

- Test files for CRITICAL behaviors (format: follows workspace test patterns, test names match spec language, assertions verify validation criteria)
  - Example: `tests/behaviors/authentication.test.ts` validates `specs/3-behaviors/authentication.spec.md`
- Test files for contracts (format: contract validation tests, schema validation, API compliance)
  - Example: `tests/contracts/api/users-api.test.ts` validates `specs/3-contracts/api/users.yaml`
- Test files for constraints (format: boundary verification tests)
  - Example: `tests/constraints/performance.test.ts` validates performance constraints

## Validation

- All CRITICAL behaviors have corresponding tests
- All contracts have validation tests
- All constraints have verification tests
- Test names map to specification validation criteria (1:1 traceability)
- Tests pass when implementation satisfies specifications
- Tests fail when implementation violates specifications
- Tests serve as executable documentation (readable, clear intent)

## Success Criteria

- Complete coverage (all CRITICAL specs have tests)
- Traceability clear (can map test to spec criterion)
- Tests reliable (no flakiness, deterministic)
- Tests maintainable (clear, follows patterns)
- Tests executable documentation (readable by humans)

## Error Handling

**If specification lacks validation criteria:**
- Cannot create test without testable criteria
- Guide to update spec with validation criteria
- Explain tests require observable, verifiable criteria

**If testing approach undefined:**
- Guide to specs/workspace/workflows.spec.md
- Request testing approach definition (TDD, test-after, patterns)
- Cannot create tests without HOW guidance

**If contract format unsupported:**
- Request contract validation tool recommendation
- Common tools: OpenAPI validator, JSON Schema validator, AsyncAPI validator
- Cannot validate contract without appropriate tooling

**If constraint unverifiable:**
- Report constraint as untestable
- Suggest making constraint verifiable (add measurable criteria)
- Document limitation

## Constraints

What this prompt should NOT do:
- ❌ Test implementation details (test observable behaviors only)
- ❌ Skip CRITICAL behaviors (all must have tests)
- ❌ Create tests without spec traceability (must map to validation criteria)
- ❌ Write brittle tests (avoid implementation coupling)
- ❌ Skip contract validation (all external interfaces must be validated)
