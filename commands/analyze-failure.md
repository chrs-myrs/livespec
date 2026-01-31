---
description: Forensic analysis when LiveSpec adoption fails
---

# Analyze Failure

Conduct forensic analysis when LiveSpec adoption fails or stalls.

## When to Use

- Team abandoning LiveSpec
- Specs drifting despite methodology
- Compliance consistently below 50%
- Repeated spec-first violations
- Considering whether to continue with LiveSpec

## Analysis Process

### Step 1: Gather Evidence

Collect data from:
- Recent session compliance scores
- Git history (spec vs code commits)
- Team feedback (if available)
- Project structure analysis

### Step 2: Identify Root Causes

Common failure modes:

**Wrong Project Fit:**
- Project too small for methodology overhead
- Rapid prototyping phase (specs slow iteration)
- Solo developer (overhead not justified)

**Insufficient Buy-In:**
- Team doesn't see value
- Methodology imposed, not adopted
- No champion maintaining discipline

**Spec-First Violations:**
- Code written before specs
- Specs created retroactively
- "We'll add specs later" pattern

**Workflow Misalignment:**
- Phases don't match team's process
- Too much ceremony for culture
- Tools don't integrate well

### Step 3: Document Failure Mode

Create `var/failure-analysis.md`:

```markdown
# LiveSpec Adoption Failure Analysis

**Date:** YYYY-MM-DD
**Project:** [name]
**Duration Tried:** X weeks/months

## Symptoms
- [Observable problem 1]
- [Observable problem 2]

## Root Causes
1. [Primary cause]
2. [Contributing factor]

## Evidence
- Compliance average: X%
- Specs created: X, Code files: Y
- [Other data]

## Recommendation
[Continue with adjustments / Pause / Abandon]

## If Continuing
- [Adjustment 1]
- [Adjustment 2]

## If Abandoning
- [What to preserve]
- [Clean exit steps]
```

### Step 4: Recommend Path Forward

**Continue with adjustments:**
- Reduce ceremony (skip optional phases)
- Focus on high-value specs only
- Adjust compression level

**Pause and reassess:**
- Wait for project to stabilize
- Get team alignment first
- Try on smaller scope

**Graceful exit:**
- Document what worked
- Preserve valuable specs
- Remove methodology overhead

## Output

Failure analysis document with:
- Clear diagnosis of what went wrong
- Honest recommendation
- Actionable next steps

## References

For detailed failure analysis:
- `${CLAUDE_PLUGIN_ROOT}/references/prompts/utils/analyze-failure.md`
