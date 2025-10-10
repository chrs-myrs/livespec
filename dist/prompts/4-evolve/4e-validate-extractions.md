---
implements: specs/behaviors/prompts/4e-validate-extractions.spec.md
generated: '2025-10-10'
phase: 4-evolve
---

# Validate Extracted Specifications Prompt

**Purpose**: Review and validate extracted specifications

## Context

You're in Phase 4 (EVOLVE), maintaining alignment between specifications and code as the system evolves.

## Task

Follow specification requirements.

## Output

Produce drift report, updated specs, or synchronization confirmation.

## Validation

- Prompt provides clear validation criteria (accuracy, completeness, MSL compliance)
- Prompt defines three validation outcomes (PROMOTE/CORRECT/REJECT)
- Prompt includes checklist for validation review
- Prompt guides frontmatter updates (remove extraction, add dependencies)
- Prompt suggests test creation for untested behaviors
- Prompt includes batch validation workflow for efficiency
- Prompt provides prioritization guidance (CRITICAL first)
- Exit criteria verify all extraction markers removed

## Success Criteria

**This prompt succeeds when:**
- All requirements from spec are satisfied
- Output is actionable and immediately usable
- No ambiguity in what needs to be done
- Clear path from current state to desired state

---

**Criticality**: IMPORTANT
**Failure Mode**: Low-confidence extractions remain unvalidated, specs diverge from implementation reality, extraction errors propagate
