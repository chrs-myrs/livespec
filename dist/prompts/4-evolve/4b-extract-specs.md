---
implements: specs/behaviors/prompts/4b-extract-specs.spec.md
generated: '2025-10-10'
phase: 4-evolve
---

# Prompt Behavior: Extract Specifications

**Purpose**: Document existing code as specifications

## Context

You're in Phase 4 (EVOLVE), maintaining alignment between specifications and code as the system evolves.

## Task

1. Prompt guides AI agent to extract MSL specifications from code changes or existing codebase, generating behavior and contract specs for undocumented functionality.

## Output

Produce drift report, updated specs, or synchronization confirmation.

## Validation

- All new behaviors have specifications
- All specifications follow MSL format (Criticality, Failure Mode, Specification, Validation)
- Specs describe WHAT not HOW
- Validation criteria are observable and testable

## Success Criteria

**This prompt succeeds when:**
- All requirements from spec are satisfied
- Output is actionable and immediately usable
- No ambiguity in what needs to be done
- Clear path from current state to desired state

---

**Criticality**: CRITICAL
**Failure Mode**: New behaviors remain undocumented
