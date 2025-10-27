# E-Commerce Checkout Example

## Why This Exists

This example demonstrates LiveSpec v3.0's research integration capabilities, showing the complete evidence-based requirements flow:

**Research → Requirements → Strategy → Implementation**

Specifically, it shows how user research findings directly inform functional requirements, which then guide implementation specifications, creating a fully traceable chain from user insights to code.

## What Success Looks Like

- **Traceability**: Every requirement traces back to specific research findings
- **Evidence-based**: Requirements justified by user quotes, observations, and measurements
- **Many-to-many relationships**: One research artifact informs multiple requirements; one requirement informed by multiple sources
- **Complete flow**: Demonstrates all four research artifact types (persona, insights, flow) informing requirements and implementations
- **Realistic**: Based on common e-commerce challenges (checkout friction, mobile optimization, time constraints)

## What This Demonstrates

### Research Artifacts (research/)
1. **Persona**: Time-constrained shopper (shopping during work breaks)
2. **Research Insights**: Checkout friction study with 10 participants
3. **UX Flow**: Simplified checkout flow design

### Requirements Layer (specs/requirements/)
1. **Strategic**: High-level outcomes for checkout system
2. **Functional**: Guest checkout and simplified checkout requirements
   - Both directly linked to research via `informed-by:` frontmatter

### Strategy Layer (specs/strategy/)
1. **UX Optimization**: Approach for implementing time-optimized checkout
   - Derives from requirements, provides implementation guidance

### Implementation Layer (specs/behaviors/)
1. **Single-Page Checkout**: Detailed implementation spec
   - Satisfies both functional requirements
   - Guided by UX optimization strategy

## Traceability Examples

### Research → Requirements
```
research/insights/checkout-friction-study.md (Finding 1: Account creation abandonment)
  ↓ informs
specs/requirements/functional/guest-checkout.spec.md
```

### Requirements → Implementation
```
specs/requirements/functional/guest-checkout.spec.md
specs/requirements/functional/simplified-checkout.spec.md
  ↓ satisfies
specs/behaviors/single-page-checkout.spec.md
```

### Complete Chain
```
research/personas/time-constrained-shopper.md
  ↓ informs
specs/requirements/functional/guest-checkout.spec.md
  ↓ satisfies
specs/behaviors/single-page-checkout.spec.md
  ↓ implements
[code]
```

## How to Use This Example

### Validate Traceability
```bash
# From examples/ecommerce-checkout/

# Find research informing guest checkout requirement
../../../scripts/traceability/find-research-basis.sh \
  specs/requirements/functional/guest-checkout.spec.md

# Find requirements informed by checkout study
../../scripts/traceability/find-requirements-from-research.sh \
  research/insights/checkout-friction-study.md

# Validate all research linkage
../../scripts/traceability/validate-research-links.sh

# Analyze impact if research changes
../../scripts/traceability/cascade-impact.sh \
  research/insights/checkout-friction-study.md
```

### Explore the Flow
1. Start with research artifacts to see evidence
2. Read functional requirements to see how research informs specs
3. Check strategy for implementation approach
4. Review behavior spec for detailed implementation
5. Use traceability scripts to validate linkage

### Key Learning Points
- Research artifacts are NOT specs (flexible metaspec guidance)
- Requirements explicitly link to research (`informed-by:` field)
- Research artifacts link forward to requirements (`informs:` field)
- Many-to-many relationships possible (checkout study informs both requirements)
- Evidence-based requirements include quotes, frequencies, measurements
- Complete audit trail from user insight to implementation detail
