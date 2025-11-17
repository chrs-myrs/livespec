---
specifies: prompts/4-evolve/4c-sync-complete.md
criticality: CRITICAL
failure_mode: Cannot confirm specs and code are synchronized
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/functional/drift-detection.spec.md
  - specs/1-requirements/functional/five-phases.spec.md
guided-by:
  - specs/2-strategy/phase-workflow.spec.md
---

# Prompt Behavior: Synchronisation Complete

## Requirements
- [!] Prompt guides AI agent to verify all drift resolved, run validation, document evolution, and confirm synchronisation complete.
  - Produces sync completion report (format: markdown with drift resolution summary, validation results, evolution log)
  - All drift items from 4a-detect-drift resolved
  - All tests passing
  - All behaviors have current specifications
  - Evolution documented with rationale
  - Changes committed to version control

## Context

Use when:
- After drift detection and resolution (Phase 4a, 4b complete)
- Need to confirm specs and code aligned
- Before marking evolution cycle complete
- Periodic synchronisation checkpoints

## Prerequisites

- Drift detection run (Phase 4a completed)
- Drift items resolved (specs updated or code fixed)
- Tests exist for all behaviors
- Version control (git) available
- Validation tooling available

## Outputs

- Sync completion report (format: markdown with sections):
  - Drift items resolved (list from 4a, resolution for each)
  - Validation results (all tests pass, behaviors verified)
  - Evolution log (what changed and why)
  - Workspace patterns (any pattern changes documented)
  - Synchronisation confirmation (specs and code aligned)
- Git commit (format: commit message with sync summary, references to drift report)

## Validation

- All drift items from 4a resolved (none outstanding)
- All tests passing (validation run succeeds)
- All behaviors have current specifications (no undocumented functionality)
- Evolution logged with rationale (changes documented)
- Changes committed to version control (git commit exists)
- Sync report references drift detection report (traceability)

## Success Criteria

- Complete resolution (all drift addressed)
- Evidence-based confirmation (validation proves alignment)
- Documented evolution (future reference clear)
- Clean state (ready for next evolution cycle)
- Committed changes (version control up to date)

## Error Handling

**If drift items unresolved:**
- Cannot mark sync complete
- Document outstanding items
- Provide resolution plan
- Estimate completion time

**If tests failing:**
- Cannot confirm synchronisation
- Report which tests fail
- Identify specifications violated
- Fix before sync confirmation

**If evolution rationale unclear:**
- Document "reason unclear" temporarily
- Flag for future investigation
- Complete sync but note gap

**If workspace patterns changed but not documented:**
- Update specs/workspace/patterns.spec.md
- Document pattern changes
- Ensure consistency across project

## Constraints

What this prompt should NOT do:
- ❌ Mark sync complete with unresolved drift (all items must be addressed)
- ❌ Skip validation (must prove alignment)
- ❌ Omit evolution rationale (document WHY changes made)
- ❌ Skip git commit (version control required)
- ❌ Ignore pattern changes (workspace specs must reflect reality)
