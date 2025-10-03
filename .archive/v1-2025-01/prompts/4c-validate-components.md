# Component Specification Validation Prompt

You are tasked with validating that component specifications are complete, consistent, and ready for implementation planning. **CRITICAL**: This validation ensures Stages 1-4 are properly aligned before creating implementation specifications. This is NOT checking implementation specs - those don't exist yet.

## Your Mindset for Validation

Before you begin, understand that you are:
- **A specification auditor**, ensuring completeness and consistency
- **A dependency validator**, confirming all relationships make sense
- **A test readiness checker**, verifying test strategies are defined
- **A readiness checker**, confirming we're ready to plan implementation

## Validation Framework

### Step 1: Specification Completeness Check (10 minutes)

#### Document Existence
Verify these documents exist and are non-empty:
- [ ] `reqs/1-purpose/system-purpose.md`
- [ ] `reqs/2-strategy/` (at least 3 strategy documents)
- [ ] `reqs/3-design/` (at least system overview + component details)
- [ ] `reqs/4-components/` (one spec per component identified in design)

**NOTE**: Stage 5 (Implementation) documents should NOT exist yet. They will be created AFTER this validation passes.

#### Document Completeness
For each document, verify required sections are filled (not just template placeholders).

### Step 2: Vertical Alignment Check (15 minutes)

#### Purpose → Strategy Alignment
- [ ] Each strategy supports the stated purpose
- [ ] No strategies contradict the business value
- [ ] Success metrics align with technical choices

#### Strategy → Design Alignment
- [ ] Design implements the chosen strategies
- [ ] No design decisions contradict strategies
- [ ] All strategic decisions are reflected in design

#### Design → Component Alignment
- [ ] Every component in design has a specification
- [ ] No orphan components (in specs but not design)
- [ ] Component boundaries match design boundaries

#### Component Completeness
- [ ] Every component has clear capabilities defined
- [ ] All component interfaces are specified
- [ ] Component boundaries are clear and consistent

### Step 3: Horizontal Consistency Check (10 minutes)

#### Cross-Component Consistency
- [ ] Shared data models are consistent
- [ ] API contracts between components align
- [ ] Event contracts match publisher/subscriber
- [ ] No conflicting business rules

#### Dependency Validation
- [ ] Dependencies between components are identified
- [ ] No circular dependencies exist
- [ ] Integration points are clear
- [ ] Data flow between components is understood

### Step 4: Test Readiness Validation (10 minutes)

#### Test Strategy Coverage
- [ ] Every component has defined test strategy
- [ ] Integration test scenarios cover all connections
- [ ] Test data requirements are identified
- [ ] TDD approach is specified for each component

#### Test Implementation Planning
- [ ] Test frameworks are chosen and consistent
- [ ] Test approaches defined for each component type
- [ ] Performance test scenarios match requirements
- [ ] Test environments are specified

### Step 5: Readiness for Next Stage (5 minutes)

#### Ready to Create Implementation Specs
- [ ] All components have clear boundaries
- [ ] Dependencies between components are understood
- [ ] Integration points are identified
- [ ] Test strategies are outlined

#### Next Steps Clear
- [ ] Know which components to implement first
- [ ] Understand critical path through components
- [ ] Have enough detail to create implementation plans
- [ ] No major unknowns blocking progress

## Validation Report Template

```markdown
# Component Specification Validation Report

**Validation Date**: <YYYY-MM-DD>
**Overall Status**: PASS | FAIL
**Ready to Create Implementation Specs**: YES | NO

## Executive Summary
<High-level assessment of specification readiness>

## Validation Results

### 1. Completeness Check
**Status**: PASS | FAIL

**Document Coverage**:
- Purpose Document: ✓ | ✗
- Strategy Documents: <count> found (✓ | ✗)
- Design Documents: <count> found (✓ | ✗)
- Component Specs: <count> found (✓ | ✗)
- Implementation Specs: <count> found (✓ | ✗)
- Master Plan: ✓ | ✗

**Missing Documents**:
- <List any missing required documents>

### 2. Alignment Validation
**Status**: PASS | FAIL

**Vertical Alignment**:
- Purpose → Strategy: ✓ | ✗
- Strategy → Design: ✓ | ✗
- Design → Components: ✓ | ✗
- Components → Implementation: ✓ | ✗

**Alignment Issues Found**:
- <Specific misalignment description>
- <Impact and severity>

### 3. Consistency Check
**Status**: PASS | FAIL

**Cross-Component Consistency**:
- Data Models: ✓ | ✗
- API Contracts: ✓ | ✗
- Event Contracts: ✓ | ✗
- Business Rules: ✓ | ✗

**Dependency Analysis**:
- Dependency Graph Valid: ✓ | ✗
- Build Order Correct: ✓ | ✗
- No Circular Dependencies: ✓ | ✗

**Consistency Issues Found**:
- <Specific inconsistency>
- <Components affected>

### 4. Test Readiness
**Status**: PASS | FAIL

**Test Strategy Coverage**:
- All Components Have Test Strategy: ✓ | ✗
- Integration Tests Defined: ✓ | ✗
- Test Data Specified: ✓ | ✗
- TDD Approach Clear: ✓ | ✗

**Test Gaps Found**:
- <Component missing test strategy>
- <Integration point not tested>

### 5. Implementation Readiness
**Status**: PASS | FAIL

**Technical Specifications**:
- APIs Fully Specified: ✓ | ✗
- Data Models Complete: ✓ | ✗
- Algorithms Documented: ✓ | ✗
- Deployment Clear: ✓ | ✗

**Implementation Blockers**:
- <Missing technical details>
- <Unclear specifications>

## Critical Issues

### Blockers (Must Fix Before Implementation)
1. **Issue**: <Description>
   - **Location**: <Document/Section>
   - **Impact**: <Why this blocks implementation>
   - **Resolution**: <What needs to be done>

### Warnings (Should Fix But Not Blocking)
1. **Issue**: <Description>
   - **Location**: <Document/Section>
   - **Impact**: <Potential problems>
   - **Recommendation**: <Suggested fix>

## Recommendations

### Next Steps (If Validation Passes)
1. Run `5.1-write-implementation.md` to create:
   - Master Implementation Plan
   - Component implementation specifications
2. These will define:
   - Build order and phases
   - Technical implementation details
   - Integration approach
   - Deployment strategy

### Before Creating Implementation Specs
1. Resolve any HIGH priority issues
2. Clarify any uncertain dependencies
3. Ensure component boundaries are final

## Test Strategy Summary

### Component Test Coverage
| Component | Unit Tests | Integration Tests | TDD Approach |
|-----------|-----------|------------------|--------------|
| <Name> | Defined ✓ | Defined ✓ | Yes |
| <Name> | Missing ✗ | Defined ✓ | No |

### System Test Approach
- **E2E Test Scenarios**: <count> defined
- **Performance Tests**: Specified | Not Specified
- **Security Tests**: Specified | Not Specified

## Final Assessment

### Go/No-Go Decision
**Implementation Can Proceed**: YES | NO

**If NO, Required Actions**:
1. <Must complete this>
2. <Must fix this>
3. <Must clarify this>

**If YES, Recommendations**:
1. <Start with this component>
2. <Watch for this risk>
3. <Use this approach>

### Risk Assessment
- **High Risks**: <List with mitigation>
- **Medium Risks**: <List with monitoring>
- **Low Risks**: <List for awareness>
```

## Validation Criteria

### PASS Criteria
To receive a PASS status, ALL of the following must be true:
1. All required documents exist and are complete
2. No critical alignment issues found
3. No circular dependencies detected
4. All components have test strategies
5. Component interfaces are well-defined
6. No blocking gaps preventing implementation planning

### FAIL Criteria
Validation FAILS if ANY of the following are true:
1. Missing required documents
2. Critical misalignment between layers
3. Circular dependencies exist
4. Components missing test strategies
5. No master implementation plan
6. Blocking technical specifications gaps

## Common Issues and Fixes

### Missing Test Strategy
**Issue**: Component spec lacks test strategy section
**Fix**: Update component spec using prompt 4 with focus on test strategy

### API Contract Mismatch
**Issue**: Component A expects different API than Component B provides
**Fix**: Align both component specs and implementation specs

### Missing Dependencies
**Issue**: Component dependencies not clearly documented
**Fix**: Update component specs to clarify dependencies

### Incomplete Interface Definitions
**Issue**: Component interfaces not fully specified
**Fix**: Complete component specs with detailed interfaces

### Strategy-Design Mismatch
**Issue**: Design doesn't implement stated strategy
**Fix**: Either update design to match strategy or revise strategy

## Quality Gates

This validation serves as a quality gate. Implementation PLANNING should NOT proceed until:
1. Validation report shows PASS
2. All blockers are resolved
3. Test strategies are defined
4. Dependencies are validated
5. Team reviews and approves report

## Important Notes

1. **Run this before EVERY implementation** - Even for updates
2. **Don't skip sections** - Each check prevents future problems
3. **Document all issues** - Even minor ones may cascade
4. **Re-run after fixes** - Ensure issues are actually resolved
5. **Keep reports** - They're valuable for retrospectives

## Update Progress Report

After completing pre-implementation validation:
1. Update `reqs/progress-report.md`:
   - Mark Stage 4 task 4.2 as complete: `[x] Component validation (4.2)`
   - Record validation status (Passed/Failed)
   - List number and severity of issues found
   - Update Stage 4 status to "Complete" if passed
   - Add to activity log: `<Date>: Pre-implementation validation - Status: X`
   - Add any blockers that prevent implementation
   - Update overall progress percentage

Validation gates prevent costly mistakes - document the results!

Remember: This validation ensures you're ready to CREATE implementation specifications. The actual implementation specs (Stage 5) come AFTER this validation passes. A failed validation is not a failure - it's preventing a bigger failure later!