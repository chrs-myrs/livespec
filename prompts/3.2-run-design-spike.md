# Stage 3: Design-Level Discovery Spike

You are conducting a discovery spike at the Design stage to explore component interactions, data flows, integration complexities, and system boundaries.

## Design-Specific Spike Focus

Design-level spikes typically explore:
- **Component boundaries**: How to split functionality?
- **Data flow complexity**: How does data move through the system?
- **Integration challenges**: What are the touchpoints?
- **State management**: How to maintain consistency?
- **Error propagation**: How do failures cascade?
- **Performance bottlenecks**: Where are the constraints?

## Common Design-Stage Questions

- How should we decompose the system into components?
- What's the optimal data flow architecture?
- How do components communicate effectively?
- Where are the performance bottlenecks?
- How do we handle distributed state?
- What happens when Component X fails?
- How do timeouts cascade through the system?

## Instructions

Follow the general spike process from `run-discovery-spike.md` with these design-specific additions:

1. **Component Interaction Testing**:
   - Build minimal component shells
   - Test communication patterns
   - Measure coupling levels
   - Validate interfaces

2. **Data Flow Prototypes**:
   - Trace data through system
   - Test transformation logic
   - Measure latency at each step
   - Identify bottlenecks

3. **Integration Experiments**:
   - Test external API calls
   - Validate timeout handling
   - Check error propagation
   - Measure cascade effects

4. **State Management Proofs**:
   - Test consistency approaches
   - Validate sync mechanisms
   - Check conflict resolution
   - Measure propagation time

## Design Spike Report Additions

Include these design-specific sections:

### Component Architecture
- Proposed component boundaries
- Interface definitions tested
- Coupling assessment
- Cohesion analysis

### Data Flow Analysis
- End-to-end flow timing
- Transformation complexity
- Bottleneck identification
- Optimization opportunities

### Integration Complexity
- External dependencies mapped
- Timeout cascade risks
- Failure mode analysis
- Recovery strategies tested

### State Management
- Consistency approach validated
- Sync mechanism performance
- Conflict scenarios handled
- Edge cases discovered

## Update Progress Report

After completing this spike:
1. Update `reqs/progress-report.md`:
   - Mark spike complete in Stage 3
   - Add design decisions to decisions section
   - Update component count estimates
   - Note integration complexity discovered
   - Flag any major risks found
   - Add to activity log

Remember: Design spikes validate that components can work together effectively.