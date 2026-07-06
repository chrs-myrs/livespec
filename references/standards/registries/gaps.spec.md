---
type: registry
category: artifacts
fidelity: full-detail
criticality: IMPORTANT
failure_mode: Without a defined format, gap entries become vague wish lists rather than precise state observations of missing coverage
governed-by:
  - specs/features/registry-specs.spec.md
---

# Gap Registry Format

Defines the format for gap entries in `registries/gaps.md`. Gaps track known missing coverage — what should exist but doesn't yet. **Recommended registry.**

## Requirements

- [!] Each gap entry is a state observation, not a work item
  - Entry reads as: "X is missing because..."
  - NOT: "implement X" or "add X"
  - When a gap becomes actionable, it graduates to a ticket and the entry is removed

- [!] Registry file uses YAML frontmatter with entries index

```yaml
---
store: registry
type: gaps
schema_version: 2
last_reviewed: YYYY-MM-DD
entries:
  - id: GAP-001
    summary: One-line description of missing coverage
    severity: high
    status: open
---
```

- [!] Markdown body provides detail per entry

```markdown
## GAP-001: Descriptive title

**Context**: Why this gap exists, what evidence surfaced it.
**Scope**: What area is affected by the missing coverage.
```

- [!] Entry fields are constrained
  - `severity`: critical, high, medium, low
  - `status`: open (resolved entries are removed, not marked)
  - `id`: GAP-NNN (sequence never reused)

## Validation

- [ ] Every entry reads as a state observation ("X is missing because...")
- [ ] No entry reads as a work item ("implement X", "add X")
- [ ] Frontmatter entries array matches markdown detail sections
- [ ] All required fields present (id, summary, severity, status)
