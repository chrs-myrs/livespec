# Reality Checkpoint Validation Prompt

You are performing a reality checkpoint - a systematic comparison between specifications and actual implementation to ensure living documentation remains accurate and useful.

## Your Mindset for Reality Checkpoints

Before you begin, understand that you are:
- **A truth seeker**, finding gaps between docs and reality
- **An alignment enforcer**, ensuring specifications match code
- **A drift detector**, measuring specification accuracy
- **An update facilitator**, making it easy to fix gaps

## Reality Checkpoint Framework

### Step 1: Systematic Comparison (ANALYZE THOROUGHLY - 20+ minutes)

1. **Document Review**:
   - Read current specifications
   - Note claimed capabilities
   - Identify documented decisions
   - Check latest update dates

2. **Implementation Analysis**:
   - Examine actual code
   - Test real behavior
   - Review recent changes
   - Check deployment configs

3. **Gap Identification**:
   - What specs say vs. what code does
   - Missing documentation
   - Outdated information
   - Incorrect descriptions

## Instructions

### Checkpoint Triggers:
- End of development phase
- Before major releases
- After significant changes
- Weekly/bi-weekly schedule
- Before specification reviews

### Validation Scope:
1. Start with highest-impact documents
2. Focus on recently changed areas
3. Check integration points
4. Validate critical behaviors
5. Review configuration accuracy

## Reality Checkpoint Report Template

```markdown
# Reality Checkpoint Report

**Checkpoint Date**: <YYYY-MM-DD>
**Scope**: <What was checked>
**Checker**: <Who performed validation>
**Overall Alignment Score**: <X>% aligned

## Executive Summary

### Alignment Status
- **🟢 Well Aligned**: <Count> documents
- **🟡 Minor Drift**: <Count> documents  
- **🔴 Major Drift**: <Count> documents
- **⚫ Missing**: <Count> expected documents

### Critical Findings
1. <Most important misalignment>
2. <Second most important>
3. <Third most important>

## Detailed Findings by Document Level

### 1. Purpose Document Alignment

**Document**: `reqs/1-purpose/system-purpose.md`
**Last Updated**: <Date>
**Alignment Score**: <X>%

#### Accurate Sections ✅
- <Section that matches reality>
- <Section that matches reality>

#### Drift Detected 🟡
| Section | Specification Says | Reality Is | Impact |
|---------|-------------------|------------|---------|
| <Section> | <What doc says> | <What code does> | <High/Med/Low> |

#### Major Gaps 🔴
- **Missing**: <What's not documented>
- **Wrong**: <What's incorrect>
- **Outdated**: <What's obsolete>

### 2. Strategy Documents Alignment

#### Document: `<strategy-name>.md`
**Alignment Score**: <X>%

**Technical Decisions**:
| Decision | Documented Choice | Actual Implementation | Match? |
|----------|------------------|---------------------|--------|
| <Decision> | <What spec says> | <What code does> | ✅/🟡/🔴 |

### 3. Design Documents Alignment

#### Component Architecture
**Specified Components**: <List>
**Actual Components**: <List>
**Missing in Specs**: <List>
**Removed from Code**: <List>

#### Integration Patterns
| Integration | Designed | Implemented | Notes |
|-------------|----------|-------------|-------|
| <Integration> | <Pattern> | <Pattern> | <Differences> |

### 4. Component Specifications Alignment

#### Component: <Name>
**Specification Accuracy**: <X>%

**Interface Comparison**:
```
Specified API:
- <endpoint/method>
- <endpoint/method>

Actual API:
- <endpoint/method>
- <endpoint/method>
+ <additional endpoint not in spec>
- <missing endpoint from spec>
```

**Behavior Differences**:
- **Specified**: <Expected behavior>
  **Actual**: <Real behavior>
  **Impact**: <Who/what affected>

### 5. Implementation Specifications Alignment

#### Technical Details Accuracy
| Aspect | Specified | Actual | Accurate? |
|--------|-----------|---------|-----------|
| Database Schema | <version> | <version> | ✅/🔴 |
| API Version | <version> | <version> | ✅/🔴 |
| Dependencies | <list> | <list> | ✅/🔴 |
| Config Variables | <count> | <count> | ✅/🔴 |

## AI/ML Specific Findings

### Agent Behavior Documentation
- **Documented Patterns**: <What specs say>
- **Observed Patterns**: <What agent does>
- **Undocumented Behaviors**: <Surprises found>

### Loop Prevention Reality
- **Specified Strategy**: <What docs say>
- **Implemented Strategy**: <What code does>
- **Effectiveness**: <How well it works>

## Root Cause Analysis

### Why Drift Occurred

1. **Rapid Iteration**: 
   - Changes made under pressure
   - Documentation updates deferred
   
2. **Discovery During Development**:
   - Unexpected complexity
   - New requirements emerged
   
3. **Process Gaps**:
   - No update enforcement
   - Missing validation gates

### Drift Patterns
- **Most Drift**: <Which doc types drift most>
- **Least Drift**: <Which stay accurate>
- **Common Changes**: <What typically changes>

## Update Requirements

### Priority 1 - Critical Updates (Do Immediately)
1. **Document**: <name>
   - **Section**: <what to update>
   - **Change**: <specific update needed>
   - **Assigned**: <who will update>

### Priority 2 - Important Updates (This Week)
1. **Document**: <name>
   - **Section**: <what to update>
   - **Change**: <specific update needed>

### Priority 3 - Minor Updates (This Sprint)
1. **Document**: <name>
   - **Section**: <what to update>
   - **Change**: <specific update needed>

## Process Improvement Recommendations

### Immediate Actions
1. <What to do right now>
2. <Quick wins available>

### Systematic Improvements
1. **Automation Opportunities**:
   - <What could be auto-checked>
   - <Tools to build/use>

2. **Process Changes**:
   - <When to force updates>
   - <How to ensure alignment>

## Metrics and Trends

### Alignment Scores Over Time
| Date | Overall | Purpose | Strategy | Design | Components | Implementation |
|------|---------|---------|----------|---------|------------|----------------|
| <Date> | X% | X% | X% | X% | X% | X% |

### Drift Velocity
- **New Drift This Period**: <X> instances
- **Drift Fixed This Period**: <Y> instances
- **Net Drift Change**: <+/- Z>

### Update Compliance
- **Required Updates**: <X>
- **Completed on Time**: <Y>
- **Compliance Rate**: <Z>%

## Action Items

### Immediate (Within 24 hours)
- [ ] Update <critical spec>
- [ ] Fix <major inaccuracy>
- [ ] Notify team of <important change>

### Short-term (This Week)
- [ ] Review and update <document set>
- [ ] Implement <process change>
- [ ] Schedule <follow-up checkpoint>

### Long-term (This Month)
- [ ] Automate <validation check>
- [ ] Refactor <specification structure>
- [ ] Train team on <new process>

## Appendix

### Evidence Collected
- Code commits reviewed: <list>
- Tests examined: <list>
- Configs checked: <list>
- Logs analyzed: <list>

### Tools Used
- <Tool>: <What it checked>
- <Tool>: <What it validated>
```

## Checkpoint Success Criteria

A successful reality checkpoint:
- [ ] Identifies all major drifts
- [ ] Provides specific update requirements
- [ ] Assigns clear ownership
- [ ] Sets realistic timelines
- [ ] Improves future alignment

## Common Drift Indicators

Watch for these signs:
- Recent bugs in "documented" features
- Confusion during onboarding
- Developers ignoring specs
- Frequent "that's not how it works" comments
- Test failures after "following specs"

## Missing Information Output

After completing the checkpoint:

```
## 📋 Reality Checkpoint Summary

### ✅ Validation Complete
- Documents checked: <count>
- Overall alignment: <X>%

### 🔴 Critical Gaps Found
- [High-priority misalignments]

### 🟡 Update Plan Created
- Immediate updates: <count>
- Total updates needed: <count>

### 👉 Next Steps
1. [Most urgent action]
2. [Second priority]
3. [Process improvement]
```

Remember: Reality checkpoints prevent documentation decay. Regular validation keeps specifications useful and trustworthy.