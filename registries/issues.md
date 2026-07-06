---
store: registry
type: issues
schema_version: 2
last_reviewed: 2026-07-06
entries:
  - id: ISSUE-005
    summary: /livespec:evolve command stale in 9 files (renamed to /livespec:audit, never fully swept)
    severity: low
    status: open
---

# Issue Registry

Tracks known problems accepted for now — what's broken but tolerated.

---

## ISSUE-005: /livespec:evolve command stale in 9 files (renamed to /livespec:audit, never fully swept)

**Context**: Discovered 2026-07-06 while resolving ISSUE-004 and fixing a directly-related dead reference in `skills/design/SKILL.md`. The `evolve` skill was renamed to `audit` in an earlier release, and most of the codebase was updated, but a repo-wide sweep found `/livespec:evolve` still referenced in 9 files: `references/prompts/utils/reorganize-workspace.md`, `references/prompts/utils/analyze-failure.md`, `references/prompts/utils/learn.md`, `agents/context-builder.md`, `specs/strategy/ai-discoverability.spec.md`, `docs/quickstart.md`, `commands/design.md`, `commands/learn.md`, `CHANGELOG.md` (the last is likely a legitimate historical mention, not a live reference — verify per-file rather than assume). Mechanical fix (`/livespec:evolve` → `/livespec:audit`), low severity since the command still resolves to nothing catastrophic, just a stale label.
**Category**: Structure
