---
store: registry
type: gaps
schema_version: 2
last_reviewed: 2026-10-05
entries:
  - id: GAP-008
    summary: Example projects are never validated, so all three drifted from the schema unnoticed
    severity: low
    status: open
    date: 2026-10-05
  - id: GAP-006
    summary: Spec paths written in body text are never validated, so dead prose references survive every audit
    severity: low
    status: open
    date: 2026-10-05
  - id: GAP-007
    summary: Nothing detects a spec restating its requirements as narrative sections, the bloat pattern behind 61 lines per requirement in forgewick
    severity: low
    status: open
    date: 2026-10-05
  - id: GAP-001
    summary: Artifact specs declaring 'specifies' empty, leaving no machine-checkable spec-to-code link
    severity: low
    status: open
    date: 2026-09-15
  - id: GAP-004
    summary: Eight validators named by project-health.spec.md were never built, so the health report cannot run as specified
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

## GAP-003: Artifact specs for deliverables never produced

**Severity**: low
**Status**: open
**Recorded**: 2026-09-15 at `96b93e6`

Two artifact specs describe deliverables that do not exist:

- `specs/artifacts/validators/context-tree-visualizer.spec.md` names `scripts/visualize-context-tree.sh`
- `specs/artifacts/diagrams/value-structure-context-tree-relationship.spec.md` describes a Mermaid diagram with no rendered or stored artefact

Both are specs waiting on implementation rather than code missing its spec, which is the healthier direction of the two. They are the reason `specifies` coverage is 17 of 19 rather than complete: there is nothing to point at.

Either build them or delete the specs. Leaving them is the state that produced this session's larger findings, where documentation described tooling that had been removed.

---

## GAP-004: Health-report validators never built

**Severity**: medium
**Status**: open
**Recorded**: 2026-09-15 at `ab64480`

`specs/features/project-health.spec.md` names eight validators: taxonomy
structure, workspace scope, code-in-specs, architecture alignment, contract
completeness, value structure, agent compliance, and compliance dashboard
generation. None exist.

`references/prompts/utils/run-health-report.md` instructed running all eight. It
now runs the five validators that ship and states plainly that the eight do not
exist. Two metaspecs carried the same invocations and now name them as planned.

This is the same shape as GAP-003 and the healthier direction of the two: specs
waiting on implementation rather than code missing its spec. The harm was that
the prompt read as an instruction, so an agent following it would try to run
tooling that has never existed.

Either build them or reduce the spec to what health reporting actually does.

---

## GAP-006: Body-text spec references are unvalidated

**Severity**: low
**Status**: open
**Recorded**: 2026-10-05 at `a401ec8`

`validate-crossrefs.sh` checks frontmatter relationship fields only. A spec path
written in prose is never resolved. The forgewick feedback report (§2.4) found
seven dead ones in one project, including `.metaspec.md` names for files that
are `.spec.md` and a path to a spec archived months earlier, all of which had
survived several audits.

A naive existence check is the reason this stays open. Several of forgewick's
apparently dead paths were correct: they name files generated in target
projects, or illustrate where product specs belong. `validate-constraints.sh`
already declines to check spec paths in project context for the same reason.
A useful check has to tell assertion from illustration, or run as report-only.

---

## GAP-007: Requirements restated as narrative are undetected

**Severity**: low
**Status**: open
**Recorded**: 2026-10-05 at `a401ec8`

The forgewick feedback report (§4) found six specs that each stated their
content twice: once as `### REQ-*` entries under `## Requirements`, then again
as narrative `##` sections mirroring them one for one. The cluster ran to 3,315
lines for 54 requirements, 61 lines per requirement, and fell to 7 per
requirement once the restatement went. It survived every prior audit, and no
current check, including `/livespec:audit msl`, looks for it.

---

## GAP-008: Example projects are never validated

**Severity**: low
**Status**: open
**Recorded**: 2026-10-05 at `7d1a7ee`

`examples/` holds three standalone LiveSpec projects that ship with the plugin.
Their spec paths resolve from each example's own root, so the validators, which
resolve from the repository root, cannot check them in place, and nothing else
does. All three drifted unnoticed: no schema fields, links into layouts retired
two major versions earlier, and specs lost in the v5 cleanup while others still
linked to them. Each now passes when copied into its own repository and
validated there, which is the check that would catch the next drift; it is run
by hand only.
