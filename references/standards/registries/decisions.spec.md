---
type: registry
category: artifacts
fidelity: full-detail
criticality: IMPORTANT
failure_mode: Without a defined format, decision entries lose their rationale and rejected alternatives, so past choices get re-litigated or silently reversed
governed-by:
  - specs/features/registry-specs.spec.md
---

# Decision Registry Format

Defines the format for entries in `registries/decisions.md`. Decisions track architecture and design choices with their rationale and rejected alternatives. **Required registry.**

## Requirements

- [!] Each decision entry is a record of a choice made, not a proposal
  - Entry reads as: "X was chosen over Y because..."
  - NOT: "we should use X" or "evaluate X vs Y"
  - When a decision is reversed, the entry is removed (git history holds the record); a superseding decision gets its own new entry

- [!] Registry file uses YAML frontmatter with entries index

```yaml
---
store: registry
type: decisions
schema_version: 2
last_reviewed: YYYY-MM-DD
entries:
  - id: DEC-001
    summary: One-line description of the decision
    severity: n/a
    status: accepted
    date: YYYY-MM-DD
    alternatives_considered: [OptionB, OptionC]
---
```

- [!] Markdown body provides detail per entry

```markdown
## DEC-001: Descriptive title

**Context**: What forced the decision, what constraints applied.
**Alternatives considered**: Each rejected option and why it lost.
**Consequence**: What this commits the project to; what remains open.
**Related**: Cross-references to specs or other entries.
```

- [!] Entry fields are constrained
  - `severity`: `n/a` (decisions are not ranked by severity)
  - `status`: `accepted` (reversed decisions are removed, not marked)
  - `date`: ISO date the decision was made
  - `alternatives_considered`: array of rejected options
  - `id`: DEC-NNN (sequence never reused)

## Validation

- [ ] Every entry records a made decision, not a proposal
- [ ] Every entry carries rationale and rejected alternatives
- [ ] Frontmatter entries array matches markdown detail sections
- [ ] All required fields present (id, summary, status, date, alternatives_considered)
