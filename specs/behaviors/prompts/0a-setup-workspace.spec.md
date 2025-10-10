---
specifies: prompts/0-define/0a-setup-workspace.md
criticality: CRITICAL
failure_mode: Users cannot create workspace specifications without guidance
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
---

# Prompt Behavior: Setup Workspace

## Requirements
- [!] Prompt guides AI agent to create workspace/ specifications (constitution, patterns, workflows) that define how the target project is developed, customized for the specific project context.
  - Prompt produces three workspace spec files
  - All specs follow MSL format (Criticality, Failure Mode, Specification, Validation)
  - Specs are specific to target project, not generic
  - User understands workspace defines HOW to build, not WHAT to build
  - Prompt references folder-structure behavior and MSL format requirements

## Prompt Outputs

- `specs/workspace/constitution.spec.md` - Development principles and governance
- `specs/workspace/patterns.spec.md` - Code and specification patterns
- `specs/workspace/workflows.spec.md` - Development process workflows

## Validation

- Prompt produces three workspace spec files
- All specs follow MSL format (Criticality, Failure Mode, Specification, Validation)
- Specs are specific to target project, not generic
- User understands workspace defines HOW to build, not WHAT to build
- Prompt references folder-structure behavior and MSL format requirements
