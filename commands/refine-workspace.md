---
description: Optimize workspace structure based on usage patterns
---

# Refine Workspace

Analyze context usage patterns and reorganize for optimal agent efficiency.

## What This Does

1. Analyzes context usage from recent sessions
2. Identifies hot/warm/cold sections
3. Proposes START/MIDDLE/END repositioning
4. Identifies repeated content for extraction
5. Generates reorganization plan

## Prerequisites

- At least 10 sessions of usage data
- Compliance data in `~/.claude/livespec/compliance/`

## Analysis Process

### Section Temperature Analysis

**Hot sections** (used >80% of sessions):
- Should be in START position
- Critical for agent effectiveness
- Never extract, keep inline

**Warm sections** (used 40-80% of sessions):
- Should be in MIDDLE position
- Important but not always needed
- Consider extraction if large

**Cold sections** (used <40% of sessions):
- Should be in END position or extracted
- Reference only when needed
- Candidates for removal

### Redundancy Detection

Identifies content appearing in multiple locations:
- CLAUDE.md vs AGENTS.md overlap
- Repeated patterns across contexts
- Duplicate guidance

### Repositioning Recommendations

```markdown
## Proposed Changes

### Move to START
- [Section X]: Currently MIDDLE, used 85% of sessions

### Move to END
- [Section Y]: Currently MIDDLE, used 25% of sessions

### Extract to Reference
- [Section Z]: 500 lines, only used 15% of sessions
  - Create: references/[topic].md
  - Keep pointer in AGENTS.md

### Remove (unused)
- [Section W]: Never referenced in 15 sessions
```

## When to Use

- After 10+ sessions
- When context feels bloated
- Signal-to-noise ratio below 40%
- Agents fetching too often
- AGENTS.md exceeds compression level targets

## Output

After analysis, optionally execute reorganization:
1. Update AGENTS.md structure
2. Extract cold content to references
3. Rebuild context
4. Validate changes

## References

For detailed reorganization procedures:
- `${CLAUDE_PLUGIN_ROOT}/references/prompts/utils/reorganize-workspace.md`
- `${CLAUDE_PLUGIN_ROOT}/references/guides/context-positioning.md`
