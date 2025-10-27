---
derives-from:
  - PURPOSE.md
  - specs/1-requirements/strategic/outcomes.spec.md
governed-by:
  - specs/1-requirements/strategic/constraints.spec.md
  - .livespec/standard/metaspecs/strategy.spec.md
criticality: CRITICAL
failure_mode: Without clear layer separation, requirements and implementations mix, preventing traceability and cascade analysis
---

# Three-Layer Architecture Pattern

## Requirements
- [!] LiveSpec specifications organized into three distinct layers with explicit separation, many-to-many relationships via frontmatter, and tooling support for traceability.
  - **Layer 1 - Requirements** (`specs/1-requirements/`): Pre-implementation specifications defining WHAT must be achieved, independent of solution approach
  - **Layer 2 - Strategy** (`specs/2-strategy/`): Architectural decisions defining HOW system approaches requirements, guides implementations
  - **Layer 3 - Implementations** (`specs/3-behaviors/` and `specs/3-contracts/`): Detailed specifications defining EXACTLY how system works, directly linked to code
  - **Research Layer** (`research/`, optional): Discovery artifacts that inform requirements with evidence (not specifications themselves)
  - Requirements layer contains strategic/ (outcomes, constraints) and functional/ (feature requirements)
  - Implementation layer contains behaviors/ (observable outcomes) and contracts/ (interfaces)
  - Research layer contains personas/, journeys/, flows/, insights/ (evidence-based discovery)
  - Many-to-many relationships via frontmatter (`satisfies:`, `guided-by:`, `derives-from:`, `informed-by:`, `informs:`)
  - One requirement satisfied by multiple implementations (one-to-many down)
  - One implementation satisfies multiple requirements (many-to-one up)
  - One strategy guides multiple implementations (one-to-many down)
  - One research artifact informs multiple requirements (one-to-many)
  - One requirement informed by multiple research artifacts (many-to-one)
  - Traceability tooling enables cascade impact analysis including research linkage
  - Each layer has distinct changeability characteristics (strategic: rare, strategy: occasional, implementations: frequent, research: evolves with understanding)

## Layer Definitions

### Layer 1: Requirements (Pre-Implementation)

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

### Layer 2: Strategy (Approach)

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

### Layer 3: Implementations (Detailed Specs)

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

### Research Layer (Optional)

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

## Many-to-Many Relationships

### Relationship Types

**satisfies** (implementations → requirements):
- Implementation specs declare which requirements they satisfy
- Many-to-many: One implementation can satisfy multiple requirements
- Many-to-many: One requirement can be satisfied by multiple implementations

**guided-by** (implementations → strategy):
- Implementation specs declare which strategies guide them
- Many-to-one: Multiple implementations follow same strategy
- One-to-many: One strategy guides multiple implementations

**derives-from** (strategy → requirements):
- Strategy specs declare which requirements they derive from
- Many-to-one: Strategy derives from multiple requirements
- One-to-many: Requirement influences multiple strategies

### Frontmatter Examples

**Requirement** (requirements/functional/loan-accuracy.spec.md):
```yaml
---
derives-from: requirements/strategic/outcomes.spec.md
criticality: CRITICAL
failure_mode: Incorrect calculations breach contracts
---
```

**Strategy** (strategy/calculation-approach.spec.md):
```yaml
---
derives-from:
  - requirements/functional/loan-accuracy.spec.md
  - requirements/functional/regulatory-compliance.spec.md
governed-by: requirements/strategic/constraints.spec.md
---
```

**Implementation** (behaviors/interest-calculation.spec.md):
```yaml
---
satisfies:
  - requirements/functional/loan-accuracy.spec.md
  - requirements/functional/regulatory-compliance.spec.md
guided-by:
  - strategy/calculation-approach.spec.md
---
```

### Relationship Graph

```
requirements/functional/loan-accuracy.spec.md
  ↓ derives-from
strategy/calculation-approach.spec.md
  ↓ guided-by
  ├─→ behaviors/interest-calculation.spec.md ─┐
  ├─→ behaviors/amortization.spec.md          ├─→ satisfies → loan-accuracy
  └─→ behaviors/payment-schedule.spec.md ─────┘

requirements/functional/regulatory-compliance.spec.md
  ↓ satisfies
  ├─→ behaviors/interest-calculation.spec.md
  ├─→ behaviors/late-fee-calculation.spec.md
  └─→ behaviors/disclosure-generation.spec.md
```

## Dual Linkage Pattern (NOT Pure Cascade)

**Critical clarification:** Implementations have TWO types of relationships, not one intermediated path.

### Common Misconception

❌ **WRONG**: Pure cascade (implementations intermediated by strategy):
```
Requirements → Strategy → Implementations
```
This suggests implementations ONLY link to strategy, and strategy intermediates to requirements.

✅ **CORRECT**: Dual linkage (implementations link to BOTH):
```
Requirements ──┐
               ├─→ Implementations (satisfies requirements directly)
Strategy ──────┘    (guided-by strategy for HOW)
```

### How Dual Linkage Works

**Implementations have two distinct relationships:**

1. **`satisfies:` Requirements** (WHAT they achieve)
   - Direct link from implementation back to requirements
   - NOT intermediated by strategy
   - Answers: "What business value does this provide?"
   - Example: `interest-calculation.spec.md satisfies loan-accuracy.spec.md`

2. **`guided-by:` Strategy** (HOW they do it)
   - Downward guidance from strategy to implementation
   - Answers: "What technical approach should I use?"
   - Example: `interest-calculation.spec.md guided-by calculation-approach.spec.md`

### Why This Matters

**Enables rapid rebuild capability:**
- Requirements are technology-agnostic (portable)
- Strategy changes when replatforming (new tech stack)
- Implementations rebuilt with same `satisfies:` (same requirements) but new `guided-by:` (new strategy)

**Example replatform:**
```yaml
# Python implementation
---
satisfies:
  - specs/1-requirements/functional/loan-accuracy.spec.md  # Unchanged
guided-by:
  - specs/2-strategy/python-calculation-approach.spec.md   # Old strategy
---

# Go implementation (after replatform)
---
satisfies:
  - specs/1-requirements/functional/loan-accuracy.spec.md  # Same requirements!
guided-by:
  - specs/2-strategy/go-calculation-approach.spec.md       # New strategy
---
```

**Traceability in both directions:**
- **Upward**: What requirements does this implementation satisfy?
- **Downward**: What strategy guides this implementation?
- **Impact analysis**: Change requirements → find all implementations that satisfy it (direct, not through strategy)

### Numbered Folders Clarify Conceptual Order

The numbered folder structure shows conceptual ordering:
- **1-requirements**: WHAT (first)
- **2-strategy**: HOW (second, derives from requirements)
- **3-behaviors/3-contracts**: EXACTLY (third, satisfies requirements + guided-by strategy)

**But NOT a strict pipeline:**
- Implementations link DIRECTLY to requirements (satisfies)
- Implementations also link to strategy (guided-by)
- Both relationships exist simultaneously

### Frontmatter Example

```yaml
# specs/3-behaviors/payment-processing.spec.md
---
satisfies:                          # Direct link to requirements (WHAT)
  - specs/1-requirements/functional/transaction-accuracy.spec.md
  - specs/1-requirements/functional/idempotency.spec.md
guided-by:                          # Guidance from strategy (HOW)
  - specs/2-strategy/api-design.spec.md
  - specs/2-strategy/data-consistency.spec.md
criticality: CRITICAL
failure_mode: Payment failures cause revenue loss
---
```

This implementation:
- ✅ SATISFIES transaction accuracy and idempotency requirements (business value)
- ✅ IS GUIDED BY API design and data consistency strategies (technical approach)
- ✅ Can change strategies (replatform) while keeping same requirements (same business value)

## Traceability Workflows

### Find Implementations for Requirement

**Question**: "What implements this requirement?"

**Command**:
```bash
grep -r "satisfies:.*$(basename requirement.spec.md)" specs/3-behaviors/ specs/3-contracts/
```

**Use cases**:
- Requirement changes → find affected implementations
- Validate requirement coverage
- Understand implementation scope

### Find Requirements for Implementation

**Question**: "What requirements does this satisfy?"

**Command**:
```bash
awk '/^satisfies:/,/^[a-z_-]+:/ {print}' implementation.spec.md | grep "^  -"
```

**Use cases**:
- Implementation changes → verify still satisfies requirements
- Understand implementation purpose
- Impact analysis

### Cascade Impact Analysis

**Scenario**: Requirement changes

**Workflow**:
1. Find all strategies deriving from requirement
2. Find all implementations satisfying requirement
3. Find all implementations guided by affected strategies
4. Validate all implementations still satisfy updated requirement

**Tooling**: `scripts/cascade-impact.sh <changed-spec>`

### Validate Coverage

**Question**: "Are all requirements implemented?"

**Command**:
```bash
for req in specs/1-requirements/**/*.spec.md; do
  grep -r "satisfies:.*$(basename $req)" specs/3-behaviors/ specs/3-contracts/ || echo "Missing: $req"
done
```

**Use cases**:
- Release readiness check
- Identify gaps
- Validate completeness

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

## Technology-Agnostic Requirements: Rapid Rebuild Capability

### Core Benefit: Replatform Without Rewriting Requirements

The separation of requirements (WHAT) from strategy (HOW) from implementation (EXACTLY) enables **rapid rebuild on different technology stacks** while maintaining functional equivalence.

**Why this matters:**
- **Microservices best practice**: Services should be rebuildable quickly on different tech stacks
- **Technology evolution**: Frameworks, languages, and platforms evolve; requirements don't
- **Cost reduction**: Rebuild without rediscovering or revalidating requirements
- **Strategic flexibility**: Switch technologies without losing specification investment
- **Disaster recovery**: Rebuild from requirements if codebase lost
- **Competitive response**: Adopt new platforms faster than competitors

### Rebuild Workflow

**Scenario**: Rebuild existing service in new technology stack

**Preserved (no changes needed)**:
1. **Requirements layer** (`specs/1-requirements/`)
   - Strategic outcomes (unchanged - business goals don't change with tech)
   - Functional requirements (unchanged - WHAT system must do is constant)
   - Validation criteria (unchanged - same tests prove correctness)
   - Research basis (unchanged - user needs don't change with tech)

**Modified (new approach)**:
2. **Strategy layer** (`specs/2-strategy/`)
   - Create new strategy specs for new tech stack approach
   - Example: "Use Rust actix-web" (was "Use Python FastAPI")
   - Example: "Use PostgreSQL triggers" (was "Application-level validation")
   - Document WHY new approach satisfies same requirements

**Rebuilt (implementation from scratch)**:
3. **Implementation layer** (`specs/3-behaviors/`, `specs/3-contracts/`)
   - Write new implementation specs for new tech
   - Maintain same `satisfies:` frontmatter (same requirements)
   - Update `guided-by:` frontmatter (new strategies)
   - Write new code implementing new specs
   - Validate against requirements layer (same tests)

### Example: Loan Service Replatform

**Context**: Rebuild Python loan calculation service in Go for performance

**Requirements layer (unchanged)**:
```yaml
# specs/1-requirements/functional/loan-accuracy.spec.md
---
derives-from: requirements/strategic/outcomes.spec.md
criticality: CRITICAL
failure_mode: Incorrect calculations breach contracts
---

# Loan Calculation Accuracy

## Requirements
- [!] Payment calculations accurate to 2 decimal places
- [!] Compound interest calculated per federal regulations
- [!] Amortization schedules reflect actual payment distribution
- [!] All calculations auditable with parameter logging

## Validation
- Test suite validates calculations against regulatory test vectors
- Payment amounts match expected values within $0.01
- Audit logs capture all calculation inputs and outputs
```

**Strategy layer (new approach)**:
```yaml
# specs/2-strategy/calculation-approach-go.spec.md
---
derives-from:
  - requirements/functional/loan-accuracy.spec.md
governed-by: requirements/strategic/constraints.spec.md
criticality: CRITICAL
---

# Financial Calculation Strategy (Go Implementation)

## Requirements
- [!] Use shopspring/decimal library for monetary values (precise decimal arithmetic)
- [!] Implement calculations as pure functions (testability, auditability)
- [!] Calculation service layer separate from HTTP handlers (clean architecture)
- [!] Parameter logging via structured logging (zap library)
```

**Implementation layer (rebuilt in Go)**:
```yaml
# specs/3-behaviors/interest-calculation-go.spec.md
---
satisfies:
  - requirements/functional/loan-accuracy.spec.md
  - requirements/functional/regulatory-compliance.spec.md
guided-by:
  - strategy/calculation-approach-go.spec.md
criticality: CRITICAL
---

# Interest Calculation Implementation (Go)

## Requirements
- [!] Compound interest = principal × ((1 + rate/frequency)^(frequency × years) - 1)
  - Implementation: Use decimal.Decimal for all monetary values
  - Rounding: RoundHalfEven to 2 decimal places
  - Function signature: `CalculateInterest(principal, rate decimal.Decimal, frequency, years int) decimal.Decimal`
  - Logging: Log parameters and result with correlation ID
  - Testing: Table-driven tests with regulatory test vectors
```

### Benefits Realized

**Speed**: Rebuild in days/weeks (not months)
- Requirements already validated (no rediscovery)
- Test vectors already defined (validate new implementation)
- Business logic already clarified (no meetings/research)
- Edge cases already identified (captured in requirements)

**Quality**: Maintain functional equivalence
- Same requirements = same behavior guarantee
- Same validation criteria = proof of correctness
- Many-to-many traceability = coverage verification
- Requirement tests portable across implementations

**Cost**: Fraction of original development
- No requirements analysis phase
- No research phase (if research conducted previously)
- No validation design phase
- Focus 100% on implementation

**Risk**: Reduced implementation risk
- Requirements battle-tested from first implementation
- Known edge cases already handled
- Validation approach proven
- Audit trail preserved (why decisions made)

### Microservices Pattern

**Decompose monolith → rebuild services independently**:

1. **Extract requirements** for service boundary
   ```bash
   # Service-specific requirements
   specs/1-requirements/functional/payment-processing/
   ├── transaction-accuracy.spec.md
   ├── idempotency.spec.md
   └── audit-logging.spec.md
   ```

2. **Choose optimal stack per service**
   - Payment service: Go (performance critical)
   - Admin portal: Python/Django (rapid development)
   - Analytics: Rust (data processing)
   - Each service: **same requirements, different strategy/implementation**

3. **Validate equivalence**
   ```bash
   # Requirements-driven testing
   # Same test suite validates all implementations
   ./scripts/traceability/validate-coverage.sh
   ```

### When Requirements DO Change

**Technology change that affects requirements** (rare):

Example: Moving to eventually-consistent database

**Requirements impact**:
- **Functional requirements updated**: "System must handle eventual consistency"
- **New validation criteria**: "Read-after-write may show stale data for ≤500ms"
- **Strategy guides implementation**: "Use event sourcing with read replicas"
- **Traceability preserved**: Implementation `satisfies:` updated requirement

**Key insight**: Even when requirements change due to tech constraints, the separation ensures **explicit decision and documentation**.

## Migration from Current Structure

### Current Structure
```
specs/
├── mission/outcomes.spec.md        # Strategic requirements
├── mission/constraints.spec.md     # Boundaries
├── strategy/                       # Approach
└── behaviors/                      # MIXED (requirements + implementations)
```

### Target Structure
```
specs/
├── requirements/
│   ├── strategic/                  # Move mission/ here
│   │   ├── outcomes.spec.md
│   │   └── constraints.spec.md
│   └── functional/                 # Extract from behaviors/
│       └── [feature].spec.md
├── strategy/                       # Unchanged
├── behaviors/                      # Implementation specs only
└── contracts/                      # Unchanged
```

### Migration Steps

1. **Create requirements/ structure**:
   ```bash
   mkdir -p specs/1-requirements/{strategic,functional}
   ```

2. **Move strategic requirements**:
   ```bash
   mv specs/1-requirements/strategic/* specs/1-requirements/strategic/
   rmdir specs/mission
   ```

3. **Analyze behaviors/ folder**:
   - Identify specs that are requirements (pre-implementation, no formulas)
   - Identify specs that are implementations (detailed, formula-based)

4. **Extract functional requirements**:
   ```bash
   # For each requirement-level spec in behaviors/
   mv specs/3-behaviors/[requirement].spec.md specs/1-requirements/functional/
   ```

5. **Update frontmatter relationships**:
   - Add `satisfies:` to implementation specs
   - Add `guided-by:` to implementation specs
   - Update `derives-from:` in strategy specs

6. **Validate structure**:
   ```bash
   scripts/validate-coverage.sh
   scripts/cascade-impact.sh --validate-all
   ```

### Example Migration

**Before** (specs/3-behaviors/authentication.spec.md):
```yaml
---
criticality: CRITICAL
failure_mode: Unauthorized access
---
# Authentication
- [!] System must authenticate users
```
**Classification**: Requirement (high-level, no implementation details)

**After** (specs/1-requirements/functional/authentication.spec.md):
```yaml
---
derives-from: specs/1-requirements/strategic/outcomes.spec.md
criticality: CRITICAL
failure_mode: Unauthorized access
---
# Authentication Requirement
- [!] System must authenticate users before granting access
- [!] Authentication failures logged
- [!] Multi-factor authentication supported
```

**New implementation spec** (specs/3-behaviors/oauth-authentication.spec.md):
```yaml
---
satisfies:
  - specs/1-requirements/functional/authentication.spec.md
guided-by:
  - specs/2-strategy/security-architecture.spec.md
criticality: CRITICAL
failure_mode: Authentication bypass possible
---
# OAuth Authentication Implementation
- [!] OAuth 2.0 with PKCE flow
- [!] JWT tokens with 1-hour expiry
- [!] Refresh tokens stored securely
```

## Validation

- Requirements layer exists with strategic/ and functional/ subfolders
- Strategy layer derives from requirements
- Implementation specs use satisfies: and guided-by: frontmatter
- Many-to-many relationships possible (arrays in frontmatter)
- One requirement can be satisfied by multiple implementations
- One implementation can satisfy multiple requirements
- Traceability tooling enables cascade analysis
- Each layer has documented changeability characteristics
- Migration guide exists for restructuring projects
