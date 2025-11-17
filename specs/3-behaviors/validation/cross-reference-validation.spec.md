---
criticality: IMPORTANT
failure_mode: Broken cross-references cause spec/doc drift, lost traceability, and methodology violations
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
satisfies:
  - specs/1-requirements/functional/drift-detection.spec.md
guided-by:
  - specs/2-strategy/validation.spec.md
  - specs/2-strategy/dogfooding.spec.md
---

# Cross-Reference Validation

## Requirements

- [!] System validates all cross-references between specifications, documentation, and implementation files to ensure relationship integrity.
  - All frontmatter references validated (implements:, derives-from:, governed-by:, satisfies:, specifies:, supports:)
  - Spec→doc relationships verified (when spec references doc, doc must exist)
  - Doc→spec backlinks verified (when doc exists, corresponding spec should reference it)
  - Broken references reported with file path and line number
  - Validation can run pre-commit or on-demand
  - Reports categorize issues by severity (ERROR: broken link, WARNING: missing backlink)

## Validation

- Validator detects all frontmatter reference types
- Validator reports missing target files
- Validator reports line numbers for broken references
- Validator distinguishes ERROR (must fix) vs WARNING (should fix)
- Validator can run in CI/CD pipeline
- Validator output actionable (tells user what to fix)

## Examples

**Valid cross-reference:**
```yaml
# In specs/3-artifacts/prompts/0a-setup-workspace.spec.md
---
specifies: prompts/0-define/0a-setup-workspace.md
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
---
```
✅ Both targets exist: `prompts/0-define/0a-setup-workspace.md` and `.livespec/standard/metaspecs/prompt.spec.md`

**Broken cross-reference:**
```yaml
# In specs/2-strategy/pathways/partnership/clt-formation.spec.md
---
implements: docs/pathways/clt-formation.md  # Spec claims to implement this doc
---
```
❌ ERROR: `docs/pathways/clt-formation.md` does not exist (referenced in specs/2-strategy/pathways/partnership/clt-formation.spec.md:3)

**Missing backlink:**
```yaml
# docs/pathways/clt-formation.md exists but doesn't reference clt-formation.spec.md
```
⚠️ WARNING: docs/pathways/clt-formation.md missing backlink to specs/2-strategy/pathways/partnership/clt-formation.spec.md

## Failure Scenarios

**If spec references non-existent file:**
- Validation fails with ERROR
- Reports exact file and line number
- Suggests creating target or removing reference
- Blocks commit if running in git hook

**If doc missing backlink to spec:**
- Validation warns with WARNING
- Reports both file paths
- Suggests adding frontmatter to doc
- Does not block commit (warning only)

**If circular references detected:**
- Validation warns with WARNING
- Reports reference cycle path
- Suggests breaking cycle
- Does not block commit (architectural decision)
