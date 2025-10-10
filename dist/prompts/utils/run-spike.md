---
implements: specs/behaviors/prompts/run-spike.spec.md
generated: '2025-10-10'
---

# Run Spike Discovery Prompt

**Purpose**: Conduct time-boxed technical investigation

## Context

This utility prompt helps with common development scenarios across all phases.

## Task

1. Prompt guides time-boxed technical exploration to answer specific questions before committing to design/implementation, producing spike report in specs/spikes/ with clear answer, findings (worked/failed/surprises), measurements, recommendations, and disposable code samples, reducing risk by converting unknowns to knowns.

## Output

Complete the specified task with clear deliverables.

## Validation

- Prompt exists at dist/prompts/utils/run-spike.md
- Prompt has spec: frontmatter reference
- Spike charter template includes question, time box, success criteria, out of scope
- Report template comprehensive (answer, findings, measurements, recommendations)
- Emphasizes disposable code (spike ≠ production)
- Integration steps documented (update complexity, architecture, constraints, behaviors)
- Example scenarios cover common spike types (performance, integration, AI/ML)
- Tips emphasize focus, measurement, immediate documentation, sharing findings
- Output directory: specs/spikes/ (not root or var/)

## Success Criteria

**This prompt succeeds when:**
- All requirements from spec are satisfied
- Output is actionable and immediately usable
- No ambiguity in what needs to be done
- Clear path from current state to desired state

---

**Criticality**: IMPORTANT
**Failure Mode**: Without spike guidance, teams waste time on full implementations for unvalidated approaches or skip exploration leading to costly architectural mistakes
