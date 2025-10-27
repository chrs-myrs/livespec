---
specifies: prompts/1-design/1c-create-contracts.md
criticality: IMPORTANT
failure_mode: External interfaces lack formal specifications
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/functional/five-phases.spec.md
guided-by:
  - specs/2-strategy/phase-workflow.spec.md
---

# Prompt Behavior: Create Contracts

## Requirements
- [!] Prompt actively verifies Phase 0 prerequisites before proceeding, preventing phase jumping.
  - Checks PURPOSE.md exists (if missing → guide to 0b-define-problem)
  - Checks specs/1-requirements/strategic/outcomes.spec.md exists (if missing → guide to 0c-define-outcomes)
  - Checks specs/1-requirements/strategic/constraints.spec.md exists (if missing → guide to 0f-identify-constraints)
  - Verifies research evaluation complete or documented skip (if missing → guide to 0e-evaluate-research-needs)
  - STOPS execution if any prerequisite missing
  - Outputs clear guidance to missing Phase 0 prompts

- [!] Prompt guides AI agent to create machine-readable contracts (OpenAPI, JSON Schema, AsyncAPI) for all external system interfaces.
  - Produces contract files in `specs/3-contracts/` subdirectories (format: OpenAPI 3.0 YAML, JSON Schema draft-07, AsyncAPI 2.0 YAML)
  - Contracts created for all external interfaces (API, data formats, async events)
  - Uses standard, machine-readable formats
  - Contracts are validatable (pass format validators)
  - No internal implementation contracts (only external interfaces)

## Context

Use when:
- After architecture defined (Phase 1a complete)
- Before implementation (Phase 2)
- System has external interfaces (APIs, data exchange, events)
- Need formal interface specifications for:
  - API client/server implementation
  - Data validation
  - Integration testing
  - External system integration

## Prerequisites

- specs/2-strategy/architecture.spec.md exists (identifies external interfaces)
- specs/3-behaviors/ exists (defines system behaviors requiring interfaces)
- `specs/3-contracts/` directory created with subdirectories (api/, data/, events/)
- Agent understands contract formats (OpenAPI, JSON Schema, AsyncAPI)
- Agent understands difference between external (needs contract) and internal (no contract) interfaces

## Outputs

- `specs/3-contracts/api/*.yaml` - OpenAPI 3.0 specifications for REST/HTTP APIs (format: YAML with paths, operations, request/response schemas, authentication)
- `specs/3-contracts/data/*.json` - JSON Schema draft-07 definitions for data structures (format: JSON with type definitions, validation rules)
- `specs/3-contracts/events/*.yaml` - AsyncAPI 2.0 specifications for async messaging (format: YAML with channels, messages, bindings) (if applicable)

## Validation

- Contract files exist for all external interfaces identified in architecture
- All files use standard formats (OpenAPI 3.0, JSON Schema draft-07, AsyncAPI 2.0)
- Contracts pass format validators (openapi-validator, ajv, asyncapi-validator)
- Contracts are machine-readable (parseable by standard tools)
- No contracts created for internal implementation details
- Contracts traceable to behaviors (interface supports specific system behaviors)

## Success Criteria

- Contracts enable automated validation and testing
- Contracts comprehensive (cover all external interaction scenarios)
- Contracts precise (unambiguous, enforceable)
- Contracts minimal (no over-specification of internal details)
- Contracts maintainable (clear, well-documented)

## Error Handling

**If architecture doesn't identify external interfaces:**
- Guide to Phase 1a: Review architecture to identify integration points
- Explain contracts needed for external system interactions

**If unclear whether interface is external:**
- Test: "Does entity outside our control use this interface?"
- YES → External → Needs contract
- NO → Internal → No contract needed

**If external service documentation already exists:**
- Reference external docs (Auth0, Stripe, AWS), don't copy them
- Optional: Import OpenAPI spec to `knowledge/integrations/` if needed for code generation
- Don't duplicate external documentation in `specs/3-contracts/`
- Create contract only if YOU provide the interface or external docs unavailable

**If contract format unclear:**
- REST/HTTP API → OpenAPI 3.0 (YAML)
- Data structures → JSON Schema draft-07 (JSON)
- Async messaging → AsyncAPI 2.0 (YAML)
- Other → Use most appropriate standard format

**If contract validation fails:**
- Use format validator to identify issues
- Fix schema errors before proceeding
- Ensure contract follows spec version correctly

## Constraints

What this prompt should NOT do:
- ❌ Create contracts for internal implementation interfaces (only external)
- ❌ Duplicate external API documentation (reference it instead)
- ❌ Create contracts for well-documented external services (link to their docs)
- ❌ Over-specify implementation details in contracts (keep interface-focused)
- ❌ Use non-standard contract formats (stick to OpenAPI, JSON Schema, AsyncAPI)
- ❌ Skip validation (all contracts must be machine-validatable)
- ❌ Create contracts without traceability to behaviors (must support system requirements)
