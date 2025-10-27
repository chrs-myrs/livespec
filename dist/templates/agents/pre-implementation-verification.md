## ⚠️ CRITICAL: Pre-Implementation Verification

Before implementing ANY deliverable (code, prompt, template, documentation, config), verify:

1. ☐ **Behavior spec exists** for this deliverable
   - Check: `specs/3-behaviors/[deliverable].spec.md` exists
   - Spec has Requirements section with [!] items
   - Spec has Validation criteria
   - Spec has Failure Mode defined

2. ☐ **Tests exist** (if TDD project) and currently FAIL (RED)
   - Check: `tests/behaviors/[deliverable].test.ts` exists
   - Tests map to validation criteria (one test per criterion)
   - Tests currently fail (no implementation yet)

3. ☐ **Plan includes methodology steps** (not just implementation)
   - Plan includes spec creation (specific file path)
   - Plan includes test creation if TDD (specific file path)
   - Plan includes TDD cycle if applicable (RED → GREEN → REFACTOR)

**If any checkbox is unchecked → STOP**

Guide user to Phase 1 (DESIGN):
- For behaviors: "Use `.livespec/1-design/1b-define-behaviors.md`"
- For contracts: "Use `.livespec/1-design/1c-create-contracts.md`"
- For architecture/strategy: "Use `.livespec/1-design/1a-design-architecture.md`"
