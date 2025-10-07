---
spec: specs/behaviors/prompts/3a-run-validation.spec.md
---

# 3a: Run Validation

**Phase**: VERIFY
**Purpose**: Validate all specifications are satisfied
**Prerequisites**: Phase 2 complete (implementation and tests exist)

## Task

Run comprehensive validation to ensure the system meets all specifications.

## Validation Checklist

### 1. Run All Tests

Execute the complete test suite:
```bash
# Run all tests
pytest tests/              # Python
npm test                   # JavaScript
cargo test                 # Rust
# etc.
```

**Success Criteria:**
- ✅ All tests pass
- ✅ No failing tests
- ✅ No skipped CRITICAL behavior tests

### 2. Validate Behaviors

For each specification in `specs/behaviors/`, verify:

```markdown
# specs/behaviors/user-authentication.md
**Validation:**
- Valid credentials allow login ✓
- Invalid credentials are rejected ✓
- Session persists after login ✓
```

Create validation report:
```markdown
# Behavior Validation Report

## user-authentication.md
- ✅ Valid credentials allow login
- ✅ Invalid credentials rejected
- ✅ Session persists

## data-export.md
- ✅ CSV export works
- ⚠️ PDF export slow (>5s) - see issue #42
```

### 3. Validate Contracts

Run contract validation tools:

**For OpenAPI specs:**
```bash
# Check for breaking changes
oasdiff breaking specs/contracts/api/v1.yaml specs/contracts/api/v2.yaml

# Validate implementation matches spec
dredd specs/contracts/api/users-api.yaml http://localhost:3000
```

**For JSON Schema:**
```bash
# Validate test data
ajv validate -s specs/contracts/data/user.json -d tests/fixtures/users/*.json
```

**For AsyncAPI:**
```bash
# Validate event formats
asyncapi validate specs/contracts/events/user-events.yaml
```

### 4. Verify Constraints

Check all constraints from `specs/constraints.md`:

```markdown
# specs/constraints.md

## Performance Constraint
**Specification**: API must respond within 200ms for 95th percentile
**Validation**: Run load tests

## Compatibility Constraint
**Specification**: Must work on Python 3.9+
**Validation**: Test on Python 3.9, 3.10, 3.11
```

Create constraint validation report:
```markdown
# Constraint Validation Report

## Performance
- ✅ API p95 response time: 187ms

## Compatibility
- ✅ Python 3.9: All tests pass
- ✅ Python 3.10: All tests pass
- ✅ Python 3.11: All tests pass
```

## Validation Report

Create `var/validation-report.md`:

```markdown
# Validation Report

**Date**: 2025-01-10
**Phase**: VERIFY
**Status**: ✅ PASS | ⚠️ PASS WITH WARNINGS | ❌ FAIL

## Summary
- Total behaviors: 12
- Behaviors passing: 11
- Behaviors with warnings: 1
- Behaviors failing: 0

## Critical Behaviors
✅ All 8 CRITICAL behaviors validated

## Contracts
✅ All contracts validated
- No breaking changes detected
- All implementations match specs

## Constraints
✅ All constraints satisfied
- Performance: 187ms (target: <200ms)
- Compatibility: Python 3.9-3.11 ✓

## Issues
- ⚠️ data-export.md: PDF export slower than expected (#42)

## Conclusion
System ready for deployment with minor optimization recommended.
```

## Exit Criteria

- [ ] All tests passing
- [ ] All CRITICAL behaviors validated
- [ ] All contracts verified
- [ ] All constraints satisfied
- [ ] Validation report created
- [ ] Any issues documented

## Next Step

Once validation is complete, proceed to `3b-acceptance-review.md`
