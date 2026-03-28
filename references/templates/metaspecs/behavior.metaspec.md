---
type: metaspec
applies-to:
  - specs/features/**/*.spec.md
  - specs/interfaces/**/*.spec.md
purpose: Define quality criteria for behavior specs (observable outcomes and contracts)
---

# Behavior Metaspec

Behavior specs define WHAT the system does from an external perspective.

## Requirements

- [!] Behavior specs describe observable outcomes, not implementation
  - What users/systems can do or observe
  - External behavior, not internal mechanics
  - Testable without knowing implementation details

- [!] Every behavior has validation criteria
  - How to verify the behavior works
  - Acceptance test scenarios
  - Edge cases and error conditions

- [!] Frontmatter links to strategy and foundation
  ```yaml
  governed-by: references/templates/metaspecs/behavior.metaspec.md
  satisfies:
    - specs/foundation/outcomes.spec.md
  guided-by:
    - specs/strategy/architecture.spec.md
  criticality: CRITICAL | IMPORTANT
  failure_mode: [What breaks without this]
  ```

## Two Subtypes

### Features (specs/features/*.spec.md)
- User-facing behaviors
- System behaviors
- Observable outcomes

### Interfaces (specs/interfaces/*.spec.md)
- API contracts (request/response shapes)
- Data format definitions
- Integration boundaries

**Same metaspec, different focus:**
- Features: "User can reset password"
- Interfaces: "POST /auth/reset returns {token, expires_at}"

## The Behavior Test

**Can you verify this without reading the code?**
- YES → Good behavior spec
- NO → Too implementation-focused

**Would a user/API consumer care about this?**
- YES → Good behavior spec
- NO → Probably strategy or implementation detail

## Anti-Patterns

Behavior specs must NOT contain:

- **Implementation details** - "Uses Redis for caching" belongs in strategy/
- **Database schemas** - Unless it's a public data contract
- **Internal algorithms** - "Sorts using quicksort" is implementation
- **Code structure** - "Has UserService class" is implementation
- **Technology choices** - "Built with React" belongs in strategy/
- **Process rules** - "Requires code review" belongs in workspace/

## Valid References

| Direction | Target | Relationship |
|-----------|--------|--------------|
| UP | specs/foundation/*.spec.md | satisfies |
| UP | specs/strategy/*.spec.md | guided-by |
| ACROSS | Other behavior specs | depends-on (sparingly) |
| NEVER | Implementation files | Specs don't reference code |

## Example Structure

### Feature Spec

```markdown
---
governed-by: references/templates/metaspecs/behavior.metaspec.md
satisfies:
  - specs/foundation/outcomes.spec.md
guided-by:
  - specs/strategy/architecture.spec.md
criticality: IMPORTANT
failure_mode: Users cannot [do thing], blocking [outcome]
---

# [Feature Name]

## Requirements

- [!] User can [observable action]
  - Given: [preconditions]
  - When: [trigger]
  - Then: [observable outcome]
  - Error: [what happens when it fails]
```

### Interface Spec

```markdown
---
governed-by: references/templates/metaspecs/behavior.metaspec.md
satisfies:
  - specs/features/[feature].spec.md
criticality: IMPORTANT
failure_mode: API consumers cannot integrate
---

# [API/Interface Name]

## Endpoints

### [METHOD] [path]

**Request:**
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| field | type | yes/no | what it is |

**Response:**
| Field | Type | Description |
|-------|------|-------------|
| field | type | what it is |

**Errors:**
| Code | Condition |
|------|-----------|
| 400 | Invalid input |
| 404 | Resource not found |
```

## Validation Checklist

- [ ] Behaviors are observable externally
- [ ] No implementation details (technology, algorithms, code structure)
- [ ] Validation criteria are testable
- [ ] satisfies links to foundation outcomes
- [ ] guided-by links to relevant strategy
- [ ] governed-by frontmatter present
