---
specifies: prompts/0-define/0d-assess-complexity.md
criticality: IMPORTANT
failure_mode: Projects launched without realistic timeline expectations, leading to missed deadlines and poor planning
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/functional/five-phases.spec.md
guided-by:
  - specs/2-strategy/phase-workflow.spec.md
---

# Prompt Behavior: Assess Complexity

## Requirements
- [!] Prompt analyzes project complexity factors (AI/ML, integrations, discovery needs, volatility) and provides complexity score with timeline buffer recommendations.
  - Produces `specs/1-requirements/strategic/complexity-assessment.md` (format: markdown report with scored factors, timeline buffer, discovery spikes)
  - Calculates weighted complexity score (0-10 scale)
  - Recommends timeline buffer based on complexity level
  - Identifies discovery spikes for high-uncertainty areas
  - Provides risk assessment and mitigation strategies

## Context

Use when:
- After problem/outcomes defined (Phase 0 complete)
- Before committing to timeline/budget
- Need realistic project planning baseline
- Team needs to understand uncertainty and risk factors

## Prerequisites

- PURPOSE.md exists (project understanding)
- specs/1-requirements/strategic/outcomes.spec.md exists (requirements clarity)
- specs/1-requirements/strategic/constraints.spec.md exists (boundary understanding)
- Agent understands complexity factors (AI/ML unpredictability, integration complexity, discovery needs, requirements volatility)

## Outputs

- `specs/1-requirements/strategic/complexity-assessment.md` - Complexity analysis and planning recommendations (format: markdown with:
  - Overall complexity score (0-10) and level (Low/Medium/High/Extreme)
  - Factor breakdowns (AI/ML uncertainty, integration complexity, discovery needs, volatility)
  - Timeline buffer recommendation (+20%/+35%/+50%/+70%)
  - Discovery spikes list (areas needing investigation)
  - Risk assessment and mitigation strategies)

## Validation

- specs/1-requirements/strategic/complexity-assessment.md exists
- Complexity score calculated using weighted factors
- Score aligns with qualitative assessment (Low/Medium/High/Extreme)
- Timeline buffer recommendation matches complexity level
- Discovery spikes identified for uncertain/novel areas
- Risk assessment covers major project risks
- Mitigation strategies are actionable

## Success Criteria

- Complexity assessment realistic (not overly optimistic or pessimistic)
- Timeline buffer protects against underestimation
- Discovery spikes address genuine unknowns (not busywork)
- Team understands project risk profile
- Planning decisions informed by complexity reality

## Error Handling

**If project too simple for formal assessment:**
- Acknowledge low complexity
- Provide minimal assessment (Low complexity, +20% buffer)
- Skip detailed analysis for simple projects

**If unable to assess factor (insufficient information):**
- Mark factor as "Unknown" or "Needs Discovery"
- Recommend discovery spike to clarify
- Use conservative (higher) complexity estimate

**If complexity extremely high (>8/10):**
- Flag as potential red flag
- Suggest breaking into phases or smaller projects
- Recommend additional risk mitigation

**If user disputes assessment:**
- Explain reasoning for each factor score
- Adjust if user provides new information
- Document assumptions and uncertainty

## Constraints

What this prompt should NOT do:
- ❌ Provide false confidence in timeline estimates (complexity is inherently uncertain)
- ❌ Skip factors due to optimism bias (assess all factors objectively)
- ❌ Recommend inadequate buffers to meet deadline pressure
- ❌ Create discovery spikes for well-understood areas (focus on genuine unknowns)
- ❌ Ignore integration complexity (often underestimated risk factor)
