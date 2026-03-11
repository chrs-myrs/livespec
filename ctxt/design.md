# DESIGN Mode

Sub-agent context for architecture, behaviors, and contracts.

## Summary

Design mode translates strategic outcomes into concrete specifications. This mode creates architecture decisions, observable behaviors, and interface contracts before any implementation begins.

## When to Use

**Entry conditions:**
- Define mode complete (PURPOSE.md, constraints, outcomes exist)
- Problem space clear, ready to design solution
- Strategic requirements documented

**Exit conditions:**
- Architecture defined in specs/strategy/
- Observable behaviors specified in specs/features/
- API/data contracts defined in specs/interfaces/
- Ready to implement

## Workflow

### Step 1: Design Architecture

**Skill:** `/livespec:do spec strategy`

**Creates:** `specs/strategy/architecture.spec.md`

**Captures:**
- High-level system structure
- Technology selections with rationale
- Cross-cutting concerns (auth, logging, caching)
- Integration patterns

**Key principle:** Specify approach (HOW at strategic level), not implementation details.

**Example:**
```markdown
---
criticality: CRITICAL
failure_mode: Implementation lacks architectural guidance
---

# System Architecture

## Requirements

- [!] System uses microservices for independent scaling.
  - User service handles authentication
  - Order service handles transactions
  - Services communicate via message queue
```

### Step 2: Define Behaviors

**Skill:** `/livespec:do feature <name>` or `/livespec:do spec behavior`

**Creates:** Multiple specs in `specs/features/`

**Captures:**
- Observable outcomes system must exhibit
- User-facing features
- System behaviors
- Error handling

**Key principle:** Specify WHAT system does (outcomes), not HOW.

**Example:**
```markdown
---
criticality: IMPORTANT
failure_mode: Users cannot authenticate
satisfies:
  - specs/foundation/outcomes.spec.md
guided-by:
  - specs/strategy/architecture.spec.md
---

# User Authentication

## Requirements

- [!] Users can authenticate with email and password.
  - Valid credentials grant access
  - Invalid credentials show error
  - Session persists across browser refresh
```

### Step 3: Create Contracts

**Skill:** `/livespec:do spec contract`

**Creates:** Multiple specs in `specs/interfaces/`

**Captures:**
- API endpoint definitions
- Data schemas
- Integration contracts
- Message formats

**Key principle:** Specify interface precisely (contracts must be exact).

**Example:**
```markdown
---
criticality: IMPORTANT
failure_mode: Integration fails without contract
---

# Auth API Contract

## Requirements

- [!] POST /auth/login accepts credentials and returns token.
  - Request: {email: string, password: string}
  - Response: {token: string, expires: number}
  - Error: 401 with {error: string}
```

## Dual Linkage Pattern

Behavior specs have **two relationships**:

**satisfies** (vertical - WHAT business value):
```yaml
satisfies:
  - specs/foundation/security-outcomes.spec.md
```

**guided-by** (horizontal - HOW implemented):
```yaml
guided-by:
  - specs/strategy/oauth-architecture.spec.md
```

**Why this matters:**
- Enables rapid rebuild (same requirements, different strategy)
- Technology-agnostic requirements
- Clear traceability

## Decision Points

**How detailed should architecture be?**
- Strategic level (approach, key decisions)
- NOT implementation details (class names, function signatures)
- Test: "Does this enable different implementations?" → Good

**One behavior spec or many?**
- Related behaviors → One spec
- Unrelated behaviors → Separate specs
- Test: "Do these share same purpose?" → One spec

**When to create contracts?**
- API contracts: External interface defined
- Data contracts: Schema must be exact
- Event contracts: Event-driven architecture
- Skip if: Pure internal implementation

## Common Patterns

### REST API Pattern

```
specs/strategy/api-architecture.spec.md
  → "RESTful, OAuth 2.0, JSON responses"

specs/features/user-management.spec.md
  → "System creates, retrieves, updates users"

specs/interfaces/api/v1/users.spec.md
  → "GET /users/{id} returns {id, name, email}"
```

### Event-Driven Pattern

```
specs/strategy/event-architecture.spec.md
  → "Event sourcing with Kafka, CQRS pattern"

specs/features/order-processing.spec.md
  → "System publishes OrderCreated on new order"

specs/interfaces/events/order-events.spec.md
  → "OrderCreated: {order_id, items[], total}"
```

## References

- Do skill: `/livespec:do`
- Parent context: AGENTS.md
- Metaspecs: `.livespec/standard/metaspecs/behavior.spec.md`, `.livespec/standard/metaspecs/contract.spec.md`
- Behavior-contract boundary: `.livespec/guides/behavior-contract-boundary.md`

---

*Design mode specialist for LiveSpec*
*Parent: AGENTS.md*
