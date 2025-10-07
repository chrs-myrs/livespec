---
criticality: IMPORTANT
failure_mode: Without clear workflows, contributors don't know how to evolve LiveSpec properly
constrained_by:
  - livespec-standard/metaspecs/workspace.spec.md
---

# LiveSpec Development Workflows

## Requirements
- LiveSpec development follows specific workflows: new prompts require behavior specs first, spec changes follow EVOLVE phase workflow, changes validated through real usage before merge, periodic MSL audits maintain minimalism, and documentation updates accompany prompt/spec changes.
  - Every prompt in prompts/ has spec in specs/prompts/
  - Git history shows specs update with implementation
  - Pull requests include testing evidence
  - Specifications don't grow larger over time
  - docs/ reflects current prompts/ and specs/ state
