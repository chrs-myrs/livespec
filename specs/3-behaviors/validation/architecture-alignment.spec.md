---
criticality: IMPORTANT
failure_mode: Specifications describing non-existent structures create false documentation, mislead developers, and violate spec-reality synchronization
governed-by:
  - dist/standard/metaspecs/behavior.spec.md
satisfies:
  - specs/1-requirements/functional/drift-detection.spec.md
guided-by:
  - specs/2-strategy/validation.spec.md
  - specs/2-strategy/dogfooding.spec.md
---

# Architecture Alignment Validation

## Requirements

- [!] System validates that directory structures and file patterns described in architecture and strategy specifications actually exist in the project filesystem to prevent spec-reality drift.
  - Scans architecture.spec.md and strategy specs for directory references
  - Extracts mentioned paths (policies/, templates/, src/, etc.)
  - Verifies each referenced directory/file exists
  - Reports missing structures with specification location
  - Distinguishes between planned (future) vs claimed (current) structures
  - Provides remediation guidance (create directory or update spec to mark as planned)
  - Can run during Phase 2 (BUILD) to catch implementation gaps or Phase 4 (EVOLVE) for drift detection

## Validation

- Validator parses architecture and strategy specifications
- Validator extracts directory and file path references
- Validator checks filesystem for existence of referenced paths
- Validator reports missing structures with spec location and line number
- Validator distinguishes ERROR (claims it exists) vs WARNING (describes future state)
- Validator suggests creating missing directories or updating specs
- Validator output actionable (exact paths to create or spec lines to update)

## Examples

**Aligned architecture spec:**
```markdown
# specs/2-strategy/architecture.spec.md

## Requirements
- [!] System organized into four primary components
  - Policy Library: Taxonomy-organized governance rules
    - Location: `policies/{dimension}/`
    - Contains: *.spec.md policy files
  - Audit System: Scans projects for compliance
    - Location: `src/audit/`
    - Contains: scanner, validator, reporter
```

Filesystem check:
```bash
$ ls -d policies/ src/audit/
policies/  src/audit/
```
✅ **ALIGNED**: Both referenced directories exist

**Misaligned architecture spec:**
```markdown
# specs/2-strategy/architecture.spec.md (project-governance)

## Requirements
- [!] System organized into four primary components
  - Policy Library: Location `policies/universal/`, `policies/agentic/`
  - Template Library: Location `templates/cicd/`, `templates/mcp/`
  - Audit System: Location `src/audit/`
  - Forge System: Location `src/forge/`
```

Filesystem check:
```bash
$ ls -d policies/ templates/ src/
ls: cannot access 'policies/': No such file or directory
ls: cannot access 'templates/': No such file or directory
ls: cannot access 'src/': No such file or directory
```
❌ **MISALIGNMENT DETECTED**:
- ERROR: `policies/` referenced in architecture.spec.md:24 but does not exist
- ERROR: `templates/` referenced in architecture.spec.md:25 but does not exist
- ERROR: `src/audit/` referenced in architecture.spec.md:26 but does not exist
- ERROR: `src/forge/` referenced in architecture.spec.md:27 but does not exist

**Remediation options:**
1. Create missing directories: `mkdir -p policies/universal policies/agentic templates/cicd templates/mcp src/audit src/forge`
2. Update spec to mark as planned: "Policy Library (planned): Will be located in `policies/`..."
3. Remove references if no longer applicable

**Planned structure (valid):**
```markdown
# specs/2-strategy/architecture.spec.md

## Requirements
- [!] System will be organized into components (Phase 2 planned)
  - Policy Library (to be implemented): `policies/`
  - Template Library (to be implemented): `templates/`

## Implementation Status
- [ ] Create policies/ directory structure
- [ ] Create templates/ directory structure
```
⚠️ **WARNING**: Future structure clearly marked as planned
- Validator recognizes future tense ("will be", "planned")
- Validator checks "Implementation Status" for TODO markers
- Does not report ERROR (clearly marked as future state)

## Failure Scenarios

**If spec describes existing structure that doesn't exist:**
- Validator reports ERROR (highest severity)
- Example: "System organized into `policies/` directory" but no policies/ exists
- Location: specs/2-strategy/architecture.spec.md:24
- Suggests: "Create directory: mkdir -p policies/ OR mark as planned in spec"
- Blocks commit if running in git hook
- This was the EXACT issue in project-governance

**If spec lists file patterns that don't match:**
- Validator reports WARNING
- Example: "Contains `*.spec.md policy files`" but no .spec.md files in policies/
- Suggests: "Create initial policy files OR update spec to reflect current state"
- Does not block commit (directory exists, just empty)

**If spec references implementation without code:**
- Validator reports ERROR
- Example: "Audit System: Location `src/audit/`" but src/ doesn't exist
- Suggests: "Either implement audit system OR move spec to Phase 1 design (not Phase 2 built)"
- Rationale: "If architecture spec describes locations, implementation should exist"

**If spec uses future tense or "planned" markers:**
- Validator allows (no error)
- Detects phrases: "will be", "planned", "to be implemented", "future"
- Detects TODO markers: `- [ ] Create directory`
- Reports INFO: "Future structure documented, not yet implemented"

## Implementation Notes

**Path extraction patterns:**

**Directory references to detect:**
- Explicit paths: `policies/`, `src/audit/`, `templates/cicd/`
- Pattern descriptions: `{dimension}/`, `*.spec.md files in policies/`
- Code blocks showing structure (extract tree structure)
- "Location:" labels in specs

**Filesystem validation:**
- For each extracted path, run `ls -d [path]` or equivalent
- Check exit code (0 = exists, non-zero = missing)
- For wildcard patterns, check `find [path] -name [pattern]`
- For nested paths, validate parent directories first

**Future-state detection:**

**Keywords indicating planned (not ERROR):**
- "will be", "planned", "to be implemented", "future"
- "Phase 2", "Phase 3" (if currently in Phase 1)
- TODO checkboxes: `- [ ]`
- "Implementation Status" sections with incomplete tasks

**Keywords indicating current (ERROR if missing):**
- "organized into", "located in", "contains"
- "System uses", "System stores"
- Present tense without qualification

**Remediation strategies:**

| Situation | Remediation |
|-----------|-------------|
| Missing policies/ | `mkdir -p policies/universal policies/agentic` |
| Missing src/ | "Implement system OR mark spec as Phase 1 design only" |
| Empty directory | "Create initial files OR update spec: 'will contain...'" |
| Wrong path | "Update spec to match actual implementation location" |

**Scope limitations:**
- Only validates directories and major file patterns (not every individual file)
- Focuses on architecture-level structures (policies/, src/, templates/)
- Does not validate file contents (only existence)
- Does not validate internal code organization (that's for code review)

**Cross-spec validation:**
- Read architecture.spec.md first
- Check all 2-strategy/ specs for path references
- May check patterns.spec.md for directory organization claims
- Does not check 3-behaviors/ (behaviors describe outcomes, not structure)

**Historical context:**
This validator addresses issue discovered in project-governance where:
- architecture.spec.md (252 lines) extensively describes directory structures
- References `policies/universal/`, `policies/agentic/`, `policies/{dimension}/`
- References `templates/cicd/`, `templates/mcp/`
- References `src/audit/`, `src/forge/`, `src/remediation/`
- NONE of these directories exist in the repository
- Creates "spec debt" - detailed architecture documentation with zero implementation
- Agent exploration revealed: "Specs extensively reference policies/ but it doesn't exist"
- User perceives project as "partially implemented" but actually zero code exists
- This validation would have caught the misalignment immediately
