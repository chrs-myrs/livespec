---
store: registry
type: gaps
schema_version: 2
last_reviewed: 2026-09-15
entries:
  - id: GAP-001
    summary: Artifact specs declaring 'specifies' empty, leaving no machine-checkable spec-to-code link
    severity: low
    status: open
    date: 2026-09-15
  - id: GAP-002
    summary: No CI, so validation enforcement is per-clone and an unhooked contributor is unvalidated until review
    severity: medium
    status: open
    date: 2026-09-15
  - id: GAP-003
    summary: Two artifact specs describe deliverables that were never produced (context tree visualiser script, value-structure diagram)
    severity: low
    status: open
    date: 2026-09-15
---

# Gap Registry

Tracks known missing coverage — what should exist but doesn't yet.

---

## GAP-001: Artifact specs declaring 'specifies' empty

**Severity**: low
**Status**: open
**Recorded**: 2026-09-15 at `8675011`, updated at `96b93e6`

Of the specs under `specs/artifacts/` where the schema makes `specifies` mandatory, some declare it empty. Coverage was 1 of 16 when first recorded and is now 17 of 19.

The frontmatter validator reports this on every run as part of its relationship graph population table, so the number is visible without investigation. It was invisible before because presence-only checking treated an empty declaration as satisfied.

`specifies` is the field where an empty declaration cannot be excused as schema-against-practice. Other mandatory relationship fields often have the same information sitting on a different populated edge — a strategy spec with an empty `derives-from` above a populated `satisfies` pointing at the same foundation spec. `specifies` has no substitute: nothing else in the schema links a spec to its code, so an empty one means the link does not exist in machine-checkable form anywhere.

The consequence observed was that artifact specs continued to instruct readers to run scripts deleted months earlier, and no validation could detect it. The two entries still empty are tracked as GAP-003, because their deliverables do not exist to be linked.

---

## GAP-002: No CI, so enforcement is per-clone

**Severity**: medium
**Status**: open
**Recorded**: 2026-09-15 at `96b93e6`

There is no `.github/` directory and no test or validation workflow. Validation runs through the pre-commit hook installed by `scripts/setup-hooks.sh`, which `/livespec:init` and `/livespec:upgrade` now invoke.

That covers projects created or upgraded through those skills, and it covers the developer who runs the installer. It does not cover a contributor who clones an existing project and never installs the hook: their work is unvalidated until review. Nothing detects that state.

`specs/strategy/validation.spec.md` previously described a `tests/run-all-tests.sh` suite and a GitHub Actions workflow, neither of which exists. That spec now describes what ships and names this gap rather than implying coverage.

Closing this needs a CI step, deliberately not designed in this pass.

---

## GAP-003: Artifact specs for deliverables never produced

**Severity**: low
**Status**: open
**Recorded**: 2026-09-15 at `96b93e6`

Two artifact specs describe deliverables that do not exist:

- `specs/artifacts/validators/context-tree-visualizer.spec.md` names `scripts/visualize-context-tree.sh`
- `specs/artifacts/diagrams/value-structure-context-tree-relationship.spec.md` describes a Mermaid diagram with no rendered or stored artefact

Both are specs waiting on implementation rather than code missing its spec, which is the healthier direction of the two. They are the reason `specifies` coverage is 17 of 19 rather than complete: there is nothing to point at.

Either build them or delete the specs. Leaving them is the state that produced this session's larger findings, where documentation described tooling that had been removed.
