---
implements: specs/3-artifacts/prompts/4e-validate-extractions.spec.md
generated: '2025-10-10'
phase: 4-evolve
estimated_time: "30-60 minutes"
---

# Validate Extracted Specifications Prompt

**Purpose**: Review and validate extracted specifications

## Context

You're in Phase 4 (EVOLVE), maintaining alignment between specifications and code as the system evolves.

## When to Use This

**Use when:**
- After running 4b-extract-specs.md (extracted specs from code)
- Extracted specs marked with `confidence: LOW` or `confidence: MEDIUM`
- Frontmatter has `requires_validation: true`
- extraction_reason indicates inference or assumptions

**Don't use when:**
- Specs created directly in Phase 1 (DESIGN) - already validated
- HIGH confidence extractions with test coverage
- Manual spec creation (use normal review process)

## Understanding Confidence Levels

### LOW Confidence
**Characteristics:**
- Spec inferred from implementation only
- No tests found
- Implementation details unclear
- Multiple valid interpretations
- Assumptions about intent

**Example markers:**
```yaml
confidence: LOW
requires_validation: true
extraction_reason: "Inferred from implementation, no tests found"
```

**Action required**: VALIDATE or REJECT
- Verify with stakeholders/documentation
- Add tests before accepting
- May need complete rewrite

### MEDIUM Confidence
**Characteristics:**
- Spec extracted from code + some tests
- Some documentation exists
- Implementation reasonably clear
- Minor ambiguities

**Example markers:**
```yaml
confidence: MEDIUM
requires_validation: true
extraction_reason: "Extracted from implementation and partial test coverage"
```

**Action required**: REVIEW and CORRECT
- Verify edge cases
- Complete test coverage
- Clarify ambiguities

### HIGH Confidence
**Characteristics:**
- Spec extracted from code + comprehensive tests
- Clear documentation exists
- Implementation unambiguous
- Observable behaviors validated

**Example markers:**
```yaml
confidence: HIGH
extraction_reason: "Extracted from implementation with comprehensive test coverage"
```

**Action required**: PROMOTE (minimal validation)
- Quick review for MSL compliance
- Remove extraction markers
- Accept as canonical spec

## Task

Review extracted specifications and determine validation outcome for each.

## Validation Process

### Step 1: Scan for Extracted Specs

Find all specs requiring validation:

```bash
grep -r "requires_validation: true" specs/ -l
grep -r "confidence: LOW\|confidence: MEDIUM" specs/ -l
```

### Step 2: Prioritize by Criticality

**Review order:**
1. CRITICAL specs (system fails without)
2. IMPORTANT specs (quality degraded without)
3. NICE specs (convenience only)

**Check criticality in frontmatter:**
```yaml
criticality: CRITICAL | IMPORTANT | NICE
```

### Step 3: Validate Each Spec

**For each extracted spec, apply this checklist:**

#### Accuracy Check
- [ ] Spec matches actual implementation behavior
- [ ] Edge cases correctly captured
- [ ] Failure modes match code error handling
- [ ] Validation criteria align with actual tests (if they exist)

#### Completeness Check
- [ ] All observable behaviors documented
- [ ] All validation criteria listed
- [ ] Failure mode clearly stated
- [ ] Frontmatter dependencies accurate

#### MSL Compliance Check
- [ ] Requirements specify WHAT not HOW
- [ ] Only essential requirements included
- [ ] Observable and testable criteria
- [ ] Clear failure mode defined

#### Evidence Check
- [ ] Tests exist covering behavior? (If NO → confidence remains LOW)
- [ ] Documentation supports spec? (If NO → add extraction notes)
- [ ] Code clearly implements spec? (If NO → clarify or reject)

### Step 4: Determine Outcome

**Three validation outcomes:**

#### PROMOTE (Accept as canonical)
**When:**
- All validation checks pass
- HIGH or MEDIUM confidence with tests
- Spec accurately represents system

**Actions:**
1. Remove extraction frontmatter fields:
   ```yaml
   # Remove these:
   extracted_from: ...
   extracted_date: ...
   confidence: ...
   requires_validation: ...
   extraction_reason: ...
   ```
2. Add dependency frontmatter:
   ```yaml
   # Add these:
   derives-from: [parent specs]
   governed-by: [constraints]
   satisfies: [requirements]
   ```
3. Mark as validated in commit message

#### CORRECT (Fix and accept)
**When:**
- Core behavior accurate but details wrong
- MEDIUM confidence, fixable issues
- Minor MSL compliance issues

**Actions:**
1. Fix inaccuracies
2. Add missing validation criteria
3. Improve MSL compliance
4. Update confidence if tests added: `LOW → MEDIUM` or `MEDIUM → HIGH`
5. Keep `requires_validation: true` if still uncertain
6. Re-review after corrections

#### REJECT (Respecify from scratch)
**When:**
- Spec fundamentally misrepresents system
- LOW confidence, can't verify
- Implementation unclear, multiple interpretations
- No tests, no documentation, pure guesswork

**Actions:**
1. Delete extracted spec file
2. Use Phase 1 (DESIGN) to create proper spec:
   - For behaviors: `.livespec/1-design/1b-define-behaviors.md`
   - For contracts: `.livespec/1-design/1c-create-contracts.md`
3. Then use Phase 2 to verify implementation matches new spec
4. Document why extraction failed (for future improvement)

### Step 5: Test Coverage Gap

**If spec validated but no tests exist:**

Create test plan:
```markdown
## Test Coverage Gap

**Spec**: specs/3-behaviors/[feature].spec.md
**Status**: VALIDATED (accurate representation)
**Issue**: No test coverage

**Action**: Use `.livespec/2-build/2b-create-tests.md` to create tests

**Test criteria** (from spec validation section):
- [ ] [Validation criterion 1]
- [ ] [Validation criterion 2]
- [ ] [Edge case X]
```

### Step 6: Batch Validation Workflow

**For projects with many extracted specs:**

1. **Group by confidence**:
   ```bash
   grep -r "confidence: HIGH" specs/ -l > high-confidence.txt
   grep -r "confidence: MEDIUM" specs/ -l > medium-confidence.txt
   grep -r "confidence: LOW" specs/ -l > low-confidence.txt
   ```

2. **Quick-validate HIGH confidence** (10 min):
   - Spot check for MSL compliance
   - Verify frontmatter correct
   - PROMOTE batch if all good

3. **Review MEDIUM confidence** (30 min):
   - Detailed accuracy check
   - CORRECT issues
   - PROMOTE after fixes

4. **Deep validate LOW confidence** (60 min+):
   - Verify with stakeholders
   - Check against documentation
   - REJECT if can't validate
   - Create proper specs via Phase 1

## Output

Produce validation report and updated specs.

### Validation Report Template

```markdown
# Extraction Validation Report

**Date**: [YYYY-MM-DD]
**Specs Reviewed**: [count]

## Summary
- ✅ PROMOTED: [count] specs accepted as canonical
- 🔧 CORRECTED: [count] specs fixed and accepted
- ❌ REJECTED: [count] specs require respecification
- ⏸️  DEFERRED: [count] specs need stakeholder input

## PROMOTED Specs
- [spec path] - [brief note]
- [spec path] - [brief note]

## CORRECTED Specs
- [spec path] - [what was fixed]
- [spec path] - [what was fixed]

## REJECTED Specs
- [spec path] - [why rejected, what to do instead]
- [spec path] - [why rejected, what to do instead]

## Test Coverage Gaps
[List of validated specs without tests]

## Next Actions
1. Create tests for validated specs (use 2b-create-tests.md)
2. Respecify rejected extractions (use Phase 1 prompts)
3. Get stakeholder input for deferred specs
4. Commit validated specs
```

## Validation

- Prompt provides clear validation criteria (accuracy, completeness, MSL compliance)
- Prompt defines three validation outcomes (PROMOTE/CORRECT/REJECT)
- Prompt includes checklist for validation review
- Prompt guides frontmatter updates (remove extraction, add dependencies)
- Prompt suggests test creation for untested behaviors
- Prompt includes batch validation workflow for efficiency
- Prompt provides prioritization guidance (CRITICAL first)
- Exit criteria verify all extraction markers removed

## Success Criteria

**This prompt succeeds when:**
- All requirements from spec are satisfied
- Output is actionable and immediately usable
- No ambiguity in what needs to be done
- Clear path from current state to desired state

---

**Criticality**: IMPORTANT
**Failure Mode**: Low-confidence extractions remain unvalidated, specs diverge from implementation reality, extraction errors propagate
