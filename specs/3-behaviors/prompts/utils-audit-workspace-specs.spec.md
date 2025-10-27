---
specifies: prompts/utils/audit-workspace-specs.md
criticality: IMPORTANT
failure_mode: Workspace specs grow unchecked, creating context window bloat and reduced clarity
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/workspace/workflows.spec.md
---

# Prompt Behavior: Audit Workspace Specs

## Requirements

- [!] Prompt guides AI to detect redundancy, bloat, and consolidation opportunities in workspace specs using MSL minimalism tests.
  - Checks workspace spec file sizes (flags >10KB)
  - Scans for duplicate requirements (same concept stated multiple ways)
  - Identifies unnecessary elaboration (verbose explanations)
  - Detects outdated content (references to deprecated practices)
  - Applies MSL minimalism test to each requirement
  - Generates actionable audit report with specific line numbers
  - Recommends consolidations with estimated savings
  - Preserves functionality while reducing size

## Context

Use when:
- Monthly maintenance (periodic MSL audit)
- Before releases (ensure clean state)
- Workspace specs feel "heavy" (too much scrolling)
- AGENTS.md approaching 100KB limit
- After several learning captures (accumulation check)

## Prerequisites

- Workspace specs exist (specs/workspace/)
- AGENTS.md generated (for size checking)
- Git clean state (easy rollback if needed)

## Outputs

- Audit report markdown (size status, redundancies, consolidation opportunities)
- Recommended actions checklist
- Estimated savings (lines, KB)

## Validation

- Audit identifies actual redundancies (spot-check confirms)
- Recommendations are specific (file:line references)
- MSL tests correctly applied (false positives minimal)
- Consolidations preserve functionality (no requirements lost)
- Report is actionable (clear next steps)

## Success Criteria

- Workspace specs trend stable or decreasing in size
- Redundancy detected before it becomes problematic
- Consolidations maintain spec quality
- AGENTS.md stays under 100KB
- Audit takes <15 minutes to run
