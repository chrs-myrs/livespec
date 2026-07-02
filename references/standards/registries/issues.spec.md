---
type: registry
category: artifacts
fidelity: full-detail
criticality: IMPORTANT
failure_mode: Without a defined format, issue entries become bug trackers rather than records of accepted known problems
governed-by:
  - specs/features/registry-specs.spec.md
---

# Issue Registry Format

Defines the format for issue entries in `registries/issues.md`. Issues track known problems accepted for now — what's broken but tolerated.

## Requirements

- [!] Each issue entry is a state observation, not a bug report
  - Entry reads as: "X is a known limitation because..."
  - NOT: "fix X" or "X doesn't work"
  - When an issue becomes actionable, it graduates to a ticket and the entry is removed

- [!] Registry file uses YAML frontmatter with entries index

```yaml
---
store: registry
type: issues
schema_version: 2
last_reviewed: YYYY-MM-DD
entries:
  - id: ISSUE-001
    summary: One-line description of accepted problem
    severity: high
    status: open
---
```

- [!] Markdown body provides detail per entry

```markdown
## ISSUE-001: Descriptive title

**Context**: Why this problem is accepted for now, what evidence exists.
**Category**: Process | Structure | Guidance | Tooling
```

- [!] Entry fields are constrained
  - `severity`: critical, high, medium, low
  - `status`: open (resolved entries are removed, not marked)
  - `id`: ISSUE-NNN (sequence never reused)

## Validation

- [ ] Every entry reads as a state observation ("X is a known limitation because...")
- [ ] No entry reads as a work item ("fix X", "resolve X")
- [ ] Frontmatter entries array matches markdown detail sections
- [ ] All required fields present (id, summary, severity, status)
