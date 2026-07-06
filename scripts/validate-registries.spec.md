---
type: validator
category: artifacts
fidelity: process
criticality: IMPORTANT
failure_mode: Without automated registry validation, registries drift into backlogs, index and body fall out of sync, and required registries silently go missing from projects
governed-by:
  - specs/features/registry-specs.spec.md
specifies:
  - scripts/validate-registries.sh
---

# Registry Validation Script

Validates `registries/` against the taxonomy and rules in `specs/features/registry-specs.spec.md`. Backs the `/livespec:audit validate` Registry Integrity check.

## Requirements

- [!] Verifies the three required registries exist
  - `decisions.md`, `debt.md`, `security.md` must be present (ERROR if missing)

- [!] Verifies each registry file's frontmatter
  - `store: registry`, `type` matching the filename, `schema_version`, `last_reviewed`, `entries` present
  - `last_reviewed` is a valid ISO date

- [!] Verifies entry integrity per file
  - Every ID uses the prefix matching its registry type (`DEC-`, `DEBT-`, `SEC-`, `CON-`, `GAP-`, `DEP-`, `ISSUE-`)
  - The frontmatter `entries` index matches the markdown body `## ID:` sections exactly (no orphans either direction)

- [!] Flags likely process violations as warnings (not errors)
  - Entry summaries that read like work items (leading verb: implement/fix/add/refactor/resolve/…) warn
  - A registry with `last_reviewed` older than 90 days (3 months) warns as stale

- [!] Exit code contract
  - Exit 0 when there are no errors (warnings allowed)
  - Exit 1 when any error is found

## Validation

- [ ] Missing required registry produces an ERROR and exit 1
- [ ] Index/body mismatch produces an ERROR naming the offending IDs
- [ ] Wrong ID prefix for the registry type produces an ERROR
- [ ] Stale registry (>90 days) produces a WARN, not an ERROR
- [ ] Clean registry set exits 0
