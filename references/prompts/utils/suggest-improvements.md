---
implements: specs/features/improvement-analysis.spec.md
phase: utilities
---

# Suggest Strategic Improvements

**Purpose**: Analyze accumulated data (registries as accepted current state, session feedback, compliance trends) to recommend prioritized actions for resolving known tensions.

**When to use**: Monthly, when 10+ session feedback files accumulated, or when systematic patterns emerge requiring strategic analysis.

---

## Instructions for AI Agent

You are analyzing project health data to identify patterns and recommend actions for resolving known tensions. Registries track accepted current state — not work items. Focus on systematic tensions, not one-off problems.

### Step 1: Read All Registries

Read the three registry data files to understand accepted current state:

```bash
# Read gaps registry
cat registries/gaps.md

# Read issues registry
cat registries/issues.md

# Read improvements registry
cat registries/improvements.md
```

**Extract:**
- Known gaps (missing coverage accepted for now)
- Known issues (problems tolerated for now)
- Known improvement opportunities (what works but could be better)
- Note: resolved tensions are not in registries — check git history for past resolutions

### Step 2: Read Recent Session Feedback

Read last 10-15 session feedback files from `~/.claude/livespec/feedback/`:

```bash
# List recent feedback files
ls -t ~/.claude/livespec/feedback/*.md | head -15
```

**Look for patterns:**
- Same gap mentioned in 3+ sessions (systematic problem)
- Same issue appearing repeatedly (recurring friction)
- Similar methodology complaints (guidance inadequacy)
- Common confusion points (unclear documentation)

### Step 3: Analyze Compliance Trends

Read last 5-10 compliance JSON files from `~/.claude/livespec/compliance/`:

```bash
# List recent compliance files
ls -t ~/.claude/livespec/compliance/*.json | head -10
```

**Calculate trends:**
- Process compliance: Improving, declining, or stable?
- Focus efficiency: Improving, declining, or stable?
- Context efficiency: Signal-to-noise ratio trending?
- Layer scores: Which layers consistently low?

**Identify systemic issues:**
- Layer 1 (TodoWrite) consistently low → Need better TodoWrite guidance
- Layer 2 (Validation) consistently low → Need easier validation workflow
- Layer 3 (Plan Mode) consistently low → Need clearer plan mode triggers
- Context efficiency low → Need context reorganization

### Step 4: Prioritize by Impact

**Calculate priority for each gap/issue:**

**Priority = Impact × Frequency**

**Impact levels:**
- CRITICAL: Blocks work, causes failures (score: 4)
- HIGH: Significant friction, repeated slowdowns (score: 3)
- MEDIUM: Noticeable annoyance, occasional impact (score: 2)
- LOW: Minor inconvenience, rare occurrence (score: 1)

**Frequency levels:**
- Every session (score: 4)
- Most sessions (>50%) (score: 3)
- Occasional (<50%) (score: 2)
- Rare (score: 1)

**Priority Score = Impact × Frequency (range: 1-16)**

**Group by priority:**
- P1 (Critical): Score 12-16 → Address immediately
- P2 (High): Score 8-11 → Address soon
- P3 (Medium): Score 4-7 → Address when capacity allows
- P4 (Low): Score 1-3 → Nice to have

### Step 5: Identify Related Items

**Group related gaps/issues:**
- Same root cause (e.g., "unclear guidance" affecting multiple areas)
- Same category (e.g., all documentation issues)
- Same user impact (e.g., all causing session delays)

**Benefits of grouping:**
- Single solution may address multiple items
- Reveals systemic problems vs isolated issues
- Better resource allocation

### Step 6: Check History

**Before recommending solution, check git history and registry state:**
- Has a similar tension been observed before?
- Was it acted on? What happened? (check git log for registry removals)
- If the approach failed, why?
- Different approach needed?

**Avoid:**
- Repeating failed approaches
- Solutions that were tried and reverted
- Approaches that resolved a tension only to reintroduce it

**Learn from:**
- Effective changes (what made them work?)
- Tensions that recur (what's the underlying cause?)

### Step 7: Generate Prioritized Recommendations

**Format (concise, actionable):**

```markdown
# Strategic Improvement Recommendations

**Analysis Date:** YYYY-MM-DD
**Data Sources:** [X] gaps, [X] issues, [X] session feedback files, [X] compliance files

## P1 (Critical) - Address Immediately

### 1. [Descriptive title]
**Problem:** [What's wrong, with evidence from data]
**Impact:** [CRITICAL] - [Specific impact on users/work]
**Frequency:** [Every session / Most sessions] - [X occurrences in data]
**Root Cause:** [Why this is happening]
**Recommended Action:** [Specific, actionable solution]
**Affects:** [Related GAP-XXX, ISSUE-XXX references]
**Avoid:** [Any failed approaches from improvement history]

## P2 (High) - Address Soon

[Same format]

## P3 (Medium) - Address When Capacity Allows

[Same format]

## P4 (Low) - Nice to Have

[Same format]

---

## Quick Wins (High Impact, Low Effort)

[Items that are P2 or P3 but easy to implement]

## Systemic Patterns

[Cross-cutting themes affecting multiple areas]

## Data Quality Notes

[Any limitations in data, missing information, analysis caveats]
```

### Step 8: Update Registries

**Add newly discovered state observations:**
- Tensions from feedback not yet in registries (as state observations, not work items)
- Systemic problems revealed by trend analysis
- Each new entry must read as accepted current state, not an action item

**Update existing entries:**
- Add evidence from latest session data
- Update severity if new evidence warrants it

**Remove resolved entries:**
- Tensions whose accepted state has changed (gap filled, issue fixed, improvement acted on)
- Commit message captures resolution details (git history is the archive)

### Step 9: Present Recommendations

Show recommendations to user in order of priority. Be specific and actionable.

**Include:**
- What to do (clear action)
- Why (evidence from data)
- When (immediate vs soon vs later)
- Quick wins highlighted
- Systemic patterns explained

**Don't include:**
- Vague "improve X" without specifics
- Actions without justification
- Solutions that failed before (unless different approach)
- Analysis details user doesn't need

### Step 10: Ask for Direction

After presenting recommendations:

```
These recommendations are based on [X] days of data. Which priority level should I start with?

1. P1 (Critical) - [X items] - Address now
2. P2 (High) - [X items] - Address soon
3. Quick Wins - [X items] - High impact, low effort
4. Review specific item - [Let me know which]
5. Update registries only - No implementation yet
```

---

## When NOT to Use This Prompt

**Don't use if:**
- Less than 5 sessions of data (insufficient)
- No registries exist (run Phase 0 setup first)
- Immediate bug/crisis (use direct fix, not strategic analysis)
- User wants tactical help (use complete-session for immediate learning)

**Use instead:**
- **complete-session.md** - For current session learning
- **run-health-report.md** - For diagnostic check without recommendations
- **regenerate-contexts.md** - For context reorganization specifically

---

## Data Requirements

**Minimum for useful analysis:**
- 5+ session compliance files (trend analysis)
- 3+ session feedback files (pattern detection)
- Registry files exist (even if mostly empty)

**Better analysis with:**
- 10+ sessions of data
- Multiple weeks of data (show trends over time)
- Variety of tasks (not just one type of work)

---

## Output Quality Checklist

Before presenting recommendations:
- [ ] Priority calculated with evidence (Impact × Frequency)
- [ ] Related items grouped (same root cause or category)
- [ ] History checked — git log and registry state (avoid repeating failures)
- [ ] Recommendations specific and actionable (not vague)
- [ ] Evidence cited from data (sessions, registries, trends)
- [ ] Quick wins identified (high impact, low effort)
- [ ] Systemic patterns explained (cross-cutting themes)
- [ ] Registries updated (new state observations added, resolved tensions removed)
- [ ] User choice offered (what to tackle first)

---

**Remember:** Strategic improvements based on data, not hunches. Focus on patterns across sessions, not one-off complaints.
