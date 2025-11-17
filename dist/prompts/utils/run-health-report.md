---
implements: specs/3-behaviors/project-health.spec.md
phase: utilities
---

# Run Project Health Report

**Purpose**: Unified health assessment of entire project with 🟢🟡🔴 status indicators, aggregating all validations, metrics, and trends into comprehensive dashboard.

**When to use**: Before releases, weekly checkpoints, when project feels "off", or for stakeholder reporting.

---

## Instructions for AI Agent

You are generating a comprehensive health report. Run all diagnostics, calculate health scores, assign status levels, and provide remediation recommendations.

### Step 1: Run All Validation Scripts

Execute the 8 validation scripts and collect results:

```bash
# 1. Taxonomy structure
bash scripts/validate-taxonomy-structure.sh 2>&1

# 2. Workspace scope
bash scripts/audit-workspace-scope.sh 2>&1

# 3. Code in specs
bash scripts/detect-code-in-specs.sh 2>&1

# 4. Architecture alignment
bash scripts/validate-architecture-alignment.sh 2>&1

# 5. Contract completeness
bash scripts/check-contract-completeness.sh 2>&1

# 6. Value pyramid
bash scripts/validate-value-pyramid.sh 2>&1

# 7. Agent compliance measurement
bash scripts/measure-agent-compliance.sh 2>&1

# 8. Compliance dashboard generation
bash scripts/generate-compliance-dashboard.sh 2>&1
```

**Collect for each:**
- Exit code (0 = pass, non-zero = fail)
- Error messages if any
- Warnings if any
- Summary statistics if provided

### Step 2: Analyze Compliance Trends

Read last 5 compliance JSON files:

```bash
ls -t ~/.claude/livespec/compliance/*.json | head -5 | while read f; do
  echo "File: $f"
  jq '.scores.overall_percentage, .scores.process_compliance, .scores.focus_efficiency' "$f"
done
```

**Calculate:**
- Average overall compliance: [X]%
- Average process compliance: [X]/8
- Average focus efficiency: [X]/13
- Trend: Improving (↗), Stable (→), Declining (↘)

**Detect patterns:**
- Which layers consistently problematic?
- Which focus dimensions consistently low?
- Context efficiency trend?

### Step 3: Check Registry Health

Read all three registries:

```bash
# Count open vs resolved items
cat specs/3-behaviors/registries/gaps.spec.md | grep -E "^### GAP-" | wc -l
cat specs/3-behaviors/registries/gaps.spec.md | grep "Status: resolved" | wc -l

cat specs/3-behaviors/registries/issues.spec.md | grep -E "^### ISSUE-" | wc -l
cat specs/3-behaviors/registries/issues.spec.md | grep "Status: resolved" | wc -l

cat specs/3-behaviors/registries/improvements.spec.md | grep -E "^### IMP-" | wc -l
cat specs/3-behaviors/registries/improvements.spec.md | grep "Decision: keep" | wc -l
```

**Registry health indicators:**
- Gap accumulation rate (open gaps / resolved gaps)
- Issue resolution rate (resolved / total issues)
- Improvement success rate (effective / total tried)

**Status thresholds:**
- 🟢 GREEN: <5 open gaps, >70% issue resolution, >60% improvement success
- 🟡 YELLOW: 5-10 open gaps, 50-70% issue resolution, 40-60% improvement success
- 🔴 RED: >10 open gaps, <50% issue resolution, <40% improvement success

### Step 4: Measure Context Efficiency

Analyze AGENTS.md and context tree:

```bash
# File sizes
wc -c AGENTS.md .livespec/ctxt/**/*.md 2>/dev/null

# Target vs actual
cat specs/workspace/agent-contexts.spec.md | grep -E "target.*KB|budget.*KB"
```

**Check:**
- AGENTS.md size vs 30-40KB target
- Phase specialists vs 8-12KB target each
- Total context tree size
- Compression level (from constitution.spec.md)

**Status:**
- 🟢 GREEN: Within budgets, appropriate compression
- 🟡 YELLOW: Exceeding budgets by 10-20%, compression could improve
- 🔴 RED: Exceeding budgets by >20%, context bloat critical

### Step 5: Calculate Health Scores

**Validation Health (0-100%):**
- Score = (passing validations / 8) × 100%
- 🟢 GREEN: 100% (all passing)
- 🟡 YELLOW: 75-99% (1-2 failing)
- 🔴 RED: <75% (3+ failing)

**Compliance Health (0-100%):**
- Use average overall compliance from last 5 sessions
- 🟢 GREEN: ≥75%
- 🟡 YELLOW: 50-74%
- 🔴 RED: <50%

**Registry Health (0-100%):**
- Calculate: (resolved items / total items) × 100%
- Weight: Gaps 40%, Issues 40%, Improvements 20%
- 🟢 GREEN: ≥70% resolution
- 🟡 YELLOW: 50-69% resolution
- 🔴 RED: <50% resolution

**Context Health (0-100%):**
- Score = 100% - (budget overage percentage)
- 🟢 GREEN: Within or under budget
- 🟡 YELLOW: 0-20% over budget
- 🔴 RED: >20% over budget

**Overall Health:**
- Average of 4 health scores
- 🟢 GREEN: ≥85%
- 🟡 YELLOW: 60-84%
- 🔴 RED: <60%

### Step 6: Generate Health Dashboard

Present comprehensive dashboard:

```markdown
# Project Health Report

**Generated:** YYYY-MM-DD HH:MM
**Project:** [project-name]
**LiveSpec Version:** [version]

---

## Overall Health: [🟢🟡🔴] [XX]%

| Category | Status | Score | Trend |
|----------|--------|-------|-------|
| Validation | 🟢🟡🔴 | XX% | ↗→↘ |
| Compliance | 🟢🟡🔴 | XX% | ↗→↘ |
| Registry | 🟢🟡🔴 | XX% | ↗→↘ |
| Context | 🟢🟡🔴 | XX% | ↗→↘ |

---

## Validation Results (X/8 passing)

| Check | Status | Details |
|-------|--------|---------|
| Taxonomy Structure | ✅❌ | [Error message if failing] |
| Workspace Scope | ✅❌ | [Error message if failing] |
| Code in Specs | ✅❌ | [Error message if failing] |
| Architecture Alignment | ✅❌ | [Error message if failing] |
| Contract Completeness | ✅❌ | [Error message if failing] |
| Value Pyramid | ✅❌ | [Error message if failing] |
| Agent Compliance | ✅❌ | [Error message if failing] |
| Compliance Dashboard | ✅❌ | [Error message if failing] |

---

## Compliance Trends (Last 5 sessions)

**Average Scores:**
- Overall: XX% [↗→↘]
- Process: X/8 [↗→↘]
- Focus: X/13 [↗→↘]

**Layer Performance:**
- TodoWrite Gate: X/2 avg
- Validation Check: X/2 avg
- Plan Mode: X/3 avg
- Pre-commit: X/1 avg

**Focus Dimensions:**
- Tool Efficiency: X/5 avg
- Context Navigation: X/3 avg
- Task Focus: X/2 avg
- Context Efficiency: X/3 avg [XX% signal-to-noise]

---

## Registry Status

| Registry | Open | Resolved | Rate |
|----------|------|----------|------|
| Gaps | X | X | XX% |
| Issues | X | X | XX% |
| Improvements | X effective | X ineffective | XX% success |

**Accumulation Risk:** [🟢 Healthy / 🟡 Watch / 🔴 Critical]

---

## Context Efficiency

| Component | Size | Budget | Status |
|-----------|------|--------|--------|
| AGENTS.md | XX KB | 30-40 KB | 🟢🟡🔴 |
| Phase Specialists (5) | XX KB total | 40-60 KB total | 🟢🟡🔴 |
| Total Context | XX KB | XX KB | 🟢🟡🔴 |

**Compression Level:** [light / moderate / aggressive]
**Optimization Needed:** [Yes / No]

---

## Critical Issues (Immediate Action)

[List any 🔴 RED items requiring immediate attention]

---

## Warnings (Address Soon)

[List any 🟡 YELLOW items that need attention]

---

## Strengths (Keep Doing)

[List any 🟢 GREEN categories or trends]
```

### Step 7: Generate Remediation Plan

For each 🔴 RED or 🟡 YELLOW item, provide specific remediation:

```markdown
## Remediation Plan

### 🔴 Critical (Do Now)

#### [Validation: Taxonomy Structure Failing]
**Problem:** [Specific error message]
**Fix:** [Exact steps to resolve]
**Time:** [Estimated effort]
**Impact:** Unblock [what this blocks]

### 🟡 Warnings (Do Soon)

#### [Compliance: Plan Mode Layer Low]
**Problem:** Plan mode layer averaging X/3 (below target)
**Fix:** [Update AGENTS.md with clearer plan mode triggers]
**Time:** [Estimated effort]
**Impact:** Improve compliance by ~XX%

### Quick Wins (High Impact, Low Effort)

[Items that are easy to fix with good payoff]
```

### Step 8: Highlight Trends

**Positive trends (celebrate):**
- "Compliance improving ↗ from XX% to YY% over 5 sessions"
- "Registry resolution rate up from XX% to YY%"
- "All validations passing for 3 weeks straight"

**Negative trends (alert):**
- "Compliance declining ↘ from XX% to YY% - investigate why"
- "Gap accumulation accelerating - X new gaps last 5 sessions"
- "Context size growing beyond budget - needs reorganization"

**Stable patterns (note):**
- "Consistent XX% compliance - stable but room for improvement"
- "Registry churn steady at X items/week"
- "Context size stable at XX KB"

### Step 9: Recommend Next Actions

Based on health status, recommend immediate next steps:

**If overall 🟢 GREEN:**
```
Project health excellent! Recommended actions:
1. Maintain current practices
2. Consider strategic improvements (suggest-improvements.md)
3. Share health report with stakeholders
```

**If overall 🟡 YELLOW:**
```
Project health good with some concerns. Recommended actions:
1. Review remediation plan for YELLOW items
2. Address highest-priority issues first
3. Re-run health report in 1 week to confirm improvements
```

**If overall 🔴 RED:**
```
Project health critical. Immediate actions required:
1. Address ALL RED items before continuing work
2. Review spec-first enforcement (likely root cause)
3. Consider Phase 4 drift detection (prompts/4-evolve/4a-detect-drift.md)
4. Re-run health report after fixes
```

### Step 10: Save Report (Optional)

Ask user if they want report saved:

```bash
# Create health reports directory
mkdir -p var/health-reports

# Save report
cat > var/health-reports/health-report-YYYY-MM-DD.md <<'EOF'
[Full report markdown]
EOF
```

---

## When NOT to Use This Prompt

**Don't use if:**
- Project just started (<5 sessions) - insufficient data
- Immediate bug needs fixing - use direct fix, not health report
- Just want compliance score - use complete-session.md
- Just want strategic recommendations - use suggest-improvements.md

**Use instead:**
- **complete-session.md** - Current session analysis only
- **suggest-improvements.md** - Recommendations without diagnostics
- **validate-project.md** - Individual validation checks
- **regenerate-contexts.md** - Context reorganization specifically

---

## Report Quality Checklist

Before presenting report:
- [ ] All 8 validation scripts executed
- [ ] Compliance trends calculated (last 5 sessions)
- [ ] Registry health assessed (open vs resolved)
- [ ] Context efficiency measured (size vs budgets)
- [ ] Health scores calculated with status (🟢🟡🔴)
- [ ] Critical issues identified
- [ ] Remediation plan specific and actionable
- [ ] Trends highlighted (positive and negative)
- [ ] Next actions recommended based on overall status
- [ ] Dashboard concise but comprehensive

---

**Remember:** Health reports are snapshots in time. Re-run regularly (weekly/before releases) to track improvement trends.
