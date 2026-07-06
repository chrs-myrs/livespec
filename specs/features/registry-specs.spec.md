---
type: behavior
category: features
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Without registry purpose alignment and a defined taxonomy, registries become backlogs or bug trackers rather than recording accepted current state, and projects get no registries at bootstrap so known tensions have nowhere to live
governed-by:
  - specs/foundation/constraints.spec.md
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement 4: Sustainable methodology)
guided-by:
  - specs/strategy/ai-discoverability.spec.md
  - specs/workspace/patterns.spec.md
specifies:
  - references/standards/registries/decisions.spec.md
  - references/standards/registries/debt.spec.md
  - references/standards/registries/security.spec.md
  - references/standards/registries/conflicts.spec.md
  - references/standards/registries/gaps.spec.md
  - references/standards/registries/dependencies.spec.md
  - references/standards/registries/issues.spec.md
---

# Registry Management

## Requirements

### Registries Track Accepted Current State

- [!] Registries record what is known to be true now — not desired state (specs) or actionable work (tickets)
  - Each entry is a state observation: "X was decided because...", "Y debt is accepted because...", "Z is missing because..."
  - If an entry reads like a work item ("implement X", "fix Y"), it belongs in a ticket, not a registry
  - When an entry becomes actionable, it graduates to a ticket and the registry entry is removed (the entry may link to the ticket while both briefly coexist)
  - When accepted state changes (debt paid, decision reversed, gap filled, issue resolved), the entry is removed
  - Git history is the archive — no Completed sections, no resolved entries retained

### Registry Taxonomy (Tiered)

- [!] Every project has three required registries
  - `registries/decisions.md` (`DEC-`) — architecture and design decisions with rationale and rejected alternatives
  - `registries/debt.md` (`DEBT-`) — accepted technical/spec debt with priority and timeline
  - `registries/security.md` (`SEC-`) — security considerations with severity and remediation status
  - Required because every project makes decisions, accrues some debt, and has a security posture. An empty registry is a valid state — it asserts "nothing accepted here yet", not "not tracked".

- [!] Two registries are recommended, created when project complexity warrants
  - `registries/conflicts.md` (`CON-`) — known contradictions between code, specs, and conventions with resolution status
  - `registries/gaps.md` (`GAP-`) — known missing specs, tests, or coverage with triage status
  - Recommended because both directly serve a review agent's core function: suppressing known issues and adjusting expectations for areas lacking coverage.

- [!] Two registries are optional, added only when the criterion is met
  - `registries/dependencies.md` (`DEP-`) — temporal risk state of external dependencies (sunset dates, migration status, version drift)
    - Criterion: the project has external dependencies with temporal risk that no package manager or tooling already tracks. Records temporal state only — dependency contract details belong in specs.
  - `registries/issues.md` (`ISSUE-`) — known problems accepted for now (what's broken but tolerated)
    - Criterion: the project has **no external ticketing platform**. Where a tracker exists (e.g. Jira), accepted-but-unworked problems graduate to tickets instead of living here.

### Registry Frontmatter Schema (v2)

- [!] All registry files use YAML frontmatter with a machine-readable entries index
  - `store: registry` — identifies the file as a registry
  - `type` — classifies the registry (decisions, debt, security, conflicts, gaps, dependencies, issues)
  - `schema_version: 2` — format version
  - `last_reviewed` — ISO date of last human review
  - `entries` — array of entry summaries (machine-readable index)
  - Markdown body contains full detail per entry

### Entry Structure

- [!] All entries carry common structured metadata in the frontmatter entries array
  - Required common fields: `id`, `summary`, `severity` (critical/high/medium/low, or `n/a` where severity does not apply), `status` (`open`, or `accepted` for decisions)
  - Entry IDs use the prefix matching registry type: `DEC-NNN`, `DEBT-NNN`, `SEC-NNN`, `CON-NNN`, `GAP-NNN`, `DEP-NNN`, `ISSUE-NNN`
  - Sequence numbers are never reused (next entry increments from highest historical ID)
  - Markdown body provides full detail per entry (context, evidence, scope, remediation, cross-references)

- [!] Type-specific fields extend the common set where the type requires them
  - decisions: `date`, `alternatives_considered` (frontmatter); rejected-alternatives rationale (body)
  - debt: `target` (resolution timeline, optional); effort/impact (body)
  - security: `regulatory_context` (optional — FCA rule, OWASP category, or compliance requirement; not baked into generic projects)
  - conflicts: `conflicting_sources` (file paths, frontmatter)
  - dependencies: sunset date / migration status / version-drift risk (body)
  - Type-specific fields are defined per registry in `references/standards/registries/<type>.spec.md`

### Review Agent Consumption

- Registries are structured for agent consumption, not just human record
  - An agent loads registry frontmatter (the lightweight index) at review start
  - For each finding it would raise, it checks whether a registry entry with matching context exists; if so it suppresses the finding or notes "known, see {ID}"; if not it raises it
  - Full detail sections are fetched by ID only when relevant to the work in hand

### Resolution Process

- When an entry is resolved (decision reversed, debt paid, gap filled, issue fixed):
  1. Remove the entry from the frontmatter entries array
  2. Remove the corresponding markdown detail section
  3. Commit with the resolution details in the commit message
  4. Update `last_reviewed` date

### Registry Hygiene

- Registries exceeding ~30 active entries should be reviewed for items that should graduate to tickets
- Entries must not be vague — each requires specific evidence and context
- `last_reviewed` date updated when entries are added, removed, or reviewed
- A registry not updated in 3+ months should be flagged as potentially stale

## Validation

- [ ] Three required registries exist (decisions, debt, security)
- [ ] Recommended/optional registries present only when warranted, with correct type and ID prefix
- [ ] No registry entry reads like a work item ("implement X", "fix Y")
- [ ] Entries array in frontmatter matches markdown detail sections
- [ ] Sequence numbers are unique and never reused
- [ ] No Completed sections or resolved entries retained in registry files
- [ ] No registry unreviewed for 3+ months without a staleness flag
