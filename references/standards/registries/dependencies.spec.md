---
type: registry
category: artifacts
fidelity: full-detail
criticality: IMPORTANT
failure_mode: Without a defined format, dependency entries duplicate spec contract detail instead of tracking only temporal risk, or the temporal risk goes untracked entirely
governed-by:
  - specs/features/registry-specs.spec.md
---

# Dependency Registry Format

Defines the format for entries in `registries/dependencies.md`. Dependencies track the temporal risk state of external dependencies — sunset dates, migration status, version drift. **Optional registry** — add only when the project has external dependencies with temporal risk that no package manager or tooling already tracks.

## Requirements

- [!] Each dependency entry tracks temporal risk state, not contract detail
  - Entry reads as: "X reaches end-of-life on DATE / migration is at STATE..."
  - NOT the dependency's interface or contract — that belongs in specs
  - NOT "migrate off X" — active migration is a ticket
  - When the risk is retired (migrated, upgraded), the entry is removed

- [!] Registry file uses YAML frontmatter with entries index

```yaml
---
store: registry
type: dependencies
schema_version: 2
last_reviewed: YYYY-MM-DD
entries:
  - id: DEP-001
    summary: One-line description of the temporal risk
    severity: high
    status: open
---
```

- [!] Markdown body provides detail per entry

```markdown
## DEP-001: Descriptive title

**Context**: The dependency and the nature of its temporal risk.
**Timeline**: Sunset/EOL date, deprecation window, or drift measurement.
**Migration status**: Where the migration stands (not started / in progress / blocked).
```

- [!] Entry fields are constrained
  - `severity`: critical, high, medium, low
  - `status`: `open` (retired risks are removed, not marked)
  - `id`: DEP-NNN (sequence never reused)

## Validation

- [ ] Every entry tracks temporal risk, not contract detail
- [ ] No entry duplicates dependency interface details that belong in specs
- [ ] Frontmatter entries array matches markdown detail sections
- [ ] All required fields present (id, summary, severity, status)
