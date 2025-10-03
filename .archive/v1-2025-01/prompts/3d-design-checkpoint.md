# Stage 3: Design Reality Checkpoint

You are performing a design-phase reality checkpoint to validate that the proposed design is feasible and that all design decisions are properly documented before moving to component specification.

## Design-Specific Checkpoint Focus

This checkpoint occurs BEFORE implementation to catch design issues early:
- **Feasibility validation**: Can this design actually be built?
- **Complexity assessment**: Is the design unnecessarily complex?
- **Integration validation**: Will components integrate smoothly?
- **Performance validation**: Can design meet performance needs?
- **Security validation**: Are security concerns addressed?

## Design Checkpoint Validations

### 1. Architecture Feasibility
- Are all components technically possible?
- Do the chosen technologies support the design?
- Are there any circular dependencies?
- Is the deployment model realistic?

### 2. Integration Complexity
- Are all integration points identified?
- Have timeout cascades been analyzed?
- Are error propagation paths clear?
- Do we have fallback strategies?

### 3. Data Flow Validation
- Is data flow clearly documented?
- Are transformations well-defined?
- Are there any bottlenecks?
- Is consistency maintained?

### 4. Component Boundaries
- Are components properly decoupled?
- Are responsibilities clear?
- Are interfaces well-defined?
- Is there appropriate cohesion?

## Design Checkpoint Report Template

```markdown
# Design Reality Checkpoint Report

**Checkpoint Date**: <YYYY-MM-DD>
**Design Documents Reviewed**: <List>
**Overall Design Health**: <Good/Concerns/Major Issues>

## Design Validation Summary

### ✅ Validated Aspects
- <What looks good in the design>

### ⚠️ Concerns Identified
- <Design aspects that need attention>

### 🔴 Blockers Found
- <Issues that must be resolved before proceeding>

## Feasibility Assessment

### Technical Feasibility
- **Component A**: ✅ Feasible with current tech
- **Component B**: ⚠️ Requires spike for validation
- **Integration X**: 🔴 Not possible as designed

### Complexity Analysis
- Overall Complexity: <Low/Medium/High/Extreme>
- Biggest Complexity: <What and why>
- Simplification Opportunities: <Where design could be simpler>

### Performance Projections
- Expected Latency: <Can design meet requirements?>
- Throughput Capacity: <Will it scale?>
- Resource Usage: <Is it efficient?>

## Required Design Updates

### Immediate Changes
1. <Design change needed before proceeding>

### Recommended Improvements
1. <Design improvement that would help>

### Additional Spikes Needed
1. <What needs exploration before components>
```

## Update Progress Report

After completing this checkpoint:
1. Update `reqs/progress-report.md`:
   - Update Stage 3 checkpoint status
   - Record alignment score
   - Add any blockers found
   - Update complexity assessment if changed
   - Add to activity log
   - Set next recommended actions

Remember: This checkpoint prevents building components based on flawed designs.