---
implements: specs/3-behaviors/prompts/utils-measure-session.spec.md
phase: utilities
---

# Measure Session Compliance

**Purpose**: Analyze session transcript or log to measure agent adherence to LiveSpec spec-first protocol and focus efficiency.

**When to use**: After completing a session to evaluate process compliance and identify improvement opportunities.

---

## Instructions for AI Agent

You are analyzing a LiveSpec development session to measure compliance with spec-first protocol and focus efficiency.

### Step 1: Gather Session Information

Ask the user to provide:
1. **Session transcript** (conversation history), OR
2. **Session log JSON** (if available in `var/compliance/session-*.json`), OR
3. **Task description** + key events (manual summary)

If analyzing git history:
- Recent commits during session
- Files created/modified
- Pre-commit hook results

### Step 2: Score Process Compliance (0-8 points)

Analyze for four-layer spec-first enforcement:

**Layer 1: TodoWrite Gate (0-2 points)**
- Look for: "TodoWrite", "Adding todo", "Creating todo list"
- 1 point: Agent added TodoWrite BEFORE creating permanent file
- 1 point: Agent marked todo complete AFTER spec created
- 0 points: No TodoWrite or created after file operations

**Layer 2: Validation Check (0-2 points)**
- Look for: "check-requires-spec.sh", "Running validation", "Checking spec requirement"
- 1 point: Agent ran validation script
- 1 point: Agent respected exit code (stopped on failure)
- 0 points: Skipped validation or ignored results

**Layer 3: Plan Mode (0-3 points)**
- Look for: "ExitPlanMode", "Here's my plan", "Plan before proceeding"
- 1 point: Agent presented plan before creating permanent file
- 1 point: Plan explicitly mentioned spec creation step
- 1 point: Plan included specific spec path (e.g., `specs/3-behaviors/auth.spec.md`)
- 0 points: No plan or vague plan

**Layer 4: Pre-commit (0-1 point)**
- Look for: Commit messages, pre-commit hook output, validation pass/fail
- 1 point: Commit passed pre-commit validation on first attempt
- 0 points: Commit failed or required fixes

**Exceptions (don't penalize)**:
- Task was editing existing file (not creating new permanent file)
- File created in `var/`, `generated/`, or `.archive/` (not permanent)
- Research/analysis task with no file creation

### Step 3: Score Focus Efficiency (0-13 points)

**Tool Efficiency (0-5 points)**
- Look for tool usage patterns in transcript:
  - +1: Read used instead of `Bash(cat ...)`
  - +1: Grep used instead of `Bash(grep ...)` or `Bash(rg ...)`
  - +1: Glob used instead of `Bash(find ...)`
  - +2: Parallel tool calls when operations independent (single message, multiple tools)
  - -1: Bash used for file operations when specialized tool exists

**Context Navigation (0-3 points)**
- Look for context usage patterns:
  - +1: Agent referenced AGENTS.md before fetching full prompts
  - +1: Agent used Reference Library pointers (fetched detailed specs when needed)
  - -1: Agent fetched full prompt unnecessarily (info was in AGENTS.md)
  - -1: Agent missed obvious context (re-asked question answered in CLAUDE.md)

**Task Focus (0-2 points)**
- Look for scope adherence:
  - +2: Agent stayed focused on original task without wandering
  - +1: Agent asked clarifying questions before making assumptions
  - -2: Significant scope creep (explored unrelated areas without asking)
  - -1: Minor tangents (helpful but slightly off-task suggestions)

**Context Efficiency (0-3 points)**
- Analyze signal-to-noise ratio of loaded context:
  - Identify sections referenced during session (what agent actually used)
  - Identify sections loaded but unused (noise)
  - Calculate: signal-to-noise = (sections used / total sections) × 100%
  - Award points:
    - +3: >60% signal-to-noise (high efficiency)
    - +2: 40-60% signal-to-noise (moderate efficiency)
    - +1: 20-40% signal-to-noise (low efficiency)
    - +0: <20% signal-to-noise (very low efficiency)
  - Note redundant content (same topic in multiple files)
  - Identify irrelevant sections (business context, user personal details, unused modes)

### Step 4: Calculate Compliance Level

**Formula**:
- Process Compliance: (score / 8) × 100%
- Focus Efficiency: (score / 13) × 100%
- Overall Compliance: Average of both percentages

**Classification**:
- **Perfect (100%)**: 8/8 process + 11+ focus (85%+ of 13)
- **Good (75-99%)**: 6-7 process + 8+ focus (60%+ of 13)
- **Fair (50-74%)**: 4-5 process + any focus
- **Poor (<50%)**: 0-3 process

### Step 5: Generate Compliance Report

Create markdown report with following structure:

```markdown
# Agent Session Compliance Report

**Session**: [Date/Time]
**Agent**: [Agent name/model]
**Task**: [Brief task description]
**Compliance Level**: [Perfect/Good/Fair/Poor] ([Overall %])

---

## Process Compliance Score: X/8 ([X]%)

[For each layer, show ✅/⚠️/❌ with points earned]

### Layer 1: TodoWrite Gate (X/2)
✅/⚠️/❌ [Specific observation]

### Layer 2: Validation Check (X/2)
✅/⚠️/❌ [Specific observation]

### Layer 3: Plan Mode (X/3)
✅/⚠️/❌ [Specific observation]

### Layer 4: Pre-commit (X/1)
✅/⚠️/❌ [Specific observation]

---

## Focus Efficiency Score: X/13 ([X]%)

### Tool Efficiency (X/5)
[List specific tool usage patterns with +/- points]

### Context Navigation (X/3)
[List context usage patterns with +/- points]

### Task Focus (X/2)
[Describe scope adherence with +/- points]

### Context Efficiency (X/3)
**Signal-to-Noise Ratio**: [X]%

**Sections Referenced** ([N] of [Total]):
- [List sections actually used during session]

**Sections Unused** ([N] of [Total]):
- [List sections loaded but not referenced]

**Redundant Content Detected**:
- [Topic]: Found in [File1], [File2] ([overlap %])

**Recommendation**: [If <60%: Suggest which sections to remove/extract]

---

## Recommendations

[3-5 specific, actionable recommendations prioritized by impact]

1. **[Category]**: [Specific recommendation]
   - Why: [Rationale]
   - How: [Concrete action]

---

## Comparison to Project Baseline

[If baseline data available from previous sessions]

| Metric | This Session | Project Avg | Delta |
|--------|-------------|-------------|-------|
| Process Compliance | X% | Y% | ±Z% |
| Focus Efficiency | X% | Y% | ±Z% |
| Tool Efficiency | X% | Y% | ±Z% |
| Context Navigation | X% | Y% | ±Z% |

---

## Session Log Entry

[If creating session log JSON, provide structure]:

```json
{
  "session_id": "YYYY-MM-DD-HHMMSS",
  "start_time": "ISO-8601 timestamp",
  "end_time": "ISO-8601 timestamp",
  "agent": "Agent name",
  "task": "Task description",
  "scores": {
    "process_compliance": X,
    "focus_efficiency": X,
    "overall_percentage": X
  },
  "layers": {
    "todowrite_gate": X,
    "validation_check": X,
    "plan_mode": X,
    "precommit": X
  },
  "focus": {
    "tool_efficiency": X,
    "context_navigation": X,
    "task_focus": X,
    "context_efficiency": X
  },
  "context_analysis": {
    "context_loaded_tokens": X,
    "context_loaded_files": ["CLAUDE.md", "AGENTS.md"],
    "sections_referenced": ["list", "of", "used", "sections"],
    "sections_unused": ["list", "of", "unused", "sections"],
    "signal_to_noise_ratio": X.X,
    "redundant_content": [
      {
        "topic": "Topic name",
        "files": ["File1", "File2"],
        "overlap_percentage": X
      }
    ]
  },
  "files_created": ["list", "of", "permanent", "files"],
  "compliance_level": "Perfect|Good|Fair|Poor"
}
```
```

### Step 6: Provide Insights

After generating report, offer:
1. **Celebrate successes** - Highlight what went well
2. **Explain gaps** - Why certain points were lost (not blame, just clarity)
3. **Connect to outcomes** - How compliance affects code quality
4. **Suggest next steps** - Specific actions to improve

---

## Example Analysis

**User provides**: "I created auth.py and tests/test_auth.py. I made a plan first, ran the validation check, and committed."

**Agent analyzes**:
- ✅ Plan mentioned (Layer 3: +1)
- ❌ No TodoWrite visible (Layer 1: 0)
- ✅ Validation check mentioned (Layer 2: +1)
- ❌ Did plan include spec creation? Unknown (Layer 3: 0 for spec step)
- ✅ Commit passed (assuming, Layer 4: +1)

**Score**: 3/8 process (38% - Poor), recommendations focus on TodoWrite adoption and complete plan presentation

---

## Important Notes

**Be fair and constructive:**
- If information unavailable, note "Insufficient data" rather than penalizing
- Recognize that some sessions don't trigger spec-first (editing existing files)
- Focus on improvement, not criticism
- Celebrate good practices even in low-scoring sessions

**Be specific:**
- Quote actual tool calls when scoring tool efficiency
- Reference specific parts of transcript for evidence
- Provide concrete examples in recommendations

**Be useful:**
- Recommendations should be actionable (not "do better")
- Connect scores to real outcomes (not just abstract compliance)
- Explain WHY practices matter for code quality

---

## Validation Checklist

Before finalizing report:
- [ ] All four layers scored with evidence
- [ ] Tool efficiency based on actual tool usage
- [ ] Context navigation based on fetch patterns
- [ ] Task focus based on scope adherence
- [ ] Recommendations specific and actionable
- [ ] Compliance level calculated correctly
- [ ] Comparison to baseline (if available)
- [ ] Tone constructive and improvement-focused

---

**Next Steps**:
- Save report to `var/compliance/session-YYYY-MM-DD-HHMMSS-report.md`
- If creating session log, save JSON to `var/compliance/session-YYYY-MM-DD-HHMMSS.json`
- Use `.livespec/utils/next-steps.md` for workflow navigation
