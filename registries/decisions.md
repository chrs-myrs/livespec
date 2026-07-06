---
store: registry
type: decisions
schema_version: 2
last_reviewed: 2026-07-06
entries:
  - id: DEC-001
    summary: Registry taxonomy aligned to knowledge-architecture in-repo-knowledge standard (tiered decisions/debt/security + conflicts/gaps + dependencies/issues)
    severity: n/a
    status: accepted
    date: 2026-07-06
    alternatives_considered: [keep-gaps-issues-improvements, superset-both-sets]
---

# Decision Registry

Tracks architecture and design decisions with rationale and rejected alternatives. Resolved (reversed) entries are removed — git history holds the record.

---

## DEC-001: Registry taxonomy aligned to knowledge-architecture standard

**Context**: LiveSpec's registry set had drifted to a spec-health lens (gaps/issues/improvements) while the intended model was the engineering-knowledge lens defined in `../tmp/knowledge-architecture/standards/in-repo-knowledge.md` (decisions/debt/security/conflicts/gaps/dependencies). Bootstrap (`init`) created no registries at all, and `audit` barely referenced them, so new projects got nothing.

**Alternatives considered**:
- *Keep gaps/issues/improvements, wire up bootstrap+audit only*: least churn, but leaves LiveSpec prescribing a weaker taxonomy than its own downstream (knowledge-architecture) already uses.
- *Superset (keep both sets)*: no loss, but conceptual overlap (issues≈conflicts, improvements≈debt) and a larger surface to maintain.

**Consequence**: Adopt the reference taxonomy, generalised — required `decisions`/`debt`/`security`, recommended `conflicts`/`gaps`, optional `dependencies`/`issues`. `issues` retained as optional for projects without a ticketing platform (per user). `improvements` dropped (folds into `debt`/`gaps`). TMP-specifics (FCA `regulatory_context`) made an optional field, not baked in. `init` now scaffolds required registries; `audit` validates them via `scripts/validate-registries.sh`.

**Related**: specs/features/registry-specs.spec.md, references/standards/registries/
