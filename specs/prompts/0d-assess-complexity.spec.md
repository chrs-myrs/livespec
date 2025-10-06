---
specifies: prompts/0-define/0d-assess-complexity.md
---

# Complexity Assessment Prompt

**Criticality**: IMPORTANT
**Failure Mode**: Projects launched without realistic timeline expectations, leading to missed deadlines and poor planning

## Specification

Prompt analyzes project complexity factors (AI/ML, integrations, discovery needs, volatility) and provides complexity score with timeline buffer recommendations and identifies required discovery spikes.

## Outputs

- `specs/complexity-assessment.md` containing:
  - Overall complexity score (0-10) and level (Low/Medium/High/Extreme)
  - Factor breakdowns (AI/ML, integration, discovery, volatility)
  - Timeline buffer recommendation (+20%/+35%/+50%/+70%)
  - List of discovery spikes needed
  - Risk assessment and mitigation strategies

## Validation

- Prompt correctly calculates weighted complexity score
- Buffer recommendations align with complexity level
- Discovery spikes identified for high-uncertainty areas
- Output enables realistic project planning
