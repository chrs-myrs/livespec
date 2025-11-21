---
criticality: IMPORTANT
failure_mode: Health report prompt unclear, validations missed, status thresholds wrong, remediation plans vague or missing
specifies: dist/prompts/utils/run-health-report.md
implements: specs/3-behaviors/project-health.spec.md
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
  - specs/workspace/patterns.spec.md
---

# Utility Prompt: Run Health Report

## Requirements

- [!] Prompt MUST guide agent through diagnostic workflow
  - Step 1: Run all 8 validation scripts
  - Step 2: Analyze compliance trends (last 5)
  - Step 3: Check registry health
  - Step 4: Measure context efficiency
  - Step 5: Calculate health scores
  - Step 6: Generate dashboard
  - Step 7: Generate remediation plan
  - Step 8: Highlight trends
  - Step 9: Recommend next actions
  - Step 10: Save report (optional)

- [!] Prompt MUST specify all 8 validation scripts
  - validate-taxonomy-structure.sh
  - audit-workspace-scope.sh
  - detect-code-in-specs.sh
  - validate-architecture-alignment.sh
  - check-contract-completeness.sh
  - validate-value-structure.sh
  - measure-agent-compliance.sh
  - generate-compliance-dashboard.sh

- [!] Prompt MUST define health score thresholds
  - Validation health: 100% = 🟢, 75-99% = 🟡, <75% = 🔴
  - Compliance health: ≥75% = 🟢, 50-74% = 🟡, <50% = 🔴
  - Registry health: ≥70% = 🟢, 50-69% = 🟡, <50% = 🔴
  - Context health: Within budget = 🟢, 0-20% over = 🟡, >20% over = 🔴
  - Overall health: ≥85% = 🟢, 60-84% = 🟡, <60% = 🔴

- [!] Prompt MUST specify dashboard format
  - Overall health with status and score
  - Category breakdown table
  - Validation results table (8 checks)
  - Compliance trends section
  - Registry status table
  - Context efficiency table
  - Critical issues section
  - Warnings section
  - Strengths section
  - Maximum 2 pages output

- [!] Prompt MUST require remediation plans
  - 🔴 Critical: Do now with specific steps, time estimate, impact
  - 🟡 Warnings: Do soon with priority
  - Quick wins highlighted
  - All RED items must have remediation

- [!] Prompt MUST specify trend analysis
  - Positive trends (compliance improving, all passing)
  - Negative trends (compliance declining, gaps accumulating)
  - Stable patterns (consistent performance)
  - Evidence cited (numbers, timeframes)

- [!] Prompt MUST provide next action recommendations
  - GREEN: Maintain, consider strategic improvements
  - YELLOW: Review remediation, address priorities, re-check 1 week
  - RED: Stop work, fix critical, run drift detection, re-check immediately

- [!] Prompt MUST specify when NOT to use
  - Project just started (<5 sessions)
  - Immediate bug (direct fix)
  - Just want compliance (use complete-session)
  - Just want recommendations (use suggest-improvements)

## Validation

- [ ] All 10 workflow steps documented
- [ ] All 8 validation scripts listed
- [ ] Health score thresholds defined (5 categories)
- [ ] Status indicators specified (🟢🟡🔴)
- [ ] Dashboard format detailed
- [ ] Remediation plan requirements stated
- [ ] Trend analysis requirements stated
- [ ] Next actions by status defined
- [ ] "When NOT to use" section present
- [ ] Quality checklist provided

## Failure Mode

Without proper prompt specification:
- Validations missed (incomplete assessment)
- Wrong status assignment (thresholds unclear)
- Vague remediation (no actionable steps)
- Dashboard incomplete (missing categories)
- No trend analysis (can't track improvement)
- Used inappropriately (wrong tool for task)
