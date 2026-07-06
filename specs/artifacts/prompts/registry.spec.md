---
type: prompt
category: artifacts
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Without prompt registry, users and AI agents cannot navigate methodology or understand prompt relationships
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md
guided-by:
  - specs/strategy/ai-discoverability.spec.md
  - specs/strategy/architecture.spec.md
derives-from:
  - specs/features/three-modes.spec.md
  - specs/workspace/workflows.spec.md
specifies: []
---

# Prompt Registry

Most LiveSpec functionality is delivered through the 8 self-contained skills
(`skills/*/SKILL.md` — see `specs/artifacts/commands/generation.spec.md` for
the authoritative skill/command mapping). This registry covers what's left:
8 standalone prompt files under `references/prompts/` that are either still
directly referenced by a live skill, or stand alone as reference material
with no natural skill home.

**Status**: ISSUE-004 (17 files with unmigrated unique content) is resolved
— each file was either folded into an existing skill (design, go, learn,
audit) or dropped as out of LiveSpec's domain (implementation/TDD mechanics)
or redundant with content that already exists inline elsewhere. This
registry now describes a stable end state, not an in-progress migration.

## Requirements

- [!] LiveSpec's surviving standalone prompts are indexed with accurate mode, spec, and purpose
  - Each prompt's governing spec (where one exists) lives in `specs/artifacts/prompts/`
  - One prompt currently lacks a governing spec (`learn.md`) — flagged in the table below; separate, pre-existing observation, not part of ISSUE-004
  - Registry reflects actual files on disk, verified against `references/prompts/{define,utils}/`

## Prompt Inventory

### DEFINE (1 prompt)

| Prompt | Spec | Purpose |
|--------|------|---------|
| 0x-validate-understanding | 0x-validate-understanding.spec.md | Verify conceptual understanding (validation only) |

### Utils (7 prompts)

| Prompt | Spec | Purpose |
|--------|------|---------|
| analyze-failure | analyze-failure.spec.md | Forensic analysis when adoption fails |
| feedback-report | utils-feedback-report.spec.md | Structured feedback for LiveSpec improvement |
| learn | (none — no governing spec) | Session completion and learning capture. **Live dependency**: referenced by `skills/learn/SKILL.md` |
| measure-session-compliance | utils-measure-session.spec.md | Session compliance scoring. **Live dependency**: referenced by `skills/learn/SKILL.md` |
| reorganize-workspace | utils-reorganize-workspace.spec.md | Context optimization based on usage patterns |
| run-health-report | utils-run-health-report.spec.md | Diagnostic health assessment with remediation plans |
| suggest-improvements | utils-suggest-improvements.spec.md | Strategic improvement analysis from accumulated data |

## Validation

- Registry lists exactly 8 prompts (1+7), matching `references/prompts/{define,utils}/` on disk
- Every listed prompt file exists; every referenced spec file exists (except `learn.md`, explicitly noted as spec-less)
- `learn.md` and `measure-session-compliance.md` remain in place — deleting either would break `skills/learn/SKILL.md`
- No entry references `dist/`, `.livespec/`, or a deleted prompt file
