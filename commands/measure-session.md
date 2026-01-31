---
description: Measure agent compliance for current or recent session
---

# Measure Session

Analyze session transcript to measure agent adherence to LiveSpec spec-first protocol.

## What This Measures

### Process Compliance (0-8 points)

**Layer 1: TodoWrite Gate (0-2)**
- Agent added todo BEFORE creating permanent file
- Agent marked todo complete AFTER spec created

**Layer 2: Validation Check (0-2)**
- Agent ran validation script
- Agent respected exit code

**Layer 3: Plan Mode (0-3)**
- Agent presented plan before creating permanent file
- Plan mentioned spec creation step
- Plan included specific spec path

**Layer 4: Pre-commit (0-1)**
- Commit passed validation on first attempt

### Focus Efficiency (0-13 points)

**Tool Efficiency (0-5)**
- Read used instead of Bash(cat)
- Grep used instead of Bash(grep)
- Glob used instead of Bash(find)
- Parallel tool calls when independent

**Context Navigation (0-3)**
- Referenced AGENTS.md before fetching full prompts
- Used Reference Library pointers appropriately

**Task Focus (0-2)**
- Stayed focused on original task
- Asked clarifying questions before assumptions

**Context Efficiency (0-3)**
- Signal-to-noise ratio of loaded context
- >60%: 3 points, 40-60%: 2 points, 20-40%: 1 point

## Compliance Levels

| Level | Process | Focus |
|-------|---------|-------|
| Perfect | 8/8 | 11+/13 |
| Good | 6-7/8 | 8+/13 |
| Fair | 4-5/8 | any |
| Poor | 0-3/8 | any |

## Report Format

```markdown
# Session Compliance Report

**Session:** [Date/Time]
**Task:** [Description]
**Level:** [Perfect/Good/Fair/Poor] (X%)

## Process Compliance: X/8 (X%)

### Layer 1: TodoWrite Gate (X/2)
[Observation]

### Layer 2: Validation Check (X/2)
[Observation]

### Layer 3: Plan Mode (X/3)
[Observation]

### Layer 4: Pre-commit (X/1)
[Observation]

## Focus Efficiency: X/13 (X%)

[Breakdown by dimension]

## Recommendations

1. [Specific improvement]
2. [Specific improvement]
```

## When to Use

- After completing a session
- Evaluating process compliance
- Identifying improvement opportunities
- Training on LiveSpec methodology

## Exceptions (Don't Penalize)

- Editing existing files (not creating)
- Files in var/, generated/, .archive/
- Research/analysis with no file creation

## References

For detailed measurement procedures:
- `${CLAUDE_PLUGIN_ROOT}/references/prompts/utils/measure-session-compliance.md`
