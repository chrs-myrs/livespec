---
name: sweep
description: |
  Multi-project LiveSpec audit. Discovers all LiveSpec projects under ~/projects/ (excluding ~/projects/tmp/),
  scores them by maintenance need, presents a prioritised target list for approval, then orchestrates
  parallel agents to audit and remediate each project. Produces per-project issue files, a consolidated
  report, and a meta-report of cross-project framework patterns.
  USE WHEN: User mentions "sweep", "multi-project", "audit all projects", "portfolio audit", "maintenance scan", or wants to audit multiple projects at once.
argument-hint: [--conservative|--aggressive] [--stale-days <N>]
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, AskUserQuestion, Task
---

> **CRITICAL INSTRUCTION**: Follow this workflow step-by-step. All guidance is INLINE below.

# LiveSpec Sweep

Multi-project audit that discovers, prioritises, analyses, and optionally remediates LiveSpec projects across your portfolio.

## Usage

```
/livespec:sweep                  # Default: tiered remediation
/livespec:sweep --conservative   # Report only, no auto-writes
/livespec:sweep --aggressive     # Auto-apply Tier 1+2, report Tier 3
/livespec:sweep --stale-days 30  # Custom staleness threshold
```

---

## Workflow

### Step 1: Parse Arguments

Extract flags from invocation arguments:
- `--conservative` → `MODE=conservative`
- `--aggressive` → `MODE=aggressive`
- default → `MODE=tiered`
- `--stale-days N` → `STALE_DAYS=N` (default 60)

Announce to user:
```
Running LiveSpec Sweep...
Mode: [tiered|conservative|aggressive]
Scanning: ~/projects/ (excluding tmp/)
```

---

### Step 2: Discover and Fingerprint Projects

Run the discovery script:

```bash
PLUGIN_SCRIPTS="${CLAUDE_PLUGIN_ROOT}/scripts"
STALE_DAYS=60  # or from args

bash "${PLUGIN_SCRIPTS}/sweep-projects.sh" --stale-days "${STALE_DAYS}"
```

The script outputs a markdown table of projects scored 0-10 by five signals:
- Version lag (0-2)
- Missing required files (0-2)
- Stale specs (0-2)
- Structure violations (0-2)
- Incomplete/unlinked specs (0-2)

Display the discovery output directly to the user.

---

### Step 3: Get Approval

Present the priority list and ask:

```
[AskUserQuestion]
Header: "Proceed"
Question: "Which projects should I audit? (Discovery complete above)"
Options:
  - "All flagged projects (WARNING + CRITICAL)"
  - "Critical only"
  - "I'll specify" → follow up with text input for project names
  - "Cancel sweep"
```

**HARD GATE**: No agents spawned, no files written until user approves.

If user selects "I'll specify", ask:
```
[AskUserQuestion]
Header: "Projects"
Question: "Which projects to include? (comma-separated project names)"
Options: [free text via Other]
```

If user cancels: stop and confirm "Sweep cancelled. No changes made."

---

### Step 4: Prepare Report Paths

```bash
REPORT_DATE=$(date +%Y-%m-%d)
REPORT_DIR="${PWD}/var/audit-reports"
mkdir -p "${REPORT_DIR}"

SWEEP_REPORT="${REPORT_DIR}/${REPORT_DATE}-sweep.md"
META_REPORT="${REPORT_DIR}/${REPORT_DATE}-meta.md"
```

Initialize the consolidated report with header:

```markdown
# LiveSpec Sweep Report — YYYY-MM-DD

**LiveSpec version:** 5.7.0
**Sweep mode:** [tiered|conservative|aggressive]
**Started:** HH:MM UTC
**Projects audited:** [N]

---
```

---

### Step 5: Audit Projects in Parallel

For each approved project, spawn a background agent:

```
Task tool:
  subagent_type: general-purpose
  run_in_background: true
  prompt: |
    You are auditing the LiveSpec project at: [PROJECT_PATH]
    Project name: [PROJECT_NAME]
    Sweep mode: [MODE]
    LiveSpec plugin version: 5.7.0

    ## Your Mission

    Perform a comprehensive LiveSpec audit of this project and compile findings.

    ## Step 1: Read Project State

    Read these files to understand the project:
    - [PROJECT_PATH]/AGENTS.md (if exists)
    - [PROJECT_PATH]/PURPOSE.md (if exists)
    - [PROJECT_PATH]/specs/workspace/taxonomy.spec.md (if exists)
    - List all files under [PROJECT_PATH]/specs/ (up to 50 files)

    ## Step 1b: Check Prior Audit History

    Check if [PROJECT_PATH]/.livespec-audit/issues.md exists:
    - If it exists: read it and extract the most recent audit's Tier 2 and Tier 3 findings as a "prior issues list"
    - Keep this list in memory to compare against current findings at Step 5b
    - If it doesn't exist: prior_issues = []

    ## Step 2: Run Health Checks

    Check for these issues (same logic as /livespec:audit health):

    **Structural:**
    - Specs missing frontmatter (criticality, failure_mode)
    - Specs missing ## Requirements or ## Validation sections
    - Cross-references pointing to non-existent files

    **Coverage:**
    - Major code directories (src/, lib/) without corresponding specs (run extract mode if unspecified code directories are detected)
    - Specs referencing removed/renamed code

    **Context:**
    - AGENTS.md missing or clearly outdated (no mention of current specs)
    - PURPOSE.md absent or over-limit (>20 content lines)

    **Framework usage problems:**
    - Specs specifying HOW instead of WHAT (implementation details in specs)
    - workspace/ specs containing product-specific content
    - features/ containing artifacts that belong in artifacts/
    - [!] markers missing from requirements

    ## Step 2b: AGENTS.md and Agent File Inspection

    All findings from this step are automatically Tier 3.

    **If [PROJECT_PATH]/AGENTS.md exists:**
    - Extract all skill invocations (patterns like `/livespec:...` or slash command references)
    - Verify each skill is current (current skills: livespec:design, livespec:audit, livespec:init, livespec:learn, livespec:upgrade, livespec:go, livespec:sweep)
    - Extract all ctxt/ path references (e.g., `ctxt/design.md`, `ctxt/define.md`)
    - Verify each ctxt/ file exists at the referenced path within the project
    - Flag any references to pre-v5 paths: `.livespec/0-define/`, `.livespec/1-design/`, `.livespec/prompts/`, etc.

    **Search for agent definition files in the project:**
    - Check `.claude/agents/` directory
    - Check `agents/` directory
    - For each agent definition file found: grep for removed/renamed paths (old `.livespec/` prompt paths, legacy command names)

    All mismatches → Tier 3 finding: "Outdated framework reference in [file]: [specific issue]"

    ## Step 3: Score Issues by Severity

    For each issue found:
    - **Tier 1** (auto-fixable): Missing boilerplate files, missing frontmatter fields, version bumps
    - **Tier 2** (needs approval): Spec rewrites, AGENTS.md regeneration, cross-reference updates
    - **Tier 3** (human judgment): Architectural misalignment, framework misuse patterns, strategic concerns, outdated framework references (from Step 2b)

    ## Step 4: Apply Tier 1 Fixes (if mode allows)

    If mode is "tiered" or "aggressive":
    - Create missing .livespec-audit/ directory
    - Add obvious missing frontmatter fields (criticality: IMPORTANT, failure_mode: placeholder)
    - Note each auto-fix applied

    If mode is "conservative": skip all writes to project

    ## Step 5: Write Per-Project Issues File

    First, get the git HEAD:
    ```bash
    GIT_HEAD=$(git -C [PROJECT_PATH] rev-parse --short HEAD 2>/dev/null || echo "not a git repo")
    ```

    **If [PROJECT_PATH]/.livespec-audit/issues.md does NOT exist** — create it with full provenance header:
    ```markdown
    # LiveSpec Audit Issues — [PROJECT_NAME]

    <!-- Provenance — do not remove -->
    **LiveSpec version:** 5.7.0
    **Report generated:** YYYY-MM-DD HH:MM UTC
    **Checks performed:** structural, cross-references, coverage, agent-inspection
    **Project path:** [PROJECT_PATH]
    **Git HEAD:** [GIT_HEAD]
    <!-- End provenance -->

    **Sweep mode:** [MODE]
    **Overall status:** [GREEN|YELLOW|RED]

    ## Summary
    - Tier 1 issues (auto-fixable): N
    - Tier 2 issues (needs approval): N
    - Tier 3 issues (human judgment): N
    - Auto-fixes applied: N

    ## Issues

    ### Tier 1 — Auto-fixable
    - [ ] [Issue description] → [Suggested fix]

    ### Tier 2 — Needs Approval
    - [ ] [Issue description] → [Suggested fix]

    ### Tier 3 — Human Judgment
    - [ ] [Issue description] → [Context and recommendation]

    ## Framework Usage Observations
    [Patterns that indicate framework confusion — used for meta-report]
    ```

    **If [PROJECT_PATH]/.livespec-audit/issues.md ALREADY EXISTS** — append a dated section:
    ```markdown

    ---

    ## Audit Run — YYYY-MM-DD HH:MM UTC
    **LiveSpec version:** 5.7.0 | **Mode:** sweep-[MODE] | **Git HEAD:** [GIT_HEAD]
    **Status:** [GREEN|YELLOW|RED]

    ### Summary
    - Tier 1: N | Tier 2: N | Tier 3: N | Auto-fixed: N

    ### Tier 1 — Auto-fixable
    - [ ] [Issue] → [Fix]

    ### Tier 2 — Needs Approval
    - [ ] [Issue] → [Fix]

    ### Tier 3 — Human Judgment
    - [ ] [Issue] → [Recommendation]

    ### Framework Usage Observations
    [Patterns for meta-report]
    ```

    ## Step 5b: Cross-Audit Learning

    Compare current Tier 2 and Tier 3 findings against prior_issues (from Step 1b):
    - Issue found in BOTH current AND prior run → prepend `[PERSISTENT]` to that finding entry
    - Issue was in prior run but NOT in current findings → add a note:
      `[RESOLVED since prior run: [issue description]]` in the relevant tier section

    ## Step 6: Return Summary

    Return a JSON summary for the orchestrator:
    ```json
    {
      "project": "[PROJECT_NAME]",
      "path": "[PROJECT_PATH]",
      "status": "GREEN|YELLOW|RED",
      "tier1_count": N,
      "tier2_count": N,
      "tier3_count": N,
      "autofixes_applied": N,
      "framework_patterns": ["pattern1", "pattern2"],
      "issues_file": "[PROJECT_PATH]/.livespec-audit/issues.md"
    }
    ```
```

Notify user as each agent completes:
```
✓ [project-name]: [status] — T1:[n] T2:[n] T3:[n] fixes applied:[n]
```

---

### Step 6: Compile Consolidated Report

After all agents complete, write the sweep report:

```markdown
# LiveSpec Sweep Report — YYYY-MM-DD

**LiveSpec version:** 5.7.0
**Sweep mode:** [tiered|conservative|aggressive]
**Completed:** HH:MM UTC
**Projects audited:** N

## Executive Summary

| Status  | Count |
|---------|-------|
| 🟢 GREEN  | N |
| 🟡 YELLOW | N |
| 🔴 RED    | N |

Total Tier 1 issues: N (X auto-fixed)
Total Tier 2 issues: N (require approval)
Total Tier 3 issues: N (human judgment)

## Projects

### 🔴 [project-name]
**Path:** ~/projects/project-name
**Issues:** `.livespec-audit/issues.md`
**Summary:** [brief description of main problems]

**Tier 2 actions pending approval:**
- [ ] [Specific action needed]

---

### 🟡 [another-project]
...
```

---

### Step 7: Compile Meta-Report

**Pattern deduplication process:**

1. Collect all `framework_patterns` arrays returned by per-project agents
2. Build a frequency map: group patterns by description (case-insensitive string match)
3. Filter: only patterns appearing in **3+ distinct projects** qualify as cross-project
4. For each qualifying pattern, record:
   - Count of affected projects
   - Names of up to 3 example projects
   - A suggested framework improvement

If zero patterns meet the ≥3 threshold: write a single line "No cross-project patterns detected in this sweep." and skip the meta-report file entirely.

If qualifying patterns exist, write:

```markdown
# LiveSpec Framework Meta-Report — YYYY-MM-DD

**Generated from sweep of:** N projects
**LiveSpec version:** 5.7.0
**Date:** YYYY-MM-DD HH:MM UTC

This report surfaces patterns appearing across 3+ projects that may indicate
framework-level confusion rather than individual project errors.

## Cross-Project Patterns

### [Pattern Name] — N projects affected

**Description:** [What the pattern is]
**Affected projects:** project-a, project-b, project-c
**Suggested framework improvement:** [What to clarify/fix in LiveSpec itself]

---
```

If no cross-project patterns: note "No cross-project patterns detected in this sweep."

---

### Step 8: Present Completion Summary

```
Sweep complete.

Projects audited: N
🔴 RED:    N  — immediate attention needed
🟡 YELLOW: N  — maintenance recommended
🟢 GREEN:  N  — healthy

Auto-fixes applied: N (Tier 1)
Pending approval:  N (Tier 2, see consolidated report)
Human review:      N (Tier 3)

Reports:
  var/audit-reports/YYYY-MM-DD-sweep.md
  var/audit-reports/YYYY-MM-DD-meta.md (if applicable)

Per-project issues: {project}/.livespec-audit/issues.md

To address Tier 2 items, review the consolidated report and run:
  /livespec:audit  (within each project directory)
```

---

## Remediation Modes Reference

| Mode | Tier 1 | Tier 2 | Tier 3 |
|------|--------|--------|--------|
| `conservative` | Report only | Report only | Report only |
| `tiered` (default) | Auto-apply | Approval required | Report only |
| `aggressive` | Auto-apply | Auto-apply | Approval required |

---

## Signal Scoring Reference

| Signal | Score 0 | Score 1 | Score 2 |
|--------|---------|---------|---------|
| Version lag | Current | Minor lag | Major/legacy |
| Missing files | All present | Some missing | Core missing |
| Stale specs | Active spec commits | Low activity | No spec commits in 60+ days |
| Structure violations | <20% violation rate | 20-50% | 50%+ |
| Incomplete specs | <25% incomplete | 25-50% | 50%+ |

**Total score:** 0-10
- 0 = HEALTHY (green)
- 1-3 = WARNING (yellow)
- 4-10 = CRITICAL (red)
