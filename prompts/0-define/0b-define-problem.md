---
spec: specs/prompts/0b-define-problem.spec.md
---

# 0b: Define Problem

**Phase**: DEFINE
**Purpose**: Articulate the core problem this project solves
**Context**: See `PURPOSE.md` (LiveSpec's own purpose statement) as example

## Task

Create `specs/problem.md` that clearly defines the problem this project addresses.

## Questions to Answer

1. **What problem exists?**
   - What breaks or fails currently?
   - What pain points do users experience?
   - What gap exists in available solutions?

2. **Who experiences this problem?**
   - Who are the primary users?
   - What are their needs and constraints?
   - What alternatives have they tried?

3. **Why does this problem matter?**
   - What's the impact of not solving it?
   - What value comes from solving it?
   - How do you measure success?

## MSL Format

Follow strict MSL format:

```markdown
# Problem Statement

**Criticality**: CRITICAL
**Failure Mode**: Without clear problem definition, [specific consequence]

## Specification
[Single paragraph or sentence defining the problem]

## Validation
- Users can explain the problem in their own words
- Users recognize this problem in their context
- Solution addresses stated problem
- [Additional validation criteria]
```

## Guidelines

**Keep it minimal:**
- Remove marketing language
- Remove obvious statements
- Remove nice-to-haves
- Focus on what fails without a solution

**Make it testable:**
- How do you know users have this problem?
- How do you verify your solution addresses it?
- What observable criteria indicate success?

## Exit Criteria

- [ ] specs/problem.md exists
- [ ] Problem statement is one clear sentence/paragraph
- [ ] Follows MSL format exactly
- [ ] Validation criteria are observable
- [ ] Problem is worth solving (passes MSL test)

## Next Step

Once problem is defined, proceed to `0c-identify-constraints.md`
