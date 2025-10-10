---
implements: specs/behaviors/prompts/1c-create-contracts.spec.md
---

# 1c: Create Contracts

**Phase**: DESIGN
**Purpose**: Define API and data contracts for external interfaces
**Context**: Contracts enable integration and testing

## Task

Create contracts in `specs/contracts/` for all external interfaces.

## When to Create Contracts

Create contracts if your system has:
- **APIs** that other systems call
- **Data formats** that must be validated
- **Events** that are published/consumed
- **Integration points** with external systems

If your system has no external interfaces, skip this step.

## Types of Contracts

### API Contracts (`specs/contracts/api/`)
Use OpenAPI 3.0 specification for REST APIs:

```yaml
# specs/contracts/api/users-api.yaml
openapi: 3.0.0
info:
  title: Users API
  version: 1.0.0
paths:
  /users:
    get:
      summary: List users
      responses:
        '200':
          description: Success
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/User'
```

### Data Contracts (`specs/contracts/data/`)
Use JSON Schema for data validation:

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "User",
  "type": "object",
  "required": ["id", "email"],
  "properties": {
    "id": {"type": "string", "format": "uuid"},
    "email": {"type": "string", "format": "email"}
  }
}
```

### Event Contracts (`specs/contracts/events/`)
Use AsyncAPI for event-driven systems:

```yaml
# specs/contracts/events/user-events.yaml
asyncapi: 2.0.0
info:
  title: User Events
  version: 1.0.0
channels:
  user.created:
    publish:
      message:
        payload:
          type: object
          properties:
            userId: {type: string}
            email: {type: string}
```

## Contract Benefits

**For Testing:**
- Use tools like `oasdiff` to detect breaking changes
- Use contract testing (Pact) to validate integrations
- Generate mock servers from contracts

**For AI Agents:**
- Contracts are machine-readable
- Agents can validate implementations
- Drift detection works on contracts

**For Humans:**
- Clear interface documentation
- Version control for APIs
- Change management

## Guidelines

**Only critical interfaces:**
- External APIs (yes)
- Internal helper functions (no)
- Public data formats (yes)
- Private data structures (no)

**Use standard formats:**
- OpenAPI for REST APIs
- JSON Schema for data
- AsyncAPI for events
- GraphQL SDL for GraphQL

**Version your contracts:**
- Include version numbers
- Document breaking vs non-breaking changes
- Plan migration paths

## Exit Criteria

- [ ] All external interfaces have contracts
- [ ] Contracts use standard formats (OpenAPI, JSON Schema, etc.)
- [ ] Contracts are machine-readable
- [ ] No internal implementation contracts (over-specification)

## Phase Complete

When architecture, behaviors, and contracts are defined:
- ✅ **Phase 1: DESIGN is complete**
- → Proceed to **Phase 2: BUILD** (`prompts/2-build/`)
