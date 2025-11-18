---
guided-by:
  - specs/workspace/constitution.spec.md
criticality: CRITICAL
failure_mode: Without TDD discipline, LiveSpec code lacks test coverage, making refactoring risky and preventing confidence in changes
---

# LiveSpec Testing Approach (TDD)

## Requirements
- [!] LiveSpec development follows Test-Driven Development (TDD) discipline where automated tests are written before implementation code, following Red-Green-Refactor cycle for all non-trivial code.
  - Phase 2 (BUILD) follows TDD workflow
  - Tests written BEFORE implementation code (test-first development)
  - Red-Green-Refactor cycle: Write failing test → Make it pass → Improve design
  - Automated tests required for all non-trivial code (unit, integration, behavior validation)
  - Escape hatch available for trivial scripts (justification required, documented in implementation)
  - Tests map directly to behavior specs (specs/3-behaviors/ → tests → implementation)
  - TDD ensures correctness, enables refactoring, prevents regression
  - Complete TDD workflow documented in .livespec/guides/tdd.md

## TDD Discipline

### Red-Green-Refactor Cycle

**RED (Write Failing Test)**:
1. Read behavior spec (specs/3-behaviors/*.spec.md)
2. Identify testable criteria from spec
3. Write test that fails (behavior not yet implemented)
4. Run test to confirm failure
5. Verify test fails for right reason (not syntax error)

**GREEN (Make Test Pass)**:
1. Write minimal code to make test pass
2. Don't optimize yet (that's Refactor)
3. Run test to confirm it passes
4. All tests must pass (including existing tests)

**REFACTOR (Improve Design)**:
1. Look for duplication, unclear names, poor structure
2. Improve code while keeping tests passing
3. Run tests after each refactor
4. Stop when design is clean

### When TDD Applies

**TDD required for:**
- Bash scripts that validate behaviors (tests/, scripts/)
- Node.js/TypeScript code (if LiveSpec adds programmatic tools)
- Complex prompt logic (if prompts include conditional behavior)
- Data transformations (parsing, generation, extraction)

**Escape hatch for trivial scripts:**
- Simple file copies (cp, mv)
- Basic directory creation (mkdir -p)
- Symlink creation (ln -s)
- One-liner utilities

**Justification required when skipping TDD:**
- Document in implementation comment: "TDD skipped: [reason]"
- Reason must be: trivial operation, no logic, no failure modes
- If in doubt, write the test

## Test-Spec-Implementation Traceability

### Mapping Pattern

```
specs/3-behaviors/folder-structure.spec.md
  ↓ defines observable behaviors
tests/prompts/test_folder_structure.sh
  ↓ validates implementation
scripts/setup-workspace.sh (or other implementation)
```

### Example

**Spec** (specs/3-behaviors/folder-structure.spec.md):
```markdown
## Requirements
- [!] Workspace contains required folders
  - specs/workspace/ exists
  - specs/1-requirements/ exists
  - specs/2-strategy/ exists
```

**Test** (tests/prompts/test_folder_structure.sh):
```bash
# Validates: specs/workspace/ exists
[ -d "specs/workspace" ] || echo "FAIL: Missing specs/workspace/"

# Validates: specs/1-requirements/ exists
[ -d "specs/1-requirements" ] || echo "FAIL: Missing specs/1-requirements/"
```

**Implementation** (scripts/setup-workspace.sh):
```bash
mkdir -p specs/workspace
mkdir -p specs/1-requirements
mkdir -p specs/2-strategy
```

## Benefits of TDD for LiveSpec

### Correctness
- Tests prove behavior specs are satisfied
- Catch mistakes before they reach users
- Validate methodology actually works

### Refactoring Confidence
- Change implementation without fear
- Tests prove behavior unchanged
- Evolve architecture safely

### Regression Prevention
- Old behaviors stay working
- New changes don't break existing functionality
- Continuous validation of methodology

### Documentation
- Tests show how to use functionality
- Executable examples (better than comments)
- Living documentation of expected behavior

## Relationship to Validation Strategy

**TDD (this spec)** = Development discipline
- Write tests before code
- Applied during implementation (Phase 2)
- Ensures new code is tested

**Validation (specs/2-strategy/validation.spec.md)** = Continuous verification
- Tests run continuously
- Applied during maintenance (Phase 4)
- Ensures existing code stays compliant

**Complementary approaches:**
- TDD creates tests during development
- Validation runs tests continuously
- Together: comprehensive quality assurance

## Implementation Benefits

- **Code quality**: TDD forces testable design (less coupling, clearer interfaces)
- **Developer confidence**: Tests prove code works
- **Faster debugging**: Failing test pinpoints problem
- **Better design**: Test-first reveals design issues early

## Strategic Benefits

- **Reliability**: Users trust LiveSpec works correctly
- **Maintainability**: Can refactor without breaking changes
- **Dogfooding validation**: Proves LiveSpec methodology works (uses own Phase 2 workflow)
- **Adoption driver**: Users see LiveSpec developers follow own methodology

## Validation

- TDD discipline documented as Principle #3 in constitution
- Red-Green-Refactor cycle defined
- Test-Spec-Implementation traceability pattern specified
- Escape hatch rules clear (trivial only, justification required)
- Relationship to validation.spec.md explained
- Complete workflow available in .livespec/guides/tdd.md
