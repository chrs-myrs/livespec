---
derives-from:
  - specs/strategy/architecture.spec.md
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
specifies:
  - prompts/generated/self-improve.md (when generated)
generated_by:
  - prompts/utils/generate-self-improvement.md
criticality: IMPORTANT
failure_mode: Without systematic improvement analysis, projects accumulate technical debt and process inefficiencies
---

# Self-Improvement Analysis Prompt

## Requirements
- [!] Generated self-improve.md prompt conducts systematic project-wide improvement analysis using ultrathink, reading project specs to identify gaps, inconsistencies, and opportunities aligned with stated PURPOSE.
  - Prompt uses ultrathink for deep pattern recognition and analysis
  - Reads PURPOSE.md to understand project vision
  - Reads specs/mission/ to validate alignment with outcomes and constraints
  - Reads specs/strategy/ to assess architectural decisions
  - Reads specs/workspace/ to evaluate process adherence
  - Analyzes spec completeness (missing behaviors, contracts, validations)
  - Identifies spec-code drift indicators
  - Detects anti-patterns and technical debt
  - Suggests improvements prioritized by impact (High/Medium/Low)
  - Groups recommendations by category (specs, code, process, documentation)
  - Provides specific implementation steps with estimates
  - States expected benefits clearly
  - Focuses on project's stated priorities from PURPOSE
  - Adapts analysis depth to project domain (software/governance/ops/planning)

## Validation
- Ultrathink block references actual project PURPOSE and principles
- Analysis reads real specs (not assumptions)
- Recommendations specific to this project (not generic)
- Priorities align with PURPOSE success criteria
- Implementation steps are actionable
- Categories match project's spec structure
- Graceful degradation if ultrathink unsupported by agent
