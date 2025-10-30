---
criticality: IMPORTANT
failure_mode: Without decision tree specification, research workflow guidance is undefined and Phase 0e evaluation becomes inconsistent
specifies: dist/prompts/utils/research-decision-tree.md
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
---

# Prompt Behavior: Research Decision Tree

## Requirements
- [!] Prompt guides user through structured decision process to determine if UX research is needed before implementation, producing clear recommendation with justification.
  - Asks project type questions (user-facing app, API, internal tool, infrastructure)
  - Assesses novelty (new domain for team, established patterns, hybrid)
  - Evaluates user knowledge (well-understood needs, assumptions, unknowns)
  - Determines risk level (high user impact, low impact, experimental)
  - Applies decision tree logic to classify research need (Essential, Recommended, Optional, Skip)
  - Produces recommendation with specific justification referencing decision criteria
  - Suggests research scope if recommended (interviews, surveys, usability testing, competitive analysis)
  - Estimates research effort (days/weeks) based on scope
  - References Phase 0e (evaluate-research-needs.md) if research recommended
  - Explains when to revisit decision (after prototyping, after first user feedback)

## Validation
- Decision tree correctly classifies obvious cases (user-facing new domain → Essential research)
- Recommendation includes clear justification citing specific criteria
- Research scope suggestions are appropriate for project type
- Effort estimates are realistic (not too optimistic)
- Guidance explains when research can be skipped safely (established patterns, low risk)
- Integration with Phase 0e workflow is clear
