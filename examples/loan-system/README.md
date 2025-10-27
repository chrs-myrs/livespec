# Loan System Example

This example demonstrates LiveSpec's **three-layer architecture** with many-to-many traceability relationships.

## Structure

```
specs/
├── requirements/              # Layer 1: WHAT (pre-implementation)
│   ├── strategic/            # Strategic outcomes & constraints
│   └── functional/           # Feature requirements
├── strategy/                  # Layer 2: HOW (approach)
└── behaviors/                 # Layer 3: EXACTLY (implementations)
```

## Many-to-Many Relationships Demonstrated

### One Requirement → Many Implementations

**requirements/functional/regulatory-compliance.spec.md** is satisfied by:
- behaviors/interest-calculation.spec.md (interest follows regulations)
- behaviors/late-fee-calculation.spec.md (fees follow state regulations)
- behaviors/disclosure-generation.spec.md (TILA disclosures)

### One Implementation → Many Requirements

**behaviors/interest-calculation.spec.md** satisfies:
- requirements/functional/loan-accuracy.spec.md (accurate calculations)
- requirements/functional/regulatory-compliance.spec.md (TILA compliance)
- requirements/functional/audit-trail.spec.md (complete logging)

### One Strategy → Many Implementations

**strategy/calculation-approach.spec.md** guides:
- behaviors/interest-calculation.spec.md
- behaviors/late-fee-calculation.spec.md
- behaviors/amortization-schedule.spec.md

## Traceability Examples

### Find implementations for a requirement

```bash
grep -r "satisfies:.*loan-accuracy.spec.md" specs/behaviors/

# Results:
# behaviors/interest-calculation.spec.md
# behaviors/amortization-schedule.spec.md
```

### Find requirements for an implementation

```bash
awk '/^satisfies:/,/^[a-z_-]+:/ {print}' specs/behaviors/interest-calculation.spec.md | grep "^  -"

# Results:
# - requirements/functional/loan-accuracy.spec.md
# - requirements/functional/regulatory-compliance.spec.md
# - requirements/functional/audit-trail.spec.md
```

### Cascade impact analysis

**Scenario**: `regulatory-compliance.spec.md` changes (new regulation)

```bash
grep -r "satisfies:.*regulatory-compliance.spec.md" specs/behaviors/

# Affected implementations:
# - interest-calculation.spec.md
# - late-fee-calculation.spec.md
# - disclosure-generation.spec.md
```

All three implementation specs need review and potential updates.

## Key Patterns

### Strategic Requirements
- **outcomes.spec.md**: High-level business objectives
- **constraints.spec.md**: Non-negotiable boundaries
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

## Benefits Demonstrated

✅ **Clear separation**: Requirements vs implementations never mixed
✅ **Traceability**: Know exactly what satisfies what
✅ **Cascade analysis**: Find all affected specs when requirements change
✅ **Flexibility**: Many-to-many relationships reflect reality
✅ **Impact management**: Understand scope of changes
✅ **Coverage validation**: Ensure all requirements implemented
