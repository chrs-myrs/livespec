---
specifies: prompts/1-design/1a-design-architecture.md
criticality: CRITICAL
failure_mode: Implementation lacks architectural guidance
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/functional/five-phases.spec.md
guided-by:
  - specs/2-strategy/phase-workflow.spec.md
---

# Prompt Behavior: Design Architecture

## Requirements
- [!] Prompt actively verifies Phase 0 prerequisites before proceeding, preventing phase jumping.
  - Checks PURPOSE.md exists (if missing → guide to 0b-define-problem)
  - Checks specs/1-requirements/strategic/outcomes.spec.md exists (if missing → guide to 0c-define-outcomes)
  - Checks specs/1-requirements/strategic/constraints.spec.md exists (if missing → guide to 0f-identify-constraints)
  - Verifies research evaluation complete or documented skip (if missing → guide to 0e-evaluate-research-needs)
  - STOPS execution if any prerequisite missing
  - Outputs clear guidance to missing Phase 0 prompts

- [!] Prompt guides AI agent to document high-level solution architecture defining major components and their interactions, focusing on WHAT not HOW.
  - Produces `specs/2-strategy/architecture.spec.md` (format: MSL with major components, boundaries, key design decisions)
  - Defines major components and their responsibilities
  - Identifies major external dependencies with links to documentation
  - Addresses problem statement from PURPOSE.md
  - Satisfies all constraints from constraints.spec.md
  - No implementation details (focuses on structure and approach)

## Context

Use when:
- After outcomes/constraints defined (Phase 0 complete)
- Before detailed behavior specification (Phase 1b)
- Need high-level solution approach
- Team needs architectural guidance before implementation

## Prerequisites

- PURPOSE.md exists (problem understanding)
- specs/1-requirements/strategic/outcomes.spec.md exists (requirements)
- specs/1-requirements/strategic/constraints.spec.md exists (boundaries)
- `specs/2-strategy/` directory created
- Agent understands difference between architecture (WHAT components) and implementation (HOW to build)

## Outputs

- `specs/2-strategy/architecture.spec.md` - System structure and key design decisions (format: MSL with major components, component responsibilities, interaction patterns, key design decisions, major external dependencies with documentation links, constraint satisfaction explanation)

## Validation

- specs/2-strategy/architecture.spec.md exists
- Follows MSL format (criticality, failure_mode, Requirements with [!])
- Defines major components with clear responsibilities
- Defines component boundaries and interfaces
- Major external dependencies identified with documentation links
- External dependencies referenced, not duplicated
- Addresses all outcomes from outcomes.spec.md
- Satisfies all constraints from constraints.spec.md
- No implementation details (languages, frameworks, specific libraries)
- Architecture is appropriate to problem scale

## Success Criteria

- Architecture provides clear implementation guidance without over-prescribing
- Components have single, well-defined responsibilities
- Boundaries minimize coupling and dependencies
- Design decisions traceable to requirements/constraints
- Architecture leaves appropriate design space for implementers

## Error Handling

**If outcomes/constraints unclear:**
- Guide to Phase 0: Complete 0b-0d prompts first
- Explain architecture derives from outcomes and respects constraints

**If architecture becomes implementation-detailed:**
- Remind: Architecture is WHAT components, not HOW to build
- Example: "Uses React components" → "Has UI layer"
- Focus on logical structure, not technology choices

**If architecture too simple (single component):**
- Question whether decomposition needed
- Small projects may not need complex architecture
- Document "monolithic" as valid architectural decision if appropriate

**If architecture too complex (many components):**
- Review component responsibilities for overlap
- Consider grouping related components
- Apply YAGNI: Only decompose where genuinely needed

**If unclear whether to document external dependency:**
- Test: "Is this dependency architecturally significant?"
- YES → Mention in architecture with link to external docs (one line)
- NO → Document in standard dependency file (package.json, requirements.txt), not architecture
- Most dependencies don't need architectural documentation
- Reference external docs, never duplicate them

## Constraints

What this prompt should NOT do:
- ❌ Specify implementation technology (language, framework, library)
- ❌ Include detailed component internals (those emerge during implementation)
- ❌ Over-decompose into excessive components (keep appropriate to scale)
- ❌ Ignore constraints from constraints.spec.md (architecture must respect boundaries)
- ❌ Create architecture that doesn't address outcomes (must be traceable)
