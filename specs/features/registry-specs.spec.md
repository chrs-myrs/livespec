---
type: behavior
category: features
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Without registry purpose alignment, registries become backlogs or bug trackers rather than recording accepted current state, blurring the boundary between known tensions and actionable work
governed-by:
  - specs/foundation/constraints.spec.md
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement 4: Sustainable methodology)
guided-by:
  - specs/strategy/ai-discoverability.spec.md
  - specs/workspace/patterns.spec.md
specifies:
  - references/standards/registries/gaps.spec.md
  - references/standards/registries/issues.spec.md
  - references/standards/registries/improvements.spec.md
---

# Registry Management

## Requirements

### Registries Track Accepted Current State

- [!] Registries record what is known to be true now — not desired state (specs) or actionable work (tickets)
  - Each entry is a state observation: "X is missing because...", "Y is accepted as a known limitation because..."
  - If an entry reads like a work item ("implement X", "fix Y"), it belongs in a ticket, not a registry
  - When an entry becomes actionable, it graduates to a ticket and the registry entry is removed
  - When accepted state changes (gap filled, issue resolved), the entry is removed
  - Git history is the archive — no Completed sections, no resolved entries retained

### Registry Frontmatter Schema (v2)

- [!] All registry files use YAML frontmatter with a machine-readable entries index
  - `store: registry` — identifies the file as a registry
  - `type` — classifies the registry (gaps, issues, improvements)
  - `schema_version: 2` — format version
  - `last_reviewed` — ISO date of last human review
  - `entries` — array of entry summaries (machine-readable index)
  - Markdown body contains full detail per entry

### Entry Structure

- [!] All entries carry structured metadata in the frontmatter entries array
  - Required fields per entry: `id`, `summary`, `severity` (critical/high/medium/low), `status` (open)
  - Entry IDs use prefix matching registry type: `GAP-NNN`, `ISSUE-NNN`, `IMP-NNN`
  - Sequence numbers are never reused (next entry increments from highest historical ID)
  - Markdown body provides full detail per entry (context, evidence, scope)

### Resolution Process

- When an entry is resolved (gap filled, issue fixed, improvement acted on):
  1. Remove the entry from the frontmatter entries array
  2. Remove the corresponding markdown detail section
  3. Commit with the resolution details in the commit message
  4. Update last_reviewed date

### Registry Types

**Gaps** — known missing coverage (what should exist but doesn't yet)
- Frontmatter fields: `id`, `summary`, `severity`, `status`
- Body fields: Context, Scope
- Entry reads as: "X is missing because..."

**Issues** — known problems accepted for now (what's broken but tolerated)
- Frontmatter fields: `id`, `summary`, `severity`, `status`
- Body fields: Context, Category
- Entry reads as: "X is a known limitation because..."

**Improvements** — known improvement opportunities pending review (what works but could be better)
- Frontmatter fields: `id`, `summary`, `severity`, `status`
- Body fields: Evidence, Category
- Entry reads as: "X works but could be better because..."

### Registry Hygiene

- Registries exceeding ~30 active entries should be reviewed for items that should graduate to tickets
- Entries must not be vague — each requires specific evidence and context
- last_reviewed date updated when entries are added, removed, or reviewed

## Validation

- [ ] No registry entry reads like a work item ("implement X", "fix Y")
- [ ] Entries array in frontmatter matches markdown detail sections
- [ ] Sequence numbers are unique and never reused
- [ ] last_reviewed is within the last 30 days
- [ ] No Completed sections or resolved entries retained in registry files
