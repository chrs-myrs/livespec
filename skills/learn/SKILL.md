---
name: learn
description: Session completion, compliance measurement, and learning capture
argument-hint: [capture|compliance]
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, AskUserQuestion
---

# LiveSpec Learn

Complete sessions with analysis, capture learnings to specs, and save compliance data for methodology improvement.

## Usage

- `/livespec:learn` - Full session completion workflow
- `/livespec:learn capture` - Capture learnings only (mid-session)
- `/livespec:learn compliance` - Show compliance scores only

## Full Session Completion Workflow (Default)

When invoked without arguments, runs the complete session analysis.

### Step 1: Analyze Compliance

**Process Compliance (0-8 points):**

| Layer | Check | Points |
|-------|-------|--------|
| Layer 1 | TodoWrite used for new files | 0-2 |
| Layer 2 | Validation checks run | 0-2 |
| Layer 3 | Plan mode for complex changes | 0-3 |
| Layer 4 | Pre-commit validation | 0-1 |

**Focus Efficiency (0-13 points):**

| Metric | Check | Points |
|--------|-------|--------|
| Tool Efficiency | Read/Grep/Glob vs Bash | 0-5 |
| Context Navigation | AGENTS.md usage | 0-3 |
| Task Focus | Scope adherence | 0-2 |
| Context Efficiency | Signal-to-noise ratio | 0-3 |

### Step 2: Capture Session Learnings

Scan conversation for:

**Corrections:**
- "I initially thought X, but actually it's Y"
- Mistaken assumptions corrected
- Wrong approaches abandoned

**Clarifications:**
- "No, I meant..."
- Requirements refined during discussion
- Scope adjusted based on feedback

**Patterns:**
- Same problem hit multiple times
- New conventions established
- "We should always do X" statements

**Spec updates needed:**
- Missing requirements discovered
- Behaviors clarified
- Constraints identified

### Step 3: Apply MSL Gate

Before adding learning to spec, verify:

1. **Is this essential?** Would specs fail without it?
2. **Is this WHAT not HOW?** Not implementation detail?
3. **What problem does this prevent?** Real, not theoretical?

If fails gate: Note as observation, don't add to spec.

### Step 4: Present Report

```markdown
# Session Complete

**Accomplished:**
- [Summary of work done]

**Compliance:** XX% (X/8 process, X/13 focus) - [Level]

**Session Learnings:** (if any)
- [Key insight 1]
- [Key insight 2]

**Specs to Update:** (if any)
- specs/workspace/patterns.spec.md → "Always check taxonomy"
- specs/strategy/auth.spec.md → "JWT over sessions"

**Highlights:**
- [What went well]

**Improvements:**
- [Actionable suggestions]

**Next:** Start fresh session with clearer context.
```

### Step 5: Save Data

Write compliance data to `~/.claude/livespec/`:

**compliance/YYYY-MM-DD-HHMMSS-projectname.json:**
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

**feedback/YYYY-MM-DD-HHMMSS-projectname.md:** (if issues found)
- Qualitative observations
- Methodology gaps
- Suggested improvements

### Step 6: Offer Learning Application

Use AskUserQuestion:

```
Apply learnings to specs?

[MultiSelect: true]
- "Always check taxonomy before creating files"
  → specs/workspace/patterns.spec.md

- "API uses JWT tokens, not sessions"
  → specs/strategy/auth.spec.md

- "Add custom learning" (describe something not listed)

[Apply Selected] [Skip]
```

For each confirmed learning:
1. Read target spec
2. Add requirement with [!] marker
3. Preserve MSL format
4. Suggest context rebuild if workspace spec changed

---

## Mode: capture (Mid-Session)

**Purpose:** Capture learnings without full session completion.

**Invocation:** `/livespec:learn capture`

**Workflow:**

1. Scan conversation for insights (same as Step 2 above)
2. Present found learnings
3. Offer to apply to specs
4. Skip compliance measurement and session end

Use when:
- Important insight emerged mid-session
- Want to capture before forgetting
- Not ready to end session

---

## Mode: compliance (Scores Only)

**Purpose:** Show compliance scores without capturing learnings.

**Invocation:** `/livespec:learn compliance`

**Workflow:**

1. Analyze process compliance (Layer 1-4)
2. Analyze focus efficiency
3. Display scores
4. Skip learning capture and session end

Use when:
- Quick compliance check
- Debugging methodology adherence
- Mid-session progress check

---

## Classification Levels

| Level | Criteria | Interpretation |
|-------|----------|----------------|
| Perfect | 100% (8/8 + 11+/13) | Exemplary methodology adherence |
| Good | 75-99% (6-7/8 + 8+/13) | Strong compliance, minor gaps |
| Fair | 50-74% (4-5/8) | Acceptable, improvement needed |
| Poor | <50% (0-3/8) | Significant methodology gaps |

---

## When to Trigger Session Completion

Agent should proactively suggest `/livespec:learn` when:

1. **Task completed** - All todos marked done
2. **Context threshold** - >100K tokens used (50% of budget)
3. **Natural stopping point** - Ready to commit, switching tasks
4. **User appears stuck** - Repeated attempts, no progress

---

## Learning Routing

| Learning Type | Target Location |
|---------------|-----------------|
| Process/Convention | specs/workspace/ |
| Architectural Decision | specs/strategy/ |
| Feature Behavior | specs/features/ |
| Constraint | specs/foundation/constraints.spec.md |

---

## Post-Session Flow

```
/livespec:learn          # This skill
       ↓
git commit               # Save work
       ↓
Fresh session            # Better context
```

---

## References

For detailed guidance:
- Session analysis: `${CLAUDE_PLUGIN_ROOT}/ctxt/session.md`
- Learning application: `${CLAUDE_PLUGIN_ROOT}/references/prompts/utils/learn.md`
- Compliance measurement: `${CLAUDE_PLUGIN_ROOT}/references/prompts/utils/measure-session-compliance.md`

## Validation

After session completion:
- Compliance data saved to ~/.claude/livespec/
- Learnings applied to appropriate specs
- Context rebuilds suggested if workspace specs changed
