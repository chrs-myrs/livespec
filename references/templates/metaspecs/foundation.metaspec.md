---
type: metaspec
applies-to: specs/foundation/**/*.spec.md
purpose: Define quality criteria for foundation specs (outcomes and constraints)
---

# Foundation Metaspec

Foundation specs define WHY the system exists and its non-negotiable boundaries.

## Requirements

- [!] Foundation specs capture strategic intent without implementation details
  - Outcomes are measurable success criteria
  - Constraints are externally imposed boundaries (not preferences)
  - No technology choices or architectural decisions
  - No feature-specific behaviors

- [!] Every requirement has clear validation criteria
  - "Success looks like..." statements
  - Measurable or observable outcomes
  - No vague aspirations ("should be good")

- [!] Frontmatter includes governance
  ```yaml
  governed-by: references/templates/metaspecs/foundation.metaspec.md
  criticality: CRITICAL | IMPORTANT
  failure_mode: [What breaks without this]
  ```

## Two Subtypes

### Outcomes (specs/foundation/outcomes.spec.md)
- What success looks like
- Measurable goals
- User/stakeholder value

### Constraints (specs/foundation/constraints.spec.md)
- External requirements (regulatory, contractual)
- Hard technical limits (not preferences)
- Non-negotiable boundaries

## Anti-Patterns

Foundation specs must NOT contain:

- **Implementation details** - "Use PostgreSQL" belongs in strategy/
- **Feature behaviors** - "User can login" belongs in features/
- **Process rules** - "PRs require review" belongs in workspace/
- **Preferences disguised as constraints** - "Should use TypeScript" is not a constraint
- **Technology choices** - Architecture decisions belong in strategy/

## Valid References

| Direction | Target | Relationship |
|-----------|--------|--------------|
| UP | PURPOSE.md | derives-from |
| DOWN | strategy/*.spec.md | informs |
| DOWN | features/*.spec.md | satisfied-by |
| NEVER | Other foundation specs | No circular deps |

## Example Structure

```markdown
---
governed-by: references/templates/metaspecs/foundation.metaspec.md
criticality: CRITICAL
failure_mode: Without clear outcomes, success cannot be measured
---

# Strategic Outcomes

## Requirements

- [!] System enables [measurable outcome]
  - Success: [specific metric or state]
  - Validation: [how to verify]

- [!] System operates within [constraint]
  - Source: [why this is non-negotiable]
  - Validation: [how to verify compliance]
```

## Validation Checklist

- [ ] No implementation/technology mentions
- [ ] All requirements have validation criteria
- [ ] Constraints cite external source (regulation, contract, physics)
- [ ] Outcomes are measurable
- [ ] governed-by frontmatter present
