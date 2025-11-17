---
implements: specs/3-artifacts/prompts/1b-design-architecture.spec.md
generated: '2025-10-10'
phase: 1-design
estimated_time: "20-30 minutes"
---

# Prompt Behavior: Design Architecture

**Purpose**: Define system architecture and technical approach

## Context

You're in Phase 1 (DESIGN), creating specifications that define what the system should do before any implementation begins.

## Before This Prompt

⚠️ **Prerequisites**: Verify Phase 0 complete before proceeding. [Full checklist](.livespec/standard/phase-prerequisites.md#phase-1-design---prerequisites)

## Task

1. Prompt guides AI agent to document high-level solution architecture defining major components and their interactions, focusing on WHAT not HOW.

## External Dependencies

When documenting architecture, identify major external dependencies:
- Authentication services (Auth0, Okta)
- Payment processors (Stripe, PayPal)
- Cloud services (AWS S3, Google Cloud)
- Major libraries or frameworks

**How to document:**
- Mention dependency with link to documentation
- Explain architectural role (one line)
- Don't duplicate external documentation

**Example:**
"System uses Auth0 (https://auth0.com/docs) for user authentication, providing OAuth2/OIDC identity management."

**When NOT to document:**
- Obvious library usage (logging, HTTP clients)
- Dependencies fully managed in package.json/requirements.txt
- Non-architecturally-significant dependencies

## Output

Generate behavior or contract specifications following MSL format.

## Validation

- Architecture specification exists
- Follows MSL format
- Defines major components and boundaries
- Addresses problem statement
- Satisfies all constraints
- No implementation details (focuses on structure)

## Success Criteria

**This prompt succeeds when:**
- All requirements from spec are satisfied
- Output is actionable and immediately usable
- No ambiguity in what needs to be done
- Clear path from current state to desired state

---

**Criticality**: CRITICAL
**Failure Mode**: Implementation lacks architectural guidance
