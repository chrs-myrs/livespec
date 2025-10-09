---
criticality: IMPORTANT
failure_mode: Without clear workflows, contributors don't know how to evolve LiveSpec properly
constrained_by:
  - .livespec/standard/metaspecs/workspace.spec.md
---

# LiveSpec Development Workflows

## Requirements
- [!] LiveSpec development follows specific workflows with spec-first guidance as essential first step: AI agents check for spec existence before implementation, new prompts require behavior specs first, spec changes follow EVOLVE phase workflow, changes validated through real usage before merge, periodic MSL audits maintain minimalism, and documentation updates accompany prompt/spec changes.
  - **Spec-First Guidance Workflow** (essential before implementation):
    - AI checks: Does `specs/behaviors/[deliverable].spec.md` exist for what user wants to implement?
    - If NO: Pause to ensure spec exists first
    - AI says: "I need a specification before implementing. Let's create specs/behaviors/[deliverable].spec.md first using Phase 1 (DESIGN)"
    - AI guides user to appropriate Phase 1 prompt (1a-design-architecture.md, 1b-define-behaviors.md, or 1c-create-contracts.md)
    - If YES: Verify spec has Requirements section with [!] items, Validation criteria, and Failure Mode defined
    - Then proceed to implementation
    - Applies to all deliverables (CHANGELOG, README, configs, templates all need specs)
  - Every prompt in prompts/ has spec in specs/behaviors/prompts/
  - Git history shows specs created before implementation
  - Pull requests include testing evidence
  - Specifications don't grow larger over time (MSL audits)
  - docs/ reflects current prompts/ and specs/ state
