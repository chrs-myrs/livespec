---
store: registry
type: issues
schema_version: 2
last_reviewed: 2026-07-02
entries:
  - id: ISSUE-003
    summary: references/prompts/ and much of specs/ still assume the old dist/ distribution model
    severity: medium
    status: open
---

# Issue Registry

Tracks known problems accepted for now — what's broken but tolerated.

---

## ISSUE-003: references/prompts/ and much of specs/ still assume the old dist/ distribution model

**Context**: Discovered 2026-07-02 while resolving ISSUE-001/ISSUE-002 (both now fixed: dead `.livespec` symlink removed, legacy regeneration pathway deleted, generated-file headers now point at `/livespec:audit context`). A much larger sprawl remains: 30+ files under `references/prompts/`, `references/guides/`, and `specs/` (e.g. `specs/artifacts/prompts/*.spec.md`, `specs/strategy/architecture.spec.md`, `specs/workspace/*.spec.md`) still describe or reference the pre-plugin `dist/.claude/commands/livespec/`, `dist/prompts/`, install-script, and `generated_by`/`generated_at` metadata model, none of which exist any more — commands now live flatly at `commands/*.md` routing to `skills/*/SKILL.md` (see `specs/artifacts/commands/generation.spec.md`, rewritten 2026-07-02). Confirmed independently by the context-builder agent during the same session's full AGENTS.md/ctxt/ regeneration: it flagged `specs/strategy/architecture.spec.md`, `specs/strategy/distribution.spec.md`, `specs/workspace/folder-organization.spec.md`, `specs/workspace/context-compression.spec.md`, and `specs/workspace/livespec.spec.md` by name as still detailing the pre-plugin `dist/`/submodule model — these are the highest-priority targets for the audit pass, since they're workspace/strategy specs that directly govern generated output. Unlike ISSUE-001/002, this isn't two files with an obvious replacement — it's a wide, unaudited tail across two directory trees where some content may still be load-bearing (e.g. `references/prompts/utils/learn.md`, `reorganize-workspace.md` — unclear if actively used or fully superseded by the self-contained `skills/*/SKILL.md` pattern). Needs a dedicated DESIGN-mode pass, not a spot-fix.
**Category**: Structure
