---
specifies: prompts/4-evolve/4b-extract-specs.md
criticality: CRITICAL
failure_mode: New behaviors remain undocumented
---

# Prompt Behavior: Extract Specifications

## Requirements
- [!] Prompt guides AI agent to extract MSL specifications from code changes or existing codebase, generating behavior and contract specs for undocumented functionality.
  - All new behaviors have specifications
  - All specifications follow MSL format (Criticality, Failure Mode, Specification, Validation)
  - Specs describe WHAT not HOW
  - Validation criteria are observable and testable

## Prompt Outputs

- New `specs/behaviors/*.spec.md` for new behaviors
- Updated `specs/contracts/` for new interfaces
- Specs follow MSL format strictly

## Validation

- All new behaviors have specifications
- All specifications follow MSL format (Criticality, Failure Mode, Specification, Validation)
- Specs describe WHAT not HOW
- Validation criteria are observable and testable
