---
specifies: prompts/0-define/0f-identify-constraints.md
criticality: CRITICAL
failure_mode: Projects violate boundaries that should have been identified upfront
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/functional/five-phases.spec.md
guided-by:
  - specs/2-strategy/phase-workflow.spec.md
---

# Prompt Behavior: Identify Constraints

## Requirements
- [!] Prompt guides AI agent to document hard constraints (technical, business, domain) that cannot be negotiated, distinguishing real constraints from preferences and goals.
  - Produces `specs/1-requirements/strategic/constraints.spec.md` (format: MSL with criticality, failure_mode, Requirements listing non-negotiable boundaries)
  - Each constraint has concrete validation criteria
  - Constraints are real boundaries (not goals or preferences)
  - No design decisions disguised as constraints
  - Each constraint would cause project failure if violated

## Context

Use when:
- Early in Phase 0 (after problem defined, before architecture)
- Need to identify non-negotiable boundaries
- Before making design decisions that might violate constraints
- Team needs clarity on "what we cannot change"

## Prerequisites

- PURPOSE.md exists (understanding of project goals)
- Understanding of domain, business context, technical environment
- `specs/1-requirements/strategic/` directory created
- Agent understands difference between constraints (boundaries) and requirements (goals)

## Outputs

- `specs/1-requirements/strategic/constraints.spec.md` - Non-negotiable project boundaries (format: MSL with hard constraints, each with validation criteria and failure consequences)

## Validation

- specs/1-requirements/strategic/constraints.spec.md exists
- Follows MSL format (criticality, failure_mode, Requirements with [!])
- Each constraint has concrete validation criteria
- Constraints are genuinely non-negotiable (violating them would cause failure)
- No design preferences disguised as constraints
- No goals or aspirations (constraints are boundaries, not targets)
- Each constraint has clear failure consequence

## Success Criteria

- Constraints capture genuine boundaries (technical, business, regulatory, domain)
- Team understands what cannot be negotiated
- Design decisions can be validated against constraints
- Constraints prevent costly violations later
- Minimal set (only true constraints, not preferences)

## Error Handling

**If user confuses goals with constraints:**
- Clarify: Constraints are boundaries (cannot violate), goals are targets (try to achieve)
- Example: "Must be fast" (goal) vs "Must run on existing hardware" (constraint)
- Ask: "What would happen if we violated this?"

**If design decisions disguised as constraints:**
- Challenge: "Is this truly non-negotiable, or a design preference?"
- Example: "Must use microservices" → likely preference, not constraint
- Test: "Could project succeed with different approach?"

**If no constraints identified:**
- Probe for: Regulatory requirements, technical limitations, business boundaries
- Suggest common constraint categories: compliance, integration, performance minimums
- Explain: All projects have some constraints (even if minimal)

**If too many constraints (>8-10):**
- Review each: Is this truly non-negotiable?
- Group related constraints
- Move preferences to architecture decisions

## Constraints

What this prompt should NOT do:
- ❌ Include design preferences (those are architecture decisions)
- ❌ Include aspirational goals (those are outcomes/requirements)
- ❌ Include "nice to have" boundaries (only non-negotiable constraints)
- ❌ Over-constrain (leave design space for implementers)
- ❌ Skip validation criteria (must be able to verify compliance)
