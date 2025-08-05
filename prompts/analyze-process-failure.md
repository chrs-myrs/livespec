# Process Failure Analysis Prompt

You are tasked with analyzing failures in the Bidirectional Specifications System process. Your goal is to diagnose what went wrong, why it happened, and provide specific recommendations for improving the system to prevent similar failures.

## Your Mindset for Failure Analysis

Before you begin, understand that you are:
- **A forensic investigator**, examining evidence to understand what happened
- **A systems analyst**, identifying root causes and patterns
- **A process engineer**, recommending concrete improvements
- **A prevention specialist**, thinking about how to avoid future failures

## Failure Description

The user has provided the following description of what went wrong:

```
$ARGUMENTS
```

## Analysis Framework

### Phase 1: Evidence Collection (15 minutes)

#### 1.1 Project Structure Analysis
Examine the current project structure:
- [ ] Check if `reqs/` directory exists and has expected structure
- [ ] Verify presence of specification files at each level
- [ ] Identify missing or incomplete documents
- [ ] Look for orphaned or inconsistent files

#### 1.2 Document Quality Review
For each specification level found:
- [ ] **Purpose Level**: Does `system-purpose.md` exist and contain clear business value?
- [ ] **Strategy Level**: Are technical decisions documented with rationale?
- [ ] **Design Level**: Is system architecture clear with component boundaries?
- [ ] **Component Level**: Are component capabilities well-defined?
- [ ] **Implementation Level**: Does master plan exist? Are individual specs complete?

#### 1.3 Process Artifacts Analysis
Look for evidence of process execution:
- [ ] Check for change logs (`*-changelog.md` files)
- [ ] Look for validation reports or notes
- [ ] Examine any implementation artifacts
- [ ] Check for test strategies and TDD evidence

#### 1.4 Code-Documentation Alignment
If code exists:
- [ ] Compare code structure to documented design
- [ ] Check if components match specifications
- [ ] Identify undocumented code or over-documented features
- [ ] Look for recent changes not reflected in specs

### Phase 2: Root Cause Analysis (20 minutes)

#### 2.1 Failure Pattern Classification

Based on evidence, classify the failure type:

**Documentation Failures**:
- [ ] Incomplete specification hierarchy
- [ ] Missing critical documents
- [ ] Poor document quality
- [ ] Inconsistent information across levels

**Process Failures**:
- [ ] Skipped validation steps
- [ ] Wrong mode selection
- [ ] Improper prompt usage
- [ ] Inadequate change tracking

**Implementation Failures**:
- [ ] No master implementation plan
- [ ] Components built in wrong order
- [ ] Poor integration between components
- [ ] TDD not followed

**Alignment Failures**:
- [ ] Code diverged from specifications
- [ ] Specifications became outdated
- [ ] Manual changes not synchronized
- [ ] Missing bidirectional updates

#### 2.2 Contributing Factors Analysis

For each identified failure, analyze:

**System Factors**:
- Were the prompts unclear or insufficient?
- Did the system lack necessary guidance?
- Were there gaps in the process flow?

**User Factors**:
- Was the chosen mode appropriate for the situation?
- Were prerequisites understood and met?
- Was the process followed correctly?

**Project Factors**:
- Was the project scope appropriate for this system?
- Were there external constraints not considered?
- Did the project characteristics match system assumptions?

#### 2.3 Cascade Effect Analysis

Trace how the initial failure propagated:
- Which downstream processes were affected?
- How did the failure compound over time?
- What secondary failures were triggered?

### Phase 3: Impact Assessment (10 minutes)

#### 3.1 Immediate Impact
- What deliverables were affected?
- How much work was lost or needs rework?
- What timeline delays occurred?

#### 3.2 Quality Impact  
- How did documentation quality suffer?
- What technical debt was introduced?
- How was system understanding compromised?

#### 3.3 Process Impact
- What confidence was lost in the system?
- Which process steps became unreliable?
- How was future adoption affected?

### Phase 4: Diagnostic Report Generation (15 minutes)

## Failure Analysis Report

**Project**: `<project-name>`
**Analysis Date**: `<current-date>`
**Analyst**: Claude Code
**Failure Description**: `<from $ARGUMENTS>`

### Executive Summary
<Brief summary of what went wrong, primary causes, and key recommendations>

### Failure Timeline
<Chronological sequence of what happened, when failures occurred>

### Root Cause Analysis

#### Primary Failure Type: `<classification>`
<Detailed analysis of the main failure pattern>

#### Contributing Factors:
1. **System Factor**: <What the system failed to provide>
2. **Process Factor**: <How the process was inadequate>  
3. **User Factor**: <What went wrong in execution>
4. **Project Factor**: <Environmental or scope issues>

#### Cascade Effects:
<How the initial failure led to secondary problems>

### Evidence Summary

#### What We Found:
- **Missing**: <List of missing documents/artifacts>
- **Incomplete**: <List of partial or poor-quality items>
- **Inconsistent**: <List of conflicting information>
- **Outdated**: <List of stale documentation>

#### Quality Assessment:
| Specification Level | Status | Quality Score | Issues |
|-------------------|---------|---------------|---------|
| 1-Purpose | ✓/✗/~ | 1-10 | <key issues> |
| 2-Strategy | ✓/✗/~ | 1-10 | <key issues> |
| 3-Design | ✓/✗/~ | 1-10 | <key issues> |
| 4-Components | ✓/✗/~ | 1-10 | <key issues> |
| 5-Implementation | ✓/✗/~ | 1-10 | <key issues> |

### Specific Findings

#### Documentation Issues:
<Detailed findings about documentation problems>

#### Process Issues:
<Specific problems with how the process was executed>

#### System Issues:
<Problems with the bidirectional system itself>

## Recommendations

### Immediate Actions (Fix Current Project)
1. **Priority 1 (Critical)**: <Must-do actions to recover>
2. **Priority 2 (Important)**: <Should-do actions to improve>
3. **Priority 3 (Beneficial)**: <Could-do actions to optimize>

### Process Improvements (Prevent Future Failures)

#### System Enhancements:
1. **Prompt Improvements**: <Specific changes needed to prompts>
2. **Validation Enhancements**: <Better checking mechanisms>
3. **Documentation Clarifications**: <Areas needing clearer guidance>

#### Process Refinements:
1. **Mode Selection**: <Better guidance for choosing modes>
2. **Validation Gates**: <Additional checkpoints needed>
3. **Error Recovery**: <Better handling of partial failures>

#### User Experience Improvements:
1. **Training Materials**: <Additional guidance needed>
2. **Quick Start Improvements**: <Onboarding enhancements>
3. **Troubleshooting Guides**: <Common failure patterns>

### Long-term Strategic Changes

#### System Architecture:
<Fundamental changes to prevent this class of failure>

#### Process Framework:
<Structural improvements to the overall approach>

#### Quality Assurance:
<Better mechanisms for ensuring success>

## Implementation Plan

### Phase 1: Recovery (Immediate - 1 week)
- [ ] <Specific recovery actions with owners and dates>

### Phase 2: Prevention (Short-term - 1 month)  
- [ ] <System improvements with priorities>

### Phase 3: Enhancement (Medium-term - 3 months)
- [ ] <Strategic improvements with roadmap>

## Metrics and Monitoring

### Success Indicators:
- <How to measure if recommendations are working>

### Warning Signs:
- <Early indicators of similar future failures>

### Monitoring Plan:
- <What to track to prevent recurrence>

## Lessons Learned

### What Worked Well:
<Positive aspects that should be preserved>

### What Didn't Work:
<Clear failures that must be addressed>

### Key Insights:
<Deep understanding gained from this failure>

## Risk Assessment for Future Projects

### High Risk Scenarios:
<Situations most likely to trigger similar failures>

### Mitigation Strategies:
<Proactive measures for high-risk situations>

### Decision Framework:
<How to choose approaches to minimize risk>

---

## Appendices

### A: Detailed Evidence
<Full documentation of all findings>

### B: Code Analysis
<Technical analysis of any code-related issues>

### C: Process Artifacts  
<Screenshots, logs, or other supporting evidence>

### D: Comparative Analysis
<How this failure compares to known patterns>

## Usage Instructions

### Running This Analysis

```bash
# Basic failure analysis
claude-code "Use prompts/analyze-process-failure.md" --arguments "The implementation got confused and only implemented one component"

# Detailed analysis with context
claude-code "Use prompts/analyze-process-failure.md" --arguments "Auto-build mode created incomplete specs and validation was skipped, leading to fragmented implementation"

# Analysis with specific focus
claude-code "Use prompts/analyze-process-failure.md" --arguments "focus:alignment - Documentation drifted from code and alignment checks were not run regularly"
```

### Analysis Modes

The prompt supports different analysis focuses based on $ARGUMENTS:

- **focus:documentation** - Deep dive into specification quality issues
- **focus:process** - Emphasis on workflow and execution problems  
- **focus:implementation** - Focus on coding and TDD issues
- **focus:alignment** - Concentrate on synchronization failures
- **focus:system** - Analyze the bidirectional system itself

### Expected Outputs

1. **Comprehensive Report** - Full analysis with all sections
2. **Executive Summary** - High-level findings and recommendations
3. **Action Plan** - Prioritized steps for recovery and improvement
4. **Process Recommendations** - Specific system enhancements needed

### When to Use This Analysis

- **After any significant failure** in the bidirectional specs process
- **Before major project retrospectives** to understand issues
- **When planning system improvements** based on real experience
- **For training purposes** to understand failure patterns

### Integration with System Improvement

The output of this analysis should be:
1. **Fed back** to system maintainers for prompt improvements
2. **Used to update** user guides with better guidance
3. **Incorporated** into validation checks to prevent recurrence
4. **Shared** with other users facing similar challenges

Remember: Failure is a learning opportunity. Each failure analyzed makes the system stronger and more reliable for everyone.

## Quality Checklist

Before finalizing the analysis, ensure:

- [ ] Root cause clearly identified and explained
- [ ] Multiple contributing factors considered
- [ ] Specific, actionable recommendations provided
- [ ] Both immediate fixes and long-term improvements covered
- [ ] Clear implementation plan with priorities
- [ ] Success metrics defined
- [ ] Lessons learned captured for future reference

The goal is not just to fix the current problem, but to make the entire system more robust and user-friendly.