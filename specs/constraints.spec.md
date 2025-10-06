---
derives_from:
  - PURPOSE.md
  - specs/problem.spec.md
---

# LiveSpec Constraints

**Criticality**: CRITICAL
**Failure Mode**: Violating these constraints makes LiveSpec unusable or defeats its purpose

## Agent Agnostic

**Specification**: LiveSpec must work with any AI coding agent (Claude, Copilot, Cursor, etc.)

**Validation**: Same LiveSpec structure produces effective results across 3+ different AI agents

## Manual Adoption

**Specification**: LiveSpec must be simple enough to adopt and use without custom tooling

**Validation**: Users can set up and use LiveSpec with standard file operations and AI agent prompts only

## MSL Minimalism

**Specification**: All specifications must follow MSL principles (critical requirements only)

**Validation**: Specifications cannot be further reduced without losing essential information

## No Framework Lock-in

**Specification**: LiveSpec must be pure information architecture with no proprietary formats or tools

**Validation**: Specifications are readable markdown, folder structure is standard, no custom parsers required

## Testable Behaviors

**Specification**: All behaviors must be observable and verifiable

**Validation**: Every specification includes concrete validation criteria
