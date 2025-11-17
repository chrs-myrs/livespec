---
criticality: IMPORTANT
failure_mode: Problems encountered during sessions lost, no systematic resolution, recurring issues drain productivity
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
guided-by:
  - specs/workspace/patterns.spec.md
---

# Issue Registry

## Requirements

- [!] Registry MUST track problems encountered during LiveSpec usage
  - Each issue includes: what happened, why it's problematic, status, resolution
  - Issues categorized: tooling, process, documentation, validation, guidance
  - Status tracked: open, investigating, resolved, wontfix
  - Discovery context recorded (session ID, phase, workflow)

- [!] Issue entries MUST be specific and reproducible
  - Description states observable problem behavior
  - Why problematic explains impact on user/agent work
  - Reproduction steps provided when applicable
  - No subjective complaints without objective impact

- [!] Registry MUST support resolution tracking
  - Resolution actions recorded (spec updated, prompt created, bug fixed)
  - Effectiveness noted (did resolution actually fix issue?)
  - Related issues linkable (same root cause, similar symptoms)
  - Recurrence tracked (if issue re-appears after resolution)

- [!] Registry MUST be maintained through defined workflows
  - Updated by: Capture Session Learnings (immediate issues), Run Health Report (diagnostic issues)
  - Reviewed by: Suggest Improvements prompt (pattern identification)
  - Status transitions: open → investigating → resolved/wontfix
  - Resolution verified before closing (not just implemented, but confirmed working)

## Validation

**Issue Entry Completeness:**
```bash
# Each issue must have required fields
cat specs/3-behaviors/registries/issues.spec.md | grep -A 10 "^### ISSUE-" | \
  grep -E "(What|Why|Status|Resolution)" | wc -l
# Should be 4× number of issues
```

**Specificity Check:**
```bash
# No vague entries
! grep -i "doesn't work well" specs/3-behaviors/registries/issues.spec.md
! grep -i "could be better" specs/3-behaviors/registries/issues.spec.md
```

**Resolution Tracking:**
```bash
# All resolved issues have resolution actions
cat specs/3-behaviors/registries/issues.spec.md | grep -B 5 "Status: resolved" | \
  grep "Resolution:" >/dev/null || echo "Resolved issue missing resolution details"
```

## Failure Mode

Without issue tracking:
- Problems forgotten after session ends
- Same issues encountered repeatedly
- No evidence of systematic problems (invisible patterns)
- User frustrations dismissed as one-offs
- Resolution effectiveness unknown (no feedback loop)

---

## Current Issues

### ISSUE-001: Generated File Direct Edits

**What:** Users occasionally edit AGENTS.md, CLAUDE.md, or context tree files directly instead of editing source specs

**Why Problematic:** Changes lost on regeneration, creates drift between sources and outputs, validation errors

**Category:** Process

**Status:** Investigating

**Resolution:** Need clearer warnings in generated files, validation that catches edits faster, better guidance about regeneration workflow

**Discovered:** Multiple sessions (validation catches this regularly)

**Related:** GAP-005 (need better generated file protection)

---

### ISSUE-002: Cross-Reference Breaks During Reorganization

**What:** When prompts renamed/moved, cross-references in frontmatter and navigation break if not systematically updated

**Why Problematic:** Broken bidirectional linking, prompt discovery fails, validation errors

**Category:** Tooling

**Status:** Open

**Resolution:** Need checklist for updates (source, spec, registry, navigation, predecessors, docs) or automated tool

**Discovered:** 2025-11-13 during prompt reorganization discussion

**Related:** Need cross-reference update automation

---

### ISSUE-003: Session Completion Not Triggered Proactively

**What:** Agents don't recommend session completion even when context >100K tokens or all tasks done

**Why Problematic:** Sessions run too long, context degrades, manual session management burden

**Category:** Guidance

**Status:** Investigating

**Resolution:** Add active trigger logic to AGENTS.md, make detection unmissable

**Discovered:** 2025-11-08 (127K token session feedback)

**Related:** GAP-001 (agent session prompting)

---

### ISSUE-004: Terminology Inconsistency

**What:** "Conversation" vs "session", "internalise learnings" vs "capture learnings", ambiguous "framework evolution"

**Why Problematic:** User and agent confusion about workflows, unclear when to use which tool

**Category:** Documentation

**Status:** Investigating

**Resolution:** Create terminology guide, standardize across all docs/prompts, validate term usage

**Discovered:** 2025-11-13 user question about improvement workflows

**Related:** GAP-002 (learning terminology confusion)

---

## Registry Maintenance

**Update Frequency:**
- After every session (if issues encountered during work)
- After health reports (if diagnostic checks reveal problems)
- When validation fails (systematic issues detected)

**Review Triggers:**
- 5+ open issues accumulated
- Same issue appears in 3+ sessions (recurring problem)
- CRITICAL severity issue identified
- Weekly or monthly strategic review

**Archival Policy:**
- Resolved issues moved to `.archive/issues-resolved-YYYY-MM.md`
- Archive includes resolution details and effectiveness assessment
- Archived issues reviewed if symptoms re-appear

**Severity Levels:**
- **CRITICAL:** Blocks work, immediate attention required
- **HIGH:** Significant productivity impact, address soon
- **MEDIUM:** Noticeable friction, address when possible
- **LOW:** Minor annoyance, nice to fix

---

*This registry is maintained through automated workflows (Capture Session Learnings, Run Health Report) and manual additions when issues discovered.*
