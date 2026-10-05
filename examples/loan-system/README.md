# Loan System Example

This example demonstrates LiveSpec's **three-layer architecture** with many-to-many traceability relationships.

## Structure

```
specs/
├── foundation/                # Layer 1: WHAT
│   ├── outcomes.spec.md       # Strategic outcomes
│   ├── constraints.spec.md    # Non-negotiable boundaries
│   └── functional/            # Feature requirements
├── strategy/                  # Layer 2: HOW (approach)
└── features/                  # Layer 3: EXACTLY (behaviors)
```

## How the Links Work

Links are written upward: each spec names what it depends on (`satisfies`,
`guided-by`, `derives-from`, and `governed-by` for the constraints), from the
repository root. The downward direction is generated: every spec's `supports:`
lists the specs that link up to it, written by `validate-crossrefs.sh --fix`, so
it never drifts from the upward links.

## Many-to-Many Relationships Demonstrated

### One Requirement → Many Implementations

`foundation/functional/regulatory-compliance.spec.md` is satisfied by:
- `features/interest-calculation.spec.md` (interest follows regulations)
- `features/late-fee-calculation.spec.md` (fees follow state regulations)
- `features/disclosure-generation.spec.md` (TILA disclosures)
- `features/amortization-schedule.spec.md` (accurate payment breakdown)

### One Implementation → Many Requirements

`features/interest-calculation.spec.md` satisfies:
- `foundation/functional/loan-accuracy.spec.md` (accurate calculations)
- `foundation/functional/regulatory-compliance.spec.md` (TILA compliance)
- `foundation/functional/audit-trail.spec.md` (complete logging)

### One Strategy → Many Implementations

`strategy/calculation-approach.spec.md` guides all four behaviors: interest
calculation, late fees, amortization schedules and disclosures.

## Traceability

### Find implementations for a requirement

Open the requirement. Its generated `supports:` lists everything that depends on
it:

```yaml
# specs/foundation/functional/loan-accuracy.spec.md
supports:
  - specs/features/amortization-schedule.spec.md
  - specs/features/interest-calculation.spec.md
  - specs/strategy/calculation-approach.spec.md
```

### Find requirements for an implementation

Open the implementation. Its `satisfies:` names them:

```yaml
# specs/features/interest-calculation.spec.md
satisfies:
  - specs/foundation/functional/loan-accuracy.spec.md
  - specs/foundation/functional/regulatory-compliance.spec.md
  - specs/foundation/functional/audit-trail.spec.md
```

### Cascade impact analysis

**Scenario**: `regulatory-compliance.spec.md` changes (new regulation)

Its `supports:` lists four behaviors and the strategy. All of them need review
and potential updates.

## Key Patterns

### Strategic Requirements
- **outcomes.spec.md**: High-level business objectives
- **constraints.spec.md**: Non-negotiable boundaries, which the functional requirements and strategy name in `governed-by`
- Rarely change (fundamental shifts only)

### Functional Requirements
- **loan-accuracy.spec.md**: Accuracy requirements
- **regulatory-compliance.spec.md**: Legal compliance
- **audit-trail.spec.md**: Auditability requirements
- Change occasionally (feature evolution)

### Strategy
- **calculation-approach.spec.md**: Calculation methodology
- Derives from multiple requirements
- Guides multiple implementations
- Changes occasionally (design evolution)

### Implementations
- **interest-calculation.spec.md**: Precise formula
- **late-fee-calculation.spec.md**: State-specific fees
- **amortization-schedule.spec.md**: Payment breakdown
- **disclosure-generation.spec.md**: Regulatory documents
- Satisfy multiple requirements each
- Change frequently (continuous evolution)

## Validating

Copy the example into its own repository, then run the LiveSpec validators from
its root; `/livespec:init` vendors them into a project's `scripts/`:

```bash
bash scripts/validate-frontmatter.sh
bash scripts/validate-crossrefs.sh
```

## Benefits Demonstrated

✅ **Clear separation**: Requirements vs implementations never mixed
✅ **Traceability**: Know exactly what satisfies what
✅ **Cascade analysis**: Find all affected specs when requirements change
✅ **Flexibility**: Many-to-many relationships reflect reality
✅ **Impact management**: Understand scope of changes
✅ **Coverage validation**: Ensure all requirements implemented
