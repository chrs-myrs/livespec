---
criticality: IMPORTANT
failure_mode: Inconsistent naming makes LiveSpec projects harder to understand and navigate
governed-by:
  - .livespec/standard/metaspecs/base.spec.md
---

# Naming Convention

## Requirements
- LiveSpec projects follow strict naming patterns for specifications and prompts.
  - All specifications use `.spec.md` extension (required)
  - Specification filenames use kebab-case (e.g., `user-authentication.spec.md`)
  - Prompt filenames follow pattern `[0-4][a-z]-descriptive-name.md`
  - Phase prefix: 0-4 (DEFINE, DESIGN, BUILD, VERIFY, EVOLVE)
  - Letter suffix: sequential within phase (a, b, c, d, e)
  - Prompt examples: `0a-setup-workspace.md`, `1b-define-behaviors.md`, `4d-regenerate-agents.md`
  - Specification filenames describe content clearly (no abbreviations unless standard)
  - One behavior per spec file (filename matches behavior)
  - User documentation uses British English (synchronisation, behaviour, organise)
  - Code elements use American English (synchronize, behavior, organize)

## Examples

**Good specification names:**
- ✅ `user-authentication.spec.md`
- ✅ `api-versioning.spec.md`
- ✅ `drift-detection.spec.md`

**Bad specification names:**
- ❌ `auth.spec.md` (unclear abbreviation)
- ❌ `UserAuthentication.spec.md` (PascalCase not kebab-case)
- ❌ `user_authentication.spec.md` (snake_case not kebab-case)
- ❌ `spec-user-auth.md` (wrong extension)

**Good prompt names:**
- ✅ `0a-setup-workspace.md` (Phase 0, first prompt)
- ✅ `1b-define-behaviors.md` (Phase 1, second prompt)
- ✅ `4d-regenerate-agents.md` (Phase 4, fourth prompt)

**Bad prompt names:**
- ❌ `setup-workspace.md` (missing phase prefix)
- ❌ `0-setup-workspace.md` (missing letter suffix)
- ❌ `0a_setup_workspace.md` (underscore not hyphen)

## Notes

**Phase numbers:**
- 0 = DEFINE (problem, constraints, workspace)
- 1 = DESIGN (architecture, behaviors, contracts)
- 2 = BUILD (implementation, tests)
- 3 = VERIFY (validation, acceptance)
- 4 = EVOLVE (drift detection, spec extraction, sync)

**Letter suffixes** indicate execution order within phase. Start with 'a', continue sequentially.

**.spec.md extension** enables:
- Easy identification of specifications
- Tool automation (find all specs with `find . -name "*.spec.md"`)
- Clear distinction from regular markdown documentation
