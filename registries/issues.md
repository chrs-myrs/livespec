---
store: registry
type: issues
schema_version: 2
last_reviewed: 2026-07-02
entries:
  - id: ISSUE-004
    summary: 17 surviving prompt files hold unique content never migrated into any of the 8 skills
    severity: medium
    status: open
---

# Issue Registry

Tracks known problems accepted for now — what's broken but tolerated.

---

## ISSUE-004: 17 surviving prompt files hold unique content never migrated into any of the 8 skills

**Context**: Discovered 2026-07-02 while resolving ISSUE-003 (now fixed: dead `dist/`/`.livespec/` model purged from ~90 files across `references/prompts/`, `references/guides/`, and `specs/`; 18 fully-superseded prompt+spec pairs deleted; `specs/strategy/distribution.spec.md`, `specs/interfaces/distribution/dist-package.spec.md`, and the stash-origin `specs/features/{plugin-skills,ambient-architecture}.spec.md` deleted; `specs/workspace/distribution.spec.md` and `references/standards/conventions/context-tree.spec.md` rewritten). What's left, tracked in `specs/artifacts/prompts/registry.spec.md`, is 25 prompt files — 8 are genuinely still needed (2 live skill dependencies: `learn.md`, `measure-session-compliance.md`; a handful of standalone reference material: `analyze-failure.md`, `feedback-report.md`, `reorganize-workspace.md`, `suggest-improvements.md`, `0x-validate-understanding.md`, `run-health-report.md`). The remaining 17 have unique content that doesn't exist in any skill yet, and deciding where each piece belongs is a feature-design call, not a mechanical fix: `0b-customize-workspace.md` (MCP integration guidance), `0c-define-outcomes.md`, `0d-assess-complexity.md`, `0e-evaluate-research-needs.md`, `0f-identify-constraints.md` (all candidates for `/livespec:design`), `1a-document-ux-flows.md`, `1b-design-architecture.md` (also has a dead link to a `phase-prerequisites.md` file that no longer exists anywhere), `2a-implement-from-specs.md`, `2b-create-tests.md`, `3b-acceptance-review.md` (no governing spec), `4f-document-implementation.md`, `audit-context-compression.md`, `detect-phase-restart.md`, `extract-purpose-overflow.md`, `research-decision-tree.md`, `run-spike.md` (candidates for `/livespec:design` or `/livespec:audit`, or a new dedicated skill). One file, `validate-project.md`, is worse than unmigrated — it describes several mechanisms with no v5 equivalent at all (copying commands from `dist/.claude/commands/livespec/` + `generated_by` frontmatter, `.livespec-version`/`dist/VERSION` sync, symlinked `.livespec/` dogfooding) and needs restructuring, not relocation. Needs a dedicated `/livespec:design` session to decide per-item placement (existing skill vs. new skill vs. drop).
**Category**: Structure
