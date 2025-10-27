---
specifies: prompts/4-evolve/4a-detect-drift.md
criticality: CRITICAL
failure_mode: Specifications become outdated without detection
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
  - specs/1-requirements/functional/drift-detection.spec.md
  - specs/1-requirements/functional/five-phases.spec.md
guided-by:
  - specs/2-strategy/phase-workflow.spec.md
---

# Prompt Behavior: Detect Drift

## Requirements
- [!] Prompt guides detection of semantic drift between specifications and implementation using 70-80-10 classification pattern (auto-accept/review/manual).
  - Analyzes code changes since last check (via git diff or file comparison)
  - Classifies changes by impact: refactoring (no spec change), behavior addition (new spec), behavior modification (update spec)
  - Uses semantic analysis (understands intent), not just text diff
  - Produces categorized drift report with actionable next steps
  - Applies 70-80-10 target: 70% auto-accepted, 20% for review, 10% manual resolution

## Context

Use when:
- After implementation work (continuous drift detection)
- Before releases (verification that specs match code)
- Weekly/periodic spec synchronization checks
- After merging feature branches

## Prerequisites

- Existing specifications in `specs/` (behaviors/, contracts/, strategy/)
- Implementation code to compare against
- Git repository (for tracking changes since last check)
- Ability to read code and specs

## Outputs

- Drift report (format: markdown with categorized findings):
  - **Auto-accepted**: Refactorings, internal changes, no spec impact
  - **Review required**: Behavior additions or modifications needing spec updates
  - **Manual resolution**: Conflicts, unclear changes, architectural shifts
- Next actions per category (which specs to update, how)
- Optional: Updated specs for auto-accepted changes (format: MSL)

## Validation

- All code changes since last check analyzed
- Changes classified correctly (refactoring vs behavior change)
- Semantic understanding demonstrated (not just string matching)
- Report identifies specific specs needing updates (with file paths)
- Next actions are clear and actionable
- Classification roughly follows 70-80-10 pattern (if significantly off, review classification logic)

## Success Criteria

- Drift detection is semantic (understands intent, not just text changes)
- Classification reduces manual work (70-80% auto or review-only)
- False positives minimal (refactorings correctly auto-accepted)
- False negatives avoided (behavior changes not missed)
- Report actionable (clear which specs to update and why)

## Error Handling

**If no specs exist:**
- Guide to Phase 4b: Use `.livespec/4-evolve/4b-extract-specs.md` to create initial specs
- Explain drift detection requires baseline specifications

**If git history unavailable:**
- Fall back to full codebase scan (compare all files against specs)
- Warn: Without git history, all code appears as "new"

**If unable to classify change:**
- Default to "Manual resolution" category (safe default)
- Include reasoning: "Unable to determine semantic impact"
- Provide context for human reviewer

**If classification heavily skewed (e.g., 100% manual):**
- Report classification distribution in summary
- Suggest: May indicate methodology issues or unclear specs

## Constraints

What this prompt should NOT do:
- ❌ Use text diff alone (must understand semantic impact)
- ❌ Auto-update specs without analysis (review required for behavior changes)
- ❌ Flag trivial changes like formatting, comments (noise reduction)
- ❌ Assume refactoring is "always safe" (some refactorings change behavior)
- ❌ Miss behavior changes hidden in "refactorings" (careful semantic analysis needed)
