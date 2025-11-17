---
criticality: IMPORTANT
failure_mode: Without minimalism audit, specs accumulate bloat through over-specification, HOW violations, and non-essential requirements
specifies: dist/prompts/utils/audit-msl-minimalism.md
implements: specs/3-behaviors/slash-command-generation.spec.md
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
  - .livespec/guides/msl-minimalism.md
---

# Prompt Behavior: Audit MSL Minimalism

## Requirements
- [!] Prompt audits specifications against MSL minimalism principles, identifying over-specification and providing actionable remediation
  - Reads `.livespec/guides/msl-minimalism.md` for the 4 essential questions
  - Applies questions to each requirement: Essential? HOW vs WHAT? Problem prevention? Conventional?
  - Scans for HOW violations (code blocks, implementation details, technology lock-in)
  - Calculates bloat score per spec (violations / total requirements × 100%)
  - Assigns status (🟢 0-10%, 🟡 11-25%, 🔴 >25% bloat)
  - Identifies common patterns (most frequent violation type, most over-specified area)
  - Provides spec-by-spec remediation (specific line numbers, suggested rewrites)
  - Highlights exemplar specs (minimal, outcome-focused, no implementation details)
  - Generates actionable recommendations (immediate fixes, ongoing practices)
  - Reports estimated reduction (before/after requirement counts)

## Validation
- Prompt correctly applies all 4 essential questions to each requirement
- Bloat percentage calculations accurate (violations / total × 100%)
- Status assignments correct (🟢🟡🔴 based on bloat thresholds)
- Violations cite specific requirements with line numbers
- Recommendations actionable (not vague "improve" suggestions)
- Exemplar identification highlights truly minimal specs
- Pattern analysis identifies systemic issues (not just individual violations)
