# E-Commerce Checkout Example

Complete demonstration of LiveSpec v3.0 research integration: **Research → Requirements → Strategy → Implementation**

## Quick Overview

This example shows how user research directly informs requirements in a traceable way:

```
research/insights/checkout-friction-study.md
  (Finding 1: 30% abandonment at account creation)
    ↓ informs
specs/requirements/functional/guest-checkout.spec.md
    ↓ satisfies
specs/behaviors/single-page-checkout.spec.md
```

## Structure

```
ecommerce-checkout/
├── PURPOSE.md                 # Why this example exists
├── research/                  # Research artifacts (evidence)
│   ├── personas/
│   │   └── time-constrained-shopper.md
│   ├── insights/
│   │   └── checkout-friction-study.md
│   └── flows/
│       └── simplified-checkout-flow.md
└── specs/
    ├── requirements/
    │   ├── strategic/
    │   │   └── outcomes.spec.md
    │   └── functional/
    │       ├── guest-checkout.spec.md
    │       └── simplified-checkout.spec.md
    ├── strategy/
    │   └── ux-optimization.spec.md
    └── behaviors/
        └── single-page-checkout.spec.md
```

## Key Features Demonstrated

### 1. Research Artifacts
- **Persona**: Time-constrained shopper profile with needs
- **Research Insights**: Detailed study findings with evidence
- **UX Flow**: Mermaid diagrams showing proposed solution

### 2. Bidirectional Linkage
**Research artifacts** link forward:
```yaml
---
informs:
  - specs/requirements/functional/guest-checkout.spec.md
  - specs/requirements/functional/simplified-checkout.spec.md
---
```

**Requirements** link back:
```yaml
---
informed-by:
  - research/insights/checkout-friction-study.md
  - research/personas/time-constrained-shopper.md
---
```

### 3. Evidence-Based Requirements
Requirements include:
- Direct user quotes
- Observed behaviors
- Measurements (e.g., "8.5 minutes average checkout time")
- Sample sizes (n=10)
- Frequency data ("7/10 participants")

### 4. Many-to-Many Relationships
- One research study informs two requirements
- One requirement informed by multiple research sources
- One implementation satisfies two requirements

## Traceability Examples

### Find Research Basis
```bash
# What research informs guest checkout requirement?
../../scripts/traceability/find-research-basis.sh \
  specs/requirements/functional/guest-checkout.spec.md

Output:
  ✓ research/insights/checkout-friction-study.md
    Type: Research Insights
    Title: Checkout Friction Study - January 2025
    Created: 2025-01-15

  ✓ research/personas/time-constrained-shopper.md
    Type: Persona
    Title: Time-Constrained Shopper
    Created: 2025-01-15
```

### Find Requirements from Research
```bash
# What requirements does the checkout study inform?
../../scripts/traceability/find-requirements-from-research.sh \
  research/insights/checkout-friction-study.md

Output:
  ✓ specs/requirements/functional/guest-checkout.spec.md
    Title: Guest Checkout Requirement
    Criticality: CRITICAL

  ✓ specs/requirements/functional/simplified-checkout.spec.md
    Title: Simplified Checkout Requirement
    Criticality: CRITICAL
```

### Validate Research Links
```bash
# Validate all research ↔ requirement linkage
../../scripts/traceability/validate-research-links.sh

Output:
  ✓ All research linkages valid!
```

### Cascade Impact Analysis
```bash
# What's affected if research changes?
../../scripts/traceability/cascade-impact.sh \
  research/insights/checkout-friction-study.md

Output:
  Requirements Informed By This Research:
    ✓ specs/requirements/functional/guest-checkout.spec.md
    ✓ specs/requirements/functional/simplified-checkout.spec.md

  Action Items:
    • Review 2 requirement spec(s) informed by this research
    • Verify requirements still align with updated research findings
    • Consider if new insights require new requirements
```

## Reading Order

### 1. Start with Research
Read these to understand the evidence:
1. `research/personas/time-constrained-shopper.md` - Who are we building for?
2. `research/insights/checkout-friction-study.md` - What did research find?
3. `research/flows/simplified-checkout-flow.md` - What solution is proposed?

### 2. See Requirements
See how research informs requirements:
1. `specs/requirements/strategic/outcomes.spec.md` - High-level goals
2. `specs/requirements/functional/guest-checkout.spec.md` - Specific requirement
3. `specs/requirements/functional/simplified-checkout.spec.md` - Another requirement

Notice the `informed-by:` frontmatter linking back to research!

### 3. Understand Strategy
1. `specs/strategy/ux-optimization.spec.md` - How to approach implementation

### 4. Review Implementation
1. `specs/behaviors/single-page-checkout.spec.md` - Detailed implementation spec

Notice `satisfies:` linking to requirements!

## Key Learning Points

### Research is NOT a Spec
- Research artifacts use flexible templates, not rigid MSL format
- Quality guided by metaspecs, not requirements
- Focus on evidence (quotes, observations, measurements)
- Separate observation from interpretation from implications

### Evidence-Based Requirements
- Requirements reference specific research findings
- Include quotes, frequencies, sample sizes
- Show rationale for each requirement decision
- Traceable back to user needs

### Bidirectional Traceability
- Research links forward (`informs:`)
- Requirements link back (`informed-by:`)
- Scripts validate consistency
- Impact analysis traces both directions

### Many-to-Many Relationships
- One research artifact can inform multiple requirements
- One requirement can be informed by multiple research sources
- Enables complex, realistic traceability patterns
- No artificial one-to-one constraints

## Running Traceability Scripts

All scripts work from the example directory:

```bash
cd examples/ecommerce-checkout/

# Find research for a requirement
../../scripts/traceability/find-research-basis.sh \
  specs/requirements/functional/guest-checkout.spec.md

# Find requirements for research
../../scripts/traceability/find-requirements-from-research.sh \
  research/insights/checkout-friction-study.md

# Validate linkage
../../scripts/traceability/validate-research-links.sh

# Cascade impact
../../scripts/traceability/cascade-impact.sh \
  research/insights/checkout-friction-study.md
```

## See Also

- [Three-Layer Architecture](../../specs/strategy/three-layer-architecture.spec.md)
- [Research Metaspecs](../../.livespec/standard/metaspecs/research/)
- [Research Templates](../../.livespec/templates/research/)
- [Phase 0e: Evaluate Research Needs](../../dist/prompts/0-define/0e-evaluate-research-needs.md)
- [AGENTS.md - Research Integration](../../AGENTS.md#research-integration-v30)
