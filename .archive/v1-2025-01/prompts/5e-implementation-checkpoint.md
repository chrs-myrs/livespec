# Stage 5: Implementation Reality Checkpoint

You are performing an implementation-phase reality checkpoint to ensure that the built system matches the specifications and that all documentation accurately reflects the implemented reality.

## Implementation-Specific Checkpoint Focus

This checkpoint occurs AFTER implementation to ensure living documentation:
- **Specification accuracy**: Do specs match what was built?
- **Behavior validation**: Does system behave as documented?
- **Integration reality**: Do integrations work as designed?
- **Performance reality**: Does system meet stated requirements?
- **Documentation currency**: Is all documentation up-to-date?

## Implementation Checkpoint Validations

### 1. Code-Specification Alignment
- Does each component match its specification?
- Are all APIs implemented as documented?
- Do data models match schemas?
- Are algorithms as described?

### 2. Behavior Verification
- Does system behavior match documentation?
- Are error conditions handled as specified?
- Do edge cases work as documented?
- Is performance as promised?

### 3. Integration Validation
- Do all integrations work as designed?
- Are timeouts configured correctly?
- Do error propagations match documentation?
- Are fallbacks working?

### 4. AI/ML Specific (if applicable)
- Does agent behave within documented boundaries?
- Are loop prevention strategies working?
- Is confidence expression as specified?
- Do tools work as documented?

## Implementation Checkpoint Report Template

```markdown
# Implementation Reality Checkpoint Report

**Checkpoint Date**: <YYYY-MM-DD>
**Implementation Phase**: <Phase name/number>
**Code Coverage**: <X>%
**Overall Alignment**: <X>%

## Implementation Validation Summary

### ✅ Correctly Implemented
- <What matches specifications perfectly>

### 🟡 Minor Deviations
- <Small differences from specs>

### 🔴 Major Discrepancies
- <Significant gaps between specs and reality>

## Detailed Alignment Analysis

### Component Implementation
| Component | Spec Match | Deviations | Action Required |
|-----------|------------|------------|-----------------|
| <Name> | 95% | Minor API differences | Update spec |
| <Name> | 100% | None | None |
| <Name> | 70% | Missing features | Implement or update |

### Behavior Validation
- **Documented Behavior A**: ✅ Works as specified
- **Documented Behavior B**: 🟡 Works but differently
- **Documented Behavior C**: 🔴 Not implemented

### Performance Reality
| Metric | Specified | Actual | Status |
|--------|-----------|---------|---------|
| Latency | <100ms | 87ms | ✅ Met |
| Throughput | 1000/sec | 800/sec | 🟡 Close |
| Memory | <1GB | 1.2GB | 🔴 Exceeded |

### Integration Health
- **External API**: ✅ Working as designed
- **Database**: 🟡 Schema drift detected
- **Message Queue**: 🔴 Different error handling

## Documentation Updates Required

### Priority 1 - Immediate
1. <Spec that must be updated now>
2. <Critical mismatch to fix>

### Priority 2 - This Week
1. <Important update needed>

### Priority 3 - Maintenance
1. <Minor update for clarity>

## Lessons Learned

### What Changed During Implementation
- <Why implementation differed from design>

### Discovered Complexities
- <What was harder than expected>

### Simplifications Found
- <What was easier than expected>
```

## Update Progress Report

After completing this checkpoint:
1. Update `reqs/progress-report.md`:
   - Update Stage 5 checkpoint status
   - Record final alignment score
   - Update implementation progress
   - Add drift metrics
   - Note documentation updates needed
   - Add to activity log
   - Trigger Stage 6 if updates needed

Remember: This checkpoint ensures documentation reflects reality, not wishes.