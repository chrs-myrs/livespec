---
type: registry
category: artifacts
fidelity: full-detail
criticality: IMPORTANT
failure_mode: Without a defined format, security entries lose severity and remediation state, so accepted security posture and known exposures cannot be reviewed or suppressed reliably
governed-by:
  - specs/features/registry-specs.spec.md
---

# Security Registry Format

Defines the format for entries in `registries/security.md`. Security tracks accepted security considerations, known exposures, and their remediation status. **Required registry.** An empty security registry is valid — it asserts "no accepted security items currently".

## Requirements

- [!] Each security entry is a record of an accepted consideration or known exposure, not a remediation task
  - Entry reads as: "X is a known/accepted security consideration because..."
  - NOT: "patch X" or "fix the X vulnerability" (active remediation is a ticket)
  - When the exposure is closed, the entry is removed

- [!] Registry file uses YAML frontmatter with entries index

```yaml
---
store: registry
type: security
schema_version: 2
last_reviewed: YYYY-MM-DD
entries:
  - id: SEC-001
    summary: One-line description of the consideration or exposure
    severity: high
    status: open
    regulatory_context: FCA CONC 5.2A   # optional — compliance/regulatory tie
---
```

- [!] Markdown body provides detail per entry

```markdown
## SEC-001: Descriptive title

**Context**: The consideration or exposure and why it is accepted for now.
**Remediation**: Current mitigation and any planned closure.
**Regulatory context**: FCA rule, OWASP category, or compliance requirement (where applicable).
```

- [!] Entry fields are constrained
  - `severity`: critical, high, medium, low
  - `status`: `open` (closed exposures are removed, not marked)
  - `regulatory_context`: optional — present only where a regulatory or compliance tie applies (not baked into generic projects)
  - `id`: SEC-NNN (sequence never reused)

## Validation

- [ ] Every entry reads as an accepted consideration or known exposure, not a remediation task
- [ ] Frontmatter entries array matches markdown detail sections
- [ ] All required fields present (id, summary, severity, status)
