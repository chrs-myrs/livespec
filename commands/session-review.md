---
description: End-of-session analysis with compliance and learning capture
---

# Session Review

Analyze current session for compliance, capture learnings, and save data for methodology improvement.

## When to Use

- Task completed successfully (all todos done)
- Context approaching 100K tokens (50% of budget)
- Natural stopping point (ready to commit, switching tasks)
- User appears stuck (repeated attempts, no progress)

## Process

### Step 1: Analyze Compliance

**Process Compliance (0-8 points)**:
- Layer 1 (TodoWrite Gate): 0-2 points
- Layer 2 (Validation Check): 0-2 points
- Layer 3 (Plan Mode): 0-3 points
- Layer 4 (Pre-commit): 0-1 point

**Focus Efficiency (0-13 points)**:
- Tool Efficiency: 0-5 (Read/Grep/Glob vs Bash)
- Context Navigation: 0-3 (AGENTS.md usage)
- Task Focus: 0-2 (scope adherence)
- Context Efficiency: 0-3 (signal-to-noise ratio)

### Step 2: Capture Learnings

Scan conversation for:
- **Corrections made**: Mistaken assumptions corrected
- **Clarifications provided**: Requirements refined
- **Patterns emerged**: Repeated issues, new conventions
- **Specs needing updates**: What should change

### Step 3: Show Report

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

**Next:** Run /livespec:learn to apply insights, then start fresh session.
```

### Step 4: Save Data

Write to `~/.claude/livespec/compliance/YYYY-MM-DD-HHMMSS-projectname.json`:
```json
{
  "session_id": "YYYY-MM-DD-HHMMSS",
  "project_name": "projectname",
  "scores": {
    "process_compliance": 7,
    "focus_efficiency": 11,
    "overall_percentage": 89
  },
  "compliance_level": "Good"
}
```

Write feedback to `~/.claude/livespec/feedback/YYYY-MM-DD-HHMMSS-projectname.md` if issues found.

## Classification Levels

- **Perfect (100%)**: 8/8 process + 11+ focus
- **Good (75-99%)**: 6-7 process + 8+ focus
- **Fair (50-74%)**: 4-5 process
- **Poor (<50%)**: 0-3 process

## Post-Session Flow

```
/livespec:session-review  # This command
         ↓
/livespec:learn           # Capture insights to specs
         ↓
git commit                # Save work
         ↓
Fresh session             # Better context
```

## References

For detailed session analysis:
- Context file: `ctxt/session.md`
- Learn command: `/livespec:learn`
