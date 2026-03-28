# DESIGN Mode

> **Generated file** - Do not edit directly. Regenerate using `.livespec/prompts/utils/regenerate-contexts.md`

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

**Skill:** `/livespec:design spec strategy`

**Creates:** `specs/strategy/architecture.spec.md`

**Frontmatter template:**
```yaml
---
type: strategy
category: strategy
fidelity: decisions-only
criticality: CRITICAL
failure_mode: Implementation lacks architectural guidance
governed-by: []
derives-from:
  - specs/foundation/outcomes.spec.md
  - specs/foundation/constraints.spec.md
---
```

**Captures:**
- High-level system structure
- Technology selections with rationale
- Cross-cutting concerns (auth, logging, caching)
- Integration patterns

**Key principle:** Specify approach (HOW at strategic level), not implementation details.

### Step 2: Define Behaviors

**Skill:** `/livespec:design feature <name>`

**Creates:** Multiple specs in `specs/features/`

**Frontmatter template:**
```yaml
---
type: behavior
category: features
fidelity: behavioral
criticality: IMPORTANT
failure_mode: [Concrete description of user impact]
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement N: Name)
guided-by:
  - specs/strategy/architecture.spec.md
---
```

**Key principle:** Specify WHAT system does (outcomes), not HOW.

**Example:**
```markdown
---
type: behavior
category: features
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Users cannot authenticate
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement 1: Security)
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

**Skill:** `/livespec:design spec contract`

**Creates:** Multiple specs in `specs/interfaces/`

**Frontmatter template:**
```yaml
---
type: contract
category: interfaces
fidelity: full-detail
criticality: IMPORTANT
failure_mode: Integration fails without contract
governed-by: []
supports:
  - specs/features/[feature].spec.md
---
```

**Key principle:** Specify interface precisely (contracts must be exact).

## Dual Linkage Pattern

Behavior specs have **two relationships**:

**satisfies** (vertical — WHAT business value):
```yaml
satisfies:
  - specs/foundation/security-outcomes.spec.md (Requirement 2: Auth)
```

**guided-by** (horizontal — HOW implemented):
```yaml
guided-by:
  - specs/strategy/oauth-architecture.spec.md
```

**Why this matters:**
- Enables rapid rebuild (same requirements, different strategy)
- Technology-agnostic requirements
- Clear traceability

## Frontmatter Checklist for New Specs

Before creating any spec during design:
- [ ] `type` is from allowed values (behavior, contract, strategy, etc.)
- [ ] `category` matches the directory you're placing it in
- [ ] `fidelity` set (behavioral for features, full-detail for interfaces, decisions-only for strategy)
- [ ] `criticality` is CRITICAL or IMPORTANT (not "USEFUL" — that's MSL non-spec territory)
- [ ] `failure_mode` is concrete, one sentence, describes real impact
- [ ] `governed-by` contains only content governance specs (NOT metaspec paths)
- [ ] Per-category fields present (features: satisfies + guided-by; strategy: derives-from; interfaces: supports)
- [ ] All field names hyphenated (`derives-from`, `guided-by`) — never underscored

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

### Governance/Methodology Pattern (LiveSpec-style)

```
specs/strategy/architecture.spec.md
  → "Two-branch model, specs drive everything"

specs/features/context-generation.spec.md
  → "Agent context tree generated from workspace specs"
  satisfies: foundation/outcomes.spec.md
  guided-by: strategy/architecture.spec.md

specs/artifacts/prompts/4d-regenerate-context.spec.md
  → "Prompt generates AGENTS.md + ctxt/ tree"
  specifies: dist/prompts/4-evolve/4d-regenerate-context.md
```

## References

- Design skill: `/livespec:design`
- Parent context: AGENTS.md
- Vocabulary spec: `references/standards/vocabulary.spec.md` (canonical controlled terms)
- Base metaspec: `references/standards/metaspecs/base.spec.md`
- Behavior metaspec: `.livespec/standard/metaspecs/behavior.spec.md`
- Contract metaspec: `.livespec/standard/metaspecs/contract.spec.md`

---

*Design mode specialist for LiveSpec v5.4.2*
*Parent: AGENTS.md*
