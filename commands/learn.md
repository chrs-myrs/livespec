---
description: Session completion, compliance measurement, and learning capture
---

# Learn

Complete sessions with analysis, capture learnings to specs, and save compliance data for methodology improvement.

## Usage

```
/livespec:learn                      # Full session completion
/livespec:learn capture              # Capture learnings only (mid-session)
/livespec:learn compliance           # Show compliance scores only
```

## Session Completion Flow

When invoked at session end:

### Step 1: Analyze Compliance

**Process Compliance (0-8 points):**
- Layer 1 (TodoWrite Gate): 0-2 points
- Layer 2 (Validation Check): 0-2 points
- Layer 3 (Plan Mode): 0-3 points
- Layer 4 (Pre-commit): 0-1 point

**Focus Efficiency (0-13 points):**
- Tool Efficiency: 0-5 (Read/Grep/Glob vs Bash)
- Context Navigation: 0-3 (AGENTS.md usage)
- Task Focus: 0-2 (scope adherence)
- Context Efficiency: 0-3 (signal-to-noise ratio)

### Step 2: Capture Learnings

Scans conversation for:

- **Corrections made**: Mistaken assumptions corrected
- **Clarifications provided**: Requirements refined
- **Patterns emerged**: Repeated issues, new conventions
- **Specs needing updates**: What should change

### Step 3: Apply MSL Gate

Before adding learning to spec:

1. Is this essential? (would system fail?)
2. Is this WHAT not HOW? (not implementation detail)
3. What problem does this prevent? (proven, not theoretical)

### Step 4: Present Report

```markdown
# Session Complete

**Accomplished:**
- [What was done]

**Compliance:** X% (X/8 process, X/13 focus) - [Level]

**Session Learnings:** (if any)
- [Key insights]
- [Specs to update]

**Highlights:**
- [Things that went well]

**Improvements:**
- [Actionable suggestions]

**Next:** Start fresh session with clearer context.
```

### Step 5: Save Data

Writes to `~/.claude/livespec/`:
- `compliance/YYYY-MM-DD-HHMMSS-projectname.json` - Metrics
- `feedback/YYYY-MM-DD-HHMMSS-projectname.md` - Qualitative notes

### Step 6: Apply Learnings (Optional)

Asks which learnings to capture:

```
Apply learnings to specs?

[ ] "Always check taxonomy before creating files"
    → specs/workspace/patterns.spec.md

[ ] "API uses JWT tokens, not sessions"
    → specs/strategy/auth.spec.md

[Apply Selected] [Skip]
```

## Classification Levels

| Level | Criteria |
|-------|----------|
| Perfect (100%) | 8/8 process + 11+ focus |
| Good (75-99%) | 6-7 process + 8+ focus |
| Fair (50-74%) | 4-5 process |
| Poor (<50%) | 0-3 process |

## When to Use

- Task completed successfully (all todos done)
- Context approaching 100K tokens (50% of budget)
- Natural stopping point (ready to commit, switching tasks)
- User appears stuck (repeated attempts, no progress)

## See Also

- `/livespec:design` - Create and refine specs
- `/livespec:evolve` - Health checks and validation
