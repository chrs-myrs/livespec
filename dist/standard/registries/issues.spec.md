---
criticality: IMPORTANT
failure_mode: Problems encountered during sessions lost, no systematic resolution, recurring issues drain productivity
---

# Issue Registry Format

Defines the format for tracking problems in `docs/registries/issues.md`.

## Requirements

- [!] Each issue entry MUST follow standard format
  - ID pattern: `ISSUE-[NNN]` (e.g., ISSUE-001, ISSUE-002)
  - Required fields: What, Why Problematic, Category, Status, Resolution, Discovered
  - All fields populated (no empty required fields)

- [!] Status MUST use defined transitions
  - open: Issue identified, not yet investigated
  - investigating: Actively analyzing root cause
  - resolved: Solution implemented and verified
  - wontfix: Decided not to address (with justification)

- [!] Category MUST group related issues
  - tooling: Tool bugs or limitations
  - process: Workflow or procedure problems
  - documentation: Incorrect or unclear docs
  - validation: Validation script issues
  - guidance: Agent behavior problems

- [!] Issue entries MUST be specific and reproducible
  - What: States observable problem behavior
  - Why Problematic: Explains impact on work
  - Resolution: Records what fixed it (if resolved)

- [!] Severity SHOULD indicate priority
  - CRITICAL: Blocks work, immediate attention
  - HIGH: Significant productivity impact
  - MEDIUM: Noticeable friction
  - LOW: Minor annoyance

## Entry Format

```markdown
### ISSUE-[NNN]: [Title]

**What:** [Observable problem behavior]

**Why Problematic:** [Impact on user/agent work]

**Category:** [tooling/process/documentation/validation/guidance]

**Status:** [open/investigating/resolved/wontfix]

**Resolution:** [What fixed it, or why wontfix]

**Discovered:** [YYYY-MM-DD] [context]

**Related:** [Links to related issues or gaps]

---
```

## Validation

**Entry completeness:**
```bash
cat docs/registries/issues.md | grep -A 10 "^### ISSUE-" | \
  grep -E "(What|Why|Category|Status|Resolution|Discovered)" | wc -l
# Should be 6x number of issues
```

**No vague entries:**
```bash
! grep -i "doesn't work well" docs/registries/issues.md
! grep -i "could be better" docs/registries/issues.md
```

**Resolution tracking:**
```bash
cat docs/registries/issues.md | grep -B 5 "Status: resolved" | \
  grep "Resolution:" >/dev/null || echo "Resolved issue missing resolution"
```

## Maintenance

**Update triggers:**
- After session completion (if issues encountered)
- After health reports (if diagnostics reveal problems)
- When validation fails (systematic issues)

**Review triggers:**
- 5+ open issues accumulated
- Same issue appears in 3+ sessions
- CRITICAL severity issue identified
- Weekly or monthly strategic review

**Archival:**
- Resolved issues move to `.archive/issues-resolved-YYYY-MM.md`
- Include resolution details and effectiveness assessment

## Failure Mode

Without issue tracking:
- Problems forgotten after session ends
- Same issues encountered repeatedly
- No evidence of systematic problems
- Resolution effectiveness unknown
