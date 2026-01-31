---
description: Workflow orchestration and mode navigation
---

# Next Steps

Analyze project state and recommend appropriate next mode.

## What This Does

Examines what exists in your project to suggest the right next action:
- Checks specs/ for existing specifications
- Identifies current mode in workflow
- Recommends specific prompt to use next

## Three-Mode Workflow

```
DEFINE → DESIGN → EVOLVE
  ↑                  ↓
  └──────────────────┘
```

## Decision Tree

### No specs/workspace/ exists
**You are in:** Pre-Mode 0
**Next:** `/livespec:init` to initialize workspace

### specs/workspace/ exists but no PURPOSE.md
**You are in:** Mode 0 (DEFINE)
**Next:** Create PURPOSE.md with project vision

### PURPOSE.md exists but no specs/features/
**You are in:** Mode 0 → 1 transition
**Next:** `/livespec:design` to create behavior specs

### specs/features/ has specs
**You are in:** Mode 2 (EVOLVE)
**Next:** `/livespec:evolve detect` to check spec health

## Output Format

```markdown
# Current Project State

**Mode:** [0-2] ([Name])
**Status:** [Brief description]

## What Exists
- specs/workspace/: [Yes/No]
- PURPOSE.md: [Yes/No]
- specs/features/: [X files]

## Recommended Next Step

[Specific action with command or skill reference]

## Alternative Paths
- [Option 1]: If [condition]
- [Option 2]: If [condition]
```

## When to Use

- Uncertain about next mode
- After completing current mode
- Returning to project after break
- Project feels directionless
- Learning LiveSpec workflow

## References

For detailed mode information:
- `${CLAUDE_PLUGIN_ROOT}/references/prompts/utils/next-steps.md`
