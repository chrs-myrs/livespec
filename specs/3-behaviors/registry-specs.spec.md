---
criticality: IMPORTANT
failure_mode: Target projects lack guidance on registry format, inconsistent tracking across projects, methodology gaps invisible
specifies:
  - dist/standard/registries/gaps.spec.md
  - dist/standard/registries/issues.spec.md
  - dist/standard/registries/improvements.spec.md
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
guided-by:
  - specs/workspace/patterns.spec.md
---

# Registry Format Specifications

Governs the distributed registry format specs that target projects copy from `dist/standard/registries/`.

## Requirements

### Common Registry Format

- [!] All registry specs MUST use MSL format with consistent structure
  - Frontmatter: criticality, failure_mode
  - Requirements section defining entry structure
  - Validation section with testable checks
  - Failure Mode section explaining consequences

- [!] All registry entry formats MUST include common fields
  - Entry ID: `[TYPE]-[NNN]` pattern (e.g., GAP-001, ISSUE-001, IMP-001)
  - Status field with defined transitions
  - Discovery/implementation date
  - Category for grouping related entries

- [!] All registries MUST define maintenance workflows
  - Update triggers (when to add entries)
  - Review triggers (when to analyze patterns)
  - Archival policy (when/how to archive resolved items)

### Gap Registry Spec (gaps.spec.md)

- [!] Gap entries MUST track methodology gaps
  - Fields: Description, Impact (CRITICAL/HIGH/MEDIUM/LOW), Frequency, Potential Solution, Status, Discovered
  - Status values: identified, investigating, planned, resolved
  - Categories: process, tooling, documentation, guidance

- [!] Gap entries MUST be actionable
  - Description states what is missing or inadequate
  - Impact quantifies cost (severity + frequency)
  - Potential solution proposes concrete improvement

### Issue Registry Spec (issues.spec.md)

- [!] Issue entries MUST track problems encountered
  - Fields: What (observable behavior), Why Problematic, Category, Status, Resolution, Discovered
  - Status values: open, investigating, resolved, wontfix
  - Categories: tooling, process, documentation, validation, guidance

- [!] Issue entries MUST be specific and reproducible
  - Description states observable problem behavior
  - Resolution records what fixed it (if resolved)
  - Related issues linkable for pattern detection

### Improvement Registry Spec (improvements.spec.md)

- [!] Improvement entries MUST track experiments and outcomes
  - Fields: Changed, Hypothesis, Category, Implemented, Outcome, Evidence, Decision
  - Status values: proposed, implemented, evaluating, effective, ineffective, mixed
  - Decision values: keep, revert, iterate

- [!] Improvement entries MUST support learning from experiments
  - Hypothesis states expected benefit
  - Outcome describes actual impact with evidence
  - Ineffective improvements retained to prevent repetition

## Validation

**Distributed specs exist:**
```bash
ls dist/standard/registries/{gaps,issues,improvements}.spec.md
```

**All specs have required sections:**
```bash
for spec in dist/standard/registries/*.spec.md; do
  grep -q "## Requirements" "$spec" && \
  grep -q "## Validation" "$spec" && \
  grep -q "## Failure Mode" "$spec" || \
  echo "Missing section in $spec"
done
```

**Entry ID format defined:**
```bash
for spec in dist/standard/registries/*.spec.md; do
  grep -q "\[TYPE\]-\[NNN\]" "$spec" || \
  grep -qE "(GAP|ISSUE|IMP)-[0-9]{3}" "$spec" || \
  echo "Missing ID format in $spec"
done
```

## Failure Mode

Without registry format specifications:
- Target projects create inconsistent registries (no standard format)
- Entry quality varies wildly (no validation criteria)
- No maintenance guidance (registries become stale)
- Pattern detection impossible across projects (incompatible formats)
- LiveSpec methodology improvements invisible (no tracking mechanism)

---

## Three-Layer Registry Pattern

```
GOVERNANCE (this spec)
specs/3-behaviors/registry-specs.spec.md
  |
  +--> specifies format for:
  |
DISTRIBUTION (what target projects copy)
dist/standard/registries/gaps.spec.md
dist/standard/registries/issues.spec.md
dist/standard/registries/improvements.spec.md
  |
  +--> defines format for:
  |
DATA (project-specific, not distributed)
docs/registries/gaps.md
docs/registries/issues.md
docs/registries/improvements.md
```

Target projects:
1. Copy `dist/` to `.livespec/` (gets format specs)
2. Create `docs/registries/*.md` files (project's own data)
3. Follow format defined in `.livespec/standard/registries/*.spec.md`
