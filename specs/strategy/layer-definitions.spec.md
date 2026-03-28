---
type: strategy
category: strategy
fidelity: decisions-only
criticality: IMPORTANT
failure_mode: Without clear layer definitions, specs placed incorrectly causing organizational confusion
governed-by: []
derives-from:
  - specs/strategy/three-layer-architecture.spec.md
---

# Three-Layer Definitions and Structure

## Requirements
- [!] LiveSpec defines three specification layers with distinct purposes, characteristics, and frontmatter conventions, plus optional research layer providing evidence basis.
  - Layer 1 (Requirements): Pre-implementation, WHAT, solution-independent, stable
  - Layer 2 (Strategy): Post-requirements, HOW, architectural approach, occasional changes
  - Layer 3 (Implementations): Post-strategy, EXACTLY, code-linked, frequent changes
  - Research layer (optional): Pre-requirements, evidence, discovery artifacts, evolves with understanding
  - Each layer has distinct frontmatter conventions
  - Each layer has distinct changeability characteristics

## Layer 1: Requirements (Pre-Implementation)

**Location**: `specs/foundation/`

**Purpose**: Define WHAT must be achieved, independent of solution

**Characteristics**:
- Pre-implementation (written before design)
- Solution-independent (no HOW)
- Stable (rarely change)
- Strategic outcomes and hard constraints

**Structure**:
```
specs/foundation/
├── outcomes.spec.md   # High-level goals (mission-level)
└── constraints.spec.md # Non-negotiable boundaries
```

**Frontmatter**:
```yaml
---
derives-from: PURPOSE.md
criticality: CRITICAL
failure_mode: [Business impact]
---
```

**Content focus**: Observable outcomes needed, success criteria, validation approach (no implementation details)

**Example**: "System must accurately calculate loan payments per federal regulations"

## Layer 2: Strategy (Approach)

**Location**: `specs/strategy/`

**Purpose**: Define HOW system approaches requirements

**Characteristics**:
- Post-requirements, pre-implementation
- Solution approach (architectural decisions)
- Occasionally changes (design evolution)
- Guides implementations

**Frontmatter**:
```yaml
---
derives-from:
  - specs/foundation/outcomes.spec.md
governed-by:
  - specs/foundation/constraints.spec.md
criticality: CRITICAL|IMPORTANT
failure_mode: [Technical impact]
---
```

**Content focus**: Architectural approach, technology choices, design patterns, cross-cutting decisions

**Example**: "Use Decimal library for monetary calculations, calculate on backend for auditability"

## Layer 3: Implementations (Detailed Specs)

**Location**: `specs/features/` and `specs/interfaces/`

**Purpose**: Define EXACTLY how system works (linked to code)

**Characteristics**:
- Post-strategy, during implementation
- Implementation-linked (maps to code)
- Frequently changes (feature evolution)
- Observable and testable

**Structure**:
```
specs/
├── features/              # Observable behavioral specifications
│   └── [behavior].spec.md
└── interfaces/            # Interface specifications
    ├── api/
    └── data/
```

**Frontmatter**:
```yaml
---
satisfies:
  - specs/features/[feature1].spec.md
  - specs/features/[feature2].spec.md
guided-by:
  - specs/strategy/[approach].spec.md
criticality: CRITICAL|IMPORTANT
failure_mode: [Implementation impact]
---
```

**Content focus**: Precise algorithms, formulas, validation rules, interface contracts, exact behaviors

**Example**: "Compound interest = principal × (1 + rate/frequency)^(frequency × years), rounded to 2 decimals using ROUND_HALF_EVEN"

## Research Layer (Optional)

**Location**: `research/`

**Purpose**: Provide evidence basis for requirements (not specifications themselves)

**Characteristics**:
- Pre-requirements (informs Layer 1)
- Discovery artifacts (personas, journeys, flows, insights)
- Optional (not all projects need research)
- Not MSL specs (flexible quality guidance via metaspecs)
- Evidence-based (observations, data, user quotes)

**Structure**:
```
research/
├── personas/           # User types
├── journeys/           # User workflows
├── flows/              # Interaction patterns
└── insights/           # Research findings
```

**Frontmatter** (research artifacts link forward to requirements):
```yaml
---
created: YYYY-MM-DD
source: "User interviews, n=10"
informs:
  - specs/features/[feature1].spec.md
  - specs/features/[feature2].spec.md
---
```

**Requirements link back** (optional `informed-by:` field):
```yaml
---
informed-by:
  - research/insights/checkout-friction-study.md
derives-from: requirements/strategic/outcomes.spec.md
criticality: CRITICAL
---
```

**Content focus**: Evidence (quotes, observations, measurements), patterns, user needs, pain points, opportunities

**Example**: "7/10 users frustrated by checkout length (avg 8.5 min), 4/10 considered abandoning"

**Quality guidance**: `.livespec/standard/metaspecs/research/[artifact-type].metaspec.md`

**Traceability tools**: `find-research-basis.sh`, `find-requirements-from-research.sh`, `validate-research-links.sh`

## Changeability Characteristics

### Strategic Requirements (Rare Changes)

**Location**: `specs/foundation/`

**Changeability**: Rare (fundamental shifts only)

**Impact when changed**: Massive (entire system may need redesign)

**Examples**:
- Core business model changes
- New regulatory compliance domain
- Fundamental constraints shift

**Change process**: Strategic review, architecture reassessment, full impact analysis

### Feature Specifications (Frequent Changes)

**Location**: `specs/features/`

**Changeability**: Frequent (feature evolution)

**Impact when changed**: Localized to moderate (specific behaviors affected)

**Examples**:
- New feature behaviors
- Business rule changes
- User need evolution

**Change process**: Verify requirements still satisfied, update code, test

### Strategy (Occasional Changes)

**Location**: `specs/strategy/`

**Changeability**: Occasional (design evolution)

**Impact when changed**: Moderate (implementations following strategy affected)

**Examples**:
- Technology stack changes
- Architecture pattern shifts
- Cross-cutting approach changes

**Change process**: Architecture review, guided implementations update, validation

### Interface Contracts (Occasional Changes)

**Location**: `specs/interfaces/`

**Changeability**: Occasional (API evolution)

**Impact when changed**: Moderate (consumers may need updates)

**Examples**:
- API version changes
- Data format updates
- New endpoints

**Change process**: Version appropriately, notify consumers, update implementations

### Research (Evolves with Understanding)

**Location**: `research/`

**Changeability**: Evolves (as user understanding deepens)

**Impact when changed**: Informs requirements updates (evidence basis shifts)

**Examples**:
- New user insights discovered
- Usage patterns emerge
- Pain points identified

**Change process**: Update research artifacts, review informed requirements, consider requirement updates

## Validation
- Three layers clearly defined with distinct purposes
- Frontmatter conventions documented per layer
- Changeability characteristics explicit per layer
- Research layer optional but structured when present
- Layer structure enables traceability and impact analysis
