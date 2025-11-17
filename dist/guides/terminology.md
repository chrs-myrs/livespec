# LiveSpec Terminology Guide

## Purpose

This guide establishes consistent terminology across LiveSpec documentation, prompts, and agent guidance to prevent confusion and ensure clear communication.

---

## Improvement Taxonomy

LiveSpec uses a four-level improvement taxonomy with distinct triggers, scopes, and tools.

### Session-Level: "Capture Session Learnings"

**When:** End of every session (eager detection required)

**Scope:** Current session → project specs (workspace + behaviors)

**Tool:** `dist/prompts/utils/complete-session.md`

**What it does:**
- Analyzes process compliance (0-8 points)
- Calculates focus efficiency (0-13 points)
- Scans current session for corrections, clarifications, patterns
- Identifies specs to update based on session insights
- Generates LiveSpec feedback (methodology gaps for LiveSpec maintainers)
- Saves compliance data + feedback to `~/.claude/livespec/`

**Triggers:**
- Context >100K tokens
- All tasks completed
- Natural stopping point (commit, switching tasks)
- User appears stuck

### Context-Level: "Refine Workspace"

**When:** Periodic (when context feels bloated or inefficient)

**Scope:** AGENTS.md structure, ctxt/ hierarchy, compression strategy

**Tools:**
- `dist/prompts/utils/regenerate-contexts.md` - Regenerate context tree
- `dist/prompts/utils/reorganize-workspace.md` - Optimize structure based on usage

**What it does:**
- Analyzes context usage patterns (which sections loaded most?)
- Recommends reorganization (move hot sections to START)
- Identifies extraction candidates (inline → templates)
- Evaluates compression effectiveness (file sizes vs budgets)
- Regenerates AGENTS.md + ctxt/ tree with optimizations

### Strategic-Level: "Suggest Improvements"

**When:** Monthly or when feedback accumulates (10+ session feedback files)

**Scope:** Value hierarchy, methodology gaps, prioritization

**Tool:** `dist/prompts/utils/suggest-improvements.md`

**Uses:** Three registries in `specs/3-behaviors/registries/`:
- `gaps.spec.md` - Methodology gaps identified
- `issues.spec.md` - Problems encountered
- `improvements.spec.md` - Changes tried and their results

**What it does:**
- Reads all registries + recent session feedback
- Identifies patterns (repeated gaps/issues)
- Prioritizes by impact (CRITICAL > IMPORTANT)
- Recommends specific actions (update spec X, create prompt Y)
- Updates registries with newly discovered entries
- Outputs prioritized improvement plan

### Diagnostic-Level: "Run Health Report"

**When:** Before releases, weekly, or on-demand

**Scope:** Overall project state (validations + metrics + trends)

**Tool:** `dist/prompts/utils/run-health-report.md`

**What it does:**
- Runs all 8 validation scripts
- Checks compliance trends (last 5 sessions)
- Reviews registry health (accumulating?)
- Measures context efficiency (within budgets?)
- Assigns status per category: 🟢 GREEN / 🟡 YELLOW / 🔴 RED
- Generates remediation plan for issues
- Outputs comprehensive health dashboard

---

## Core Terms

### Session

**Definition:** A bounded period of agent interaction, terminated by completion triggers.

**Use for:**
- Agent interaction boundaries
- Completion triggers
- Analysis scope

**Don't use for:**
- Methodology patterns (use "workflow")
- File generation processes (use "process")

**Examples:**
- ✅ "Complete this session and analyze compliance"
- ✅ "Session approaching 150K tokens - recommend completion"
- ❌ "Complete this conversation" (use "session")
- ❌ "End the interaction" (vague, use "session")

### Workflow

**Definition:** A structured sequence of steps that describes HOW to execute a process.

**Use for:**
- Step-by-step procedures (TDD workflow, Phase 0-4 workflow)
- Process descriptions

**Don't use for:**
- WHEN agent does work (use "session")
- Specific agent interactions (use "session")

**Examples:**
- ✅ "Following the TDD workflow"
- ✅ "The validation workflow caught errors"
- ❌ "This workflow is taking too long" (use "session")

### Task

**Definition:** A specific unit of work within a session, tracked via TodoWrite.

**Use for:**
- TodoWrite items
- Scope adherence (task focus scoring dimension)
- Specific work units

**Don't use for:**
- Entire session scope (use "session")
- Methodology patterns (use "workflow")

**Examples:**
- ✅ "Mark the task as completed"
- ✅ "Task focus score: 2/2 (stayed on scope)"
- ❌ "Task completed, end the session" (task ≠ session)

### Process

**Definition:** A repeatable methodology pattern that governs how work is done.

**Use for:**
- Methodology patterns
- Workspace governance
- Repeatable approaches

**Don't use for:**
- Agent interactions (use "session")
- Specific work (use "task")

**Examples:**
- ✅ "Process compliance: 6/8 points"
- ✅ "Spec-first process requires specification before implementation"

### Registry

**Definition:** A structured specification that tracks items in a category over time.

**Use for:**
- Gaps tracking (`registries/gaps.spec.md`)
- Issues tracking (`registries/issues.spec.md`)
- Improvements tracking (`registries/improvements.spec.md`)

**Structure:**
- MSL spec format
- Each entry: description, status, metadata
- Updated by prompts (capture session learnings, suggest improvements)
- Reviewed periodically (suggest improvements workflow)

**Examples:**
- ✅ "Add this gap to the gap registry"
- ✅ "Review the issue registry for recurring problems"

---

## Term Hierarchy

Understanding the relationship between terms:

```
Process (methodology level)
  ↓ governs
Workflow (how to execute process)
  ↓ executed during
Session (bounded agent interaction)
  ↓ contains
Task (specific work within session)
```

**Example in practice:**
- **Process:** Spec-first methodology
- **Workflow:** Phase 1 design workflow (how to create specs)
- **Session:** Today's agent interaction creating user authentication spec
- **Task:** Write behavior requirements for OAuth flow

---

## Improvement Level Decision Matrix

**Which improvement level should I use?**

| If you want to... | Use this level | Tool |
|-------------------|----------------|------|
| Capture what happened in THIS session | Session-Level | complete-session.md |
| Update project specs based on current insights | Session-Level | complete-session.md |
| Reorganize AGENTS.md sections | Context-Level | reorganize-workspace.md |
| Regenerate context tree | Context-Level | regenerate-contexts.md |
| Identify methodology gaps across sessions | Strategic-Level | suggest-improvements.md |
| Prioritize what to improve next | Strategic-Level | suggest-improvements.md |
| Check overall project health | Diagnostic-Level | run-health-report.md |
| Get RED/YELLOW/GREEN status | Diagnostic-Level | run-health-report.md |

---

## Deprecated Terms

**"Internalise Learnings"** → **"Capture Session Learnings"**
- Reason: "Internalise" is vague, "Capture" is action-focused
- Merged into complete-session.md

**"Self-Improvement"** → Removed (ambiguous)
- LiveSpec project: Covered by "Suggest Improvements"
- Other projects: Not applicable (can't improve LiveSpec methodology)

**"Conversation"** → **"Session"**
- Reason: Inconsistent usage, "session" is standard

**"Evolve Framework"** → **"Suggest Improvements"** (strategic level) OR **"Refine Workspace"** (context level)
- Reason: "Framework" ambiguous (LiveSpec? Project? Both?)
- Clear distinction now exists between levels

---

## Common Mistakes

### ❌ Wrong: "Complete this conversation and internalise learnings"
✅ Right: "Complete this session to capture learnings"

### ❌ Wrong: "Run the session to validate"
✅ Right: "Run the validation workflow" (workflow = HOW, session = WHEN)

### ❌ Wrong: "This task is running long"
✅ Right: "This session is running long" (task = sub-unit)

### ❌ Wrong: "Evolve the framework based on gaps"
✅ Right: "Suggest improvements based on gap registry" (strategic level)

### ❌ Wrong: "Check process health"
✅ Right: "Run health report" (diagnostic level)

---

## Integration with Documentation

This terminology is reflected throughout:
- **AGENTS.md** - Uses standardized terms, active session triggers
- **Prompt files** - Named using standard terminology
- **Spec frontmatter** - Cross-references use consistent terms
- **Registry structure** - Follows registry definition
- **Validation** - Checks for deprecated term usage

---

## Future Extensions

As LiveSpec evolves, new terms may be added following these principles:

1. **Action-focused** - Use verbs that describe what happens (Capture, Refine, Suggest, Run)
2. **Unambiguous** - Clear scope (session/context/strategic/diagnostic)
3. **Distinct** - No overlap with existing terms
4. **Universal** - Works for ALL projects using LiveSpec, not just LiveSpec project itself
5. **Concise** - 2-3 words maximum

New terms must be documented here before widespread adoption.

---

*Version: 1.0*
*Last updated: 2025-11-13*
*Part of LiveSpec methodology improvement taxonomy*
