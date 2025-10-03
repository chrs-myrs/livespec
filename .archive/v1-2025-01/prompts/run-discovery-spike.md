# Discovery Spike Execution Prompt

You are conducting a time-boxed exploration spike to reduce uncertainty and learn about complex aspects of the system. Spikes are focused experiments designed to answer specific questions and inform better specifications.

## Your Mindset for Discovery Spikes

Before you begin, understand that you are:
- **An experimenter**, building just enough to learn
- **A question answerer**, focused on specific unknowns
- **A pattern discoverer**, finding what works and what doesn't
- **A risk reducer**, converting unknowns to knowns

## Spike Execution Framework

### Pre-Spike Setup (READ CAREFULLY)

1. **Spike Charter**:
   - What specific question(s) must be answered?
   - What would success look like?
   - What's the time box?
   - What's explicitly out of scope?

2. **Exploration Strategy**:
   - Build minimal prototypes
   - Test edge cases aggressively
   - Measure actual behavior
   - Document patterns

## Instructions

### Input Required:
- **Spike Name**: Clear identifier
- **Focus Area**: Specific technical challenge
- **Time Box**: Maximum time to spend
- **Key Questions**: What must be answered
- **Success Criteria**: How we'll know we're done

### Spike Activities:

1. **Build Minimal Prototype**
   - Just enough code to test the concept
   - Focus on learning, not production quality
   - Use shortcuts where they don't affect learning

2. **Aggressive Testing**
   - Push boundaries to find limits
   - Test failure modes
   - Measure performance characteristics
   - Try unexpected inputs

3. **Pattern Recognition**
   - What approaches work well?
   - What consistently fails?
   - What surprises emerged?
   - What patterns repeat?

4. **Documentation During Spike**
   - Keep a running log of discoveries
   - Capture "aha!" moments immediately
   - Screenshot unexpected behaviors
   - Note questions that arise

## Spike Report Template

```markdown
# Discovery Spike Report: <Spike Name>

**Focus Area**: <What was explored>
**Time Box**: <Planned time>
**Actual Time**: <Time actually spent>
**Date**: <YYYY-MM-DD>
**Spike Lead**: <Who ran the spike>

## Executive Summary

### Questions Answered
✅ **<Original Question>**: <Clear answer>
✅ **<Original Question>**: <Clear answer>
❌ **<Original Question>**: <Why still unanswered>

### Key Discoveries
1. **<Discovery>**: <What we learned and why it matters>
2. **<Discovery>**: <What we learned and why it matters>

### Surprise Findings
- <What we didn't expect to learn>
- <Assumptions that were wrong>

## Technical Findings

### What Worked Well
- **Approach**: <What we tried>
  - **Result**: <Why it worked>
  - **Code Sample**: <If applicable>
  
### What Failed
- **Approach**: <What we tried>
  - **Result**: <Why it failed>
  - **Learning**: <What this teaches us>

### Performance Characteristics
- **Metric**: <Measured value>
- **Metric**: <Measured value>
- **Implications**: <What this means for the system>

### Integration Gotchas
- **Issue**: <What we discovered>
  - **Impact**: <How serious>
  - **Workaround**: <If found>

## Prototype Details

### Code Structure
<Brief description of prototype architecture>

### Key Components
- **Component**: <Purpose and findings>
- **Component**: <Purpose and findings>

### Limitations of Prototype
- <What wasn't tested>
- <What shortcuts were taken>
- <What would need to change for production>

## Impact on Specifications

### Complexity Assessment Updates
- **Original Estimate**: <What we thought>
- **Revised Estimate**: <What we now know>
- **Confidence Level**: <Low|Medium|High>

### Required Specification Changes

#### Purpose Document
- <No changes needed|Specific changes required>

#### Strategy Documents  
- <What strategies need revision>
- <New strategies needed>

#### Design Documents
- <Architecture changes needed>
- <New components identified>

#### Component Specifications
- <New interfaces required>
- <Changed behaviors>

#### Implementation Specifications
- <Technical details discovered>
- <New constraints identified>

## Recommendations

### Immediate Actions
1. <What should be done right away>
2. <Critical updates needed>

### Additional Spikes Needed
- **<Spike Name>**: <What still needs exploration>
- **<Spike Name>**: <New questions raised>

### Approach Recommendations
- **Recommended Pattern**: <Based on findings>
- **Avoid**: <What definitely won't work>
- **Consider**: <Alternatives to explore>

### Risk Updates
- **New Risk**: <Discovered during spike>
- **Mitigated Risk**: <No longer a concern because...>
- **Increased Risk**: <More complex than thought>

## Appendix

### Experiment Log
<Chronological list of what was tried and results>

### Code Samples
<Key code snippets that demonstrate findings>

### Performance Data
<Detailed metrics and measurements>

### Screenshots/Diagrams
<Visual evidence of behaviors>

### Questions for Follow-up
- <Questions that arose during spike>
- <Areas needing stakeholder input>
```

## Spike Success Metrics

Track these to improve spike effectiveness:
- Questions answered vs. questions asked
- Time spent vs. time boxed
- Specification changes required
- New risks discovered
- Complexity estimate accuracy

## Common Spike Anti-patterns to Avoid

### ❌ Scope Creep
- Trying to build too much
- Polishing prototype code
- Adding "nice to have" features

### ❌ Analysis Paralysis
- Researching instead of building
- Over-documenting
- Not time-boxing effectively

### ❌ Production Mindset
- Writing comprehensive tests
- Focusing on code quality over learning
- Building for reuse

### ✅ Good Spike Practices
- Throw-away code is okay
- Ugly but functional wins
- Document learning, not code
- Stop when questions are answered

## Missing Information Output

After completing the spike, provide a summary:

```
## 📋 Spike Completion Summary

### ✅ Questions Answered
- [List successfully answered questions]

### ❌ Questions Remaining
- [Questions still needing answers]

### 🎯 Key Learnings
- [Most important discoveries]

### 📝 Specification Impact
- [Which specs need updating]

### ⚠️ New Unknowns Discovered
- [What new questions arose]

### 👉 Recommended Next Steps
1. [Immediate actions needed]
2. [Additional spikes required]
```

Remember: The goal of a spike is learning, not building. Success is measured in questions answered and uncertainty reduced, not code produced.