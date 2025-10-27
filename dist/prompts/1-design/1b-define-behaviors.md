---
implements: specs/3-behaviors/prompts/1b-define-behaviors.spec.md
generated: '2025-10-10'
phase: 1-design
estimated_time: "30-45 minutes"
---

# Prompt Behavior: Define Behaviors

**Purpose**: Specify observable system behaviors

## Context

You're in Phase 1 (DESIGN), creating specifications that define what the system should do before any implementation begins.

## Before This Prompt

⚠️ **Prerequisites**: Verify Phase 0 complete before proceeding. [Full checklist](.livespec/standard/phase-prerequisites.md#phase-1-design---prerequisites)

## Task

1. Prompt guides AI agent to create behavior specifications for all major system capabilities, focusing on observable outcomes not implementation.

## Integration Behaviors

If your system integrates with external services and the integration has non-obvious behavior or failure modes:

**Create integration behavior spec:**
- Location: `specs/3-behaviors/integrations/[service]-[capability].spec.md`
- Focus: YOUR system's behavior, not the external service's behavior
- Link to external documentation, don't duplicate it

**When to create:**
- Integration has failure modes you must handle
- Integration behavior is non-obvious or critical
- Multiple components use integration (need shared understanding)

**When NOT to create:**
- Obvious library usage (HTTP client, logging)
- Behavior fully documented in external service docs
- Standard patterns (simple API calls)

**Example:**
System authenticates via Auth0 - Create spec if handling token refresh, offline fallback, or multi-tenant complexity. Skip spec if simple OAuth2 login following Auth0 tutorial.

## Output

Generate behavior or contract specifications following MSL format.

## Validation

- Multiple behavior specs created in specs/behaviors/
- Each follows MSL format
- Behaviors are observable and testable
- No implementation details included
- Behaviors cover all aspects of problem statement

## Looking Ahead: How Behavior Specs Are Used

**In Phase 2 (BUILD):**
- Behavior specs become implementation requirements
- Validation criteria become test cases
- Failure modes guide error handling design
- Specs answer "what should this do?" during coding

**In Phase 3 (VERIFY):**
- Validation criteria checked against implementation
- Acceptance review uses behavior specs as checklist
- Observable outcomes tested systematically

**In Phase 4 (EVOLVE):**
- Drift detection compares code behavior vs spec behavior
- New behaviors discovered in code get extracted as specs
- Spec evolution tracked via behavior changes
- Traceability maintained (code → spec → requirement)

**Value of this investment**: 45 minutes writing behavior specs saves days of "what was this supposed to do?" confusion. Specs become living documentation that evolves with your code, not separate docs that rot.

## Success Criteria

**This prompt succeeds when:**
- All requirements from spec are satisfied
- Output is actionable and immediately usable
- No ambiguity in what needs to be done
- Clear path from current state to desired state

---

**Criticality**: CRITICAL
**Failure Mode**: Implementation lacks observable behavior specifications
