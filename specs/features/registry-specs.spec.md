---
type: behavior
category: features
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Without registry lifecycle management, registries accumulate resolved items, become unreadable backlogs, and lose their purpose as active tracking tools
governed-by:
  - specs/foundation/constraints.spec.md
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement 4: Sustainable methodology)
guided-by:
  - specs/strategy/ai-discoverability.spec.md
  - specs/workspace/patterns.spec.md
derives-from:
  - registries/improvements.md (IMP-008)
---

# Registry Management

## Requirements

### Registries Are Active Backlogs

- [!] Registries contain only open/pending items. Resolved, implemented, or accepted-as-limitation items are removed when their status changes.
  - Git history is the archive — no separate archive files or sections
  - A completed summary line may be retained (ID, date, one-line outcome) for sequence continuity
  - entry_count in frontmatter reflects only active items
  - last_reviewed date updated when items are added, resolved, or reviewed

### Registry Frontmatter Schema

- [!] All registry files carry consistent YAML frontmatter.
  - `store: registry` — identifies the file as a registry
  - `registry_type` — classifies the registry (gaps, issues, improvements)
  - `schema_version` — format version (integer, starting at 1)
  - `last_reviewed` — ISO date of last human review
  - `entry_count` — current number of active entries

### Entry Structure

- [!] All entries follow a consistent structure per registry type.
  - Unique identifier: `[TYPE]-[NNN]` (e.g., GAP-001, ISSUE-001, IMP-001)
  - Status field from controlled vocabulary (see `references/standards/vocabulary.spec.md`)
  - Discovery/implementation date
  - Sequence numbers are never reused (next entry increments from highest historical ID)

### Resolution Process

- When an item is resolved, implemented, or accepted as limitation:
  1. Update the item's status to its terminal state
  2. Commit with the resolution details in the commit message
  3. Remove the full entry from the registry file
  4. Optionally retain a one-line summary in a "Completed" section
  5. Decrement entry_count and update last_reviewed

### Registry Types

**Gaps** — methodology gaps (what's missing)
- Fields: Description, Impact, Frequency, Potential Solution, Status
- Terminal states: Resolved, Accepted Limitation

**Issues** — problems encountered (what's broken)
- Fields: What, Why Problematic, Category, Status, Resolution
- Terminal states: Resolved, Accepted Limitation

**Improvements** — experiments and outcomes (what we're trying)
- Fields: Changed, Hypothesis, Category, Implemented, Decision
- Terminal states: Implemented, Accepted as Limitation

## Validation

- [ ] No registry contains entries with terminal status values
- [ ] entry_count matches actual active entries
- [ ] Sequence numbers are unique and never reused
- [ ] last_reviewed is within the last 30 days
