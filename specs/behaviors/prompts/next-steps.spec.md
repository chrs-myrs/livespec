---
specifies: prompts/utils/next-steps.md
criticality: IMPORTANT
failure_mode: Users get lost in process, skip phases, or don't know what to do next, leading to incomplete adoption
constrained_by:
  - .livespec/standard/metaspecs/behavior.spec.md
---

# Workflow Orchestrator Prompt

## Requirements
- Prompt analyzes current project state (what files exist, when last updated, completion status) and recommends next action based on LiveSpec phase progression, identifying blockers and providing clear next steps.
  - Correctly identifies current phase from file analysis
  - Recommends appropriate next action for project state
  - Detects drift and suggests recovery path
  - Decision tree handles all common scenarios (starting, in-progress, blocked, drifted)
  - Output provides clear, executable next step

## Outputs

- Status report showing:
  - Current phase (0-4) and status
  - What's completed, incomplete, or missing
  - Issues found (blockers/warnings)
  - Recommended next prompt to use with rationale
  - Upcoming milestones and phase-specific tips

## Validation

- Correctly identifies current phase from file analysis
- Recommends appropriate next action for project state
- Detects drift and suggests recovery path
- Decision tree handles all common scenarios (starting, in-progress, blocked, drifted)
- Output provides clear, executable next step
