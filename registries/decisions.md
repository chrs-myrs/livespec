---
store: registry
type: decisions
schema_version: 2
last_reviewed: 2026-10-01
entries:
  - id: DEC-001
    summary: Registry taxonomy aligned to knowledge-architecture in-repo-knowledge standard (tiered decisions/debt/security + conflicts/gaps + dependencies/issues)
    severity: n/a
    status: accepted
    date: 2026-07-06
    alternatives_considered: [keep-gaps-issues-improvements, superset-both-sets]
  - id: DEC-002
    summary: Spec-checker request split: LiveSpec evolves its own validators and output contract; estate enforcement belongs to the consumer
    severity: n/a
    status: accepted
    date: 2026-09-30
    alternatives_considered: [single-python-checker-with-ci-templates, defects-only, park-all]
  - id: DEC-003
    summary: A relationship link resolves only to PURPOSE.md or a spec at a permitted layer, with a chain to PURPOSE.md
    severity: n/a
    status: accepted
    date: 2026-09-30
    alternatives_considered: [purpose-parent-for-any-spec, existence-and-chain-only]
  - id: DEC-004
    summary: Upward links are authored; each parent's downward supports list is generated and checked; implements is retired
    severity: n/a
    status: accepted
    date: 2026-09-30
    alternatives_considered: [reverse-by-query-only, both-directions-authored-with-symmetry-check, generated-link-map-file]
  - id: DEC-005
    summary: Coverage is measured from specifies alone, widened to features and interfaces with files, directories and globs
    severity: n/a
    status: accepted
    date: 2026-09-30
    alternatives_considered: [colocation-and-mentions-count, coverage-left-to-consumers]
  - id: DEC-006
    summary: Generated agent context records a hash of the specs it was generated from, replacing mtime staleness
    severity: n/a
    status: accepted
    date: 2026-09-30
    alternatives_considered: [hash-workspace-specs-only, keep-mtime-and-git-log-heuristics]
  - id: DEC-007
    summary: Validators share one versioned machine-readable output envelope
    severity: n/a
    status: accepted
    date: 2026-09-30
    alternatives_considered: [single-aggregated-verdict, per-validator-json-without-envelope, text-only]
  - id: DEC-008
    summary: Upgrade migrates known retired folders automatically and proposes a target for the rest, confirmed per folder
    severity: n/a
    status: accepted
    date: 2026-09-30
    alternatives_considered: [documented-rows-only, automate-all-general-rows]
  - id: DEC-009
    summary: A project's accepted LiveSpec version is recorded in project.yaml, written by init and updated by upgrade
    severity: n/a
    status: accepted
    date: 2026-09-30
    alternatives_considered: [derive-from-vendored-stamps, agents-md-footer]
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

---

## DEC-002: Spec-checker request split between LiveSpec and its consumers

**Context**: TMP's estate programme asked LiveSpec to ship one deterministic checker covering link resolution, component coverage, layout and version detection, a generated `implements` index, a top-down update rule, agent-context currency, per-check report/block modes with a non-author bypass, and an estate scoreboard. Checked against `8037d69`, roughly half the request was LiveSpec defects (existence-only link checks, lossy migration, no accepted-version record, sweep faults). The other half was enforcement policy tied to a CI platform.

**Alternatives considered**:
- *One new Python checker with CI templates and label bypass*: a second validator stack and a language dependency, and platform-specific enforcement (who may bypass, which checks block) inside a platform-neutral methodology.
- *Fix the defects only*: coverage and context currency are methodology semantics; a consumer re-implementing them forks the methodology.
- *Park it all*: leaves known defects in every consumer.

**Consequence**: The existing bash validators evolve in place; no new checker and no Python. LiveSpec owns link resolution, two-way links, migration, the version record, coverage, the context stamp and a versioned output contract (DEC-003 to DEC-009). Consumers own per-repo modes, bypass, the ratchet, the top-down update rule, CI-run determinism and any estate scoreboard. New findings warn by default and `--strict` promotes them, as `validate-frontmatter.sh` already does. Sweep's discovery exclusion of `~/projects/tmp/` is unaffected.

**Related**: specs/strategy/validation.spec.md, DEC-003 to DEC-009

---

## DEC-003: Links resolve only to a spec at a permitted layer

**Context**: `validate-crossrefs.sh` accepted any existing path. At `8037d69` it reported 0 broken references while 23 of 88 specs had no chain to `PURPOSE.md` and 16 had no upward link at all. `specs/strategy/validation.spec.md` lists traceability as tested.

**Alternatives considered**:
- *`PURPOSE.md` a valid parent for any spec*: a feature passes by linking straight to PURPOSE, so the chain proves nothing.
- *Existence, chain and cycles only, no layer rules*: links pointing down or sideways would count as traceability.

**Consequence**: A target is a repo-root-relative path to `PURPOSE.md` or a spec, is not the spec itself, and sits at the same or a higher layer for its field. `PURPOSE.md` is a parent only for foundation and workspace specs. Every spec must chain to `PURPOSE.md`, and cycles are reported. A path relative to the referencing file is reported with a hint, not resolved.

**Related**: specs/features/validation/cross-reference-validation.spec.md

---

## DEC-004: Upward links authored, downward links generated

**Context**: `implements` meant spec→spec in the vocabulary (17 uses) and file→spec in `frontmatter-relationships.md`, which also asks for both directions to be written by hand. At `8037d69` only 5 of 149 upward links had a matching downward `supports:`. Specs must be navigable both ways from within the file, without running a tool.

**Alternatives considered**:
- *Reverse lookup by query only*: navigating from a spec file then needs the toolchain.
- *Both directions authored, symmetry enforced*: a deletion on one side is indistinguishable from an omission on the other, so no tool can say which side is right.
- *A generated link-map file*: navigation is one hop away from the spec.

**Consequence**: The child's upward fields (`derives-from`, `satisfies`, `guided-by`, `governed-by`) are the single source of truth. `--fix` writes each parent's `supports:` list, and a mismatch is a finding. Since 2026-10-05, `--fix` keeps a `supports:` entry with no upward link back and reports it, removing it only under `--prune`: a consuming project's upgrade showed such entries can record true dependencies, and removing them reached a clean result by deleting that fact. Heavily cited specs carry long lists (`outcomes.spec.md` about 50), and adding a spec also edits its parents. `implements:` is retired and its spec→spec uses become `satisfies:`. Which spec governs a code file is answered by a query over `specifies:` (DEC-005).

**Related**: references/standards/vocabulary.spec.md, references/guides/frontmatter-relationships.md, DEC-005

---

## DEC-005: Coverage measured from `specifies:` alone

**Context**: `check-requires-spec.sh` counted a colocated spec, or any textual mention under `specs/`, as governance. `specifies:` was scoped to artifact specs, so features and interfaces had no machine-checkable link to the files they govern. Consumers need a coverage figure and a spec→files map for their own ratchets and change rules.

**Alternatives considered**:
- *Colocation and mentions keep counting*: a mention is not governance and cannot be checked.
- *Coverage left to consumers*: each would define coverage differently.

**Consequence**: `specifies:` is valid on features, interfaces and artifacts and accepts files, directories and globs. Colocated specs and mentions no longer count. Coverage is reported, never blocking, together with files governed by more than one spec and patterns that match nothing. The governed-set map is emitted through the output contract (DEC-007); any rule that blocks on it is the consumer's.

**Related**: specs/features/mandatory-frontmatter.spec.md, specs/artifacts/validators/check-requires-spec.spec.md, DEC-007

---

## DEC-006: Generated context records a hash of its sources

**Context**: `specs/workspace/generated-files.spec.md` detected staleness by timestamp and mtime, which git does not preserve, so clones disagreed. `audit context` used a git-log heuristic.

**Alternatives considered**:
- *Hash `PURPOSE.md` and workspace specs only*: misses staleness from the foundation, feature and artifact specs the generated files also draw on.
- *Keep the mtime and git-log heuristics*: not deterministic.

**Consequence**: A script hashes everything the Spec → Generated File Map feeds (tracked, sorted, LF-normalised) and stamps the configured agent doc and every `ctxt/` file. The context-builder runs it as its last step, because a model cannot compute a hash. The check reports current, stale or unstamped, and `audit context` classifies MINOR or FULL from it.

**Related**: specs/workspace/generated-files.spec.md, specs/workspace/context-architecture.spec.md

---

## DEC-007: One versioned output envelope for every validator

**Context**: Consumers gating CI on LiveSpec's validators had only human-readable text, worded differently per validator. TMP's enforcement merges per-validator results and compares base against head.

**Alternatives considered**:
- *A single aggregated verdict*: the consumer does not need it, and it couples the validators.
- *Per-validator JSON without a shared envelope*: every validator becomes its own integration.
- *Text only*: parsing breaks whenever wording changes.

**Consequence**: Every validator offers `--json` in one envelope: `schema_version`, validator id, `livespec_version`, and findings each carrying a stable id or rule code, a severity, a repo-root-relative path and a message. Output is ordered under `LC_ALL=C`, with exit codes 0, 1 and 2. The governed-set map uses the same envelope. A breaking change bumps the schema version. It ships in the same release as link resolution.

**Related**: specs/interfaces/formats/validator-output.spec.md, DEC-005

---

## DEC-008: Upgrade proposes targets for unrecognised folders and asks

**Context**: `upgrade-to-v5.sh` moved the three documented numbered folders and an undocumented `3-contracts/`. Any other numbered folder failed verification with no guidance, unnumbered folders were never detected, and `mv dir/*` overwrote same-named files.

**Alternatives considered**:
- *Automate the known rows, report everything else*: discards known mappings (`procedures/`, `meta/`, `metaspecs/`) and leaves every consumer to rediscover them.
- *Automate every general row*: rows such as `meta/` and `reports/` still need a judgement per repository.

**Consequence**: `1-requirements/`, `2-strategy/`, `3-behaviors/`, `3-contracts/` and `4-contracts/` move automatically. For any other folder the script proposes a target from the migration table and the upgrade skill confirms it per folder; folders with no mapping are reported, never moved. A repository with both current and retired folders is reported as retired and mixed. No move overwrites a file.

**Related**: specs/features/automation.spec.md, references/guides/upgrade-to-v5.md

---

## DEC-009: Accepted version recorded in `project.yaml`

**Context**: `init` wrote no `project.yaml`, so consumers recorded no accepted LiveSpec version, and sweep, which reads it there, found nothing. The only signal was the per-file vendored `source-version` stamps.

**Alternatives considered**:
- *Derive the version from vendored stamps*: a partial upgrade leaves mixed stamps and no single answer.
- *The AGENTS.md footer*: records which version generated the context, not which version was accepted.

**Consequence**: `init` writes a minimal `project.yaml` with `livespec.version`, and `upgrade` updates it only when the project accepts a version. Vendored stamps remain per-file provenance, and disagreement with `project.yaml` is reported.

**Related**: specs/features/project-config.spec.md
