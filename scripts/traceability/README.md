# LiveSpec Traceability Tools

These scripts enable traceability analysis for LiveSpec projects using the three-layer architecture pattern.

## Scripts

### 1. find-satisfying-specs.sh

Find all implementation specs that satisfy a given requirement.

**Usage:**
```bash
./find-satisfying-specs.sh <requirement-spec-path>
```

**Example:**
```bash
./find-satisfying-specs.sh specs/requirements/functional/loan-accuracy.spec.md
```

**Output:**
- Lists all behavior and contract specs that satisfy the requirement
- Shows what other requirements each implementation also satisfies
- Summary count of implementations found

**Use cases:**
- Requirement changes → identify affected implementations
- Validate requirement coverage
- Understand implementation scope for a requirement

---

### 2. validate-coverage.sh

Validate that all requirements have at least one implementation.

**Usage:**
```bash
./validate-coverage.sh [--detailed]
```

**Flags:**
- `--detailed`: Show detailed information for each requirement

**Examples:**
```bash
# Quick summary
./validate-coverage.sh

# Detailed report
./validate-coverage.sh --detailed
```

**Output:**
- Total requirements count
- Satisfied vs unsatisfied requirements
- Coverage percentage
- List of unsatisfied requirements (with criticality)
- Exit code 1 if CRITICAL requirements unsatisfied

**Use cases:**
- Release readiness check
- Identify gaps in implementation
- Validate completeness before shipping

---

### 3. cascade-impact.sh

Analyze cascade impact when a spec changes.

**Usage:**
```bash
./cascade-impact.sh <changed-spec-path>
```

**Examples:**
```bash
# Requirement changed
./cascade-impact.sh specs/requirements/functional/loan-accuracy.spec.md

# Strategy changed
./cascade-impact.sh specs/strategy/calculation-approach.spec.md

# Implementation changed
./cascade-impact.sh specs/behaviors/interest-calculation.spec.md
```

**Output:**

For **requirements**:
- Strategies deriving from this requirement
- Implementations satisfying this requirement
- Action items for updating downstream specs

For **strategies**:
- Requirements this strategy derives from (upward dependencies)
- Implementations guided by this strategy (downward dependencies)
- Action items for verification and updates

For **implementations**:
- Requirements this implementation satisfies (upward dependencies)
- Strategies guiding this implementation
- Action items for validation

**Use cases:**
- Change impact analysis
- Understand dependencies before making changes
- Plan update cascade when specs change

---

### 4. find-research-basis.sh

Find research artifacts that inform a given requirement.

**Usage:**
```bash
./find-research-basis.sh <requirement-spec-path>
```

**Example:**
```bash
./find-research-basis.sh specs/requirements/functional/simplified-checkout.spec.md
```

**Output:**
- Lists all research artifacts referenced in `informed-by:` frontmatter
- Shows research type (Persona, User Journey, UX Flow, Research Insights)
- Displays title and creation date
- Indicates if research files are missing

**Use cases:**
- Understand evidence basis for requirements
- Validate research linkage
- Review research when requirements change
- Trace decisions back to user insights

---

### 5. find-requirements-from-research.sh

Find requirements informed by a research artifact.

**Usage:**
```bash
./find-requirements-from-research.sh <research-artifact-path>
```

**Example:**
```bash
./find-requirements-from-research.sh research/insights/checkout-friction-study.md
```

**Output:**
- Lists requirements from `informs:` frontmatter in research artifact
- Lists requirements with `informed-by:` references to this research
- Shows requirement title and criticality
- Indicates if requirement files are missing

**Use cases:**
- Research changes → identify affected requirements
- Validate research impact
- Ensure research artifacts are being used
- Trace from insights to requirements

---

### 6. validate-research-links.sh

Validate bidirectional linkage between research artifacts and requirements.

**Usage:**
```bash
./validate-research-links.sh
```

**Output:**
- Checks research artifacts have `informs:` frontmatter
- Validates referenced requirements exist
- Checks requirements with `informed-by:` reference existing research
- Validates bidirectional consistency (research ↔ requirement)
- Summary of issues found

**Use cases:**
- Validate research integration integrity
- CI/CD quality checks
- Ensure research artifacts are properly linked
- Detect broken references

**Exit codes:**
- 0: All linkages valid
- 1: Issues found (broken links, missing frontmatter, inconsistency)

---

## Workflow Examples

### Scenario 1: Requirement Changes

**Situation:** Regulatory requirement changes (late fees now 3% instead of 5%)

```bash
# 1. Identify impact
./cascade-impact.sh specs/requirements/functional/regulatory-compliance.spec.md

# Output shows:
#   - specs/behaviors/late-fee-calculation.spec.md (needs update)
#   - specs/behaviors/interest-calculation.spec.md (may need review)

# 2. Update requirement spec
vim specs/requirements/functional/regulatory-compliance.spec.md

# 3. Update affected implementation
vim specs/behaviors/late-fee-calculation.spec.md

# 4. Verify coverage still complete
./validate-coverage.sh
```

---

### Scenario 2: Validate Before Release

**Situation:** Ready to release, need to verify all requirements implemented

```bash
# 1. Check coverage
./validate-coverage.sh --detailed

# Output shows:
#   Total requirements:      8
#   Satisfied requirements:  7
#   Unsatisfied requirements: 1
#
#   Unsatisfied Requirements:
#     [IMPORTANT] specs/requirements/functional/user-notifications.spec.md

# 2. Decide: implement or defer
# If implementing:
vim specs/behaviors/email-notifications.spec.md
# Add satisfies: field pointing to requirement

# 3. Re-check
./validate-coverage.sh

# Output:
#   ✓ All requirements have implementations
```

---

### Scenario 3: Understand Implementation Scope

**Situation:** Need to know what a single implementation spec satisfies

```bash
# 1. Analyze implementation
./cascade-impact.sh specs/behaviors/interest-calculation.spec.md

# Output shows upward dependencies:
#   Requirements This Satisfies:
#     ✓ specs/requirements/functional/loan-accuracy.spec.md
#     ✓ specs/requirements/functional/regulatory-compliance.spec.md
#     ✓ specs/requirements/functional/audit-trail.spec.md
#
#   Strategies Guiding This:
#     ✓ specs/strategy/calculation-approach.spec.md

# 2. Verify change still satisfies all three requirements
# 3. Verify change still follows strategy guidance
```

---

### Scenario 4: Strategy Evolution

**Situation:** Switching from Decimal library to Money library

```bash
# 1. Identify all implementations using this strategy
./cascade-impact.sh specs/strategy/calculation-approach.spec.md

# Output shows:
#   Implementations Guided By This:
#     ✓ specs/behaviors/interest-calculation.spec.md
#     ✓ specs/behaviors/late-fee-calculation.spec.md
#     ✓ specs/behaviors/amortization-schedule.spec.md
#     ✓ specs/behaviors/early-payoff.spec.md

# 2. Update strategy spec
vim specs/strategy/calculation-approach.spec.md

# 3. Update all 4 implementation specs
# 4. Update code
# 5. Verify requirements still satisfied
./validate-coverage.sh
```

---

### Scenario 5: Research-Informed Requirements

**Situation:** Conducted user interviews, need to trace research to requirements

```bash
# 1. After creating research artifact
vim research/insights/checkout-friction-study.md
# Add informs: frontmatter listing requirements

# 2. Update requirements with research linkage
vim specs/requirements/functional/simplified-checkout.spec.md
# Add informed-by: frontmatter pointing to research

# 3. Validate bidirectional linkage
./validate-research-links.sh

# Output:
#   ✓ All research linkages valid!

# 4. Find all requirements informed by this research
./find-requirements-from-research.sh research/insights/checkout-friction-study.md

# Output shows:
#   Requirements Informed By This Research:
#     ✓ specs/requirements/functional/simplified-checkout.spec.md
#     ✓ specs/requirements/functional/guest-checkout.spec.md

# 5. If research changes, analyze impact
./cascade-impact.sh research/insights/checkout-friction-study.md

# Output shows which requirements need review
```

---

### Scenario 6: Validate Research Basis

**Situation:** Need to understand evidence basis for a requirement

```bash
# 1. Find research informing a requirement
./find-research-basis.sh specs/requirements/functional/simplified-checkout.spec.md

# Output shows:
#   Research artifacts informing this requirement:
#     ✓ research/insights/checkout-friction-study.md
#       Type: Research Insights
#       Title: Checkout Friction Study - January 2025
#       Created: 2025-01-15
#
#     ✓ research/flows/checkout-flow.md
#       Type: UX Flow
#       Title: Checkout Process Flow
#       Created: 2025-01-12

# 2. Review research artifacts
cat research/insights/checkout-friction-study.md

# 3. If requirement changes, check if research basis still valid
vim specs/requirements/functional/simplified-checkout.spec.md
# After changes, verify alignment with research
./find-research-basis.sh specs/requirements/functional/simplified-checkout.spec.md
```

---

## Integration with CI/CD

### Pre-Commit Hook

```bash
#!/bin/bash
# .git/hooks/pre-commit

# Check if any requirement specs changed
CHANGED_REQS=$(git diff --cached --name-only | grep "specs/requirements/")

if [ -n "$CHANGED_REQS" ]; then
    echo "Requirements changed. Running impact analysis..."
    for req in $CHANGED_REQS; do
        ./scripts/traceability/cascade-impact.sh "$req"
    done

    read -p "Continue with commit? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi
```

### CI Pipeline

```yaml
# .github/workflows/validate-coverage.yml
name: Validate Requirements Coverage

on: [push, pull_request]

jobs:
  coverage:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2

      - name: Validate all requirements have implementations
        run: ./scripts/traceability/validate-coverage.sh

      - name: Check for critical gaps
        if: failure()
        run: |
          echo "❌ CRITICAL requirements lack implementations"
          ./scripts/traceability/validate-coverage.sh --detailed
          exit 1
```

---

## Technical Notes

### Frontmatter Format

Scripts expect YAML frontmatter with these fields:

**Research Artifacts:**
```yaml
---
created: YYYY-MM-DD
source: [Research method and sample]
informs:
  - specs/requirements/functional/feature1.spec.md
  - specs/requirements/functional/feature2.spec.md
---
```

**Requirements:**
```yaml
---
derives-from: requirements/strategic/outcomes.spec.md
informed-by:
  - research/insights/user-study.md
  - research/personas/primary-user.md
criticality: CRITICAL
failure_mode: [impact description]
---
```

**Strategies:**
```yaml
---
derives-from:
  - requirements/functional/feature1.spec.md
  - requirements/functional/feature2.spec.md
governed-by: requirements/strategic/constraints.spec.md
---
```

**Implementations:**
```yaml
---
satisfies:
  - requirements/functional/feature1.spec.md
  - requirements/functional/feature2.spec.md
guided-by:
  - strategy/approach.spec.md
---
```

### Path References

Scripts handle both:
- Basename references: `loan-accuracy.spec.md`
- Relative path references: `requirements/functional/loan-accuracy.spec.md`

Both styles work interchangeably.

---

## Troubleshooting

### "No implementations found" but implementations exist

**Cause:** Missing or incorrect `satisfies:` frontmatter

**Solution:**
```bash
# Check if implementation has satisfies field
grep -A 5 "^satisfies:" specs/behaviors/your-spec.spec.md

# If missing, add it:
---
satisfies:
  - requirements/functional/your-requirement.spec.md
---
```

### "File not found" errors

**Cause:** Running from wrong directory

**Solution:** Run from project root where `specs/` directory exists
```bash
cd /path/to/project
./scripts/traceability/validate-coverage.sh
```

### Coverage shows 0%

**Cause:** No `specs/requirements/` directory

**Solution:** Project may not use three-layer architecture
```bash
# Check structure
ls -la specs/

# If missing, see migration guide:
# docs/three-layer-migration.md
```

---

## See Also

- [Three-Layer Architecture Spec](../../specs/strategy/three-layer-architecture.spec.md)
- [Loan System Example](../../examples/loan-system/)
- [Migration Guide](../../docs/three-layer-migration.md)
