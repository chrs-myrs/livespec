---
spec: specs/prompts/0c-identify-constraints.spec.md
---

# 0c: Identify Constraints

**Phase**: DEFINE
**Purpose**: Document hard boundaries that cannot be violated
**Context**: See `specs/constraints.spec.md` (LiveSpec's own constraints) as example

## Task

Create `specs/constraints.md` that defines non-negotiable boundaries for this project.

## What Are Constraints?

Constraints are hard limits that:
- **Cannot be negotiated** (not preferences or goals)
- **Would break the system if violated** (CRITICAL failures)
- **Shape all design decisions** (architectural implications)

## Types of Constraints

### Technical Constraints
- Platform requirements (must run on X)
- Performance limits (must respond in Y ms)
- Compatibility needs (must work with Z)
- Resource limits (memory, bandwidth, cost)

### Business Constraints
- Regulatory compliance (must follow X regulations)
- Budget limits (cannot exceed Y)
- Timeline requirements (must launch by Z)
- Team constraints (skills, size, availability)

### Domain Constraints
- Industry standards (must implement X protocol)
- User constraints (accessibility, devices)
- Integration requirements (must connect to Y)

## MSL Format

Each constraint gets its own section:

```markdown
# Project Constraints

**Criticality**: CRITICAL
**Failure Mode**: Violating these constraints makes the project fail or unusable

## [Constraint Name]

**Specification**: [One sentence stating the constraint]

**Validation**: [How to verify compliance]
```

## Guidelines

**Only include real constraints:**
- ❌ "Should be fast" → Too vague
- ✅ "Must respond within 200ms for 95th percentile" → Testable

**Focus on boundaries:**
- ❌ "Use microservices architecture" → Design decision, not constraint
- ✅ "Must integrate with existing PostgreSQL database" → Real constraint

**Make them testable:**
- Every constraint must have objective validation
- "Cannot exceed" requires specific numbers
- "Must support" requires specific criteria

## Common Mistakes to Avoid

❌ **Goals disguised as constraints**: "Should be user-friendly"
❌ **Preferences**: "Python is preferred language"
❌ **Nice-to-haves**: "Would be good if it scaled"
❌ **Implementation details**: "Must use REST API"

✅ **Real constraints**: "Must handle 10K concurrent users"
✅ **Hard boundaries**: "Cannot store PII data"
✅ **Non-negotiable limits**: "Budget cannot exceed £50K"

## Exit Criteria

- [ ] specs/constraints.md exists
- [ ] Every constraint passes the "would project fail?" test
- [ ] All constraints are testable/verifiable
- [ ] Follows MSL format exactly
- [ ] No design decisions disguised as constraints

## Phase Complete

When workspace, problem, and constraints are defined:
- ✅ **Phase 0: DEFINE is complete**
- → Proceed to **Phase 1: DESIGN** (`prompts/1-design/`)
