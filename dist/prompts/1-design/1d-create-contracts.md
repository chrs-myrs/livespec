---
implements: specs/3-artifacts/prompts/1d-create-contracts.spec.md
generated: '2025-10-10'
phase: 1-design
estimated_time: "15-20 minutes"
---

# Prompt Behavior: Create Contracts

**Purpose**: Define interfaces and data contracts

## Context

You're in Phase 1 (DESIGN), creating specifications that define what the system should do before any implementation begins.

## Before This Prompt

⚠️ **Prerequisites**: Verify Phase 0 complete before proceeding. [Full checklist](.livespec/standard/phase-prerequisites.md#phase-1-design---prerequisites)

## Task

Follow specification requirements.

## External Service Contracts

Most external services (Auth0, Stripe, AWS) have excellent documentation. Reference it, don't duplicate it.

**When to import external contracts:**
- Code generation from OpenAPI spec
- Contract testing against external API
- External docs unavailable or unclear

**How to handle:**
1. Reference external docs in behavior specs
2. If importing OpenAPI spec, place in `knowledge/integrations/[service]-api.yaml`
3. Link behavior specs to knowledge/ imports
4. Don't create contracts for well-documented external services

**Focus on YOUR interfaces**, not external ones.

## Output

Generate behavior or contract specifications following MSL format.

## Validation

- Contracts created for all external interfaces
- Uses standard formats (OpenAPI 3.0, JSON Schema draft-07, AsyncAPI 2.0)
- Contracts are machine-readable and validatable
- No internal implementation contracts created

## Success Criteria

**This prompt succeeds when:**
- All requirements from spec are satisfied
- Output is actionable and immediately usable
- No ambiguity in what needs to be done
- Clear path from current state to desired state

---

**Criticality**: IMPORTANT
**Failure Mode**: External interfaces lack formal specifications
