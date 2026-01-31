---
derives-from:
  - PURPOSE.md
  - specs/foundation/outcomes.spec.md
supports:
  - specs/strategy/architecture.spec.md
criticality: CRITICAL
failure_mode: Violating these constraints makes LiveSpec unusable or defeats its purpose
governed-by:
  - .livespec/standard/metaspecs/constraints.spec.md
---

# LiveSpec Constraints

## Requirements
- [!] LiveSpec must operate within seven critical boundaries:
  - LiveSpec works across Claude, Copilot, Cursor (agent agnostic)
  - Setup requires only file operations, no installation scripts (manual adoption)
  - All specs follow 4-section MSL format (MSL minimalism)
  - All content is standard markdown in standard folders (no lock-in)
  - Every spec has testable validation criteria (testable behaviors)
  - All code is disposable and regenerable from specs (code disposability)
  - Specs contain WHAT/WHY only, never implementation HOW (abstraction purity)

## Agent Agnostic
Works with any AI coding agent (Claude, Copilot, Cursor, etc.). Same structure produces effective results across 3+ agents.

**Validation criteria:**
- Generated utilities go in `prompts/` (not `.claude/commands/` or tool-specific locations)
- Prompts are readable markdown (no tool-specific syntax requirements)
- Works with Claude, Copilot, Cursor, and manual copy-paste
- No dependencies on specific IDE features (slash commands are optional convenience)
- AGENTS.md guides usage (agent reads prompts and executes them)
- Same prompts work across different agents without modification

### Manual Adoption
Simple enough to adopt without custom tooling. Users can set up and use with standard file operations and AI prompts only.

### MSL Minimalism
All specifications follow MSL principles. Specifications cannot be further reduced without losing essential information.

### No Framework Lock-in
Pure information architecture with no proprietary formats. Specs are readable markdown, folder structure is standard, no custom parsers required.

### Testable Behaviors
All behaviors must be observable and verifiable. Every specification includes concrete validation criteria.

### Code Disposability
All code is disposable and regenerable from specifications. Implementation can be cut off at any point and regrown. Essential knowledge lives in specs, not code.

**Validation criteria:**
- Code contains no knowledge not derivable from specs
- Implementation discoveries level up to appropriate spec layer or remain disposable
- Regeneration from specs produces working code (TDD validates)
- Technical debt accumulates in disposable layer only

### Abstraction Purity
Specifications contain WHAT and WHY, never implementation HOW. Implementation details pollute specs and prevent clean regeneration.

**Validation criteria:**
- No technology choices in behavior specs (unless strategic)
- No performance tuning numbers in specs
- No syntax patterns or idioms in specs
- Qualitative descriptions preferred over quantitative implementation details

## Validation

- LiveSpec works across Claude, Copilot, Cursor (agent agnostic)
- Setup requires only file operations, no installation scripts (manual adoption)
- All specs follow 4-section MSL format (MSL minimalism)
- All content is standard markdown in standard folders (no lock-in)
- Every spec has testable validation criteria (testable behaviors)
- All code is disposable and regenerable from specs (code disposability)
- Specs contain WHAT/WHY only, never implementation HOW (abstraction purity)
