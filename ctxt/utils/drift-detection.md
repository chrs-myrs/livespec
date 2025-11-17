# Drift Detection Utility

⚠️ **Generated file** - Do not edit directly. Regenerate using `.livespec/prompts/utils/regenerate-contexts.md`

## Summary

Drift detection identifies when specifications and reality have diverged. This utility runs continuously (weekly, before releases) to catch spec-code misalignment early, preventing documentation rot.

## When to Use

**Run drift detection:**
- **Weekly** (minimum recommended frequency)
- **Before releases** (mandatory validation)
- **After major changes** (ad-hoc verification)
- **Continuous** (ideal with CI/CD integration)

**Signs drift may exist:**
- Code changes without spec updates
- Specs without implementations
- Behaviors changed without documentation
- Architecture diverged from strategy

## Workflow

### Step 1: Detect Drift

**Prompt:** `.livespec/4-evolve/4a-detect-drift.md`

**Detects three types of drift:**

#### 1. Code-Spec Misalignment

**Implementations without specs:**
```
Found: src/api/new-endpoint.py
Missing: specs/3-behaviors/new-endpoint.spec.md OR
         specs/3-contracts/api/v1/new-endpoint.spec.md

Action: Extract spec using 4b-extract-specs.md
```

**Specs without implementations:**
```
Found: specs/3-behaviors/obsolete-feature.spec.md
Missing: Implementation (deleted but spec remains)

Action: Delete spec: git rm specs/3-behaviors/obsolete-feature.spec.md
```

**Behaviors changed without spec updates:**
```
Found: src/auth/oauth.py (authentication flow changed)
Outdated: specs/3-behaviors/authentication.spec.md (describes old flow)

Action: Update spec to match implementation
```

#### 2. Structural Drift

**Files moved without updating cross-references:**
```
Moved: prompts/0a-quick-start.md → prompts/0-define/0a-quick-start.md
Broken: specs/3-behaviors/prompts/0a-quick-start.spec.md
        (specifies: prompts/0a-quick-start.md - wrong path)

Action: Update spec frontmatter with new path
```

**Dependencies changed without frontmatter updates:**
```
Changed: specs/2-strategy/architecture.spec.md (new approach)
Outdated: specs/3-behaviors/user-auth.spec.md
          (guided-by: old architecture, doesn't exist)

Action: Update frontmatter dependencies
```

**Generated files edited directly:**
```
Edited: AGENTS.md (modified by hand)
Source: specs/workspace/*.spec.md (not regenerated)

Action: Revert manual edits, regenerate from source
```

#### 3. Requirements Drift

**Success criteria no longer met:**
```
PURPOSE.md: "API response time <200ms"
Reality: Average response time 450ms

Action: Either optimize (meet requirement) or update PURPOSE.md (if requirement wrong)
```

**Constraints violated:**
```
Constraint: "Must use OAuth 2.0"
Reality: Using custom authentication (OAuth removed)

Action: Either revert to OAuth or update constraint spec (if intentional change)
```

**Architecture diverged from strategy:**
```
Strategy: "Microservices architecture"
Reality: Monolithic deployment

Action: Update strategy spec or fix architecture
```

### Step 2: Generate Drift Report

**Drift report format:**

```markdown
# Drift Detection Report

**Date:** 2025-11-10
**Project:** livespec
**Status:** 3 issues found

## Code-Spec Misalignment (2 issues)

### ❌ CRITICAL: Implementation without spec
- **File:** src/api/payments.py
- **Missing:** specs/3-behaviors/payment-processing.spec.md
- **Action:** Extract spec using 4b-extract-specs.md
- **Impact:** New feature undocumented

### ⚠️ IMPORTANT: Spec without implementation
- **File:** specs/3-behaviors/old-feature.spec.md
- **Missing:** Implementation (removed in commit abc123)
- **Action:** Delete obsolete spec
- **Impact:** Misleading documentation

## Structural Drift (1 issue)

### ⚠️ Broken cross-reference
- **File:** specs/3-behaviors/authentication.spec.md
- **Issue:** References specs/2-strategy/old-arch.spec.md (doesn't exist)
- **Action:** Update frontmatter to reference current architecture
- **Impact:** Broken traceability

## Requirements Drift (0 issues)

✅ All requirements met
✅ All constraints respected
✅ Architecture aligned with strategy

## Remediation Plan

1. Extract payment spec (Priority: CRITICAL)
2. Delete obsolete feature spec (Priority: IMPORTANT)
3. Fix broken cross-reference (Priority: IMPORTANT)

**Estimated time:** 30 minutes
```

### Step 3: Remediate Drift

**For each issue, follow remediation action:**

**Code without spec:**
```bash
Use .livespec/4-evolve/4b-extract-specs.md
# Extracts spec from implementation
# Mark with confidence: LOW (requires validation)
```

**Spec without code:**
```bash
# Verify spec truly obsolete (check git history)
git log --all --full-history -- specs/3-behaviors/obsolete.spec.md

# Delete if confirmed
git rm specs/3-behaviors/obsolete.spec.md
git commit -m "Remove obsolete spec (feature removed in abc123)"
```

**Behavior changed:**
```bash
# Update spec to match current implementation
Use .livespec/1-design/1c-define-behaviors.md
# Review implementation
# Update spec requirements to match reality
```

**Broken cross-reference:**
```bash
# Update frontmatter in spec
# Change: guided-by: specs/2-strategy/old-arch.spec.md
# To: guided-by: specs/2-strategy/current-arch.spec.md
```

**Generated file edited:**
```bash
# Revert manual edits
git checkout HEAD -- AGENTS.md

# Regenerate from source
Use .livespec/4-evolve/4d-regenerate-context.md

# Commit regenerated version
```

### Step 4: Confirm Synchronization

**Prompt:** `.livespec/4-evolve/4c-sync-complete.md`

**Confirms:**
- All drift issues resolved
- All extractions validated
- All cross-references updated
- System ready for next iteration

**Outputs:**
```markdown
# Synchronization Complete

**Before:**
- 2 code-spec misalignments
- 1 structural drift issue
- 0 requirements drift

**After:**
- ✅ All specs documented
- ✅ All cross-references valid
- ✅ All requirements met

**Actions taken:**
1. Extracted payment spec (validated)
2. Deleted obsolete feature spec
3. Fixed authentication cross-reference

**Status:** SYNCHRONIZED
**Next check:** 2025-11-17 (weekly)
```

## Drift Detection Patterns

### Automated CI/CD Pattern

```yaml
# .github/workflows/drift-detection.yml

on:
  schedule:
    - cron: '0 0 * * 1'  # Every Monday
  workflow_dispatch:  # Manual trigger

jobs:
  detect-drift:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Detect drift
        run: bash scripts/detect-drift.sh

      - name: Create issue if drift found
        if: failure()
        run: |
          gh issue create \
            --title "Spec drift detected" \
            --body-file drift-report.md \
            --label "drift"
```

### Pre-Release Validation Pattern

```bash
# Before every release

# Step 1: Detect drift
Use .livespec/4-evolve/4a-detect-drift.md

# Step 2: Zero drift required for release
# ✅ All drift resolved → Proceed with release
# ❌ Drift exists → Fix before release

# Step 3: Confirm synchronization
Use .livespec/4-evolve/4c-sync-complete.md

# Step 4: Tag release only if synchronized
```

### Weekly Maintenance Pattern

```bash
# Every Monday morning

# Step 1: Run drift detection
Use .livespec/4-evolve/4a-detect-drift.md

# Step 2: Review report
# - CRITICAL issues: Fix immediately
# - IMPORTANT issues: Fix this week
# - MINOR issues: Backlog

# Step 3: Remediate (spread throughout week)
# Monday: CRITICAL
# Tuesday-Thursday: IMPORTANT
# Friday: MINOR

# Step 4: Confirm sync before weekend
Use .livespec/4-evolve/4c-sync-complete.md
```

## Common Drift Scenarios

### Scenario 1: Rapid Feature Development

**Symptom:** Multiple implementations without specs

**Cause:** Fast-paced development, skipped spec-first

**Remediation:**
```bash
# Extract all missing specs
Use .livespec/4-evolve/4b-extract-specs.md

# Mark all as LOW confidence
# Validate critical specs first
Use .livespec/4-evolve/4e-validate-extractions.md

# Team retrospective: Why did we skip specs?
# Strengthen spec-first enforcement
```

### Scenario 2: Architecture Refactoring

**Symptom:** Implementation diverged from strategy specs

**Cause:** Large refactor changed approach without updating strategy

**Remediation:**
```bash
# Option A: Architecture change was correct
# Update strategy specs to match new approach
Use .livespec/1-design/1b-design-architecture.md

# Option B: Architecture drift was accidental
# Revert code to match strategy
# Or: Update strategy with explicit rationale

# Document decision either way
```

### Scenario 3: Feature Deprecation

**Symptom:** Specs without implementations

**Cause:** Features removed but specs not deleted

**Remediation:**
```bash
# Verify feature truly removed
git log --all -- path/to/implementation

# Delete obsolete specs
git rm specs/3-behaviors/old-feature.spec.md

# Update cross-references
# Remove references from other specs
```

## Examples

### Example 1: Clean Project (No Drift)

```bash
Use .livespec/4-evolve/4a-detect-drift.md

# Drift Detection Report
# Date: 2025-11-10
# Project: livespec
# Status: ✅ No drift detected

# Code-Spec Alignment: ✅ All implementations documented
# Structural Integrity: ✅ All cross-references valid
# Requirements Compliance: ✅ All requirements met

# Next check: 2025-11-17 (weekly)
```

### Example 2: Drift Detected and Fixed

```bash
# Monday: Detect drift
Use .livespec/4-evolve/4a-detect-drift.md

# Report:
# ❌ 2 implementations without specs
# ⚠️ 1 obsolete spec
# ⚠️ 3 broken cross-references

# Monday afternoon: Extract specs
Use .livespec/4-evolve/4b-extract-specs.md
# Creates: specs/3-behaviors/new-feature-1.spec.md (LOW confidence)
#         specs/3-behaviors/new-feature-2.spec.md (LOW confidence)

# Tuesday: Validate extractions
Use .livespec/4-evolve/4e-validate-extractions.md
# Reviews: Both specs, promotes to VALIDATED

# Wednesday: Delete obsolete spec
git rm specs/3-behaviors/old-feature.spec.md

# Thursday: Fix cross-references
# Update 3 specs with correct frontmatter

# Friday: Confirm synchronization
Use .livespec/4-evolve/4c-sync-complete.md
# ✅ All drift resolved
# Status: SYNCHRONIZED
```

## Reference Library

**For detailed guidance:**
- Parent: AGENTS.md (root context)
- Phase 4: ctxt/phases/4-evolve.md (full evolution methodology)
- Prompt: `.livespec/4-evolve/4a-detect-drift.md` (detailed detection)
- Scripts: `scripts/detect-drift.sh` (automated detection)

**Cross-references:**
- Phase 1 (DESIGN): Where specs are created
- Phase 2 (BUILD): Where implementations happen
- Workflows: specs/workspace/workflows.spec.md (drift workflow)

---

*Drift detection specialist for LiveSpec*
*Parent: AGENTS.md*
