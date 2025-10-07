---
derives_from:
  - PURPOSE.md
  - specs/requirements.spec.md
supports:
  - specs/strategy/architecture.spec.md
criticality: CRITICAL
failure_mode: Violating these constraints makes LiveSpec unusable or defeats its purpose
constrained_by:
  - livespec-standard/metaspecs/constraints.spec.md
---

# LiveSpec Constraints

## Requirements
- [!] LiveSpec must operate within five critical boundaries:
  - LiveSpec works across Claude, Copilot, Cursor (agent agnostic)
  - Setup requires only file operations, no installation scripts (manual adoption)
  - All specs follow 4-section MSL format (MSL minimalism)
  - All content is standard markdown in standard folders (no lock-in)
  - Every spec has testable validation criteria (testable behaviors)

## Agent Agnostic
Works with any AI coding agent (Claude, Copilot, Cursor, etc.). Same structure produces effective results across 3+ agents.

### Manual Adoption
Simple enough to adopt without custom tooling. Users can set up and use with standard file operations and AI prompts only.

### MSL Minimalism
All specifications follow MSL principles. Specifications cannot be further reduced without losing essential information.

### No Framework Lock-in
Pure information architecture with no proprietary formats. Specs are readable markdown, folder structure is standard, no custom parsers required.

### Testable Behaviors
All behaviors must be observable and verifiable. Every specification includes concrete validation criteria.

## Validation

- LiveSpec works across Claude, Copilot, Cursor (agent agnostic)
- Setup requires only file operations, no installation scripts (manual adoption)
- All specs follow 4-section MSL format (MSL minimalism)
- All content is standard markdown in standard folders (no lock-in)
- Every spec has testable validation criteria (testable behaviors)
