---
specifies: prompts/4-evolve/4a-detect-drift.md
criticality: CRITICAL
failure_mode: Specifications become outdated without detection
---

# Prompt Behavior: Detect Drift

## Requirements
- [!] Prompt guides AI agent to detect semantic drift between specifications and implementation using 70-80-10 classification pattern (auto-accept, review, manual).
  - All code changes since last check reviewed
  - Changes classified by type (refactoring, behavior change, new feature)
  - Semantic analysis used (not just text diff)
  - Next actions clearly identified

## Prompt Outputs

- Drift report classifying all changes
- Auto-accepted changes listed
- Changes requiring review identified
- Changes requiring manual resolution flagged

## Validation

- All code changes since last check reviewed
- Changes classified by type (refactoring, behavior change, new feature)
- Semantic analysis used (not just text diff)
- Next actions clearly identified
