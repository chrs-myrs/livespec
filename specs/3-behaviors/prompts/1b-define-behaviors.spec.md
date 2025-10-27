---
specifies: prompts/1-design/1b-define-behaviors.md
criticality: CRITICAL
failure_mode: Implementation lacks observable behavior specifications
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/functional/five-phases.spec.md
guided-by:
  - specs/2-strategy/phase-workflow.spec.md
---

# Prompt Behavior: Define Behaviors

## Requirements
- [!] Prompt actively verifies Phase 0 prerequisites before proceeding, preventing phase jumping.
  - Checks PURPOSE.md exists (if missing → guide to 0b-define-problem)
  - Checks specs/1-requirements/strategic/outcomes.spec.md exists (if missing → guide to 0c-define-outcomes)
  - Checks specs/1-requirements/strategic/constraints.spec.md exists (if missing → guide to 0f-identify-constraints)
  - Verifies research evaluation complete or documented skip (if missing → guide to 0e-evaluate-research-needs)
  - STOPS execution if any prerequisite missing
  - Outputs clear guidance to missing Phase 0 prompts

- [!] Prompt guides creation of behavior specifications for major system capabilities, focusing on observable outcomes from user/system/stakeholder perspective.
  - Identifies behaviors from PURPOSE.md, requirements, and architecture specs
  - Creates one spec per major capability in `specs/3-behaviors/`
  - Each spec defines observable outcome (WHAT), not implementation (HOW)
  - Each spec includes validation criteria (how to verify)
  - Covers all critical aspects of problem statement
  - Organizes behaviors by domain (subfolder pattern: behaviors/user-features/, behaviors/policies/, behaviors/integrations/, etc.)
  - Integration behaviors (system behavior when using external services) only if non-obvious or critical
  - Integration behaviors reference external documentation, not duplicate it

## Context

Use when:
- After architecture defined (Phase 1a complete)
- Before implementation begins (Phase 2)
- Need to define observable system capabilities
- Converting requirements into testable specifications
- System integrates with external services and integration has non-obvious behavior or failure modes

## Prerequisites

- PURPOSE.md exists with problem statement
- `specs/2-strategy/architecture.spec.md` exists (if applicable)
- `specs/1-requirements/strategic/outcomes.spec.md` or requirements defined
- `specs/3-behaviors/` directory created
- Agent understands observable vs implementation distinction

## Outputs

- `specs/3-behaviors/[domain]/[capability].spec.md` - One spec per major behavior (format: MSL with observable outcomes, validation criteria)
  - Examples: `behaviors/user-features/authentication.spec.md`, `behaviors/policies/access-control.spec.md`, `behaviors/integrations/stripe-webhook-processing.spec.md`
- Integration behaviors in `behaviors/integrations/` (optional, only if non-obvious or critical)
- Integration behaviors link to external documentation (not duplicate it)
- Complete coverage of critical problem aspects
- Domain-organized subfolders (if multi-domain)

## Validation

- Behavior specs exist for all critical capabilities
- Each spec follows MSL format (criticality, failure_mode, Requirements with [!])
- Each spec describes observable outcome (verifiable by user/system/auditor)
- No implementation details in specs (no "use bcrypt", "store in database")
- Validation criteria are specific and testable
- Behaviors organized by domain subfolder (if multi-domain project)
- Traceability: Each behavior maps to requirement or outcome

## Success Criteria

- Behaviors are genuinely observable (testable without implementation knowledge)
- Specs enable implementers to make reasonable HOW decisions
- Coverage complete but not excessive (critical behaviors only)
- Domain organization aids navigation (not arbitrary grouping)
- Behaviors traceable to problem statement/outcomes

## Error Handling

**If PURPOSE.md or requirements missing:**
- Guide to Phase 0: Use `.livespec/0-define/0b-define-problem.md` first
- Explain behaviors derive from problem definition

**If architecture unclear:**
- Can proceed with behavior definition (architecture optional)
- Behaviors define WHAT, architecture defines HOW (separate concerns)

**If agent confuses behavior with implementation:**
- Remind: Behaviors are observable outcomes (user/system perspective)
- Example correction: "Use JWT" → "System authenticates users securely"
- Reference observable vs implementation distinction in prerequisites

**If unclear whether to create integration behavior spec:**
- Test: "Is integration behavior non-obvious, critical, or has failure modes?"
- YES → Create spec in `behaviors/integrations/[service]-[capability].spec.md`
- NO → Skip spec, reference external docs in architecture or code
- Focus: YOUR system's behavior, not external service's behavior
- Always link to external documentation, never duplicate it
- Example: Stripe webhooks with idempotency/retry logic → Create spec
- Example: Simple Auth0 OAuth login following tutorial → Skip spec

## Constraints

What this prompt should NOT do:
- ❌ Specify implementation technology (language, framework, library)
- ❌ Create implementation-level specs (those are code, not behavior specs)
- ❌ Define internal implementation details (data structures, algorithms)
- ❌ Over-specify edge cases that implementer can reasonably handle
- ❌ Create behaviors for trivial/obvious system aspects (focus on critical)
