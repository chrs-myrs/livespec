---
criticality: IMPORTANT
failure_mode: Project health unknown, problems accumulate unnoticed, no unified view of system state, reactive rather than proactive maintenance
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
guided-by:
  - specs/workspace/patterns.spec.md
specifies:
  - dist/prompts/utils/run-health-report.md
---

# Project Health Assessment

## Requirements

- [!] Agent runs all validation scripts and collects results
  - 8 validation scripts in `scripts/` directory
  - Exit codes tracked (0 = pass, non-zero = fail)
  - Error messages collected for failing checks
  - Warnings noted for passing checks with concerns

- [!] Agent analyzes compliance trends from session data
  - Last 5-10 compliance JSON files from `~/.claude/livespec/compliance/`
  - Average overall compliance percentage
  - Average process compliance (X/8)
  - Average focus efficiency (X/13)
  - Trend calculation: Improving (↗), Stable (→), Declining (↘)
  - Layer-specific patterns (which layers consistently problematic)

- [!] Agent checks registry health
  - Gap accumulation rate (open / resolved)
  - Issue resolution rate (resolved / total)
  - Improvement success rate (effective / total tried)
  - Thresholds: GREEN <5 open gaps, YELLOW 5-10, RED >10

- [!] Agent measures context efficiency
  - AGENTS.md size vs 20-30KB target
  - Phase specialists vs 8-12KB each
  - Total context tree size
  - Compression level appropriateness

- [!] Agent calculates health scores with status indicators
  - Validation health: (passing / 8) × 100%
  - Compliance health: Average overall from sessions
  - Registry health: Weighted resolution rates
  - Context health: 100% - budget overage %
  - Overall health: Average of 4 categories
  - Status: 🟢 GREEN (≥85%), 🟡 YELLOW (60-84%), 🔴 RED (<60%)

- [!] Agent generates comprehensive health dashboard
  - Overall health status and score
  - Category breakdown (validation, compliance, registry, context)
  - Validation results table (8 checks with status)
  - Compliance trends (last 5 sessions)
  - Registry status (open vs resolved)
  - Context efficiency (size vs budgets)
  - Maximum 2 pages of output (concise but complete)

- [!] Agent provides remediation plan for issues
  - Critical items (🔴 RED): Do now with specific steps
  - Warnings (🟡 YELLOW): Do soon with priority
  - Quick wins highlighted (high impact, low effort)
  - Estimated effort for each remediation
  - Impact statement (what this fixes/improves)

- [!] Agent highlights trends for decision-making
  - Positive trends celebrated (compliance improving, all passing)
  - Negative trends alerted (compliance declining, gaps accumulating)
  - Stable patterns noted (consistent but could improve)
  - Evidence provided (specific numbers, timeframes)

- [!] Agent recommends next actions based on status
  - GREEN: Maintain practices, consider strategic improvements
  - YELLOW: Review remediation, address priorities, re-check in 1 week
  - RED: Stop work, fix critical issues, run drift detection, re-check immediately

## Validation

**Execution Completeness:**
```bash
# All 8 validation scripts must be run
test -f scripts/validate-taxonomy-structure.sh
test -f scripts/audit-workspace-scope.sh
test -f scripts/detect-code-in-specs.sh
test -f scripts/validate-architecture-alignment.sh
test -f scripts/check-contract-completeness.sh
test -f scripts/validate-value-structure.sh
test -f scripts/measure-agent-compliance.sh
test -f scripts/generate-compliance-dashboard.sh
```

**Data Requirements:**
- [ ] At least 5 compliance files analyzed
- [ ] Registry files checked (all 3)
- [ ] AGENTS.md size measured
- [ ] Context tree sizes measured

**Dashboard Quality:**
- [ ] Overall health score and status (🟢🟡🔴)
- [ ] All 4 categories scored
- [ ] Validation table complete (8 checks)
- [ ] Trends calculated with direction (↗→↘)
- [ ] Remediation plan specific and actionable
- [ ] Next actions recommended

**Status Assignment:**
- [ ] Thresholds applied correctly (GREEN ≥85%, YELLOW 60-84%, RED <60%)
- [ ] Critical issues flagged as 🔴 RED
- [ ] All RED items have remediation steps

## Failure Mode

Without project health assessment:
- Problems accumulate invisibly
- No unified view of system state
- Reactive fixes only (no prevention)
- Can't track improvement over time
- Critical issues missed until crisis
- No evidence for stakeholders
