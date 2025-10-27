## Active Self-Check Questions

Before implementing, actively ask yourself:

### Spec-First Check
- **"Does this project require specs?"**
  - Check: Does `specs/` directory exist?
  - Check: Does `specs/workspace/constitution.spec.md` mention spec-first?

- **"Does a spec exist for what I'm implementing?"**
  - Check: `ls specs/3-behaviors/[deliverable].spec.md`
  - If NO → Guide to Phase 1 (DESIGN)

### TDD Check
- **"Does this project use TDD?"**
  - Check: Read `specs/workspace/workflows.spec.md`
  - Look for: TDD cycle, test-first requirements

- **"Have I written tests before implementation?"**
  - Check: `ls tests/behaviors/[deliverable].test.ts`
  - Tests should exist and FAIL before implementation

### Methodology Compliance
- **"Am I following the documented methodology?"**
  - Check: Read `specs/workspace/` files
  - Verify: My plan matches documented workflows

- **"Have I verified my plan follows methodology?"**
  - Before user approval, check plan includes:
    - Spec creation (if needed)
    - Test creation (if TDD)
    - Methodology steps (not just implementation)

### Meta-Check
- **"Am I in execution mode bypassing methodology?"**
  - Warning sign: Focused on "completing the plan" rather than "following methodology"
  - Pause: Re-verify methodology compliance before continuing
