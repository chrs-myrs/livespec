# Phase 4: EVOLVE

⚠️ **Generated file** - Do not edit directly. Regenerate using `.livespec/prompts/utils/regenerate-contexts.md`

## Summary

Phase 4 keeps specifications synchronized with reality through continuous evolution. This is the only phase that runs continuously—detecting drift, extracting new behaviors, and updating specs as code evolves.

## When to Use This Phase

**Entry conditions:**
- System in production OR active development
- Specs and code exist (can drift)
- Ongoing maintenance and feature development

**Exit conditions:**
- NEVER (continuous phase)
- Loops back to Phases 1-2-3 as needed for changes

**Frequency:**
- Weekly (recommended minimum)
- Before releases (mandatory)
- After major changes (ad-hoc)
- Continuous (ideal with CI/CD integration)

## Phase Workflow

### Step 1: Detect Drift

**Prompt:** `.livespec/4-evolve/4a-detect-drift.md`

**Detects:**

1. **Code-spec misalignment:**
   - Implementations without specs (new code, no documentation)
   - Specs without implementations (obsolete specs)
   - Behaviors changed without updating specs

2. **Structural drift:**
   - Files moved without updating cross-references
   - Dependencies changed without frontmatter updates
   - Generated files edited directly (bypassing sources)

3. **Requirements drift:**
   - Success criteria in PURPOSE.md no longer met
   - Constraints violated (specs/1-requirements/strategic/constraints.spec.md)
   - Architecture diverged from strategy specs

**Outputs:**
- Drift report (what's out of sync)
- Severity ratings (CRITICAL/IMPORTANT/MINOR)
- Remediation plan (what to do)

### Step 2: Extract Specifications

**Prompt:** `.livespec/4-evolve/4b-extract-specs.md`

**Use when:**
- Existing codebase without specs (initial documentation)
- New behaviors emerged in code (extract and formalize)
- Implementations added without specs (retroactive documentation)

**Extracts:**

1. **Behaviors from code:**
   - Analyze implementations
   - Infer observable outcomes
   - Document in specs/3-behaviors/

2. **Contracts from code:**
   - Extract API endpoints
   - Document data schemas
   - Capture in specs/3-contracts/

3. **Confidence markers:**
   ```yaml
   ---
   extracted_from:
     - src/auth/oauth.py
   extracted_date: 2025-10-06
   confidence: LOW
   requires_validation: true
   extraction_reason: "Inferred from code, no tests found"
   ---
   ```

**Outputs:**
- Extracted specs (with confidence markers)
- Validation queue (specs needing human review)
- Coverage report (what's documented vs what exists)

### Step 3: Validate Extractions

**Prompt:** `.livespec/4-evolve/4e-validate-extractions.md`

**Reviews:**
- Low-confidence extractions (manual verification)
- Inferred requirements (are they accurate?)
- Missing test coverage (add tests for extracted behaviors)

**Promotes:**
- EXTRACTED → REVIEWED → VALIDATED (remove confidence markers)
- Add proper frontmatter (satisfies, guided-by)
- Add validation criteria and failure modes

### Step 4: Synchronize

**Prompt:** `.livespec/4-evolve/4c-sync-complete.md`

**Confirms:**
- All drift resolved (code and specs aligned)
- All extractions validated (confidence markers removed)
- All cross-references updated (broken links fixed)
- System ready for next iteration

**Outputs:**
- Synchronization report (before/after)
- Updated specs (aligned with code)
- Updated code (aligned with specs)

### Step 5: Document Implementation

**Prompt:** `.livespec/4-evolve/4f-document-implementation.md`

**Use when:**
- Implementation complete but documentation missing
- Need to capture implementation details for maintenance
- Creating deployment guides, runbooks, or operational docs

**Creates:**
- Implementation documentation (how system works)
- Deployment guides (how to deploy)
- Operational runbooks (how to maintain)
- Developer guides (how to contribute)

**Note:** Separate from specs (specs define WHAT, docs describe HOW implementation works)

### Step 6: Regenerate Agent Contexts

**Prompt:** `.livespec/4-evolve/4d-regenerate-context.md`

**Use when:**
- Workspace specs changed (constitution, patterns, workflows)
- Major methodology updates
- Agent context drift detected

**Regenerates:**
- AGENTS.md (from workspace specs)
- ctxt/* sub-agents (phase/domain/utility specialists)
- Distribution files (dist/AGENTS.md)

**Outputs:**
- Updated agent contexts
- Context compression metrics
- Validation report

## Key Prompts

| Prompt | When to Use | Output |
|--------|-------------|--------|
| 4a-detect-drift.md | Weekly, before releases | Drift report, remediation plan |
| 4b-extract-specs.md | Existing codebase, new behaviors | Extracted specs (with confidence markers) |
| 4c-sync-complete.md | After fixing drift | Synchronization report |
| 4d-regenerate-context.md | Workspace specs changed | Updated AGENTS.md, ctxt/* |
| 4e-validate-extractions.md | Low-confidence specs | Promoted validated specs |
| 4f-document-implementation.md | Implementation docs needed | Deployment guides, runbooks |

## Common Patterns

### Weekly Drift Detection Pattern

**Continuous maintenance:**

```bash
# Every Monday (or sprint start)
Use .livespec/4-evolve/4a-detect-drift.md

# Review drift report:
# ⚠️ 3 implementations without specs
# ❌ 2 specs obsolete (no implementations)
# ✅ Architecture aligned

# Address issues:
# - Extract specs for new implementations
# - Delete obsolete specs
# - Update documentation

# Confirm sync:
Use .livespec/4-evolve/4c-sync-complete.md
```

### Initial Documentation Pattern

**Brownfield project (code exists, no specs):**

```bash
# Step 1: Extract everything
Use .livespec/4-evolve/4b-extract-specs.md

# Creates:
# - PURPOSE.md (inferred from README/code)
# - specs/3-behaviors/*.spec.md (extracted behaviors)
# - specs/3-contracts/*.spec.md (extracted APIs)
# All marked: confidence: LOW, requires_validation: true

# Step 2: Validate extractions
Use .livespec/4-evolve/4e-validate-extractions.md

# Review each extracted spec:
# - Confirm behaviors are accurate
# - Add missing validation criteria
# - Add tests for behaviors
# - Promote: EXTRACTED → VALIDATED

# Step 3: Customize workspace
# Edit specs/workspace/ for your team

# Step 4: Regenerate agents
Use .livespec/4-evolve/4d-regenerate-context.md

# Result: Fully documented codebase
```

### Pre-Release Validation Pattern

**Before every release:**

```bash
# Step 1: Detect drift
Use .livespec/4-evolve/4a-detect-drift.md

# Must be zero drift for release:
# ✅ All behaviors documented
# ✅ All specs implemented
# ✅ Cross-references valid

# Step 2: Confirm synchronization
Use .livespec/4-evolve/4c-sync-complete.md

# Step 3: Proceed to release (or fix drift first)
```

### Continuous Integration Pattern

**Automated drift detection:**

```yaml
# .github/workflows/drift-detection.yml

on:
  schedule:
    - cron: '0 0 * * 1'  # Every Monday
  workflow_dispatch:  # Manual trigger

jobs:
  detect-drift:
    steps:
      - name: Detect drift
        run: bash scripts/detect-drift.sh

      - name: Create issue if drift found
        if: drift_detected
        run: gh issue create --title "Spec drift detected" --body "$DRIFT_REPORT"
```

## Drift Remediation Strategies

**When drift detected:**

### Code without specs (new implementations):
1. Extract specs: `.livespec/4-evolve/4b-extract-specs.md`
2. Validate extractions: `.livespec/4-evolve/4e-validate-extractions.md`
3. Add tests if missing
4. Confirm sync

### Specs without code (obsolete specs):
1. Verify spec truly obsolete (check git history)
2. Delete spec: `git rm specs/3-behaviors/obsolete-feature.spec.md`
3. Remove references from other specs
4. Commit with explanation

### Behavior changed without updating spec:
1. Detect change (compare code vs spec)
2. Update spec to match code (Phase 1 prompts)
3. OR revert code to match spec (if spec was correct)
4. Confirm sync

### Architecture diverged from strategy:
1. Assess: Is architecture better now? (yes → update strategy spec)
2. Or: Is drift accidental? (yes → fix code to match strategy)
3. Document rationale for change
4. Update cross-references

## Examples

### Example 1: Weekly Maintenance

```bash
# Monday morning ritual
Use .livespec/4-evolve/4a-detect-drift.md

# Report:
# ⚠️ 2 new API endpoints (no contracts)
# ⚠️ 1 behavior spec needs update (authentication changed)
# ✅ Everything else aligned

# Fix endpoint docs:
Use .livespec/4-evolve/4b-extract-specs.md
# Extracts: specs/3-contracts/api/v1/new-endpoints.spec.md

# Update authentication spec:
Use .livespec/1-design/1c-define-behaviors.md
# Updates: specs/3-behaviors/authentication.spec.md

# Confirm sync:
Use .livespec/4-evolve/4c-sync-complete.md
# ✅ All drift resolved

# Commit changes
```

### Example 2: Documenting Existing Project

```bash
# Large codebase, no specs
Use .livespec/4-evolve/4b-extract-specs.md

# Extracts:
# - 45 behavior specs (LOW confidence)
# - 23 contract specs (MEDIUM confidence)
# - PURPOSE.md (inferred)

# Validate high-priority specs first:
Use .livespec/4-evolve/4e-validate-extractions.md

# Focus on:
# - CRITICAL behaviors (authentication, payments)
# - Public APIs (user-facing contracts)
# - Core domain logic

# Iterative validation:
# Week 1: Validate 10 critical specs
# Week 2: Validate 15 important specs
# Week 3: Validate remaining specs

# Result: Fully documented over 3 weeks
```

## Decision Points

**How often should I run drift detection?**
- Minimum: Weekly
- Recommended: Before every release
- Ideal: Continuous (CI/CD integration)

**Should I extract specs retroactively?**
- YES if: Existing codebase, no specs (brownfield)
- YES if: New behaviors emerged without specs
- NO if: Starting fresh (use Phase 0-1 instead)

**What confidence level requires validation?**
- LOW confidence: MUST validate (human review required)
- MEDIUM confidence: SHOULD validate (quick review)
- HIGH confidence: Optional (AI very confident)

**When to delete obsolete specs?**
- Confirm obsolete (check git history, ask team)
- No implementation exists (and shouldn't exist)
- Document deletion reason in commit message

## Reference Library

**For detailed guidance:**
- Parent: AGENTS.md (root context)
- Prompts: `.livespec/4-evolve/*.md` (full prompt text)
- Drift detection: `scripts/detect-drift.sh`
- Extraction patterns: `.livespec/standard/metaspecs/*.spec.md`

**Cross-references:**
- Phase 1 (DESIGN): Where specs are created
- Phase 2 (BUILD): Where implementations happen
- Phase 3 (VERIFY): Where validation happens
- Workflows: specs/workspace/workflows.spec.md (evolution workflow)

---

*Phase 4 specialist for LiveSpec*
*Parent: AGENTS.md*
