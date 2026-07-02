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

Most LiveSpec functionality is now delivered through the 8 self-contained
skills (`skills/*/SKILL.md` — see `specs/artifacts/commands/generation.spec.md`
for the authoritative skill/command mapping). This registry covers what's
left: 25 standalone prompt files under `references/prompts/` whose content
hasn't been migrated into a skill yet, plus a handful still directly
referenced by a live skill.

**Status**: Some entries below cover functionality with unmigrated unique
content (tracked separately as a deferred content-migration issue) — their
placement is not final. This registry describes what exists on disk today,
not a target architecture.

## Requirements

- [!] LiveSpec's surviving standalone prompts are indexed with accurate mode, spec, and purpose
  - Each prompt's governing spec (where one exists) lives in `specs/artifacts/prompts/`
  - Two prompts currently lack a governing spec (`3b-acceptance-review.md`, `learn.md`) — flagged in the tables below
  - Registry reflects actual files on disk, verified against `references/prompts/{define,design,evolve,utils}/`

## Prompt Inventory

### DEFINE (6 prompts)

| Prompt | Spec | Purpose |
|--------|------|---------|
| 0b-customize-workspace | 0b-customize-workspace.spec.md | Full workspace customization (20-30 min, tailored) |
| 0c-define-outcomes | 0c-define-outcomes.spec.md | Define high-level requirements |
| 0d-assess-complexity | 0d-assess-complexity.spec.md | Evaluate project scope and approach |
| 0e-evaluate-research-needs | 0e-evaluate-research-needs.spec.md | Determine if UX research required |
| 0f-identify-constraints | 0f-identify-constraints.spec.md | Document non-negotiable boundaries |
| 0x-validate-understanding | 0x-validate-understanding.spec.md | Verify conceptual understanding (validation only) |

### DESIGN (2 prompts)

| Prompt | Spec | Purpose |
|--------|------|---------|
| 1a-document-ux-flows | 1a-document-ux-flows.spec.md | Document user interaction flows before architecture |
| 1b-design-architecture | 1b-design-architecture.spec.md | Define system structure and components |

### EVOLVE (4 prompts)

| Prompt | Spec | Purpose |
|--------|------|---------|
| 2a-implement-from-specs | (none) | Spec-driven implementation guidance |
| 2b-create-tests | (none) | Create tests from behavior specs |
| 3b-acceptance-review | (none — no governing spec) | Stakeholder acceptance review |
| 4f-document-implementation | 4f-document-implementation.spec.md | Create comprehensive implementation report |

### Utils (13 prompts)

| Prompt | Spec | Purpose |
|--------|------|---------|
| analyze-failure | analyze-failure.spec.md | Forensic analysis when adoption fails |
| audit-context-compression | utils-audit-context-compression.spec.md | Analyze context compression effectiveness |
| detect-phase-restart | utils-detect-phase-restart.spec.md | Detect and handle phase restarts mid-project |
| extract-purpose-overflow | utils-extract-purpose-overflow.spec.md | Route PURPOSE.md overflow content to proper specs |
| feedback-report | utils-feedback-report.spec.md | Structured feedback for LiveSpec improvement |
| learn | (none — no governing spec) | Session completion and learning capture. **Live dependency**: referenced by `skills/learn/SKILL.md` |
| measure-session-compliance | utils-measure-session.spec.md | Session compliance scoring. **Live dependency**: referenced by `skills/learn/SKILL.md` |
| reorganize-workspace | utils-reorganize-workspace.spec.md | Context optimization based on usage patterns |
| research-decision-tree | utils-research-decision-tree.spec.md | Research decision framework |
| run-health-report | utils-run-health-report.spec.md | Diagnostic health assessment with remediation plans |
| run-spike | run-spike.spec.md | Time-boxed technical exploration |
| suggest-improvements | utils-suggest-improvements.spec.md | Strategic improvement analysis from accumulated data |
| validate-project | utils-validate-project.spec.md | Comprehensive project validation |

## Validation

- Registry lists exactly 25 prompts (6+2+4+13), matching `references/prompts/{define,design,evolve,utils}/` on disk
- Every listed prompt file exists; every referenced spec file exists (except the two explicitly noted as spec-less)
- `learn.md` and `measure-session-compliance.md` remain in place — deleting either would break `skills/learn/SKILL.md`
- No entry references `dist/`, `.livespec/`, or a deleted prompt file
