# Migration Guide: Adopting Framework Improvements

This guide helps existing projects adopt the new iterative, discovery-oriented framework improvements based on lessons learned from AI/ML project development.

## Overview of Changes

The framework has evolved from a linear specification process to an iterative, discovery-oriented system that better handles:
- AI/ML non-deterministic behavior
- Complex system integrations
- Unknown unknowns requiring exploration
- Living documentation maintenance

## Migration Steps

### Phase 1: Assess Current State (Week 1)

#### 1. Run Complexity Assessment
```bash
# Use the new complexity assessment prompt
claude run prompts/0-assess-complexity.md
```

This will:
- Evaluate your project's AI/ML complexity
- Identify integration risks
- Recommend spike phases
- Suggest appropriate buffers

#### 2. Perform Reality Checkpoint
```bash
# Compare current specs to implementation
claude run prompts/reality-checkpoint.md
```

This identifies:
- Specification drift
- Outdated documentation
- Missing specifications
- Update priorities

#### 3. Document Current Gaps
Create a migration plan based on findings:
- High-priority specification updates
- Areas needing spikes
- Process improvements needed

### Phase 2: Update Core Documentation (Week 2)

#### 1. Update Purpose Document
Add AI/ML sections if applicable:
- Behavioral predictability
- Learning/adaptation needs
- Transparency requirements
- Ethical considerations

#### 2. Update Strategy Documents
Add for AI/agent systems:
- Agent architecture decisions
- Loop prevention strategies
- Timeout handling approaches
- Integration complexity management

#### 3. Update Design Documents
Add integration complexity:
- Integration map
- Timeout cascade analysis
- State synchronization needs
- Error propagation paths

### Phase 3: Implement New Processes (Week 3)

#### 1. Schedule Regular Reality Checkpoints
- Weekly during active development
- At phase boundaries
- Before major releases
- After significant changes

#### 2. Plan Discovery Spikes
For identified unknowns:
- Time-box explorations
- Document learnings
- Update specifications
- Share findings with team

#### 3. Establish Learning Capture
- End-of-sprint retrospectives
- Document surprises and gaps
- Update complexity assessments
- Feed improvements back

### Phase 4: Automate and Enforce (Week 4+)

#### 1. Create Validation Gates
```yaml
# Example: .github/workflows/spec-validation.yml
name: Specification Validation
on:
  pull_request:
    paths:
      - 'src/**'
      - 'reqs/**'

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - name: Check Spec Currency
        run: |
          # Custom script to check spec dates
          ./scripts/validate-spec-currency.sh
      
      - name: Verify Alignment
        run: |
          # Run alignment checks
          claude run prompts/align-specs-to-code.md
```

#### 2. Add Documentation Hooks
- Pre-commit hooks for spec updates
- PR templates requiring spec alignment
- Automated drift detection
- Dashboard for specification health

## Migration Patterns by Project Type

### For Pure AI/ML Projects
1. **Immediate Actions**:
   - Run complexity assessment
   - Plan behavior boundary spikes
   - Document confidence handling
   - Add fallback strategies

2. **Critical Additions**:
   - Loop prevention documentation
   - Prompt engineering guidelines
   - Model versioning strategy
   - Drift monitoring approach

### For Integration-Heavy Projects
1. **Immediate Actions**:
   - Create integration map
   - Analyze timeout cascades
   - Document state dependencies
   - Plan integration spikes

2. **Critical Additions**:
   - Circuit breaker patterns
   - Retry strategies
   - Error propagation docs
   - Recovery mechanisms

### For Hybrid Projects
1. **Immediate Actions**:
   - Full complexity assessment
   - Identify AI/integration touchpoints
   - Plan multiple spike phases
   - Budget 50%+ buffer

2. **Critical Additions**:
   - All AI considerations
   - All integration patterns
   - Extra emphasis on testing
   - Comprehensive monitoring

## Common Migration Challenges

### 1. Resistance to Documentation Updates
**Problem**: Team sees documentation as overhead
**Solution**: 
- Show specification drift costs
- Automate where possible
- Make updates part of Definition of Done
- Celebrate documentation improvements

### 2. Time Pressure
**Problem**: No time for spikes or updates
**Solution**:
- Start with highest-risk areas
- Time-box strictly
- Show ROI from early spikes
- Build into sprint planning

### 3. Legacy Specification Debt
**Problem**: Massive drift accumulated
**Solution**:
- Prioritize by impact
- Update incrementally
- Focus on active areas
- Consider partial deprecation

## Success Metrics

Track these to measure migration success:

### Specification Health
- **Drift Rate**: % of specs needing updates
- **Currency**: Average days since last update
- **Coverage**: % of system documented
- **Accuracy**: Alignment check pass rate

### Development Efficiency
- **Spike ROI**: Issues prevented vs. time spent
- **Onboarding Time**: New developer ramp-up
- **Bug Discovery**: When issues are found
- **Change Success**: Feature delivery rate

### Team Satisfaction
- **Documentation Trust**: Survey scores
- **Process Adoption**: Compliance rate
- **Knowledge Sharing**: Cross-team understanding
- **Confidence Levels**: Team certainty

## Migration Timeline

### Typical Timeline for Medium Project
- **Week 1**: Assessment and planning
- **Week 2**: Core documentation updates
- **Week 3**: Process implementation
- **Week 4**: Initial automation
- **Month 2**: Refinement and optimization
- **Month 3**: Full adoption and benefits

### Factors Affecting Timeline
- Current specification debt
- Team size and distribution
- System complexity
- AI/ML components
- Integration count
- Regulatory requirements

## Getting Help

### Resources
- Example migrated projects in `docs/examples/`
- Framework improvement details in `docs/framework-improvements.md`
- Prompt documentation in each prompt file
- Community discussions in GitHub issues

### Support Channels
- Framework questions: GitHub discussions
- Bug reports: GitHub issues
- Feature requests: Enhancement proposals
- Success stories: Share in discussions

## Conclusion

Migration to the improved framework is an investment that pays dividends through:
- Reduced surprise discoveries
- Better project planning
- Living documentation
- Team confidence
- Faster onboarding

Start small, measure progress, and iterate. The framework is designed to evolve with your needs.