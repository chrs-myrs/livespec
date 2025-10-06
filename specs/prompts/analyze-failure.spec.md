---
specifies: prompts/utils/analyze-failure.md
---

# Process Failure Analysis Prompt

**Criticality**: IMPORTANT
**Failure Mode**: Process failures repeat without understanding root causes, preventing improvement

## Specification

Prompt performs forensic analysis when LiveSpec adoption failed, identifies root causes (over-specification, abandoned Phase 4, wrong process, no enforcement), and provides recovery plan with prevention recommendations.

## Outputs

- `specs/failure-analysis.md` containing:
  - Timeline of failure and evidence collected
  - Failure classification and root cause analysis
  - Impact assessment (documentation quality, team trust, technical debt)
  - Recovery plan (immediate/short-term/long-term actions)
  - Prevention recommendations and lessons learned

## Validation

- Analysis correctly identifies failure type from common patterns
- Root causes traced to system/team/project factors
- Recovery plan prioritized and actionable
- Prevention recommendations address root causes
- Lessons captured for future reference
