---
specifies: prompts/utils/analyze-failure.md
criticality: IMPORTANT
failure_mode: Process failures repeat without understanding root causes, preventing improvement
---

# Process Failure Analysis Prompt

## Requirements
- Prompt performs forensic analysis when LiveSpec adoption failed, identifies root causes (over-specification, abandoned Phase 4, wrong process, no enforcement), and provides recovery plan with prevention recommendations.
  - Analysis correctly identifies failure type from common patterns
  - Root causes traced to system/team/project factors
  - Recovery plan prioritized and actionable
  - Prevention recommendations address root causes
  - Lessons captured for future reference

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
