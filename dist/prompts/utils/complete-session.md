---
implements: specs/3-behaviors/session-completion.spec.md
phase: utilities
---

# Complete Session Analysis

**Purpose**: Analyze session compliance, provide concise feedback, and save data for methodology improvement.

**When to use**: When session should end (task complete, context large, natural stopping point, user stuck).

---

## Instructions for AI Agent

You are completing a LiveSpec development session. Provide concise analysis, save data globally, and encourage fresh start.

### Step 1: Detect Session Completion Signals

Check if session should end:
- ✅ Task completed successfully (all todos done)
- ✅ Context approaching 100K tokens (50% of budget)
- ✅ Natural stopping point (ready to commit, switching tasks)
- ✅ User appears stuck (repeated attempts, no progress)

If ANY signal present, proceed with completion analysis.

### Step 2: Analyze Compliance

**Process Compliance (0-8 points):**
- Layer 1 (TodoWrite Gate): 0-2 points
  - 1 point: TodoWrite added before file operations
  - 1 point: Todo marked complete after spec created
- Layer 2 (Validation Check): 0-2 points
  - 1 point: `check-requires-spec.sh` executed
  - 1 point: Exit code respected
- Layer 3 (Plan Mode): 0-3 points
  - 1 point: Plan presented before creating permanent file
  - 1 point: Plan includes spec creation step
  - 1 point: Plan shows specific spec path
- Layer 4 (Pre-commit): 0-1 point
  - 1 point: Commit passed validation (or ready to pass)

**Focus Efficiency (0-13 points):**
- Tool Efficiency (0-5): Read/Grep/Glob vs Bash, parallel calls
- Context Navigation (0-3): AGENTS.md usage, appropriate fetches
- Task Focus (0-2): Scope adherence, clarifying questions
- Context Efficiency (0-3): Signal-to-noise ratio
  - Calculate: (sections referenced / total sections) × 100%
  - 3 points: >60%, 2 points: 40-60%, 1 point: 20-40%, 0 points: <20%

**Overall Compliance:**
- Process %: (score / 8) × 100%
- Focus %: (score / 13) × 100%
- Overall: Average of both

**Classification:**
- Perfect (100%): 8/8 process + 11+ focus
- Good (75-99%): 6-7 process + 8+ focus
- Fair (50-74%): 4-5 process
- Poor (<50%): 0-3 process

### Step 3: Analyze Context Efficiency

**Identify sections used:**
- What CLAUDE.md sections were referenced?
- What AGENTS.md sections were referenced?
- List specific headings/topics actually used

**Identify sections unused (noise):**
- What sections were loaded but never referenced?
- Examples: TMP Business Context, unused modes (Refine/Debug/Sprint), personal details

**Detect redundancy:**
- What topics appear in both CLAUDE.md and AGENTS.md?
- Estimate overlap percentage (e.g., "MSL Minimalism: 80% overlap")

**Calculate signal-to-noise:**
- Signal = number of sections referenced
- Noise = number of sections unused
- Ratio = (signal / total) × 100%

### Step 4: Identify What Didn't Work

**LiveSpec methodology gaps:**
- What guidance was unclear or missing?
- What prompts were hard to use?
- What specs didn't help?
- What caused confusion or extra work?

**Process friction:**
- What slowed you down?
- What felt unnecessary or bureaucratic?
- What could be simpler?

**Context issues:**
- Which CLAUDE.md sections were irrelevant?
- Which AGENTS.md sections weren't helpful?
- What redundancy caused confusion?

### Step 5: Capture Session Learnings

**Purpose:** Extract actionable insights from THIS session that should update project specs or inform LiveSpec methodology.

**Scan current conversation for:**

1. **Corrections made:**
   - Mistaken assumptions you corrected
   - Misunderstandings clarified
   - Wrong approaches abandoned
   - Example: "I initially thought X, but actually it's Y because..."

2. **Clarifications user provided:**
   - Requirements refined during discussion
   - Scope adjusted based on feedback
   - Ambiguities resolved
   - Example: User said "No, I meant..." or "Actually, it should..."

3. **Patterns that emerged:**
   - Repeated issues (same problem multiple times)
   - New conventions established
   - Workflow improvements discovered
   - Example: "We kept hitting X, so we decided Y approach works better"

4. **Specs needing updates:**
   - Workspace specs (process changes, new conventions)
   - Behavior specs (requirements changed, new behaviors added)
   - Contract specs (API changes, new interfaces)
   - Example: "This session revealed we need to update X.spec.md to include Y"

**For project specs (workspace/behaviors):**
- List specific specs to update
- Note what should change (add requirement, remove outdated, clarify ambiguity)
- Brief reasoning (why this update matters)

**For LiveSpec methodology (framework gaps):**
- What LiveSpec guidance was unclear or missing?
- What prompts were confusing or incomplete?
- What caused unnecessary friction?
- What would have helped during this session?

**Output format for Step 6 report:**
```markdown
**Session Learnings:**
- [Key learning 1: what you corrected/learned]
- [Key learning 2: pattern or clarification]

**Specs to Update:**
- [path/to/spec.md: what needs updating]
- [another/spec.md: what needs updating]

**LiveSpec Feedback:**
- [Methodology gap or improvement suggestion]
- [Framework friction point or unclear guidance]
```

**If no learnings identified:** Skip the learnings section in report (perfectly fine - not every session has major insights)

### Step 6: Show Concise Report (≤15 lines)

```markdown
# Session Complete

**Accomplished:**
- [Bullet list of what was done]

**Compliance:** [X]% ([X]/8 process, [X]/13 focus) - [Perfect|Good|Fair|Poor]

**Session Learnings:** (if any captured in Step 5)
- [Key insights from this session]
- [Specs to update: list paths]

**Highlights:**
- [2-3 things that went well]

**Improvements:**
- [2-3 specific, actionable suggestions]

**Data saved to:** ~/.claude/livespec/compliance/ and ~/.claude/livespec/feedback/

**Next:** Consider committing your work and starting a fresh session for better focus.
```

### Step 7: Detect Project Metadata

**Project name:**
```bash
# Try git remote first
git remote get-url origin 2>/dev/null | sed 's/.*\///' | sed 's/\.git$//'

# Fallback to directory name
basename "$(pwd)"
```

**Project path:**
```bash
pwd
```

**Git remote URL (if available):**
```bash
git remote get-url origin 2>/dev/null
```

**LiveSpec version:**
- Check `.livespec-version` file or default to "unknown"

### Step 8: Write Compliance JSON

**File:** `~/.claude/livespec/compliance/YYYY-MM-DD-HHMMSS-projectname.json`

**Create directory if needed:**
```bash
mkdir -p ~/.claude/livespec/compliance
```

**Structure:**
```json
{
  "session_id": "YYYY-MM-DD-HHMMSS",
  "start_time": "ISO-8601 timestamp",
  "end_time": "ISO-8601 timestamp",
  "agent": "Claude Sonnet 4.5",
  "task": "Brief task description",
  "project_metadata": {
    "project_name": "projectname",
    "project_path": "/absolute/path/to/project",
    "git_remote": "https://github.com/user/repo.git",
    "livespec_version": "3.4.0"
  },
  "scores": {
    "process_compliance": 7,
    "focus_efficiency": 11,
    "overall_percentage": 89
  },
  "layers": {
    "todowrite_gate": 2,
    "validation_check": 2,
    "plan_mode": 2,
    "precommit": 1
  },
  "focus": {
    "tool_efficiency": 5,
    "context_navigation": 2,
    "task_focus": 2,
    "context_efficiency": 2
  },
  "context_analysis": {
    "context_loaded_tokens": 25000,
    "context_loaded_files": ["CLAUDE.md", "AGENTS.md"],
    "sections_referenced": ["Spec-First Protocol", "MSL Minimalism"],
    "sections_unused": ["TMP Business Context", "Refine Mode"],
    "signal_to_noise_ratio": 45.5,
    "redundant_content": [
      {
        "topic": "MSL Minimalism",
        "files": ["CLAUDE.md", "AGENTS.md"],
        "overlap_percentage": 80
      }
    ]
  },
  "files_created": ["list", "of", "permanent", "files"],
  "compliance_level": "Good"
}
```

### Step 9: Write Feedback Markdown (≤10 lines)

**File:** `~/.claude/livespec/feedback/YYYY-MM-DD-HHMMSS-projectname.md`

**Create directory if needed:**
```bash
mkdir -p ~/.claude/livespec/feedback
```

**Format (CONCISE, max 10 lines):**
```markdown
# Session Feedback: [projectname]

**Date:** YYYY-MM-DD
**Compliance:** [X]% ([classification])

## What Didn't Work
- [Specific example of confusion or friction]
- [Specific example of unclear guidance]

## Methodology Gaps
- [Missing or unclear LiveSpec guidance]
- [Suggested improvement to prompts/specs]
```

**Rules:**
- Maximum 10 lines total
- Focus ONLY on problems/gaps (no praise)
- Be specific (quote exact prompts/specs that were unclear)
- Suggest concrete improvements
- Skip this file if session was perfect (no feedback needed)

### Step 10: Handle Write Failures Gracefully

```bash
# Try to write files, but don't fail session if it doesn't work
{
  # Write JSON
  echo "$JSON" > ~/.claude/livespec/compliance/YYYY-MM-DD-HHMMSS-projectname.json

  # Write markdown
  echo "$MARKDOWN" > ~/.claude/livespec/feedback/YYYY-MM-DD-HHMMSS-projectname.md
} 2>/dev/null || echo "Note: Could not save to ~/.claude/livespec/ (continuing anyway)"
```

**Always show the report to user, even if file writes fail.**

### Step 11: Encourage Fresh Session

After showing report and saving files:

```
Your work has been analyzed and saved. Consider:
1. Committing your changes (if ready)
2. Starting a fresh session for your next task
3. Benefits: Fresh context, better focus, reduced cognitive load

Data saved to ~/.claude/livespec/ for future methodology improvements.
```

---

## When NOT to Use This Prompt

**Don't complete session if:**
- Task just started (< 10 minutes)
- User explicitly wants to continue
- In middle of complex operation
- About to commit (wait until after commit)

**Complete session eagerly when:**
- Task finished successfully
- Context >150K tokens
- User switching tasks
- User seems stuck or confused

---

## Validation Checklist

Before finalizing analysis:
- [ ] Process compliance scored with evidence
- [ ] Focus efficiency scored with evidence
- [ ] Signal-to-noise calculated correctly
- [ ] Context sections identified (used vs unused)
- [ ] Redundancy detected between CLAUDE.md and AGENTS.md
- [ ] Session learnings captured (corrections, clarifications, patterns, spec updates)
- [ ] Report shown to user (≤15 lines)
- [ ] JSON written to ~/.claude/livespec/compliance/
- [ ] Markdown written to ~/.claude/livespec/feedback/ (if problems found)
- [ ] Project metadata detected correctly
- [ ] Fresh session encouraged

---

**Remember:** This is about learning and improving, not judgment. Focus on what didn't work so LiveSpec methodology can improve.
