---
name: learn
description: Session completion, compliance measurement, and learning capture
argument-hint: [capture|compliance|report]
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, AskUserQuestion
---

# LiveSpec Learn

Complete sessions with analysis, capture learnings to specs, and save compliance data for methodology improvement.

## Usage

- `/livespec:learn` - Full session completion workflow
- `/livespec:learn capture` - Capture learnings only (mid-session)
- `/livespec:learn compliance` - Show compliance scores only
- `/livespec:learn report` - Deep implementation report (substantial sessions; see "Deep Mode: Implementation Report")

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

**Substantial session?** If this session qualifies as substantial (see criteria below), offer the deeper Implementation Report instead of/alongside the bullet summary — see "Deep Mode: Implementation Report".

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

## Deep Mode: Implementation Report

**Purpose:** A fuller post-implementation "lessons learned" report for sessions substantial enough to reward honest failure analysis, not just bullet capture. This deepens Step 2/4 — it doesn't replace them. Normal session-end keeps the lightweight bullet report by default.

**Invocation:** `/livespec:learn report` (explicit), or offered automatically in Step 4 when a session is **substantial**:

- Compliance level is **Fair or Poor** (methodology gaps worth analyzing), OR
- Session spanned significant implementation (new feature, phase-2 BUILD work, or a milestone/sprint close) rather than small edits, OR
- User explicitly says the methodology was partially skipped or a first-time trial

Skip this mode for small edits, spec-only tweaks, or Perfect/Good sessions with nothing notable to dig into — the Step 4 bullet report is sufficient.

**Output location:** `var/implementation-reports/YYYY-MM-DD-[project-name]-[scope].md`

**Report skeleton:**

1. **Metadata** — project, scope, date, LiveSpec version
2. **Executive Summary** — 2-3 sentences: what was built + key learning
3. **Process Adherence** — checklist of phases/steps followed; honest accounting of what was skipped
4. **Honest Failure Analysis** (most important section) — for each skipped step: *What I thought* (flawed reasoning at the time) → *What I missed* (consequences) → *Lesson*. Tag with a cognitive-bias category where it fits:
   - **Overconfidence bias** — "this is obvious, I don't need specs"
   - **Efficiency instinct** — "specs are overhead, I'll go faster without them"
   - **Pattern matching** — "I've done this before, I know the shape"
   - **Ambiguity aversion** — "asking will slow things down"
5. **Critical Failures** — major violations only (e.g. TDD skipped entirely, contract without behavior): what happened vs what should have, impact, root cause, prevention
6. **What Worked Well / What Didn't Work Well** — concrete, evidenced; separate methodology pain points from implementation issues
7. **Quantitative Results** — metrics table (behaviors/contracts created, files new/updated, automated vs manual test coverage, issues found, rework cycles, incomplete implementations)
8. **Recommendations** — actionable, categorized as **For AI Assistants** vs **For LiveSpec Methodology**; format as `[Recommendation] — [specific change with acceptance criteria]`
9. **Conclusion** — what you got right/wrong, root cause, would you repeat the mistake, overall verdict

**Framework issue vs implementation issue** — keep these distinct, it changes what gets fixed:

| Framework issue (LiveSpec needs improvement) | Implementation issue (methodology wasn't followed) |
|---|---|
| "Behavior vs contract boundary is ambiguous for X" | "I skipped tests because it felt slow" |
| "No guidance on when to create domain model specs" | "I didn't read the constitution about TDD" |

**Good vs poor excerpt** (be specific, not defensive):

✅ Good:
> **Overconfidence bias** — *What I thought*: "Channel operations are straightforward, I've built messaging systems before." *What I missed*: discovery tools, username resolution, graceful OAuth degradation. *Lesson*: even "simple" features hide complexity; spec-first surfaces dependencies before coding reveals them expensively. *Evidence*: user had to ask "how do I discover channels?" after posting tools were already designed — 1 hour of retroactive rework.

❌ Poor:
> "I built some tools. The methodology was mostly followed. TDD would have been nice but wasn't necessary. Overall it went well."
>
> Why it's bad: no specific failure identified, no metrics, no evidence, defensive framing ("wasn't necessary" instead of admitting it was skipped).

**After filing:** if a bias or ambiguity recurs across multiple reports, route it into `specs/workspace/patterns.spec.md` (or the relevant methodology spec) via the normal Step 6 learning-application flow — patterns across reports are exactly the "same problem hit multiple times" signal Step 2 already watches for.

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
- Deep implementation report template: see "Deep Mode: Implementation Report" above

## Validation

After session completion:
- Compliance data saved to ~/.claude/livespec/
- Learnings applied to appropriate specs
- Context rebuilds suggested if workspace specs changed
