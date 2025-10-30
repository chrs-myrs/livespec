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
- [!] LiveSpec specifications organized into three distinct layers (Requirements, Strategy, Implementations) with explicit separation, dual linkage via frontmatter (satisfies + guided-by), and tooling support for traceability enabling technology-agnostic requirements and rapid rebuild capability.
  - Layer 1 (Requirements): Pre-implementation, WHAT, solution-independent
  - Layer 2 (Strategy): HOW approach, guides implementations
  - Layer 3 (Implementations): EXACTLY, code-linked, satisfies requirements + guided-by strategy
  - Research layer (optional): Evidence basis, informs requirements
  - Dual linkage: Implementations link to BOTH requirements (satisfies) and strategy (guided-by)
  - Many-to-many relationships via frontmatter
  - Traceability tooling enables cascade impact analysis
  - Technology-agnostic requirements enable rapid rebuild on different stacks

## Layer Definitions (Summary)

**For detailed characteristics, frontmatter conventions, and changeability:**
See `specs/2-strategy/layer-definitions.spec.md`

### Layer 1: Requirements
- **Location**: `specs/1-requirements/{strategic,functional}/`
- **Purpose**: WHAT must be achieved
- **Characteristics**: Pre-implementation, solution-independent, stable

### Layer 2: Strategy
- **Location**: `specs/2-strategy/`
- **Purpose**: HOW system approaches requirements
- **Characteristics**: Architectural decisions, guides implementations

### Layer 3: Implementations
- **Location**: `specs/3-behaviors/` and `specs/3-contracts/`
- **Purpose**: EXACTLY how system works
- **Characteristics**: Code-linked, observable, testable

### Research Layer (Optional)
- **Location**: `research/`
- **Purpose**: Evidence basis for requirements
- **Characteristics**: Personas, journeys, insights, not MSL specs

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

**informed-by** (requirements → research):
- Requirements declare which research informs them
- Many-to-one: Requirement informed by multiple research artifacts
- One-to-many: Research artifact informs multiple requirements

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

## Technology-Agnostic Requirements: Rapid Rebuild Capability

### Core Benefit

The separation of requirements (WHAT) from strategy (HOW) from implementation (EXACTLY) enables **rapid rebuild on different technology stacks** while maintaining functional equivalence.

**Why this matters:**
- **Microservices best practice**: Services rebuildable quickly on different tech stacks
- **Technology evolution**: Frameworks evolve; requirements don't
- **Cost reduction**: Rebuild without rediscovering requirements
- **Strategic flexibility**: Switch technologies without losing specification investment
- **Disaster recovery**: Rebuild from requirements if codebase lost

### Rebuild Workflow

**Scenario**: Rebuild existing service in new technology stack

**Preserved (no changes needed)**:
1. **Requirements layer** (`specs/1-requirements/`)
   - Strategic outcomes (unchanged - business goals constant)
   - Functional requirements (unchanged - WHAT is constant)
   - Validation criteria (unchanged - same tests prove correctness)
   - Research basis (unchanged - user needs don't change with tech)

**Modified (new approach)**:
2. **Strategy layer** (`specs/2-strategy/`)
   - Create new strategy specs for new tech stack approach
   - Document WHY new approach satisfies same requirements

**Rebuilt (implementation from scratch)**:
3. **Implementation layer** (`specs/3-behaviors/`, `specs/3-contracts/`)
   - Write new implementation specs for new tech
   - Maintain same `satisfies:` frontmatter (same requirements)
   - Update `guided-by:` frontmatter (new strategies)
   - Write new code implementing new specs
   - Validate against requirements layer (same tests)

### Benefits Realized

**Speed**: Rebuild in days/weeks (not months)
- Requirements already validated (no rediscovery)
- Test vectors already defined
- Business logic already clarified
- Edge cases already identified

**Quality**: Maintain functional equivalence
- Same requirements = same behavior guarantee
- Same validation criteria = proof of correctness
- Many-to-many traceability = coverage verification

**Cost**: Fraction of original development
- No requirements analysis phase
- No research phase (if previously conducted)
- No validation design phase
- Focus 100% on implementation

**Risk**: Reduced implementation risk
- Requirements battle-tested from first implementation
- Known edge cases already handled
- Validation approach proven

### Microservices Pattern

**Decompose monolith → rebuild services independently**:

1. **Extract requirements** for service boundary
2. **Choose optimal stack per service**
   - Payment service: Go (performance critical)
   - Admin portal: Python/Django (rapid development)
   - Analytics: Rust (data processing)
   - Each service: **same requirements, different strategy/implementation**
3. **Validate equivalence** using requirements-driven testing

## Validation
- Three layers clearly separated with distinct purposes
- Implementation specs use both `satisfies:` and `guided-by:` frontmatter
- Many-to-many relationships supported (arrays in frontmatter)
- Traceability tooling enables cascade analysis
- Requirements are technology-agnostic (portable across implementations)
- Layer definitions detailed in layer-definitions.spec.md
- Dual linkage pattern documented and enforced
