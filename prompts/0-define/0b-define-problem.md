---
implements: specs/behaviors/prompts/0b-define-problem.spec.md
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

## Exit Criteria

- [ ] PURPOSE.md exists at project root
- [ ] "Why Exists" section is 1-3 sentences
- [ ] "Success Looks Like" has 3-6 observable criteria
- [ ] Total length <20 lines
- [ ] No frontmatter (simple markdown)
- [ ] No implementation details

## Next Step

Once purpose is defined, proceed to `0c-define-outcomes.md`
