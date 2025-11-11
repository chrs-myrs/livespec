# Phase 1: DESIGN

⚠️ **Generated file** - Do not edit directly. Regenerate using `.livespec/prompts/utils/regenerate-contexts.md`

## Summary

Phase 1 designs the solution architecture before implementation. This phase translates strategic outcomes (from Phase 0) into concrete behaviors, contracts, and architectural decisions. Optional UX flow documentation captures user interaction patterns.

## When to Use This Phase

**Entry conditions:**
- Phase 0 complete (PURPOSE.md, constraints, outcomes defined)
- Problem space clear, ready to design solution
- Strategic requirements documented

**Exit conditions:**
- Architecture defined in specs/2-strategy/
- Observable behaviors specified in specs/3-behaviors/
- API/data contracts defined in specs/3-contracts/
- UX flows documented in research/flows/ (if applicable)
- Ready to implement (proceed to Phase 2)

## Phase Workflow

### Optional: Document UX Flows (Skip for Backend/API)

**When to use:**
- Complex user interactions
- Novel UX patterns
- Need stakeholder validation before coding
- Multi-step user workflows

**When to skip:**
- Pure backend/API work
- Well-understood UI patterns
- Simple CRUD interfaces

**Prompt:** `.livespec/1-design/1a-document-ux-flows.md`

**Creates:** `research/flows/[feature]-flow.md` with:
- Mermaid flowcharts showing user journey
- Screen descriptions for each step
- Error handling paths
- Success/failure outcomes

### Step 1: Design Architecture

**Prompt:** `.livespec/1-design/1b-design-architecture.md`

**Creates:** `specs/2-strategy/architecture.spec.md`

**Captures:**
- High-level system structure (components, services, layers)
- Technology selections (with strategic justification)
- Cross-cutting concerns (authentication, logging, caching)
- Integration patterns

**Key principle:** Specify HOW at strategic level (approach), not implementation details

**Example requirements:**
- "System uses microservices architecture for independent scaling"
- "API follows REST conventions with JSON responses"
- "Authentication uses OAuth 2.0 with JWT tokens"

### Step 2: Define Behaviors

**Prompt:** `.livespec/1-design/1c-define-behaviors.md`

**Creates:** Multiple specs in `specs/3-behaviors/`

**Captures:**
- Observable outcomes system must exhibit
- User-facing features
- System behaviors
- Error handling requirements

**Key principle:** Specify WHAT system does (outcomes), not HOW (implementation)

**Example requirements:**
- "System authenticates users via OAuth flow"
- "API returns validation errors with HTTP 400"
- "Cache invalidates on entity updates"

**Organization:**
- One spec per behavior (or related behavior group)
- Use subfolders for domain organization (e.g., behaviors/user-features/, behaviors/system/)

### Step 3: Create Contracts

**Prompt:** `.livespec/1-design/1d-create-contracts.md`

**Creates:** Multiple specs in `specs/3-contracts/`

**Captures:**
- API endpoint definitions (request/response formats)
- Data schemas (database models, event structures)
- Integration contracts (third-party APIs)
- Message formats (events, queues)

**Key principle:** Specify interface precisely (contracts must be exact), not implementation

**Example requirements:**
- "GET /users/{id} returns User object with fields: id, name, email, created_at"
- "User table has columns: id (UUID), name (VARCHAR), email (VARCHAR UNIQUE)"
- "UserCreated event contains: user_id, timestamp, metadata"

**Organization:**
- Group by version (contracts/api/v1/, contracts/api/v2/)
- Separate by type (contracts/database/, contracts/events/)

## Key Prompts

| Prompt | When to Use | Output |
|--------|-------------|--------|
| 1a-document-ux-flows.md | Complex user interactions | research/flows/*.md (Mermaid diagrams) |
| 1b-design-architecture.md | Need system structure | specs/2-strategy/architecture.spec.md |
| 1c-define-behaviors.md | Specify what system does | specs/3-behaviors/*.spec.md |
| 1d-create-contracts.md | Define interfaces | specs/3-contracts/*.spec.md |

## Common Patterns

### REST API Design Pattern

1. **Architecture:** Define REST conventions, authentication approach
2. **Behaviors:** Document resource operations (create user, list posts, etc.)
3. **Contracts:** Specify exact endpoint formats (GET /users/{id}, response schema)

```
specs/2-strategy/api-architecture.spec.md
  → "RESTful design, OAuth 2.0, JSON responses"

specs/3-behaviors/user-management.spec.md
  → "System creates, retrieves, updates users"

specs/3-contracts/api/v1/users.spec.md
  → "GET /users/{id} returns {id, name, email}"
```

### Event-Driven System Pattern

1. **Architecture:** Define event bus, message broker, event sourcing approach
2. **Behaviors:** Document event triggers and handling
3. **Contracts:** Specify event schemas

```
specs/2-strategy/event-architecture.spec.md
  → "Event sourcing with Kafka, CQRS pattern"

specs/3-behaviors/order-processing.spec.md
  → "System publishes OrderCreated event on new order"

specs/3-contracts/events/order-events.spec.md
  → "OrderCreated: {order_id, items[], total, timestamp}"
```

### Microservices Pattern

1. **Architecture:** Define service boundaries, communication patterns
2. **Behaviors:** Document service responsibilities (one spec per service)
3. **Contracts:** Specify service APIs and data contracts

```
specs/2-strategy/microservices-architecture.spec.md
  → "Services: user-service, order-service, payment-service"

specs/3-behaviors/user-service.spec.md
  → "User service manages authentication and profiles"

specs/3-contracts/user-service/api.spec.md
  → "POST /auth/login returns JWT token"
```

## Dual Linkage Pattern (Critical Understanding)

Behavior specs have **two relationships**, not one:

**satisfies** (vertical - WHAT business value):
```yaml
satisfies:
  - specs/1-requirements/strategic/security.spec.md
```
Links directly to requirement being fulfilled

**guided-by** (horizontal - HOW implemented):
```yaml
guided-by:
  - specs/2-strategy/oauth-architecture.spec.md
```
Follows architectural approach

**Why this matters:**
- Enables rapid rebuild (same requirements, different strategy, new behaviors)
- Technology-agnostic requirements (requirements don't change when replatforming)
- Clear traceability (business value vs technical approach)

**Common mistake:** Assuming pure cascade (Requirements → Strategy → Behaviors)

**Correct model:** Behaviors SATISFY requirements (direct) + GUIDED-BY strategy (influence)

## Examples

### Example 1: Simple CRUD API

```bash
# 1. Design architecture
Use .livespec/1-design/1b-design-architecture.md
# Creates: specs/2-strategy/api-architecture.spec.md
# Defines: REST, JSON, PostgreSQL

# 2. Define behaviors (one per resource)
Use .livespec/1-design/1c-define-behaviors.md
# Creates: specs/3-behaviors/user-management.spec.md
#         specs/3-behaviors/post-management.spec.md

# 3. Create contracts
Use .livespec/1-design/1d-create-contracts.md
# Creates: specs/3-contracts/api/v1/users.spec.md
#         specs/3-contracts/api/v1/posts.spec.md
#         specs/3-contracts/database/schema.spec.md

# 4. Proceed to Phase 2 (BUILD)
```

### Example 2: Complex Web Application (with UX research)

```bash
# 1. Document UX flows (optional but recommended)
Use .livespec/1-design/1a-document-ux-flows.md
# Creates: research/flows/user-registration-flow.md
#         research/flows/checkout-flow.md

# 2. Design architecture
Use .livespec/1-design/1b-design-architecture.md
# Creates: specs/2-strategy/web-architecture.spec.md
# Defines: React frontend, Node.js backend, microservices

# 3. Define behaviors (organized by domain)
Use .livespec/1-design/1c-define-behaviors.md
# Creates: specs/3-behaviors/user-features/registration.spec.md
#         specs/3-behaviors/user-features/checkout.spec.md
#         specs/3-behaviors/system/payment-processing.spec.md

# 4. Create contracts (API + events)
Use .livespec/1-design/1d-create-contracts.md
# Creates: specs/3-contracts/api/v1/*.spec.md
#         specs/3-contracts/events/payment-events.spec.md

# 5. Proceed to Phase 2 (BUILD) with TDD
```

## Decision Points

**Do I need UX flows?**
- YES if: Complex interactions, novel UX, need validation
- NO if: Backend/API only, simple patterns

**How detailed should architecture be?**
- Strategic level (approach, key decisions)
- NOT implementation details (class names, function signatures)
- Test: "Does this enable different implementations?" → Good architecture

**One behavior spec or many?**
- Related behaviors → One spec (e.g., "User Authentication")
- Unrelated behaviors → Separate specs
- Test: "Do these behaviors share same purpose?" → One spec

**When do I create contracts?**
- API contracts: When external interface defined
- Data contracts: When schema must be exact
- Event contracts: When event-driven architecture
- Skip contracts if: Pure internal implementation (no external interface)

## Reference Library

**For detailed guidance:**
- Parent: AGENTS.md (root context)
- Prompts: `.livespec/1-design/*.md` (full prompt text)
- Metaspecs: `.livespec/standard/metaspecs/behavior.spec.md`, `.livespec/standard/metaspecs/contract.spec.md`
- Dual linkage: `specs/2-strategy/three-layer-architecture.spec.md`
- Behavior-contract boundary: `.livespec/guides/behavior-contract-boundary.md`

**Cross-references:**
- Phase 0 (DEFINE): Where requirements come from
- Phase 2 (BUILD): Where designs become code
- Architecture docs: `specs/2-strategy/layer-definitions.spec.md`

---

*Phase 1 specialist for LiveSpec*
*Parent: AGENTS.md*
