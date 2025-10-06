---
spec: specs/prompts/4e-validate-extractions.spec.md
---

# 4e: Validate Extracted Specifications

**Phase**: EVOLVE
**Purpose**: Review and promote extracted specs from EXTRACTED to VALIDATED status
**Context**: After Phase 4b extraction, low/medium confidence specs require human validation

## Task

Review extracted specifications marked with confidence metadata, validate correctness, and promote to standard specs by removing extraction markers.

## When to Validate

Validate extracted specs when:
- **Spec has `confidence: LOW` or `MEDIUM` frontmatter**
- **Spec contains `[?]` validation markers**
- **Spec has `⚠️` EXTRACTION NOTES warning**
- **Spec has `requires_validation: true`**
- **Before merging extracted specs to main branch**

## Validation Process

### 1. Find Specs Needing Validation

```bash
# Find all specs with extraction metadata
grep -r "confidence: LOW\|confidence: MEDIUM" specs/
grep -r "requires_validation: true" specs/
grep -r "⚠️ \*\*EXTRACTION NOTES\*\*" specs/
```

### 2. Review Each Extracted Spec

For each spec requiring validation:

**Read the spec carefully:**
- Understand what behavior it describes
- Note the extraction source files
- Review the extraction reasoning
- Check the review checklist items

**Verify against source code:**
```bash
# Read the source files listed in extracted_from
cat src/auth/oauth.py
cat src/auth/session.py

# Check for tests
find tests/ -name "*auth*" -o -name "*oauth*"

# Review git history for context
git log --follow src/auth/oauth.py
```

**Assess the extraction:**
- **Accurate**: Does the spec correctly describe the implementation?
- **Complete**: Are all critical behaviors captured?
- **Minimal**: Is it MSL-compliant (WHAT not HOW)?
- **Testable**: Are validation criteria verifiable?

### 3. Make Validation Decision

Three possible outcomes:

#### A. PROMOTE (Extraction was accurate)

**If the spec is correct as extracted:**

1. Remove extraction frontmatter:
```yaml
# DELETE these lines:
extracted_from: [...]
extracted_date: 2025-10-06
confidence: LOW
requires_validation: true
extraction_reason: "..."
```

2. Add standard frontmatter:
```yaml
# ADD standard dependencies:
derives_from:
  - specs/strategy/architecture.spec.md
satisfies:
  - specs/requirements.spec.md
```

3. Remove confidence markers:
```markdown
# BEFORE:
⚠️ **EXTRACTION NOTES**: Inferred from implementation...

## Validation
**Status**: EXTRACTED - Requires human review
- [?] Sessions expire after 24 hours

# AFTER:
## Validation
- Sessions expire after 24 hours
```

4. Update criticality if needed (remove "estimated" qualifier)

#### B. CORRECT (Extraction had errors)

**If the spec needs corrections:**

1. Fix incorrect specifications
2. Add missing behaviors
3. Remove over-specifications
4. Adjust criticality if wrong
5. **Then follow PROMOTE steps** to remove markers

**Document corrections:**
```bash
git add specs/behaviors/authentication.spec.md
git commit -m "Validate and correct authentication spec

Corrections made:
- Session timeout is 1 hour not 24 hours (verified in config)
- Added missing OAuth provider validation
- Removed implementation detail about JWT structure

Promoted from EXTRACTED to VALIDATED."
```

#### C. REJECT (Extraction was invalid)

**If the spec should not exist:**

1. Delete the spec file
2. Document why in commit message

**Reasons to reject:**
- Behavior is implementation detail, not requirement
- Feature is deprecated or unused
- Duplicate of existing spec
- Not actually implemented (extraction hallucination)

### 4. Add Test Coverage (If Missing)

If extraction notes mention "no tests found":

**Create tests for validated behaviors:**
```python
# tests/test_auth.py
def test_session_expires_after_timeout():
    """Sessions expire after configured timeout"""
    # Test the validated behavior
    ...
```

**Link spec to tests:**
- Add test file path to spec frontmatter if using formal linking
- Or ensure test names match validation criteria

### 5. Update Dependencies

After validation, ensure spec properly declares:

```yaml
---
derives_from:
  - specs/strategy/architecture.spec.md  # Where design decision lives
satisfies:
  - specs/requirements.spec.md  # Which requirement this fulfills
constrained_by:
  - specs/constraints.spec.md  # Boundaries it must respect
---
```

## Validation Checklist

For each extracted spec, verify:

**Content Accuracy**
- [ ] Spec correctly describes implemented behavior
- [ ] All critical behaviors captured
- [ ] No hallucinated/incorrect requirements
- [ ] Criticality level appropriate

**MSL Compliance**
- [ ] Describes WHAT not HOW
- [ ] No implementation details
- [ ] Validation criteria testable
- [ ] Spec is minimal (remove unnecessary detail)

**Dependencies**
- [ ] `derives_from` points to parent specs
- [ ] `satisfies` links to requirements (if applicable)
- [ ] `constrained_by` references constraints (if applicable)

**Test Coverage**
- [ ] Validation criteria have corresponding tests
- [ ] Missing tests created or tracked
- [ ] Test names align with validation bullets

**Documentation**
- [ ] Extraction markers removed
- [ ] Standard frontmatter added
- [ ] Review checklist items addressed

## Batch Validation Workflow

When validating multiple specs:

### 1. Prioritize by Criticality

```bash
# Validate CRITICAL specs first
grep -l "Criticality\*\*: CRITICAL" specs/**/*.spec.md | \
  xargs grep -l "requires_validation: true"

# Then IMPORTANT specs
grep -l "Criticality\*\*: IMPORTANT" specs/**/*.spec.md | \
  xargs grep -l "requires_validation: true"
```

### 2. Group by Domain

Validate related specs together for efficiency:
- All auth specs together
- All API specs together
- All data specs together

### 3. Track Progress

Create validation tracking issue or checklist:
```markdown
## Extracted Specs Validation

**CRITICAL (validate first)**
- [ ] specs/behaviors/authentication.spec.md
- [ ] specs/behaviors/authorization.spec.md

**IMPORTANT**
- [ ] specs/behaviors/password-reset.spec.md
- [ ] specs/contracts/auth-api.yaml
```

## Exit Criteria

- [ ] All `confidence: LOW/MEDIUM` specs reviewed
- [ ] Corrections made where needed
- [ ] Extraction frontmatter removed from promoted specs
- [ ] Standard frontmatter added (derives_from, satisfies)
- [ ] `[?]` markers removed from validation criteria
- [ ] `⚠️` EXTRACTION NOTES removed
- [ ] Test coverage added for previously untested behaviors
- [ ] Invalid extractions deleted with reasoning documented

## Next Step

Once validation complete, proceed to `4c-sync-complete.md` to finalize synchronization.

## Tips

**Efficient Validation:**
- Use IDE diff view to compare before/after
- Batch similar specs for context efficiency
- Consult domain experts for ambiguous cases
- Add tests while context is fresh

**Common Issues:**
- **Over-specification**: Extract described HOW not WHAT → simplify
- **Inferred criticality wrong**: Re-assess based on actual impact
- **Missing context**: Extraction couldn't determine edge cases → add from knowledge
- **Test gaps**: No tests found → create them during validation

**Red Flags:**
- Spec describes internal implementation, not user-facing behavior
- Validation criteria mention code structure (classes, functions)
- Criticality seems arbitrary or inconsistent
- Spec duplicates existing documented behavior
