---
specifies: prompts/1-design/1c-create-contracts.md
---

# Prompt Behavior: Create Contracts

**Criticality**: IMPORTANT
**Failure Mode**: External interfaces lack formal specifications

## Specification

Prompt guides AI agent to create machine-readable contracts (OpenAPI, JSON Schema, AsyncAPI) for all external system interfaces.

## Prompt Outputs

- `specs/contracts/api/*.yaml` - OpenAPI specifications
- `specs/contracts/data/*.json` - JSON Schema definitions
- `specs/contracts/events/*.yaml` - AsyncAPI specifications (if applicable)

## Validation

- Contracts created for all external interfaces
- Uses standard formats (OpenAPI 3.0, JSON Schema draft-07, AsyncAPI 2.0)
- Contracts are machine-readable and validatable
- No internal implementation contracts created
