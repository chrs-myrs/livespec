---
type: registry
category: artifacts
fidelity: full-detail
criticality: IMPORTANT
failure_mode: Without a defined format, debt entries become vague grumbles or work items rather than records of deliberately accepted shortcuts with known cost
governed-by:
  - specs/features/registry-specs.spec.md
---

# Debt Registry Format

Defines the format for entries in `registries/debt.md`. Debt tracks deliberately accepted technical or spec shortcuts with known cost. **Required registry.**

## Requirements

- [!] Each debt entry is a record of an accepted shortcut, not a task
  - Entry reads as: "X is accepted debt because..." with the trade-off stated
  - NOT: "refactor X" or "fix the X shortcut"
  - When the debt is paid down, the entry is removed; when it becomes scheduled work, it graduates to a ticket

- [!] Registry file uses YAML frontmatter with entries index

```yaml
---
store: registry
type: debt
schema_version: 2
last_reviewed: YYYY-MM-DD
entries:
  - id: DEBT-001
    summary: One-line description of the accepted shortcut
    severity: medium
    status: open
    target: YYYY-MM-DD   # optional — timeline if one is agreed
---
```

- [!] Markdown body provides detail per entry

```markdown
## DEBT-001: Descriptive title

**Context**: Why the shortcut was taken, what the proper solution would be.
**Impact**: What the debt costs now and what it risks if left.
**Effort**: Rough cost to pay it down.
```

- [!] Entry fields are constrained
  - `severity`: critical, high, medium, low
  - `status`: `open` (paid-down entries are removed, not marked)
  - `target`: ISO date (optional — only when a timeline is agreed)
  - `id`: DEBT-NNN (sequence never reused)

## Validation

- [ ] Every entry reads as accepted debt with its trade-off, not a work item
- [ ] Frontmatter entries array matches markdown detail sections
- [ ] All required fields present (id, summary, severity, status)
