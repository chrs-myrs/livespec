---
store: registry
type: issues
schema_version: 2
last_reviewed: 2026-07-01
entries:
  - id: ISSUE-001
    summary: .livespec -> dist symlink is broken and has no single clean replacement target
    severity: medium
    status: open
  - id: ISSUE-002
    summary: Legacy prompt-based context-regeneration pathway still present alongside its replacement
    severity: medium
    status: open
---

# Issue Registry

Tracks known problems accepted for now — what's broken but tolerated.

---

## ISSUE-001: .livespec -> dist symlink is broken and has no single clean replacement target

**Context**: `dist/` no longer exists at project root following the v5 Claude Code plugin migration (distribution now happens via `.claude-plugin/plugin.json` + top-level `agents/`/`skills/`/`commands/`, not a `dist/` copy). Repointing `.livespec` isn't a one-line fix: `references/` has `guides/`, `prompts/`, `standards/` but is missing `templates/agents/spec-first-enforcement.md` (only present under root-level `templates/`), so either candidate target leaves `.livespec/templates/...` broken. Many specs and generated files still reference `.livespec/...` paths directly. Previously flagged in `.livespec-audit/issues.md` (2026-02-26, v5.1.0, T2 issues #1 and #2).
**Category**: Tooling

## ISSUE-002: Legacy prompt-based context-regeneration pathway still present alongside its replacement

**Context**: `references/prompts/utils/regenerate-contexts.md`, `references/prompts/evolve/4d-regenerate-context.md`, and their specs (`specs/artifacts/prompts/utils-regenerate-context.spec.md`, `specs/artifacts/prompts/4d-regenerate-context.spec.md`) describe a Task-tool sub-agent + chmod-444 workflow that has been superseded by `skills/audit/SKILL.md` (Mode: context) + `agents/context-builder.md`. Discovered 2026-07-01 while adding incremental-update support to context generation — the legacy pathway also documented a `ctxt/phases/`+`ctxt/utils/` tree structure that was never actually built, which caused real confusion during that work (already corrected in the live specs/agent). Neither the legacy files nor their specs have been removed or marked deprecated, so they remain discoverable and can mislead future edits.
**Category**: Structure
