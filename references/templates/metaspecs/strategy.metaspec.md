---
type: metaspec
applies-to: specs/strategy/**/*.spec.md
purpose: Define quality criteria for strategy specs (architectural decisions)
---

# Strategy Metaspec

Strategy specs define HOW the system will be built at an architectural level.

## Requirements

- [!] Strategy specs capture cross-cutting architectural decisions
  - Technology choices that affect multiple features
  - Patterns and conventions applied system-wide
  - Integration approaches and boundaries
  - No feature-specific implementation details

- [!] Every decision includes rationale
  - Why this approach over alternatives
  - What tradeoffs were accepted
  - What constraints drove the decision

- [!] Frontmatter links to foundation
  ```yaml
  governed-by: references/templates/metaspecs/strategy.metaspec.md
  derives-from:
    - specs/foundation/outcomes.spec.md
  criticality: CRITICAL | IMPORTANT
  failure_mode: [What breaks without this]
  ```

## Scope Test

**Does this decision affect multiple features?**
- YES → Strategy spec
- NO → Belongs in specific feature spec

**Is this a technology/pattern choice?**
- YES → Strategy spec
- NO → Probably foundation (outcome) or feature (behavior)

## Anti-Patterns

Strategy specs must NOT contain:

- **Feature behaviors** - "User sees dashboard" belongs in features/
- **Success criteria** - Measurable outcomes belong in foundation/
- **Process rules** - "Code review required" belongs in workspace/
- **Implementation code** - Pseudocode/examples OK, real code NO
- **Single-feature decisions** - If it only affects one feature, put it there

## Valid References

| Direction | Target | Relationship |
|-----------|--------|--------------|
| UP | specs/foundation/*.spec.md | derives-from |
| DOWN | specs/features/*.spec.md | guides |
| ACROSS | Other strategy specs | related-to (sparingly) |
| NEVER | specs/workspace/*.spec.md | Process is orthogonal |

## Example Structure

```markdown
---
governed-by: references/templates/metaspecs/strategy.metaspec.md
derives-from:
  - specs/foundation/outcomes.spec.md
criticality: IMPORTANT
failure_mode: Inconsistent architecture across features
---

# [Domain] Architecture

## Requirements

- [!] System uses [pattern/technology] for [concern]
  - Rationale: [why this choice]
  - Tradeoffs: [what we gave up]
  - Applies to: [which features/components]

- [!] [Integration/boundary] follows [approach]
  - Rationale: [why]
  - Alternatives considered: [what else was evaluated]
```

## Common Strategy Spec Types

| Type | Covers | Example |
|------|--------|---------|
| `architecture.spec.md` | Overall system structure | Monolith vs microservices |
| `api-design.spec.md` | API conventions | REST style, versioning |
| `data.spec.md` | Data storage approach | Database choices, schemas |
| `security.spec.md` | Security architecture | Auth approach, encryption |
| `integration.spec.md` | External system connections | Third-party APIs |

## Validation Checklist

- [ ] Decisions are cross-cutting (affect multiple features)
- [ ] Rationale provided for each decision
- [ ] derives-from links to foundation
- [ ] No feature-specific behaviors
- [ ] governed-by frontmatter present
