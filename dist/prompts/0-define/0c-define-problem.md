---
implements: specs/3-artifacts/prompts/0c-define-problem.spec.md
estimated_time: "10-15 minutes"
---

# 0b: Define Purpose

**Phase**: DEFINE
**Purpose**: Articulate project vision and success criteria
**Context**: See `PURPOSE.md` (LiveSpec's own purpose statement) as example

## Task

Create `PURPOSE.md` at project root that defines why this project exists and what success looks like.

## Questions to Answer

1. **Why does this project exist?**
   - What problem does it solve?
   - What gap does it fill?
   - What vision drives this?

2. **What does success look like?**
   - How will you know it worked?
   - What observable outcomes indicate success?
   - Who benefits and how?

## Format

**Simple markdown format** (no frontmatter, not an MSL spec):

```markdown
# [Project Name] Purpose

## Why [Project] Exists
[1-3 sentences describing the problem or vision this project addresses]

## What Success Looks Like
- [Observable outcome 1]
- [Observable outcome 2]
- [Observable outcome 3]
- [Observable outcome 4]
```

## Guidelines

**Keep it minimal (<20 lines):**
- Remove marketing language
- Remove implementation details
- Remove technical decisions
- Focus on vision and measurable outcomes

**Make success criteria observable:**
- Can you verify each outcome?
- Are they specific enough to test?
- Do they trace to the vision?

## Active Content Routing

**Route content to the correct spec AT CAPTURE TIME. Don't accumulate in PURPOSE then extract later.**

When gathering answers, immediately route content that doesn't belong in PURPOSE:

| If Answer Contains... | Route To |
|----------------------|----------|
| Regulatory/legal requirements | `specs/1-requirements/strategic/constraints.spec.md` |
| Specific measurable outcomes | `specs/1-requirements/strategic/outcomes.spec.md` |
| Technology choices | `specs/2-strategy/architecture.spec.md` |
| Observable system behaviors | `specs/3-behaviors/[feature].spec.md` |
| Team processes | `specs/workspace/workflows.spec.md` |

**Decision test:** "Can I explain this in an elevator pitch to a non-technical stakeholder?"
- YES → Keep in PURPOSE.md
- NO → Route immediately to appropriate spec

**Example routing:**
```
User says: "We need to comply with GDPR and support 1000 concurrent users"

Action:
- PURPOSE.md: "Privacy-first design" (vision-level)
- constraints.spec.md: "GDPR compliance required" (regulatory)
- outcomes.spec.md: "Support 1000 concurrent users" (measurable)
```

## Exit Criteria

- [ ] PURPOSE.md exists at project root
- [ ] "Why Exists" section is 1-3 sentences
- [ ] "Success Looks Like" has 3-6 observable criteria
- [ ] Total length <20 lines
- [ ] No frontmatter (simple markdown)
- [ ] No implementation details

## Next Step

Once purpose is defined, proceed to `0c-define-outcomes.md`
