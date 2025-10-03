---
specifies: prompts/2-build/2a-implement-from-specs.md
---

# Prompt Behavior: Implement from Specifications

**Criticality**: CRITICAL
**Failure Mode**: Implementation doesn't follow specifications

## Specification

Prompt guides AI agent to implement system by following specifications in priority order (CRITICAL first), respecting workspace patterns and constraints.

## Prompt Inputs

- All specs from specs/ folder
- Workspace specifications for HOW to build
- Behavior specifications for WHAT to build

## Validation

- All CRITICAL behaviors implemented
- Implementation follows workspace patterns
- All constraints satisfied
- Code matches behavior specifications
- No features added beyond specifications
