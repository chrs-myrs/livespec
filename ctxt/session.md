# Session Completion

> **Generated file** - Do not edit directly. Regenerate using `.livespec/prompts/utils/regenerate-contexts.md`

Sub-agent context for session analysis and compliance measurement.

## Summary

Session completion analyzes agent compliance and context efficiency to maintain focus and improve methodology. Provides unified analysis at session end with learning capture.

## When to Use

**Agent should proactively recommend completion when:**
- Task completed successfully (all todos done)
- Context approaching 100K tokens (50% of budget)
- Natural stopping point (ready to commit, switching tasks)
- User appears stuck (repeated attempts, no progress)

**Invoke:** `/livespec:learn`

## Session Analysis Workflow

### Step 1: Analyze Process Compliance (0-8 points)

**Layer 1 — TodoWrite Gate (0-2 points):**
- 2: Used TodoWrite before creating all permanent files
- 1: Used TodoWrite for some files
- 0: Skipped TodoWrite gate

**Layer 2 — Validation Check (0-2 points):**
- 2: Ran validation checks before creating files (including `scripts/validate-frontmatter.sh`)
- 1: Ran checks for some files
- 0: Skipped validation checks

**Layer 3 — Plan Mode (0-3 points):**
- 3: Presented plan for all new permanent files
- 2: Presented plan for most files
- 1: Presented plan occasionally
- 0: Never presented plans

**Layer 4 — Pre-commit Hook (0-1 point):**
- 1: Pre-commit validation passed
- 0: Pre-commit failed

### Step 2: Analyze Focus Efficiency (0-13 points)

**Tool Efficiency (0-5 points):**
- 5: Always used specialized tools (Read/Grep/Glob)
- 3: Mostly used specialized tools
- 1: Frequently used Bash for file operations
- 0: Mostly used Bash

**Context Navigation (0-3 points):**
- 3: Loaded AGENTS.md, used sub-agents appropriately
- 2: Loaded AGENTS.md, didn't need sub-agents
- 1: Loaded AGENTS.md late
- 0: Never loaded AGENTS.md

**Task Focus (0-2 points):**
- 2: Stayed focused on defined scope
- 1: Minor scope creep
- 0: Significant scope drift

**Context Efficiency (0-3 points):**
- 3: Signal-to-noise >60%
- 2: Signal-to-noise 40-60%
- 1: Signal-to-noise 20-40%
- 0: Signal-to-noise <20%

### Step 3: Calculate Signal-to-Noise

```
Sections used = sections referenced during session
Total sections = all sections in loaded context
Ratio = (sections used / total sections) × 100%
```

### Step 4: Check Spec Quality

When reviewing session work, verify any new/edited specs have:
- [ ] All six mandatory base fields (type, category, fidelity, criticality, failure_mode, governed-by)
- [ ] Correct `type` value (see allowed set in AGENTS.md)
- [ ] `category` matches directory
- [ ] `governed-by` contains only content governance (no metaspec paths)
- [ ] Per-category mandatory fields (features: satisfies+guided-by, workspace: applies_to, etc.)
- [ ] All relationship field names hyphenated (not underscored)

### Step 5: Identify Methodology Gaps

Look for:
- What didn't work well (2-3 specific issues)
- Why violations occurred (root causes)
- How to prevent in future (improvements)
- Frontmatter mistakes made and corrected

### Step 6: Show Report (≤15 lines)

```
Session Completion: [Task Name]

Accomplishments:
- [What was completed]
- [Key deliverables]

Compliance: X/8 process, Y/13 focus (Z% overall)
Spec quality: [frontmatter compliant? Yes/No — N issues]

What Went Well:
- [2-3 highlights]

What Could Improve:
- [2-3 suggestions]

Data saved to ~/.claude/livespec/
```

### Step 7: Save Data Globally

**Compliance data:**
`~/.claude/livespec/compliance/YYYY-MM-DD-HHMMSS-projectname.json`

**Feedback data:**
`~/.claude/livespec/feedback/YYYY-MM-DD-HHMMSS-projectname.md`

## Compliance Levels

| Level | Process | Focus | Description |
|-------|---------|-------|-------------|
| Perfect | 8/8 | 11+ | All enforcement followed |
| Good | 6-7 | 8+ | Most enforcement followed |
| Fair | 4-5 | — | Some enforcement followed |
| Poor | 0-3 | — | Enforcement bypassed |

## Post-Session Flow

```
/livespec:learn           # Capture insights to specs
         ↓
git commit                # Save work
         ↓
Fresh session             # Better context
```

## Data Format

### Compliance JSON

```json
{
  "session_id": "2025-01-31-143022-livespec",
  "project": {
    "name": "livespec",
    "path": "/home/chris/projects/livespec"
  },
  "compliance": {
    "process": {"score": 6, "max": 8, "percentage": 75},
    "focus": {"score": 9, "max": 13, "percentage": 69},
    "overall": {"score": 15, "max": 21, "percentage": 71, "level": "Good"}
  },
  "context_analysis": {
    "signal_to_noise": 33,
    "sections_loaded": 18,
    "sections_used": 6
  },
  "spec_quality": {
    "frontmatter_compliant": true,
    "issues_found": 0,
    "issues_fixed": 0
  }
}
```

### Feedback Markdown

```markdown
# Session Feedback: livespec (2025-01-31)

## What Didn't Work Well
- TodoWrite gate bypassed for 2/5 files
- governed-by had metaspec path (corrected)

## Methodology Gaps
- Spec-first enforcement not obvious enough
- Frontmatter per-category fields unclear

## Improvement Suggestions
- Move Spec-First Protocol to START section
- Add frontmatter checklist to design mode
```

## References

- Learn skill: `/livespec:learn`
- Frontmatter validation: `scripts/validate-frontmatter.sh`
- Parent context: AGENTS.md

---

*Session completion specialist for LiveSpec v5.4.0*
*Parent: AGENTS.md*
