# Registries

Accepted current state — known tensions that are neither desired state (specs) nor actionable work (tickets). Resolved entries are removed; git history has the full record. See `specs/features/registry-specs.spec.md`.

| File | Tier | Purpose |
|------|------|---------|
| `decisions.md` | required | Architecture/design decisions with rejected alternatives |
| `debt.md` | required | Accepted technical/spec debt with known cost |
| `security.md` | required | Accepted security considerations and known exposures |
| `conflicts.md` | recommended | Contradictions between code, specs, conventions |
| `gaps.md` | recommended | Known missing specs, tests, or coverage |
| `dependencies.md` | optional | Temporal risk of external dependencies |
| `issues.md` | optional | Known problems tolerated (projects without a tracker) |

This repo carries the three required registries plus `gaps.md` (recommended) and `issues.md` (optional — LiveSpec has no external ticketing platform). `conflicts.md` and `dependencies.md` are created only when warranted.
