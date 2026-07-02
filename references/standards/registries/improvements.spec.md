---
type: registry
category: artifacts
fidelity: full-detail
criticality: IMPORTANT
failure_mode: Without a defined format, improvement entries become experiment logs or work items rather than records of known opportunities
governed-by:
  - specs/features/registry-specs.spec.md
---

# Improvement Registry Format

Defines the format for improvement entries in `registries/improvements.md`. Improvements track known improvement opportunities pending review — what works but could be better.

## Requirements

- [!] Each improvement entry is a state observation, not an experiment or work item
  - Entry reads as: "X works but could be better because..."
  - NOT: "try X" or "implement X" or "hypothesis: X will improve Y"
  - When an improvement becomes actionable, it graduates to a ticket and the entry is removed

- [!] Registry file uses YAML frontmatter with entries index

```yaml
---
store: registry
type: improvements
schema_version: 2
last_reviewed: YYYY-MM-DD
entries:
  - id: IMP-001
    summary: One-line description of improvement opportunity
    severity: medium
    status: open
---
```

- [!] Markdown body provides detail per entry

```markdown
## IMP-001: Descriptive title

**Evidence**: What works, what could be better, and the evidence supporting this.
**Category**: Structure | Guidance | Process | Traceability | Governance
```

- [!] Entry fields are constrained
  - `severity`: critical, high, medium, low
  - `status`: open (resolved entries are removed, not marked)
  - `id`: IMP-NNN (sequence never reused)

## Validation

- [ ] Every entry reads as a state observation ("X works but could be better because...")
- [ ] No entry reads as a work item ("implement X", "try X")
- [ ] No entry reads as an experiment ("hypothesis: X will improve Y")
- [ ] Frontmatter entries array matches markdown detail sections
- [ ] All required fields present (id, summary, severity, status)
