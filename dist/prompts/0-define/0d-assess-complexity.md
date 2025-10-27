---
implements: specs/3-behaviors/prompts/0d-assess-complexity.spec.md
estimated_time: "10-15 minutes"
---

# 0d: Assess Project Complexity

Assess your project's complexity to plan realistic timelines, identify where discovery spikes are needed, and determine appropriate buffer.

## When to Use This

**Use when:**
- Starting a new project (before Phase 1)
- Uncertain about timeline or approach
- Project involves AI/ML, integrations, or unknowns

**Skip when:**
- Simple CRUD app or well-understood project
- Timeline isn't critical
- Requirements are clear

## Instructions

### 1. Analyze Complexity Factors

**AI/ML Complexity** (0-10 score):
- Non-deterministic behavior? (LLMs, agents)
- Natural language processing?
- Multi-step reasoning or tool use?
- Learning/adaptation required?

**Integration Complexity** (0-10 score):
- Multiple external systems (3+)?
- Real-time constraints?
- State synchronization needed?
- Complex authentication?

**Discovery Needs** (0-10 score):
- UX patterns undefined?
- Technical approach uncertain?
- Performance characteristics unknown?
- Multiple viable approaches?

**Requirements Volatility** (0-10 score):
- Stakeholder alignment pending?
- Market conditions changing?
- Success metrics undefined?
- Technology decisions unmade?

### 2. Calculate Overall Complexity

```
Weighted Score = (AI/ML × 0.3) + (Integration × 0.25) + (Discovery × 0.25) + (Volatility × 0.2)

0-2.5: Low - Traditional development
2.5-5.0: Medium - Some iteration expected
5.0-7.5: High - Significant exploration needed
7.5-10: Extreme - Highly exploratory approach
```

### 3. Determine Timeline Buffer

| Complexity | Recommended Buffer | Iteration Cycles |
|------------|-------------------|------------------|
| Low | +20% | 2-3 cycles |
| Medium | +35% | 3-4 cycles |
| High | +50% | 4-6 cycles |
| Extreme | +70% | 6+ cycles |

### 4. Identify Discovery Spikes

List specific unknowns requiring time-boxed exploration:

**Example Spikes:**
- "How does GPT-4 handle our specific domain?"
- "Can our architecture meet 100ms latency?"
- "What UX pattern works for async agents?"

## Output

Create `specs/complexity-assessment.md`:

```markdown
# Complexity Assessment

**Date**: [YYYY-MM-DD]
**Overall Complexity**: [Low/Medium/High/Extreme]
**Complexity Score**: [X.X/10]

## Factor Scores

- **AI/ML Complexity**: [X/10] - [Why]
- **Integration Complexity**: [X/10] - [Why]
- **Discovery Needs**: [X/10] - [Why]
- **Requirements Volatility**: [X/10] - [Why]

## Timeline Recommendations

- **Base Estimate**: [X weeks/months]
- **Recommended Buffer**: [+X%]
- **Total Timeline**: [X weeks/months]
- **Iteration Cycles**: [X cycles]

## Discovery Spikes Needed

1. **[Spike Name]**: [What to explore] (Duration: X days)
   - Key question: [What must be answered]
   - Success criteria: [How we'll know we're done]

2. **[Spike Name]**: [What to explore] (Duration: X days)
   - Key question: [What must be answered]
   - Success criteria: [How we'll know we're done]

## Risks

**Highest Risks:**
1. [Risk and mitigation]
2. [Risk and mitigation]

## Process Adaptations

- [ ] Use iterative specification updates
- [ ] Plan for spec evolution via Phase 4
- [ ] Budget time for exploration spikes
- [ ] Add reality checkpoints (use 4a-detect-drift quarterly)
```

## Next Steps

After completing complexity assessment:

**Always proceed to**: `0e-evaluate-research-needs.md`
- Assess whether research is needed to inform requirements
- Particularly important for Medium+ complexity projects
- Can skip quickly if no user-facing aspects

**Then**:
- If **Low complexity + no research needs**: Proceed to Phase 1 (design-architecture)
- If **Medium+**: Consider discovery spikes, complete any needed research, then Phase 1
- If **High+**: Strongly recommend using `.livespec/utils/run-spike.md` for each unknown

Remember: Better to overestimate complexity than underestimate it.
