---
spec: specs/prompts/3b-acceptance-review.spec.md
---

# 3b: Acceptance Review

**Phase**: VERIFY
**Purpose**: Stakeholder review and acceptance
**Prerequisites**: Validation complete (3a-run-validation.md)

## Task

Present the system to stakeholders for acceptance review using specifications as the validation framework.

## Review Package

Prepare a review package with:

### 1. Problem Statement
From `specs/problem.md`:
- What problem does this solve?
- Who experiences this problem?
- How is success measured?

### 2. What Was Delivered
List all implemented behaviors from `specs/behaviors/`:
```markdown
## Delivered Behaviors

### Critical (Must Have)
- ✅ User authentication
- ✅ Data export to CSV
- ✅ API endpoints
- ...

### Important (Should Have)
- ✅ Dashboard visualization
- ⚠️ PDF export (slower than target)
- ...
```

### 3. Validation Results
Include validation report from 3a:
- Test results
- Contract compliance
- Constraint satisfaction

### 4. Known Issues
Document any warnings or issues:
```markdown
## Known Issues

### ⚠️ Warning: PDF Export Performance
- **Issue**: PDF export takes 5s (target: 2s)
- **Impact**: Slow user experience for large datasets
- **Recommendation**: Optimize in next iteration
- **Workaround**: Use CSV export for large datasets
```

## Review Questions

Ask stakeholders to validate:

### Problem Validation
- ✅ Does this solve the stated problem?
- ✅ Do users recognize value?
- ✅ Are success criteria met?

### Behavior Validation
- ✅ Do all CRITICAL behaviors work as specified?
- ✅ Are IMPORTANT behaviors acceptable?
- ✅ Are there missing critical behaviors?

### Constraint Validation
- ✅ Are all constraints satisfied?
- ✅ Are performance targets met?
- ✅ Are quality standards acceptable?

### Deployment Readiness
- ✅ Is this ready for production?
- ⚠️ Should warnings be addressed first?
- ❌ Are there blocking issues?

## Acceptance Criteria

**Full Acceptance (✅ GO):**
- All CRITICAL behaviors validated
- All constraints satisfied
- No blocking issues
- Stakeholders approve

**Conditional Acceptance (⚠️ GO WITH WARNINGS):**
- All CRITICAL behaviors work
- Some IMPORTANT behaviors have warnings
- No blocking issues
- Warnings documented for future work

**Rejection (❌ NO-GO):**
- CRITICAL behaviors failing
- Constraints violated
- Blocking issues exist
- Stakeholders not satisfied

## Document Decision

Record the acceptance decision:

```markdown
# Acceptance Decision

**Date**: 2025-01-10
**Reviewers**: [Names]
**Decision**: ✅ ACCEPTED | ⚠️ ACCEPTED WITH CONDITIONS | ❌ REJECTED

## Rationale
[Why this decision was made]

## Conditions (if applicable)
- [ ] Address PDF export performance in v1.1
- [ ] Monitor API response times in production

## Sign-off
- Stakeholder 1: ✅ Approved
- Stakeholder 2: ✅ Approved
```

## Exit Criteria

- [ ] Review package prepared
- [ ] Stakeholders reviewed the system
- [ ] All questions answered
- [ ] Acceptance decision documented
- [ ] Conditions documented (if any)

## Phase Complete

When acceptance is achieved:
- ✅ **Phase 3: VERIFY is complete**
- → Proceed to **Phase 4: EVOLVE** (`prompts/4-evolve/`)

OR if changes needed:
- ← Return to **Phase 2: BUILD** to address issues
