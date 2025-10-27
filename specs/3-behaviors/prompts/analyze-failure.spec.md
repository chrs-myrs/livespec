---
specifies: dist/prompts/utils/analyze-failure.md
derives-from:
  - specs/workspace/workflows.spec.md
criticality: IMPORTANT
failure_mode: Without failure analysis guidance, users cannot diagnose and recover from LiveSpec adoption failures, losing investment and trust in methodology
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
guided-by:
  - specs/2-strategy/phase-workflow.spec.md
---

# Analyze Failure Utility Prompt

## Requirements
- [!] Prompt guides users through forensic analysis when LiveSpec adoption failed, diagnosing root causes (abandonment, over-specification, wrong process, no enforcement) and providing structured recovery plan with immediate/short-term/long-term actions.
  - Triggers: Specs drifted, became useless, team stopped maintaining, documentation ignored
  - Evidence collection: Spec vs code update frequency, last update dates, commit counts
  - Failure classification: Four types (abandonment, over-specification, wrong process, no enforcement)
  - Root cause analysis: System/team/project factors
  - Recovery plan structure: Immediate (this week), short-term (this month), long-term (quarter)
  - Creates specs/failure-analysis.md report
  - Common patterns documented: "too detailed", "stopped updating", "never started properly", "specs don't help"
  - Success criteria: 1 week (foundation updated), 1 month (behaviors documented), 3 months (specs trusted)
  - Emphasizes MSL minimalism and Phase 4 rhythm as primary prevention

## Prompt Outputs

**Primary outputs:**
- specs/failure-analysis.md (forensic analysis report)

**Report structure:**
- What Happened (chronological timeline)
- Evidence (spec status, code status, process status)
- Root Causes (primary failure, contributing factors)
- Impact Assessment (quality score, trust level, technical debt)
- Recovery Plan (immediate, short-term, long-term actions)
- Prevention Recommendations (process changes, team practices, warning signs)
- Lessons Learned (what caused failure, what would prevent, what to do differently)

**Validation:**
- Analysis identifies specific failure type
- Root causes backed by evidence
- Recovery plan has concrete actions with timeframes
- Prevention recommendations actionable
- Success criteria measurable

## Validation

- Prompt exists at dist/prompts/utils/analyze-failure.md
- Prompt has spec: frontmatter reference
- Four failure types documented (abandonment, over-specification, wrong process, no enforcement)
- Recovery plan has three timeframes (week, month, quarter)
- Common patterns documented with symptoms/causes/fixes
- Success criteria defined for 1 week, 1 month, 3 months
- Output report template comprehensive
- Emphasizes MSL minimalism and Phase 4 as prevention
