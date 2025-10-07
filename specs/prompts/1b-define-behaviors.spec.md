---
specifies: prompts/1-design/1b-define-behaviors.md
criticality: CRITICAL
failure_mode: Implementation lacks observable behavior specifications
constrained_by:
  - .livespec/standard/metaspecs/behavior.spec.md
---

# Prompt Behavior: Define Behaviors

## Requirements
- [!] Prompt guides AI agent to create behavior specifications for all major system capabilities, focusing on observable outcomes not implementation.
  - Multiple behavior specs created in specs/behaviors/
  - Each follows MSL format
  - Behaviors are observable and testable
  - No implementation details included
  - Behaviors cover all aspects of problem statement

## Prompt Outputs

- `specs/behaviors/*.spec.md` - One spec per major behavior/feature

## Validation

- Multiple behavior specs created in specs/behaviors/
- Each follows MSL format
- Behaviors are observable and testable
- No implementation details included
- Behaviors cover all aspects of problem statement
