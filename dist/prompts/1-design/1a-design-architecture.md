---
spec: specs/behaviors/prompts/1a-design-architecture.spec.md
---

# 1a: Design Architecture

**Phase**: DESIGN
**Purpose**: Define high-level solution architecture and key design decisions
**Prerequisites**: Phase 0 complete (problem, constraints, workspace defined)

## Task

Document the solution architecture that addresses the problem within the constraints.

## Create Architecture Specification

Create `specs/strategy/architecture.spec.md` that defines:

### System Structure
- What are the major components?
- How do they interact?
- What are the boundaries?

### Key Design Decisions
- What architectural patterns are used?
- Why were these patterns chosen?
- What alternatives were considered?

### Technology Choices
- What technologies are required by constraints?
- What tradeoffs were made?
- How do choices address the problem?

## MSL Format

```markdown
---
criticality: CRITICAL | IMPORTANT
failure_mode: [What breaks with different architecture]
---

# [Architecture Name]

## Requirements
- [!] [High-level architecture description]
  - Architecture addresses problem statement
  - All constraints are satisfied
  - Components have clear responsibilities
  - Interactions are well-defined

## Components
- [Component 1]: [Purpose]
- [Component 2]: [Purpose]

## Interactions
[How components work together]
```

## Consider Cross-Cutting Concerns

Before finalizing architecture, consider whether these cross-cutting concerns need strategy specs. Not every project needs all of these - create specs when the concern is critical and affects multiple features.

### Observability & Debugging
- Does this system need structured logging for debugging production issues?
- How will you track system health and performance?
- What metrics/telemetry are critical?

**If yes:** Consider `specs/strategy/logging.spec.md` or `specs/strategy/observability.spec.md`

### Error Handling
- How should errors be handled consistently across components?
- What error information needs to be preserved for debugging?
- How do errors propagate through the system?

**If yes:** Consider `specs/strategy/error-handling.spec.md`

### Security
- Does authentication/authorization affect multiple features?
- How are secrets/credentials managed?
- What security boundaries exist?

**If yes:** Consider `specs/strategy/security.spec.md`

### Data & State
- Is there a persistence strategy (database, files, cache)?
- How is data consistency maintained?
- What data flows between components?

**If yes:** Consider `specs/strategy/data.spec.md`

### Integration
- How do components communicate (APIs, events, queues)?
- Are there external system dependencies?
- What integration patterns are used?

**If yes:** Consider `specs/strategy/integration.spec.md`

### Deployment & Operations
- What environments exist (dev, staging, production)?
- How is the system deployed?
- What infrastructure is required?

**If yes:** Consider `specs/strategy/deployment.spec.md`

**Note:** Start with single `architecture.spec.md`. Split into specific strategy specs (logging.spec.md, security.spec.md, etc.) when architecture grows >100 lines or concerns become complex.

**See:** `.livespec/standard/metaspecs/strategy.spec.md` for strategy spec requirements.

## Guidelines

**Focus on "what" not "how":**
- ❌ "Use Express.js framework" → Implementation detail
- ✅ "REST API server handles requests" → Architecture component

**Keep it minimal:**
- Don't specify implementation details
- Don't include every class or function
- Focus on major components and boundaries

**Make it testable:**
- Can you draw the architecture?
- Are responsibilities clear?
- Can you validate it addresses the problem?

## Exit Criteria

- [ ] Architecture specification exists at `specs/strategy/architecture.spec.md`
- [ ] Major components identified
- [ ] Component interactions defined
- [ ] Follows MSL format
- [ ] Architecture satisfies all constraints
- [ ] Architecture solves stated problem
- [ ] Cross-cutting concerns considered (strategy specs created if needed)

## Next Step

Once architecture is defined, proceed to `1b-define-behaviors.md`
