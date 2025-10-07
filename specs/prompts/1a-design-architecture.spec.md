---
specifies: prompts/1-design/1a-design-architecture.md
criticality: CRITICAL
failure_mode: Implementation lacks architectural guidance
constrained_by:
  - .livespec/specs/metaspecs/behavior.spec.md
---

# Prompt Behavior: Design Architecture

## Requirements
- [!] Prompt guides AI agent to document high-level solution architecture defining major components and their interactions, focusing on WHAT not HOW.
  - Architecture specification exists
  - Follows MSL format
  - Defines major components and boundaries
  - Addresses problem statement
  - Satisfies all constraints
  - No implementation details (focuses on structure)

## Prompt Outputs

- `specs/architecture.spec.md` or equivalent - System structure and key design decisions

## Validation

- Architecture specification exists
- Follows MSL format
- Defines major components and boundaries
- Addresses problem statement
- Satisfies all constraints
- No implementation details (focuses on structure)
