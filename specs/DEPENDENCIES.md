# LiveSpec Specification Dependencies

**Note:** This is reference documentation, not a specification. For traceability patterns, see `specs/workspace/patterns.spec.md`.

## Overview

LiveSpec specifications form a dependency graph, not a hierarchy:
- **Vertical**: Purpose → Problem → Design → Implementation → Code
- **Horizontal**: Workspace (process) applies across all levels

## Dependency Graph

```
PURPOSE.md (Why we exist)
  ↓ defines scope
  ├─→ specs/requirements.spec.md (What we must achieve - HLR)
  │     ↓ constrains solution
  │     ├─→ specs/constraints.spec.md (Critical boundaries)
  │     │     ↓ limits options
  │     │     └─→ specs/architecture.spec.md (How we solve it)
  │     │           ↓ defines approach
  │     │           ├─→ specs/prompts/*.spec.md (What each prompt does)
  │     │           │     ↓ implements methodology
  │     │           │     └─→ prompts/*.md (Actual prompts)
  │     │           │
  │     │           └─→ specs/behaviors/*.spec.md (Observable outcomes)
  │     │                 ↓ requires
  │     │                 ├─→ specs/contracts/*.{yaml,json} (Interfaces)
  │     │                 └─→ src/, lib/, etc. (Code implementation)
  │     │
  │     └─→ specs/architecture.spec.md (derives from problem)
  │
  └─→ specs/constraints.spec.md (derives from purpose)

Orthogonal (applies to all):
  specs/workspace/
    ├── constitution.spec.md (Governance)
    ├── patterns.spec.md (Conventions)
    └── workflows.spec.md (Process)
```

## Dependency Layers

### 1. Foundation (Why & What)

**PURPOSE.md**
- **Type**: Vision statement
- **Purpose**: Why LiveSpec exists, success criteria
- **Derives from**: Nothing (root)
- **Constrains**: All other specs

**specs/requirements.spec.md**
- **Type**: High-Level Requirements (MSL spec)
- **Purpose**: What LiveSpec must achieve (strategic objectives)
- **Derives from**: PURPOSE.md
- **Constrains**: Solution space
- **Changeability**: Rare (fundamental requirements)

**specs/constraints.spec.md**
- **Type**: Critical boundaries (MSL spec)
- **Purpose**: Non-negotiable limits
- **Derives from**: PURPOSE.md, requirements.spec.md
- **Constrains**: All implementations
- **Changeability**: Rare (core principles)

### 2. Approach (How We Solve It)

**specs/architecture.spec.md**
- **Type**: Design decisions / Policy (MSL spec)
- **Purpose**: High-level approach and structure
- **Derives from**: PURPOSE.md, requirements.spec.md
- **Constrained by**: constraints.spec.md
- **Enables**: All implementation specs
- **Changeability**: Occasional (design evolution)

### 3. Implementation Specifications

**specs/prompts/*.spec.md**
- **Type**: Meta-specifications (MSL specs)
- **Purpose**: What each prompt accomplishes
- **Derives from**: architecture.spec.md
- **Implements**: methodology
- **Changeability**: Frequent (methodology evolves)

**specs/behaviors/*.spec.md**
- **Type**: Observable outcomes (MSL specs)
- **Purpose**: What system must do
- **Derives from**: architecture.spec.md
- **Satisfies**: requirements.spec.md
- **Constrained by**: constraints.spec.md
- **Changeability**: Frequent (features evolve)

**specs/contracts/*.{yaml,json}**
- **Type**: Interface definitions
- **Purpose**: API/data contracts
- **Supports**: behaviors/*.spec.md
- **Changeability**: Frequent (interfaces change)

### 4. Code Implementation

**prompts/, src/, lib/, etc.**
- **Type**: Actual implementation
- **Purpose**: Running software
- **Implements**: All specs above
- **Changeability**: Continuous

### Orthogonal: Process (How We Work)

**specs/workspace/**
- **Type**: Development methodology (MSL specs)
- **Purpose**: Govern all development work
- **Applies to**: All levels of vertical stack
- **Supports**: All development activities
- **Changeability**: Rare (process is stable)

## Frontmatter Convention

All specifications declare dependencies via YAML frontmatter:

```yaml
---
derives_from:
  - parent-spec-1.md
  - parent-spec-2.md
constrained_by:
  - constraint-spec.md
satisfies:
  - requirement-spec.md
supports:
  - child-spec-1.md
  - child-spec-2.md
applies_to:
  - all_development_work
---
```

### Field Definitions

| Field | Meaning | Example |
|-------|---------|---------|
| `derives_from` | Parent specs this is based on | `architecture.spec.md` derives from `problem.spec.md` |
| `constrained_by` | Boundaries this must respect | `behaviors/` constrained by `constraints.spec.md` |
| `satisfies` | Requirements this fulfills | `behaviors/` satisfies `problem.spec.md` |
| `supports` | What this spec enables | `architecture.spec.md` supports `behaviors/` |
| `applies_to` | Scope of application | `workspace/` applies to all development |

## Impact Tracing

### When PURPOSE.md Changes

**Affected specs:**
```bash
grep -r "derives_from.*PURPOSE" specs/
```

**Cascade:**
1. Revalidate requirements.spec.md → still achieving right objectives?
2. Revalidate constraints.spec.md → boundaries still appropriate?
3. Review architecture.spec.md → approach still achieves purpose?

**Detection:**
- Does new purpose make current problem irrelevant?
- Do constraints conflict with new direction?
- Is architecture still aligned?

### When specs/requirements.spec.md Changes

**Affected specs:**
```bash
grep -r "derives_from.*requirements.spec.md\|satisfies.*requirements.spec.md" specs/
```

**Cascade:**
1. Check constraints.spec.md → still derive from same requirements?
2. Check architecture.spec.md → approach still satisfies requirements?
3. Check all behaviors/ → still satisfy the requirements?

**Detection:**
- Does architecture satisfy the new requirements?
- Do behaviors map to new requirements?
- Are constraints still relevant?

### When specs/constraints.spec.md Changes

**Affected specs:**
```bash
grep -r "constrained_by.*constraints" specs/
```

**Cascade:**
1. Check architecture.spec.md → does it violate new constraints?
2. Check all behaviors/ → do any violate new constraints?
3. Check code → does implementation respect new constraints?

**Detection:**
- Which existing decisions violate new constraint?
- What needs redesign?
- Is code compliant?

### When specs/architecture.spec.md Changes

**Affected specs:**
```bash
grep -r "derives_from.*architecture" specs/
```

**Cascade:**
1. Review prompts/*.spec.md → methodology still aligned?
2. Review behaviors/ → still follow design decisions?
3. Review contracts/ → interfaces still appropriate?
4. Check workspace/ → process still supports architecture?

**Detection:**
- Do prompt specs implement new architecture?
- Do behaviors reflect new design?
- Is code structure aligned?

### When specs/behaviors/*.spec.md Changes

**Affected code:**
```bash
# Find implementation of this behavior
# (project-specific search)
```

**Cascade:**
1. Trace upward → still satisfies requirements.spec.md?
2. Trace upward → still derives from architecture.spec.md?
3. Trace upward → still respects constraints.spec.md?
4. Check code → implementation matches new behavior?

**Detection:**
- Does behavior change suggest architecture needs update?
- Are other behaviors affected?
- Is code drifted from new spec?

## Validation Rules

### Upward Validation (Child → Parent)

Every spec must align with its parents:

```bash
# For each spec with derives_from
for spec in specs/**/*.spec.md; do
  # Extract derives_from references
  PARENTS=$(grep -A 10 "^---" "$spec" | grep "derives_from" -A 5)

  # For each parent, validate alignment
  # (manual review - check spec still makes sense given parent)
done
```

**Questions:**
- Does this spec solve the problem its parent defines?
- Does this spec respect constraints its parent sets?
- Is derivation still logical?

### Downward Validation (Parent → Children)

Every spec must be supported by its children:

```bash
# For each parent spec
PARENT="specs/architecture.spec.md"

# Find all children
grep -r "derives_from.*$(basename $PARENT)" specs/

# Validate children still implement parent
# (manual review - check children collectively satisfy parent)
```

**Questions:**
- Do children collectively implement parent intent?
- Are there gaps in child coverage?
- Do any children conflict with parent?

### Constraint Validation (Boundaries)

Every spec must respect its constraints:

```bash
# For each spec with constrained_by
for spec in specs/**/*.spec.md; do
  # Extract constrained_by references
  CONSTRAINTS=$(grep -A 10 "^---" "$spec" | grep "constrained_by" -A 5)

  # For each constraint, validate compliance
  # (manual review against constraint validation criteria)
done
```

**Questions:**
- Does this spec violate any constraint validation criteria?
- Are workarounds used to bypass constraints?
- Is the constraint still appropriate?

## Common Patterns

### Pattern: Foundation → Approach → Implementation

```
PURPOSE.md
  ↓
requirements.spec.md (what - HLR)
  ↓
architecture.spec.md (how)
  ↓
behaviors/*.spec.md (what - detailed)
  ↓
code (actual)
```

**Validation:**
- Bottom-up: Does code satisfy behaviors which derive from architecture which satisfies requirements which fulfills purpose?
- Top-down: Does purpose guide requirements which shapes architecture which defines behaviors which code implements?

### Pattern: Constraints Flow Downward

```
constraints.spec.md
  ↓ constrains
  ├─→ architecture.spec.md
  ├─→ behaviors/*.spec.md
  └─→ code
```

**Validation:**
- Does every layer respect all constraints?
- Are constraints enforced or merely documented?
- Which code would break if constraint changes?

### Pattern: Workspace Applies Horizontally

```
workspace/constitution.spec.md ─┬─→ Writing PURPOSE.md
workspace/patterns.spec.md      ├─→ Creating problem.spec.md
workspace/workflows.spec.md     ├─→ Designing architecture.spec.md
                                ├─→ Specifying behaviors/
                                └─→ Implementing code
```

**Validation:**
- Are workspace patterns followed at all levels?
- Does code violate workspace conventions?
- Are specs written per workspace patterns?

## Tools for Dependency Tracking

### Find Dependencies

```bash
# What does this spec depend on?
grep -A 10 "^---" specs/architecture.spec.md | grep "derives_from\|constrained_by"

# What depends on this spec?
grep -r "derives_from.*architecture.spec.md" specs/
grep -r "constrained_by.*architecture.spec.md" specs/
grep -r "satisfies.*architecture.spec.md" specs/
```

### Trace Impact

```bash
# If specs/problem.spec.md changes, what's affected?
echo "Directly derived:"
grep -r "derives_from.*problem.spec.md" specs/

echo "Satisfies problem:"
grep -r "satisfies.*problem.spec.md" specs/

echo "May need review:"
grep -r "architecture\|behavior" specs/ --include="*.spec.md" -l
```

### Validate Alignment

```bash
# Check spec has required frontmatter
for spec in specs/**/*.spec.md; do
  if ! grep -q "^---" "$spec"; then
    echo "Missing frontmatter: $spec"
  fi
done

# Check derives_from targets exist
for spec in specs/**/*.spec.md; do
  PARENTS=$(grep -A 5 "derives_from:" "$spec" | grep "^ *-" | sed 's/.*- //')
  for parent in $PARENTS; do
    if [ ! -f "$parent" ]; then
      echo "Broken dependency in $spec: $parent not found"
    fi
  done
done
```

## LiveSpec Current Dependencies

### Foundation

```yaml
PURPOSE.md → (defines) → specs/requirements.spec.md
PURPOSE.md → (defines) → specs/constraints.spec.md
specs/requirements.spec.md → (constrains) → specs/architecture.spec.md
specs/constraints.spec.md → (limits) → specs/architecture.spec.md
```

### Approach

```yaml
specs/architecture.spec.md:
  derives_from: [PURPOSE.md, specs/requirements.spec.md]
  constrained_by: [specs/constraints.spec.md]
  enables: [specs/prompts/*, specs/behaviors/*]
```

### Implementation

```yaml
specs/prompts/*.spec.md:
  derives_from: [specs/architecture.spec.md]
  implements: [prompts/*.md]

specs/behaviors/* (when created):
  derives_from: [specs/architecture.spec.md]
  satisfies: [specs/requirements.spec.md]
  constrained_by: [specs/constraints.spec.md]
```

### Process

```yaml
specs/workspace/constitution.spec.md:
  applies_to: [all_development_work]

specs/workspace/patterns.spec.md:
  applies_to: [all_specifications, all_code]

specs/workspace/workflows.spec.md:
  applies_to: [all_development_activities]
```

---

**See also:**
- `specs/workspace/patterns.spec.md` - Traceability convention
- `prompts/4-evolve/4a-detect-drift.md` - Impact detection process
- `tests/prompts/test_traceability.sh` - Automated validation
