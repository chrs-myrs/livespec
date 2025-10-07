---
spec: specs/behaviors/prompts/run-spike.spec.md
---

# Run Discovery Spike

Conduct a time-boxed exploration to answer specific technical questions before committing to a design or implementation approach.

## When to Use This

**Use for:**
- Testing if an approach will work
- Measuring performance characteristics
- Understanding API behavior
- Exploring UX patterns
- Validating integration feasibility

**Don't use for:**
- Production code (spikes are throwaways)
- Well-understood problems
- Simple questions answerable with docs

## Spike Process

### 1. Define Spike Charter

**Required inputs:**
- **Question**: What specific question must be answered?
- **Time Box**: Maximum time to spend (hours/days)
- **Success Criteria**: How you'll know you're done
- **Out of Scope**: What you won't explore

**Example:**
```
Question: Can we stream GPT-4 responses with <100ms latency?
Time Box: 4 hours
Success: Measured latency under various loads
Out of Scope: Error handling, production readiness
```

### 2. Build Minimal Prototype

**Spike code is disposable:**
- Just enough to answer the question
- Hardcoded values are fine
- No tests required
- No polish needed

**Focus on learning, not quality.**

### 3. Test Aggressively

- Push boundaries to find limits
- Test failure modes
- Measure actual behavior
- Try unexpected inputs

### 4. Document Findings

Create spike report in `specs/spikes/[name]-spike.md`:

```markdown
# Spike Report: [Name]

**Question**: [What we explored]
**Time Box**: [X hours]
**Actual Time**: [Y hours]
**Date**: [YYYY-MM-DD]

## Answer

[Clear, direct answer to the question]

## Key Findings

### What Worked ✅
- **[Approach]**: [Why it worked]
- **[Pattern]**: [What we learned]

### What Failed ❌
- **[Approach]**: [Why it failed]
- **[Limitation]**: [What we discovered]

### Surprises 🎯
- [Unexpected discovery]
- [Assumption that was wrong]

## Measurements

| Metric | Expected | Actual | Notes |
|--------|----------|--------|-------|
| [Metric] | [Value] | [Value] | [Context] |

## Recommendations

**For specs:**
- [How this should inform design]
- [Constraints to document]

**For implementation:**
- [Approach to use]
- [Pitfalls to avoid]

## Code Samples

```[language]
// Key patterns discovered
[Minimal working example]
```

## Follow-up Questions

- [New unknowns discovered]
- [Additional spikes needed]
```

### 5. Discard Spike Code

**Spike code is not production code.**

Either:
- Delete it entirely
- Move to `.scratch/` or `.tmp/`
- Clearly mark as "spike - do not use"

The value is in the **report**, not the code.

## Integration with LiveSpec

**After spike:**
1. Update complexity assessment if needed
2. Incorporate findings into architecture specs
3. Document discovered constraints
4. Use learnings to refine behavior specs

## Example Spike Scenarios

### Performance Spike
```
Question: Can we handle 1000 concurrent users?
Build: Simple load test with 1000 simulated users
Test: Measure response times, error rates, resource usage
Learn: Actual capacity, bottlenecks, scaling needs
```

### Integration Spike
```
Question: How does external API handle timeouts?
Build: Call API with various timeout settings
Test: Force timeout scenarios, observe behavior
Learn: Actual timeout behavior, retry patterns, failure modes
```

### AI/ML Spike
```
Question: Does GPT-4 understand our domain context?
Build: Test prompt with domain-specific queries
Test: Various phrasings, edge cases, ambiguous inputs
Learn: Prompt patterns that work, failure modes, token costs
```

## Tips

- **Stay focused**: Answer the specific question, nothing more
- **Measure everything**: Actual data beats assumptions
- **Document immediately**: Capture insights while fresh
- **Share findings**: Update team on what you learned
- **Throw away code**: The report is the artifact, not the code

Remember: Spikes reduce risk by converting unknowns to knowns.
