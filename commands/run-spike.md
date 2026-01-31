---
description: Time-boxed technical exploration
argument-hint: <topic>
---

# Run Spike

Conduct time-boxed (30-90 minutes) technical exploration of uncertain areas.

## Usage

`/livespec:run-spike <topic>`

## Examples

```
/livespec:run-spike authentication strategies for multi-tenant SaaS
/livespec:run-spike compare GraphQL vs REST for our use case
/livespec:run-spike database schema versioning approaches
/livespec:run-spike real-time websocket vs polling performance
```

## What This Does

1. **Set time box** (default 60 minutes)
2. **Define question** to answer
3. **Explore approaches** without committing
4. **Document findings** in var/spikes/
5. **Recommend** next steps

## Spike Structure

```markdown
# Spike: [Topic]

**Time Box:** X minutes
**Question:** What are we trying to learn?
**Date:** YYYY-MM-DD

## Approaches Explored

### Option A: [Name]
- Pros: ...
- Cons: ...
- Effort: Low/Medium/High

### Option B: [Name]
- Pros: ...
- Cons: ...
- Effort: Low/Medium/High

## Findings

[What we learned]

## Recommendation

[Suggested approach with rationale]

## Next Steps

- [ ] [Action item 1]
- [ ] [Action item 2]
```

## When to Use

- Technical approach uncertain
- Evaluating multiple solutions
- Researching unfamiliar technology
- Prototyping to answer specific question
- De-risking before Phase 1 (DESIGN)

## Important Notes

- Spikes are **exploration**, not implementation
- Output goes to `var/spikes/` (not committed by default)
- Don't commit to decisions during spike
- Share findings before proceeding to design

## References

For detailed spike workflow:
- `${CLAUDE_PLUGIN_ROOT}/references/prompts/utils/run-spike.md`
