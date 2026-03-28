---
type: behavior
category: features
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Broken cross-references cause spec drift, lost traceability, and silent methodology violations — 110 stale references accumulated before detection in v5.4.0
governed-by:
  - specs/foundation/constraints.spec.md
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement 4: Sustainable methodology)
guided-by:
  - specs/strategy/validation.spec.md
  - specs/strategy/dogfooding.spec.md
specifies:
  - scripts/validate-crossrefs.sh
---

# Cross-Reference Validation

## Requirements

- [!] A validation script checks all relationship field targets in spec frontmatter exist on disk, runnable both manually and in the pre-commit hook.
  - Checks all relationship fields: governed-by, satisfies, guided-by, derives-from, supports, specifies, implements, extends, informed-by, supersedes, updated-by
  - Extracts file paths from reference values, stripping parenthetical annotations
  - Skips non-path values (e.g., "all_projects", descriptive strings)
  - Reports broken references with source file, field name, and target path
  - Exits 0 when all references valid, 1 on any broken reference
  - Integrated into pre-commit hook alongside frontmatter validation

## Validation

- [ ] `scripts/validate-crossrefs.sh` exists and is executable
- [ ] Script detects broken file path references in frontmatter
- [ ] Script ignores non-path values and empty arrays
- [ ] Script strips parenthetical annotations before path checking
- [ ] Pre-commit hook runs cross-reference validation
- [ ] All 118 current specs pass with 0 errors
