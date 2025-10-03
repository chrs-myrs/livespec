---
spec: specs/prompts/4a-detect-drift.spec.md
---

# 4a: Detect Drift

**Phase**: EVOLVE
**Purpose**: Detect when code and specifications have diverged
**Context**: See `specs/prompts/drift-detection.spec.md` for methodology

## Task

Identify semantic differences between specifications and implementation.

## When to Check for Drift

Run drift detection:
- **After code changes**: When implementation is modified
- **After spec changes**: When requirements are updated
- **Periodically**: Weekly or before releases
- **Before major work**: To ensure clean starting point

## Drift Detection Process

### 1. Identify Changes

**Since Last Check:**
```bash
# What code changed?
git log --since="last-check" --name-only src/

# What specs changed?
git log --since="last-check" --name-only specs/
```

**Focus Areas:**
- Files modified in implementation
- Related specification files
- Contract changes
- Test modifications

### 2. Semantic Analysis

For each changed area, use semantic understanding (not text diff):

**Tools to Consider:**
- **SemanticDiff**: Structural code comparison
- **oasdiff**: OpenAPI contract drift
- **Language-specific**: AST analyzers for your language

**Questions to Ask:**
- Did the behavior change or just the implementation?
- Are contracts still satisfied?
- Do tests still validate specs?
- Are there new behaviors not specified?

### 3. Classify Changes

Use the 70-80-10 pattern from `specs/behaviors/drift-detection.md`:

#### Auto-Accept (70-80%)
Changes that DON'T affect specs:
- ✅ Refactoring (same behavior, different code)
- ✅ Formatting and style changes
- ✅ Performance optimizations (behavior unchanged)
- ✅ Internal implementation improvements
- ✅ Non-breaking additions

#### Review Needed (10-20%)
Changes that MIGHT affect specs:
- ⚠️ Behavior modifications
- ⚠️ New features added
- ⚠️ Contract changes
- ⚠️ Performance characteristic changes
- ⚠️ Error handling changes

#### Manual Resolution (5-10%)
Changes requiring human decision:
- 🔴 Breaking changes
- 🔴 Conflicting requirements
- 🔴 Removed features
- 🔴 Ambiguous intent
- 🔴 Multi-spec impacts

## Create Drift Report

Document findings in `drift-report.md`:

```markdown
# Drift Detection Report

**Date**: 2025-01-10
**Since**: 2025-01-03
**Status**: ✅ CLEAN | ⚠️ MINOR DRIFT | 🔴 MAJOR DRIFT

## Changes Detected

### Auto-Accepted (No Spec Changes)
- Refactored authentication module (same behavior)
- Updated dependencies
- Fixed formatting issues

### Requiring Review
1. **New behavior: Password reset via email**
   - **Code**: Added password reset endpoint
   - **Spec**: No specification exists
   - **Action**: Extract new spec (4b-extract-specs.md)

2. **Modified behavior: CSV export includes timestamps**
   - **Code**: Added timestamp column to CSV export
   - **Spec**: specs/behaviors/data-export.md doesn't mention timestamps
   - **Action**: Update spec to include timestamp behavior

### Requiring Manual Resolution
1. **Conflicting change: API response format**
   - **Code**: Changed response from array to paginated object
   - **Spec**: specs/contracts/api/users-api.yaml specifies array
   - **Conflict**: Breaking change not documented
   - **Decision Needed**: Revert code or version API?

## Summary
- Auto-accepted: 15 changes
- Review needed: 2 changes
- Manual resolution: 1 change

## Next Steps
1. Extract spec for password reset (4b)
2. Update data-export spec for timestamps
3. Resolve API pagination conflict (stakeholder input)
```

## Decision Framework

When classifying changes, use three-way thinking:

**Base → Code → Spec:**
- **Base**: What was the original intent?
- **Code**: What does the implementation do now?
- **Spec**: What does the specification say?

**Resolution:**
- If code matches intent but spec unclear → Clarify spec
- If code diverged from intent → Fix code or update spec
- If both evolved independently → Merge or choose one

## Exit Criteria

- [ ] All code changes since last check reviewed
- [ ] All spec changes since last check reviewed
- [ ] Changes classified (auto-accept, review, manual)
- [ ] Drift report created
- [ ] Next actions identified

## Next Step

Once drift is detected and classified, proceed to:
- `4b-extract-specs.md` for new behaviors
- `4c-update-specs.md` for modified behaviors
