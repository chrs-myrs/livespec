---
derives-from:
  - specs/2-strategy/three-layer-architecture.spec.md
governed-by:
  - .livespec/standard/metaspecs/strategy.spec.md
criticality: IMPORTANT
failure_mode: Without clear layer definitions, specs placed incorrectly causing organizational confusion
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

**Location**: `specs/1-requirements/`

**Purpose**: Define WHAT must be achieved, independent of solution

**Characteristics**:
- Pre-implementation (written before design)
- Solution-independent (no HOW)
- Stable (rarely change)
- Strategic and functional requirements

**Structure**:
```
specs/1-requirements/
├── strategic/              # Strategic requirements
│   ├── outcomes.spec.md   # High-level goals (mission-level)
│   └── constraints.spec.md # Non-negotiable boundaries
└── functional/            # Functional requirements
    └── [feature].spec.md  # Feature-level requirements
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

**Location**: `specs/2-strategy/`

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
  - specs/1-requirements/functional/[feature].spec.md
governed-by:
  - specs/1-requirements/strategic/constraints.spec.md
criticality: CRITICAL|IMPORTANT
failure_mode: [Technical impact]
---
```

**Content focus**: Architectural approach, technology choices, design patterns, cross-cutting decisions

**Example**: "Use Decimal library for monetary calculations, calculate on backend for auditability"

## Layer 3: Implementations (Detailed Specs)

**Location**: `specs/3-behaviors/` and `specs/3-contracts/`

**Purpose**: Define EXACTLY how system works (linked to code)

**Characteristics**:
- Post-strategy, during implementation
- Implementation-linked (maps to code)
- Frequently changes (feature evolution)
- Observable and testable

**Structure**:
```
specs/
├── 3-behaviors/              # Observable behavioral specifications
│   └── [behavior].spec.md
└── 3-contracts/              # Interface specifications
    ├── api/
    └── data/
```

**Frontmatter**:
```yaml
---
satisfies:
  - specs/1-requirements/functional/[feature1].spec.md
  - specs/1-requirements/functional/[feature2].spec.md
guided-by:
  - specs/2-strategy/[approach].spec.md
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
  - specs/1-requirements/functional/[feature1].spec.md
  - specs/1-requirements/functional/[feature2].spec.md
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

**Location**: `specs/1-requirements/strategic/`

**Changeability**: Rare (fundamental shifts only)

**Impact when changed**: Massive (entire system may need redesign)

**Examples**:
- Core business model changes
- New regulatory compliance domain
- Fundamental constraints shift

**Change process**: Strategic review, architecture reassessment, full impact analysis

### Functional Requirements (Occasional Changes)

**Location**: `specs/1-requirements/functional/`

**Changeability**: Occasional (feature evolution)

**Impact when changed**: Significant (multiple implementations affected)

**Examples**:
- New feature requirements
- Business rule changes
- User need evolution

**Change process**: Requirements validation, affected implementations review, cascade updates

### Strategy (Occasional Changes)

**Location**: `specs/2-strategy/`

**Changeability**: Occasional (design evolution)

**Impact when changed**: Moderate (implementations following strategy affected)

**Examples**:
- Technology stack changes
- Architecture pattern shifts
- Cross-cutting approach changes

**Change process**: Architecture review, guided implementations update, validation

### Implementations (Frequent Changes)

**Location**: `specs/3-behaviors/`, `specs/3-contracts/`

**Changeability**: Frequent (continuous evolution)

**Impact when changed**: Localized (specific code modules)

**Examples**:
- Algorithm refinements
- API contract updates
- Detailed behavior adjustments

**Change process**: Verify requirements still satisfied, update code, test

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
