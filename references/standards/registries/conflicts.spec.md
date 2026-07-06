---
type: registry
category: artifacts
fidelity: full-detail
criticality: IMPORTANT
failure_mode: Without a defined format, conflict entries fail to name their conflicting sources, so contradictions between code, specs, and conventions cannot be tracked to resolution
governed-by:
  - specs/features/registry-specs.spec.md
---

# Conflict Registry Format

Defines the format for entries in `registries/conflicts.md`. Conflicts track known contradictions between code, specs, and conventions, with resolution status. **Recommended registry** — create when the project is complex enough to accumulate mismatches faster than they are resolved.

## Requirements

- [!] Each conflict entry is a record of a detected contradiction, not a fix instruction
  - Entry reads as: "X contradicts Y because..." with the conflicting sources named
  - NOT: "reconcile X and Y" or "fix the mismatch"
  - When the contradiction is resolved, the entry is removed

- [!] Registry file uses YAML frontmatter with entries index

```yaml
---
store: registry
type: conflicts
schema_version: 2
last_reviewed: YYYY-MM-DD
entries:
  - id: CON-001
    summary: One-line description of the contradiction
    severity: medium
    status: open
    conflicting_sources: [path/to/a, path/to/b]
---
```

- [!] Markdown body provides detail per entry

```markdown
## CON-001: Descriptive title

**Context**: What the contradiction is and how it was detected.
**Conflicting sources**: The files or conventions that disagree.
**Resolution status**: Why it is tolerated for now; what would resolve it.
```

- [!] Entry fields are constrained
  - `severity`: critical, high, medium, low
  - `status`: `open` (resolved entries are removed, not marked)
  - `conflicting_sources`: array of file paths or convention names
  - `id`: CON-NNN (sequence never reused)

## Validation

- [ ] Every entry names its conflicting sources
- [ ] Every entry reads as a state observation, not a fix instruction
- [ ] Frontmatter entries array matches markdown detail sections
- [ ] All required fields present (id, summary, severity, status, conflicting_sources)
