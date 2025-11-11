# Phase 3: VERIFY

⚠️ **Generated file** - Do not edit directly. Regenerate using `.livespec/prompts/utils/regenerate-contexts.md`

## Summary

Phase 3 validates the solution meets all requirements through comprehensive testing and stakeholder acceptance. This phase ensures implementation matches specifications before release or deployment.

## When to Use This Phase

**Entry conditions:**
- Phase 2 complete (implementation done, all tests passing)
- Code ready for validation
- Ready for stakeholder review

**Exit conditions:**
- All validation tests pass
- Stakeholders approve (acceptance review complete)
- No critical issues remaining
- Ready for deployment or next iteration

## Phase Workflow

### Step 1: Run Validation

**Prompt:** `.livespec/3-verify/3a-run-validation.md`

**Validates:**

1. **Spec-code alignment:**
   - Every behavior spec has implementation
   - Every contract spec has tests
   - No orphaned implementations (code without specs)

2. **Test coverage:**
   - All CRITICAL requirements tested (100% coverage required)
   - All IMPORTANT requirements tested (recommended)
   - Edge cases from specs covered

3. **Failure modes prevented:**
   - Each spec's `failure_mode` has prevention test
   - System fails safely when expected
   - Error messages match contract specs

4. **Cross-reference integrity:**
   - All frontmatter references valid
   - Spec dependencies resolved
   - No broken links in documentation

**Outputs:**
- Validation report (what passed, what failed)
- Coverage gaps (missing tests)
- Action items (what needs fixing)

### Step 2: Acceptance Review

**Prompt:** `.livespec/3-verify/3b-acceptance-review.md`

**Reviews:**

1. **Functional requirements:**
   - Does system do what specs say?
   - Are success criteria from PURPOSE.md met?
   - Do behaviors match expectations?

2. **Quality requirements:**
   - Performance acceptable?
   - Security requirements met?
   - Usability satisfactory?

3. **Stakeholder approval:**
   - Product owner accepts features
   - Technical lead approves architecture
   - QA team signs off on testing

**Outputs:**
- Acceptance decision (approved/changes required)
- Issue list (what needs fixing before approval)
- Sign-offs (who approved, when)

## Key Prompts

| Prompt | When to Use | Output |
|--------|-------------|--------|
| 3a-run-validation.md | After implementation complete | Validation report, coverage gaps |
| 3b-acceptance-review.md | Before release/deployment | Acceptance decision, issue list |

## Common Patterns

### Automated Validation Pattern

**Run full validation suite:**

```bash
# Run validation prompt
Use .livespec/3-verify/3a-run-validation.md

# Executes:
# 1. Test suite (pytest, jest, etc.)
# 2. Coverage analysis
# 3. Linting/static analysis
# 4. Spec-code alignment checks
# 5. Cross-reference validation

# Review report:
# ✅ All tests pass (120/120)
# ✅ Coverage: 95% (target: 90%)
# ⚠️ 2 specs without tests
# ❌ 3 broken cross-references

# Fix issues and re-run
```

### Manual Acceptance Pattern

**Stakeholder walkthrough:**

```bash
# Prepare acceptance review
Use .livespec/3-verify/3b-acceptance-review.md

# Review with stakeholders:
# 1. Demonstrate each behavior from specs/3-behaviors/
# 2. Verify success criteria from PURPOSE.md
# 3. Test edge cases together
# 4. Collect feedback

# Document outcomes:
# ✅ Feature A approved (meets requirements)
# ⚠️ Feature B needs minor UI tweaks
# ❌ Feature C rejected (wrong behavior)

# Create action items for feedback
```

### Continuous Verification Pattern

**Validation in CI/CD pipeline:**

```yaml
# .github/workflows/verify.yml

on: [push, pull_request]

jobs:
  verify:
    steps:
      - name: Run tests
        run: pytest --cov=src tests/

      - name: Check spec-code alignment
        run: bash scripts/validate-project.sh

      - name: Validate coverage
        run: bash scripts/check-coverage.sh 90

      # Block merge if validation fails
```

## Validation Checklist

**Before marking Phase 3 complete:**

- [ ] All automated tests pass
- [ ] Code coverage meets threshold (typically 80-90%)
- [ ] All CRITICAL spec requirements tested
- [ ] Failure modes from specs prevented
- [ ] Cross-references validated (no broken links)
- [ ] Specs match implementation (no drift)
- [ ] Stakeholder acceptance obtained
- [ ] Critical issues resolved
- [ ] Documentation updated (if needed)
- [ ] Ready for deployment

## Examples

### Example 1: REST API Validation

```bash
# Step 1: Run automated validation
Use .livespec/3-verify/3a-run-validation.md

# Checks:
# ✅ All endpoint tests pass (45/45)
# ✅ Contract specs match OpenAPI schema
# ✅ Authentication behaviors validated
# ✅ Error handling tested
# ✅ Rate limiting works

# Step 2: Acceptance review
Use .livespec/3-verify/3b-acceptance-review.md

# Stakeholder review:
# - Product owner: ✅ All user stories met
# - Tech lead: ✅ Architecture follows design
# - Security: ✅ Authentication robust
# - QA: ✅ All test scenarios pass

# Result: APPROVED for production
```

### Example 2: Complex Feature with Issues

```bash
# Step 1: Run validation (first attempt)
Use .livespec/3-verify/3a-run-validation.md

# Results:
# ✅ 95% tests pass (190/200)
# ❌ 10 tests failing (payment edge cases)
# ⚠️ Coverage: 75% (target: 90%)
# ❌ 2 specs without implementations

# Action: Fix issues, return to Phase 2 (BUILD)

# Step 2: Run validation (second attempt)
Use .livespec/3-verify/3a-run-validation.md

# Results:
# ✅ All tests pass (200/200)
# ✅ Coverage: 92%
# ✅ All specs implemented

# Step 3: Acceptance review
Use .livespec/3-verify/3b-acceptance-review.md

# Stakeholder feedback:
# ✅ Core functionality approved
# ⚠️ UI needs polish (minor)
# ⚠️ Error messages unclear (minor)

# Action: Create follow-up issues, approve for release
```

## Decision Points

**Do validation issues block release?**
- CRITICAL issues: YES (must fix before release)
- IMPORTANT issues: Usually (unless documented exception)
- MINOR issues: NO (can fix in next iteration)

**Who approves in acceptance review?**
- Minimum: Product owner (functional requirements met)
- Recommended: Product owner + Tech lead + QA
- Complex: Add security team, operations team

**When to return to Phase 2?**
- Validation failures (spec-code misalignment)
- Test failures (behaviors don't work)
- Major stakeholder rejections (wrong solution)

**When to proceed to deployment?**
- All validation passes
- Stakeholders approve
- No critical issues
- Team confident in release

## Integration with Other Phases

**Phase 2 → Phase 3:**
- Implementation complete, tests pass → Run validation
- Validation finds issues → Return to Phase 2

**Phase 3 → Phase 4:**
- After deployment → Monitor for drift
- Periodic validation to detect spec-code divergence

**Phase 3 → Phase 1:**
- Stakeholder rejection → Redesign (return to Phase 1)
- Wrong requirements → Update specs, re-implement

## Reference Library

**For detailed guidance:**
- Parent: AGENTS.md (root context)
- Prompts: `.livespec/3-verify/*.md` (full prompt text)
- Validation scripts: `scripts/validate-project.sh`
- Coverage tools: Language-specific (pytest-cov, istanbul, etc.)

**Cross-references:**
- Phase 2 (BUILD): Where implementation happens
- Phase 4 (EVOLVE): Where ongoing validation happens
- Workflows: specs/workspace/workflows.spec.md (validation workflow)

---

*Phase 3 specialist for LiveSpec*
*Parent: AGENTS.md*
