# Three-Layer Architecture Migration Guide

This guide walks you through migrating an existing LiveSpec project from the two-layer structure to the new three-layer architecture with many-to-many traceability.

## Overview

**What's changing:**
- `mission/` folder → `requirements/strategic/`
- `behaviors/` folder → Split into `requirements/functional/` and `behaviors/` (implementation-only)
- New frontmatter fields: `satisfies:` and `guided-by:`
- Traceability tooling for impact analysis

**What stays the same:**
- `strategy/` folder (unchanged)
- `contracts/` folder (unchanged)
- `workspace/` folder (unchanged)
- MSL format (unchanged)

**Benefits:**
- Clear separation of requirements from implementations
- Many-to-many traceability
- Cascade impact analysis
- Requirements coverage validation

---

## Pre-Migration Checklist

Before beginning migration:

- [ ] **Backup your project**: `cp -r . ../project-backup`
- [ ] **Commit current state**: `git add . && git commit -m "Pre-migration checkpoint"`
- [ ] **Review current structure**: Understand what's in `mission/` and `behaviors/`
- [ ] **Note customizations**: Document any project-specific patterns
- [ ] **Read this guide completely**: Understand all steps before starting

---

## Migration Steps

### Step 1: Create New Directory Structure

```bash
# Create requirements structure
mkdir -p specs/requirements/strategic
mkdir -p specs/requirements/functional

# Verify structure
tree specs/requirements/
# Output should show:
# specs/requirements/
# ├── strategic/
# └── functional/
```

### Step 2: Move Strategic Requirements

**Move mission/ contents to requirements/strategic/:**

```bash
# If you have mission/outcomes.spec.md
mv specs/1-requirements/strategic/outcomes.spec.md specs/requirements/strategic/outcomes.spec.md

# If you have mission/constraints.spec.md
mv specs/1-requirements/strategic/constraints.spec.md specs/requirements/strategic/constraints.spec.md

# Move any other mission/ files
mv specs/1-requirements/strategic/*.spec.md specs/requirements/strategic/

# Remove empty mission/ directory
rmdir specs/mission
```

**Update frontmatter paths:**

```bash
# Update derives-from references
find specs/ -name "*.spec.md" -exec sed -i 's|specs/1-requirements/strategic/|specs/requirements/strategic/|g' {} \;

# Verify changes
grep -r "mission/" specs/
# Should return no results
```

### Step 3: Analyze behaviors/ Folder

**Classify each spec** in `behaviors/` as either:

1. **Requirement** (strategic/functional - pre-implementation, solution-independent)
2. **Implementation** (detailed, formula-based, code-linked)

**Decision criteria:**

| Characteristic | Requirement | Implementation |
|----------------|-------------|----------------|
| **When written** | Before design | During implementation |
| **Abstraction** | WHAT must be achieved | EXACTLY how it works |
| **Independence** | Solution-independent | Specific algorithms/formulas |
| **Stability** | Rarely changes | Frequently evolves |
| **Example** | "System must calculate payments accurately" | "Payment = [P×r(1+r)^n]/[(1+r)^n-1]" |

**Create classification list:**

```bash
# List all behavior specs
ls specs/3-behaviors/*.spec.md > /tmp/behavior-specs.txt

# Review and classify each
vim /tmp/behavior-specs.txt
# Add prefix: REQ: or IMPL: to each line
```

### Step 4: Extract Functional Requirements

**Move requirement-level specs** from `behaviors/` to `requirements/functional/`:

```bash
# For each spec marked REQ: in your classification
# Example:
mv specs/3-behaviors/authentication.spec.md specs/requirements/functional/authentication.spec.md
mv specs/3-behaviors/loan-accuracy.spec.md specs/requirements/functional/loan-accuracy.spec.md

# Keep implementation specs in behaviors/
# (Specs marked IMPL: stay in behaviors/)
```

**Update moved specs:**

For each moved requirement spec, update frontmatter:

```yaml
# Before (in behaviors/):
---
criticality: CRITICAL
failure_mode: [impact]
---

# After (in requirements/functional/):
---
derives-from: requirements/strategic/outcomes.spec.md
governed-by: requirements/strategic/constraints.spec.md
criticality: CRITICAL
failure_mode: [impact]
---
```

### Step 5: Update Implementation Specs

**For each spec remaining in `behaviors/`**, add traceability frontmatter:

**Before:**
```yaml
---
criticality: CRITICAL
failure_mode: Incorrect calculations
---

# Interest Calculation

## Requirements
- [!] Calculate interest using formula X
```

**After:**
```yaml
---
satisfies:
  - requirements/functional/loan-accuracy.spec.md
  - requirements/functional/regulatory-compliance.spec.md
guided-by:
  - strategy/calculation-approach.spec.md
criticality: CRITICAL
failure_mode: Incorrect calculations
---

# Interest Calculation Implementation

## Requirements
- [!] Calculate interest using formula X
```

**Identify relationships:**

1. **What requirements does this satisfy?**
   - Look at spec purpose and validation criteria
   - Add to `satisfies:` array

2. **What strategy guides this?**
   - Check if strategy specs exist for architectural approach
   - Add to `guided-by:` array

### Step 6: Create Missing Strategy Specs

**If implementations reference strategies that don't exist**, create them:

```bash
# Example: Create calculation-approach.spec.md
vim specs/2-strategy/calculation-approach.spec.md
```

**Template:**
```markdown
---
derives-from:
  - requirements/functional/loan-accuracy.spec.md
  - requirements/functional/regulatory-compliance.spec.md
governed-by: requirements/strategic/constraints.spec.md
criticality: CRITICAL
failure_mode: Inconsistent calculation approach creates bugs
---

# Financial Calculation Strategy

## Requirements
- [!] Use standard financial formulas (not proprietary)
- [!] Calculate on backend for security and auditability
- [!] Use Decimal type for monetary values
- [!] Store calculation parameters for audit trail

## Validation
- All calculations use Decimal library
- Calculation history stored in database
- No client-side financial calculations exist
```

### Step 7: Validate Structure

**Check directory structure:**

```bash
tree specs/
# Expected:
# specs/
# ├── requirements/
# │   ├── strategic/
# │   │   ├── outcomes.spec.md
# │   │   └── constraints.spec.md
# │   └── functional/
# │       ├── feature1.spec.md
# │       └── feature2.spec.md
# ├── strategy/
# │   └── approach.spec.md
# ├── behaviors/
# │   ├── implementation1.spec.md
# │   └── implementation2.spec.md
# ├── contracts/
# └── workspace/
```

**Verify frontmatter:**

```bash
# Check all implementation specs have satisfies: field
for spec in specs/3-behaviors/*.spec.md; do
  if ! grep -q "^satisfies:" "$spec"; then
    echo "Missing satisfies: $spec"
  fi
done

# Check all strategy specs have derives-from: field
for spec in specs/2-strategy/*.spec.md; do
  if ! grep -q "^derives-from:" "$spec"; then
    echo "Missing derives-from: $spec"
  fi
done
```

### Step 8: Install Traceability Tools

```bash
# Ensure scripts are executable
chmod +x scripts/traceability/*.sh

# Test find-satisfying-specs
./scripts/traceability/find-satisfying-specs.sh specs/requirements/functional/[your-requirement].spec.md

# Test validate-coverage
./scripts/traceability/validate-coverage.sh

# Test cascade-impact
./scripts/traceability/cascade-impact.sh specs/requirements/functional/[your-requirement].spec.md
```

### Step 9: Validate Coverage

```bash
# Run coverage validation
./scripts/traceability/validate-coverage.sh --detailed

# Expected output:
# Total requirements:      X
# Satisfied requirements:  Y
# Unsatisfied requirements: Z
#
# ✓ Coverage: N%
```

**If coverage < 100%:**
- Review unsatisfied requirements
- Add `satisfies:` frontmatter to implementations
- Or create new implementations if needed

### Step 10: Update Documentation

**Update project README** (if it references old structure):

```markdown
# Before
specs/1-requirements/strategic/outcomes.spec.md
specs/3-behaviors/authentication.spec.md

# After
specs/requirements/strategic/outcomes.spec.md
specs/requirements/functional/authentication.spec.md
specs/3-behaviors/oauth-authentication.spec.md
```

**Update CHANGELOG:**

```markdown
## [X.Y.Z] - YYYY-MM-DD

### Changed
- **BREAKING**: Migrated to three-layer architecture (requirements/strategy/implementations)
- Moved `mission/` → `requirements/strategic/`
- Split `behaviors/` into `requirements/functional/` and `behaviors/` (implementation-only)
- Added traceability frontmatter (`satisfies:`, `guided-by:`)
- Added traceability tooling (`scripts/traceability/`)

### Migration Guide
See `docs/three-layer-migration.md` for migration instructions.
```

---

## Optional: Research Layer Integration (v3.0+)

The research layer is **optional** but recommended for user-facing projects. Skip this section if your project doesn't involve user research or if requirements are already well-documented.

### When to Add Research Integration

**Add research if:**
- Building user-facing features
- User workflows or needs unclear
- Multiple user types with different requirements
- Requirements currently based on assumptions
- Need evidence basis for decisions

**Skip research if:**
- Backend API with defined contract
- Infrastructure with no direct users
- Requirements fully documented from prior research
- Simple CRUD following standard patterns

### Step R1: Create Research Structure

```bash
# Create research folders
mkdir -p research/{personas,journeys,flows,insights}

# Verify structure
tree research/
# Output:
# research/
# ├── personas/    # User types
# ├── journeys/    # User workflows
# ├── flows/       # Interaction patterns
# └── insights/    # Research findings
```

### Step R2: Copy Research Templates and Metaspecs

```bash
# If you have LiveSpec repository
cp -r /path/to/livespec/.livespec/templates/research/ .livespec/templates/
cp -r /path/to/livespec/.livespec/standard/metaspecs/research/ .livespec/standard/metaspecs/

# Verify copied
ls .livespec/templates/research/
# Should show: persona.md.template, user-journey.md.template, ux-flow.md.template, user-insights.md.template

ls .livespec/standard/metaspecs/research/
# Should show: persona.metaspec.md, user-journey.metaspec.md, ux-flow.metaspec.md, user-insights.metaspec.md
```

### Step R3: Copy Research Traceability Scripts

```bash
# Copy research scripts
cp /path/to/livespec/scripts/traceability/find-research-basis.sh scripts/traceability/
cp /path/to/livespec/scripts/traceability/find-requirements-from-research.sh scripts/traceability/
cp /path/to/livespec/scripts/traceability/validate-research-links.sh scripts/traceability/

# Make executable
chmod +x scripts/traceability/find-research-basis.sh
chmod +x scripts/traceability/find-requirements-from-research.sh
chmod +x scripts/traceability/validate-research-links.sh

# Note: cascade-impact.sh already includes research support in v3.0+
```

### Step R4: Add Phase 0e Prompt (Optional)

```bash
# Copy research evaluation prompt
cp /path/to/livespec/dist/prompts/0-define/0e-evaluate-research-needs.md .livespec/0-define/

# Copy research evaluation spec
cp /path/to/livespec/specs/3-behaviors/prompts/0e-evaluate-research-needs.spec.md specs/3-behaviors/prompts/
```

### Step R5: Migrate Existing Research Artifacts

**If you have existing research** (user interviews, personas, etc.):

```bash
# Move to research/ folder
mv docs/personas/*.md research/personas/
mv docs/user-interviews/*.md research/insights/
mv docs/user-flows/*.md research/flows/

# Or copy if you want to preserve originals
cp docs/personas/*.md research/personas/
```

**Update format to match templates:**

1. Add frontmatter with `informs:` field
2. Link to requirements they inform
3. Ensure evidence-based (quotes, observations, data)

**Example transformation:**

```markdown
# Before (docs/personas/shopper.md)
# Time-Constrained Shopper

They shop during lunch breaks.
They want fast checkout.

# After (research/personas/time-constrained-shopper.md)
---
created: 2025-01-15
source: "User interviews Jan 2025"
sample_size: 10
informs:
  - specs/requirements/functional/simplified-checkout.spec.md
---

# Time-Constrained Shopper

## Identity
- Role: Online shopper (employed professional)
- Age: 28-45
- Context: Shopping during work breaks

## Pain Points
### Pain Point 1: Checkout Length
- **Issue**: Checkout takes 8+ minutes
- **Quote**: "By the time I get to payment, my meeting is starting." (P7)
- **Evidence**: 7/10 showed frustration during checkout

## Needs
### Need 1: Fast checkout flow
- **Priority**: HIGH
- **Informs**: specs/requirements/functional/simplified-checkout.spec.md
- **Evidence**: 10/10 mentioned time pressure; avg 8.5 min checkout vs 3 min expectation
```

### Step R6: Link Requirements to Research

**For requirements informed by research**, add `informed-by:` frontmatter:

```bash
# Edit requirement spec
vim specs/requirements/functional/simplified-checkout.spec.md
```

**Add frontmatter:**

```yaml
---
informed-by:
  - research/insights/checkout-friction-study.md
  - research/personas/time-constrained-shopper.md
derives-from: requirements/strategic/outcomes.spec.md
criticality: CRITICAL
---
```

**Add evidence basis section (optional but recommended):**

```markdown
## Evidence Basis

**From research/insights/checkout-friction-study.md**:
- Finding 2: Current checkout 8.5 min vs 3 min expectation
- 10/10 participants mentioned time pressure
- Quote: "By the time I get to payment, my meeting is starting." (P7)

**From research/personas/time-constrained-shopper.md**:
- Need 2: Simplified, fast checkout flow (HIGH priority)
- Shopping during limited time windows (3-5 minutes available)
```

### Step R7: Validate Research Linkage

```bash
# Validate bidirectional linkage
./scripts/traceability/validate-research-links.sh

# Expected output:
# ✓ All research linkages valid!

# Or if issues found:
# ⚠ research/personas/shopper.md
#   Missing 'informs:' frontmatter
# ⚠ specs/requirements/functional/feature.spec.md
#   Broken link: research/nonexistent.md (file not found)
```

**Fix any issues found:**
- Add missing `informs:` to research artifacts
- Add missing `informed-by:` to requirements
- Fix broken file paths
- Re-run validation

### Step R8: Test Research Traceability

```bash
# Find research informing a requirement
./scripts/traceability/find-research-basis.sh \
  specs/requirements/functional/simplified-checkout.spec.md

# Expected output:
# ✓ research/insights/checkout-friction-study.md
#   Type: Research Insights
#   Created: 2025-01-15
# ✓ research/personas/time-constrained-shopper.md
#   Type: Persona
#   Created: 2025-01-15

# Find requirements informed by research
./scripts/traceability/find-requirements-from-research.sh \
  research/insights/checkout-friction-study.md

# Expected output:
# ✓ specs/requirements/functional/simplified-checkout.spec.md
#   Criticality: CRITICAL
# ✓ specs/requirements/functional/guest-checkout.spec.md
#   Criticality: CRITICAL

# Test cascade impact with research
./scripts/traceability/cascade-impact.sh \
  research/insights/checkout-friction-study.md

# Expected output:
# Requirements Informed By This Research:
#   ✓ specs/requirements/functional/simplified-checkout.spec.md
#   ✓ specs/requirements/functional/guest-checkout.spec.md
# Action Items:
#   • Review 2 requirement spec(s) informed by this research
#   • Verify requirements still align with updated research findings
```

### Step R9: Update Documentation

**Add research to project README:**

```markdown
## Research

User research artifacts are stored in `research/`:
- `personas/` - User types with goals and pain points
- `journeys/` - User workflows across touchpoints
- `flows/` - Interaction flow diagrams
- `insights/` - Research findings and evidence

Requirements link to research via `informed-by:` frontmatter.
```

**Update CHANGELOG:**

```markdown
### Added
- Research layer integration with traceability
- Research templates and quality metaspecs
- Research traceability scripts (find-research-basis, validate-research-links)
- Phase 0e: Intelligent research evaluation prompt
```

### Research Integration Checklist

After research integration:

- [ ] **research/ structure created**: `[ -d research/personas ] && [ -d research/insights ]`
- [ ] **Templates installed**: `.livespec/templates/research/` exists
- [ ] **Metaspecs installed**: `.livespec/standard/metaspecs/research/` exists
- [ ] **Scripts installed**: Research traceability scripts in `scripts/traceability/`
- [ ] **Scripts executable**: `chmod +x scripts/traceability/*.sh`
- [ ] **Research artifacts created/migrated**: Artifacts follow template format
- [ ] **Frontmatter linkage added**: Research has `informs:`, requirements have `informed-by:`
- [ ] **Validation passes**: `./scripts/traceability/validate-research-links.sh` succeeds
- [ ] **Traceability tested**: Find-research-basis and find-requirements-from-research work
- [ ] **Documentation updated**: README mentions research layer
- [ ] **Example reviewed**: `examples/ecommerce-checkout/` shows complete pattern

---

## Verification Checklist

After migration, verify:

- [ ] **No mission/ directory exists**: `[ ! -d specs/mission ]`
- [ ] **requirements/ structure created**: `[ -d specs/requirements/strategic ] && [ -d specs/requirements/functional ]`
- [ ] **Strategic requirements moved**: Strategic specs in `requirements/strategic/`
- [ ] **Functional requirements extracted**: Feature requirements in `requirements/functional/`
- [ ] **Implementation specs updated**: All specs in `behaviors/` have `satisfies:` frontmatter
- [ ] **Strategy specs exist**: Specs in `strategy/` have `derives-from:` frontmatter
- [ ] **Coverage validated**: `./scripts/traceability/validate-coverage.sh` passes
- [ ] **Traceability works**: Scripts successfully analyze relationships
- [ ] **Documentation updated**: README, CHANGELOG reflect new structure
- [ ] **Tests pass**: All existing tests still pass
- [ ] **Git committed**: `git add . && git commit -m "Migrate to three-layer architecture"`

---

## Example Migration: Loan System

### Before Migration

```
specs/
├── mission/
│   ├── outcomes.spec.md
│   └── constraints.spec.md
├── strategy/
│   └── architecture.spec.md
└── behaviors/
    ├── loan-calculations.spec.md      # Requirement-level
    ├── regulatory-compliance.spec.md  # Requirement-level
    ├── interest-calculation.spec.md   # Implementation-level
    └── late-fee-calculation.spec.md   # Implementation-level
```

### After Migration

```
specs/
├── requirements/
│   ├── strategic/
│   │   ├── outcomes.spec.md           # Moved from mission/
│   │   └── constraints.spec.md        # Moved from mission/
│   └── functional/
│       ├── loan-accuracy.spec.md      # Extracted from behaviors/
│       └── regulatory-compliance.spec.md # Moved from behaviors/
├── strategy/
│   ├── architecture.spec.md
│   └── calculation-approach.spec.md   # New
└── behaviors/
    ├── interest-calculation.spec.md   # Updated with satisfies:
    └── late-fee-calculation.spec.md   # Updated with satisfies:
```

### Traceability Relationships

```yaml
# requirements/functional/regulatory-compliance.spec.md
---
derives-from: requirements/strategic/outcomes.spec.md
---

# strategy/calculation-approach.spec.md
---
derives-from:
  - requirements/functional/loan-accuracy.spec.md
  - requirements/functional/regulatory-compliance.spec.md
---

# behaviors/interest-calculation.spec.md
---
satisfies:
  - requirements/functional/loan-accuracy.spec.md
  - requirements/functional/regulatory-compliance.spec.md
guided-by:
  - strategy/calculation-approach.spec.md
---
```

---

## Troubleshooting

### Problem: Can't classify specs as requirement vs implementation

**Solution:** Ask these questions:

1. **Was this written before or during implementation?**
   - Before → Requirement
   - During → Implementation

2. **Does it contain specific formulas/algorithms?**
   - Yes → Implementation
   - No → Requirement

3. **Could requirements change without changing this?**
   - Yes → Implementation (tied to requirements)
   - No → Requirement (IS the requirement)

**Example:**
- "System must calculate payments accurately" → Requirement (WHAT)
- "Payment = [P×r(1+r)^n]/[(1+r)^n-1]" → Implementation (EXACTLY)

### Problem: validate-coverage.sh shows 0% coverage

**Cause:** Specs don't have `satisfies:` frontmatter or paths are wrong

**Solution:**
```bash
# Check one implementation spec
cat specs/3-behaviors/your-spec.spec.md | head -20

# Should show:
# ---
# satisfies:
#   - requirements/functional/...
# ---

# If missing, add frontmatter
```

### Problem: Scripts can't find relationships

**Cause:** Relative paths in frontmatter don't match actual paths

**Solution:**
```bash
# Verify frontmatter paths exist
grep -r "satisfies:" specs/3-behaviors/ | while read line; do
  FILE=$(echo "$line" | cut -d: -f1)
  REQ=$(echo "$line" | cut -d: -f3- | tr -d ' -')
  if [ -f "specs/$REQ" ]; then
    echo "✓ $FILE → $REQ"
  else
    echo "✗ $FILE → $REQ (NOT FOUND)"
  fi
done
```

### Problem: Migration breaks tests

**Cause:** Test files reference old spec paths

**Solution:**
```bash
# Update test files
find tests/ -name "*.test.*" -exec sed -i 's|specs/1-requirements/strategic/|specs/requirements/strategic/|g' {} \;
find tests/ -name "*.test.*" -exec sed -i 's|specs/3-behaviors/\([^/]*\).spec.md|specs/requirements/functional/\1.spec.md|g' {} \;

# Verify tests pass
npm test  # or your test command
```

---

## Rollback Procedure

If migration fails, rollback to pre-migration state:

```bash
# 1. Restore from backup
rm -rf specs/
cp -r ../project-backup/specs/ .

# 2. Or revert git commit
git reset --hard HEAD~1

# 3. Verify original structure restored
tree specs/
```

---

## Post-Migration

After successful migration:

1. **Update team documentation**
   - Brief team on new structure
   - Share this migration guide
   - Explain traceability tools

2. **Add to CI/CD**
   ```yaml
   # .github/workflows/validate-coverage.yml
   - name: Validate requirements coverage
     run: ./scripts/traceability/validate-coverage.sh
   ```

3. **Integrate with workflows**
   - Add coverage validation to PR checks
   - Use cascade-impact.sh when requirements change
   - Run validate-coverage.sh before releases

4. **Continuous improvement**
   - Review traceability relationships monthly
   - Refine requirement/implementation boundaries
   - Update strategy specs as architecture evolves

---

## See Also

- [Three-Layer Architecture Spec](../specs/2-strategy/three-layer-architecture.spec.md)
- [Loan System Example](../examples/loan-system/) - Three-layer without research
- [E-Commerce Checkout Example](../examples/ecommerce-checkout/) - Complete example with research integration
- [Traceability Tools README](../scripts/traceability/README.md)
- [AGENTS.md Three-Layer Section](../AGENTS.md#three-layer-architecture-v30)
- [AGENTS.md Research Integration Section](../AGENTS.md#research-integration-v30)
