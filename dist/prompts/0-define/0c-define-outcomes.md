---
implements: specs/behaviors/prompts/0c-define-outcomes.spec.md
---

# 0c: Define Outcomes

**Phase**: DEFINE
**Purpose**: Define high-level requirements (what must be achieved)
**Prerequisites**: PURPOSE.md exists

## Task

Create `specs/mission/outcomes.spec.md` that defines high-level project outcomes derived from PURPOSE.md.

## Questions to Answer

1. **What must this project achieve?**
   - What key capabilities are required?
   - What outcomes must be delivered?
   - What requirements trace to the PURPOSE?

2. **How do you know it's achieved?**
   - What validates each outcome?
   - How do you test these requirements?
   - What behaviors satisfy these outcomes?

## MSL Format

Follow MSL format:

```markdown
---
criticality: CRITICAL
failure_mode: Without [X], [specific failure]
derives-from:
  - PURPOSE.md
---

# [Project] Outcomes

## Requirements
- [!] [Outcome 1]: [High-level requirement statement]
  - [Validation criterion 1]
  - [Validation criterion 2]
- [!] [Outcome 2]: [High-level requirement statement]
  - [Validation criterion 1]
  - [Validation criterion 2]
```

## Guidelines

**Keep outcomes high-level:**
- ❌ "Users can click login button" → Too detailed (behavior spec)
- ✅ "System authenticates users securely" → High-level outcome

**Derive from PURPOSE.md:**
- Each outcome traces to PURPOSE success criteria
- Outcomes elaborate "what success looks like"
- No new goals beyond PURPOSE scope

**Make testable:**
- Each outcome has validation criteria
- Criteria are observable/measurable
- Can verify when outcome is achieved

## Examples

**Good outcomes (high-level):**
- "Support bidirectional spec-code synchronization"
- "Work across multiple AI coding agents"
- "Maintain specs without maintenance burden"

**Not outcomes (too detailed):**
- "Prompt 4a detects drift" → behavior spec
- "Use YAML frontmatter" → strategy/pattern
- "Store specs in specs/ folder" → convention

## Exit Criteria

- [ ] specs/mission/outcomes.spec.md exists
- [ ] 3-6 high-level outcomes defined
- [ ] Each outcome traces to PURPOSE.md
- [ ] Each outcome has validation criteria
- [ ] Follows MSL format exactly
- [ ] No implementation details
- [ ] No technical constraints

## Next Step

Once outcomes are defined, proceed to `0d-identify-constraints.md`
