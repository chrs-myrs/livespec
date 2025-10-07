---
spec: specs/prompts/1a-design-architecture.spec.md
---

# 1a: Design Architecture

**Phase**: DESIGN
**Purpose**: Define high-level solution architecture and key design decisions
**Prerequisites**: Phase 0 complete (problem, constraints, workspace defined)

## Task

Document the solution architecture that addresses the problem within the constraints.

## Create Architecture Specification

Create `specs/architecture.md` or equivalent that defines:

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

- [ ] Architecture specification exists
- [ ] Major components identified
- [ ] Component interactions defined
- [ ] Follows MSL format
- [ ] Architecture satisfies all constraints
- [ ] Architecture solves stated problem

## Next Step

Once architecture is defined, proceed to `1b-define-behaviors.md`
