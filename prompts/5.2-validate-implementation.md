# Implementation Specification Validation Prompt

You are tasked with validating that implementation specifications are complete and ready for coding to begin. **CRITICAL**: This validation happens AFTER implementation specs are written (5.1) but BEFORE coding starts (5.2).

## Your Mindset for Validation

Before you begin, understand that you are:
- **An implementation auditor**, ensuring technical completeness
- **A dependency validator**, confirming build order makes sense
- **An integration checker**, verifying components will work together
- **A coding gate keeper**, preventing premature implementation

## Validation Framework

### Step 1: Implementation Documents Check (10 minutes)

#### Document Existence
Verify these documents exist and are complete:
- [ ] `reqs/5-implementation/00-master-implementation-plan.md`
- [ ] `reqs/5-implementation/` (one implementation spec per component)
- [ ] All component specs from Stage 4 have corresponding implementation specs

#### Master Plan Completeness
- [ ] Build order clearly defined
- [ ] Phases have deliverables and timelines
- [ ] Dependencies mapped correctly
- [ ] Critical path identified
- [ ] Resource allocation defined

### Step 2: Technical Completeness Check (15 minutes)

#### API Specifications
- [ ] All endpoints fully documented
- [ ] Request/response schemas complete
- [ ] Error responses defined
- [ ] Authentication/authorization specified

#### Data Models
- [ ] Database schemas fully defined
- [ ] Relationships clearly mapped
- [ ] Indexes identified
- [ ] Migration strategy defined

#### Algorithms and Logic
- [ ] Core algorithms documented
- [ ] Business logic detailed
- [ ] Edge cases considered
- [ ] Performance characteristics noted

### Step 3: Integration Validation (10 minutes)

#### Component Integration
- [ ] Integration points match between components
- [ ] Data formats align across interfaces
- [ ] Event contracts are compatible
- [ ] No integration gaps

#### External Integration
- [ ] External APIs fully specified
- [ ] Authentication methods defined
- [ ] Error handling documented
- [ ] Rate limits considered

### Step 4: Implementation Readiness (10 minutes)

#### Build and Deployment
- [ ] Build process defined
- [ ] Deployment strategy clear
- [ ] Configuration management planned
- [ ] Environment requirements specified

#### Testing Approach
- [ ] Unit test approach defined
- [ ] Integration test plan clear
- [ ] Test data strategy specified
- [ ] Performance test scenarios defined

#### Operational Readiness
- [ ] Monitoring approach defined
- [ ] Logging strategy clear
- [ ] Error handling comprehensive
- [ ] Rollback procedures defined

### Step 5: Risk Assessment (5 minutes)

#### Technical Risks
- [ ] Complex integrations identified
- [ ] Performance bottlenecks anticipated
- [ ] Security concerns addressed
- [ ] Scalability limits understood

#### Mitigation Strategies
- [ ] Each risk has mitigation plan
- [ ] Fallback approaches defined
- [ ] Monitoring for risk indicators
- [ ] Escalation paths clear

## Validation Report Template

```markdown
# Implementation Specification Validation Report

**Validation Date**: <YYYY-MM-DD>
**Overall Status**: PASS | FAIL
**Ready to Begin Coding**: YES | NO

## Executive Summary
<Assessment of implementation readiness>

## Detailed Findings

### 1. Document Completeness
**Status**: COMPLETE | INCOMPLETE

**Master Implementation Plan**:
- [x] Build phases defined
- [x] Dependencies mapped
- [x] Timeline realistic
- [ ] <Missing element>

**Component Specifications**:
| Component | Spec Complete | APIs Defined | Data Models | Tests Planned |
|-----------|---------------|--------------|-------------|---------------|
| <Name> | ✓ | ✓ | ✓ | ✓ |

### 2. Technical Readiness
**Status**: READY | GAPS FOUND

**Missing Technical Details**:
- <Component>: <What's missing>

**Integration Concerns**:
- <Issue description>

### 3. Risk Assessment
**Overall Risk**: LOW | MEDIUM | HIGH

**Key Risks**:
1. <Risk>: <Mitigation approach>
2. <Risk>: <Mitigation approach>

## Critical Issues (Must Fix)

1. **<Issue>**
   - Component: <Name>
   - Impact: Blocks implementation
   - Fix Required: <Action needed>

## Recommendations

### Before Coding Begins
1. Complete any missing specifications
2. Review integration approach with team
3. Validate build order with developers
4. Ensure test approach is understood

### During Implementation
1. Follow the master plan phases
2. Update specs if reality differs
3. Track deviations from plan
4. Maintain test-first discipline

## Sign-Off Checklist

### Technical Lead
- [ ] Implementation approach sound
- [ ] Build order makes sense
- [ ] Integration approach validated
- [ ] Risks acceptable

### Development Team
- [ ] Specs provide enough detail
- [ ] Implementation approach clear
- [ ] Test strategy understood
- [ ] Timeline realistic

## Next Steps

1. **If PASSED**: 
   - Proceed to implementation (5.2)
   - Follow master plan phases
   - Begin with Phase 1 components

2. **If FAILED**: 
   - Address critical issues
   - Complete missing specifications
   - Re-run validation
   - Update master plan if needed
```

## Common Issues and Fixes

### Incomplete API Specs
**Issue**: Endpoints defined but schemas missing
**Fix**: Complete request/response schemas in implementation specs

### Missing Build Order
**Issue**: Components listed but no clear sequence
**Fix**: Update master plan with dependency-based ordering

### Integration Gaps
**Issue**: Component A expects data Component B doesn't provide
**Fix**: Align implementation specs and add data transformation if needed

### Vague Algorithms
**Issue**: Business logic described but not detailed
**Fix**: Add pseudocode or detailed steps to implementation specs

## Quality Gates

This validation serves as the final gate before coding. Implementation should NOT begin until:
1. Validation report shows PASS
2. All critical issues resolved
3. Team has reviewed and approved
4. Test approach is clear
5. Build order is validated

## Update Progress Report

After completing implementation validation:
1. Update `reqs/progress-report.md`:
   - Add validation checkpoint: `[x] Implementation validation (5.0)`
   - Record validation status
   - Note any risks or concerns
   - Update overall progress
   - Add to activity log

## Important Notes

1. **This is the "point of no return"** - After this, coding begins
2. **Ensure completeness** - Missing details cause implementation delays
3. **Validate with developers** - They need to understand the specs
4. **Keep validation report** - Reference during implementation
5. **Update specs if needed** - Better to fix now than during coding

Remember: This validation ensures implementation specs are complete enough for developers to begin coding with confidence. It's the final check before significant resources are committed to building the system.