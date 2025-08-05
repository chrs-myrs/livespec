# Learning Capture Documentation Prompt

You are tasked with capturing and documenting learnings from development activities. This creates a feedback loop that improves specifications and helps future projects avoid similar issues.

## Your Mindset for Learning Capture

Before you begin, understand that you are:
- **A pattern recognizer**, identifying recurring themes
- **A gap analyzer**, finding specification mismatches
- **An improvement advocate**, suggesting process enhancements
- **A knowledge preserver**, ensuring learnings aren't lost

## Learning Capture Framework

### Step 1: Gathering Learnings (REFLECT DEEPLY - 10+ minutes)

1. **Expectation vs. Reality**:
   - What did specifications say would happen?
   - What actually happened during implementation?
   - Where were the biggest gaps?

2. **Surprise Analysis**:
   - What caught the team off guard?
   - What complexity was hidden?
   - What turned out easier than expected?

3. **Pattern Recognition**:
   - What issues repeated across components?
   - What successful patterns emerged?
   - What anti-patterns were discovered?

## Instructions

### Automatic Processing:
1. Review recent development activities (sprints/phases/spikes)
2. Compare specifications to implementation reality
3. Identify gaps and surprises
4. Document learnings and recommendations
5. Update affected specifications

### Learning Categories to Capture

#### Technical Discoveries
- Unexpected complexity areas
- Performance characteristics
- Integration challenges
- Tool/framework limitations
- Architectural insights

#### Process Insights
- Specification gaps
- Estimation accuracy
- Communication issues
- Decision-making patterns
- Team dynamics

#### Domain Knowledge
- Business rule clarifications
- User behavior insights
- Edge cases discovered
- Compliance requirements
- Market realities

## Learning Capture Report Template

```markdown
# Learning Capture Report

**Period Covered**: <Start Date> to <End Date>
**Project/Phase**: <Name>
**Report Date**: <YYYY-MM-DD>
**Prepared By**: <Who compiled learnings>

## Executive Summary

### Key Learnings
1. **<Learning>**: <Impact on project>
2. **<Learning>**: <Impact on project>
3. **<Learning>**: <Impact on project>

### Specification Accuracy
- **Well-Specified Areas**: <What matched reality>
- **Under-Specified Areas**: <What needed more detail>
- **Over-Specified Areas**: <What was unnecessarily detailed>
- **Missing Areas**: <What wasn't specified at all>

## Detailed Learnings

### 1. Technical Discoveries

#### <Discovery Area>
**What We Expected**: <From specifications>
**What We Found**: <Actual reality>
**Gap Analysis**: <Why the difference>
**Impact**: <How this affected development>
**Recommendation**: <How to handle in future>

#### AI/ML Specific Learnings
**Agent Behavior Surprises**:
- <Unexpected behaviors>
- <Loop patterns discovered>
- <Prompt engineering insights>

**Integration Complexities**:
- <Tool interaction issues>
- <State management challenges>
- <Timeout cascades>

### 2. Process Insights

#### Specification Evolution
**Documents That Changed Most**:
1. <Document>: <Number of updates> updates
   - Key changes: <What evolved>
   
**Documents That Stayed Stable**:
1. <Document>: <Why it remained accurate>

#### Estimation Accuracy
| Component | Estimated Time | Actual Time | Variance | Reason |
|-----------|---------------|-------------|----------|---------|
| <Name> | X days | Y days | +/-Z% | <Why> |

#### Discovery Spikes Effectiveness
**Spikes Conducted**: <Number>
**Questions Answered**: <X out of Y>
**New Questions Raised**: <Number>
**ROI Assessment**: <Was it worth the time?>

### 3. Domain Insights

#### User Behavior Discoveries
- <What we learned about users>
- <Assumptions that were wrong>
- <New requirements discovered>

#### Business Rule Clarifications
- <Rules that were unclear>
- <Rules that changed>
- <Rules we discovered>

## Impact on Specifications

### Immediate Updates Needed

#### Purpose Document
- [ ] <Specific update needed>
- [ ] <Specific update needed>

#### Strategy Documents
- [ ] <Strategy that needs revision>
- [ ] <New strategy to add>

#### Design Documents
- [ ] <Architecture changes>
- [ ] <Component boundary adjustments>

#### Component Specifications
- [ ] <Interface updates>
- [ ] <Behavior clarifications>

#### Implementation Specifications
- [ ] <Technical detail additions>
- [ ] <Configuration clarifications>

### Framework Improvements Suggested

#### New Document Types Needed
- <Document type>: <Why it would help>

#### Process Changes
- <Current process>: <Suggested improvement>

#### Tooling Improvements
- <Tool/automation>: <How it would help>

## Patterns and Anti-Patterns

### Successful Patterns Discovered
1. **Pattern**: <Description>
   - Context: <When to use>
   - Benefits: <Why it works>
   - Example: <Where we used it>

### Anti-Patterns to Avoid
1. **Anti-Pattern**: <Description>
   - Context: <When it appears>
   - Problems: <Why it fails>
   - Alternative: <What to do instead>

## Recommendations

### For Current Project
1. **Immediate Actions**:
   - <What to do now>
   - <Critical fixes needed>

2. **Near-term Improvements**:
   - <What to do in next sprint>
   - <Process adjustments>

### For Future Projects
1. **Planning Phase**:
   - <How to plan better>
   - <What to assess upfront>

2. **Development Phase**:
   - <Better practices>
   - <What to watch for>

3. **Framework Evolution**:
   - <How framework should adapt>
   - <New patterns to incorporate>

## Metrics and Measurements

### Specification Drift Metrics
- **Average Updates per Document**: <Number>
- **Major Revisions**: <Count of significant changes>
- **Stability by Level**: 
  - Purpose: <High|Medium|Low>
  - Strategy: <High|Medium|Low>
  - Design: <High|Medium|Low>
  - Components: <High|Medium|Low>
  - Implementation: <High|Medium|Low>

### Development Velocity Impact
- **Pre-learning Velocity**: <Story points/week>
- **Post-learning Velocity**: <Story points/week>
- **Improvement**: <Percentage>

## Action Items

### Assigned Actions
| Action | Owner | Due Date | Priority |
|--------|-------|----------|----------|
| <Action> | <Who> | <When> | <High|Med|Low> |

### Process Updates
- [ ] Update complexity assessment criteria
- [ ] Revise spike planning guidelines
- [ ] Enhance specification templates
- [ ] Improve validation gates

## Appendix

### Raw Learning Logs
<Chronological list of learnings as captured>

### Supporting Evidence
<Links to commits, PRs, issues that demonstrate learnings>

### Team Feedback
<Quotes and insights from team members>
```

## Quality Checks:

Before finalizing:
- [ ] All major surprises documented
- [ ] Specification gaps identified
- [ ] Patterns clearly described
- [ ] Recommendations are actionable
- [ ] Metrics support conclusions
- [ ] Action items assigned

## Missing Information Output

After creating the Learning Capture report:

```
## 📋 Learning Capture Summary

### ✅ Learnings Documented
- [Major areas covered]

### ⚠️ Missing Context
- **[Area]**: [What additional context would help]

### 🔍 Incomplete Analysis
- **[Topic]**: [What needs deeper investigation]

### 👉 Follow-up Needed
1. [Who to interview for more insights]
2. [Data to gather for better analysis]
```

## Update Progress Report

After capturing learnings:
1. Update `reqs/progress-report.md`:
   - Mark Stage 6 task 6.3 as complete for this cycle
   - Increment learning reports count
   - Add key insights to decisions/notes section
   - Update complexity assessment if needed
   - Add to activity log: `<Date>: Learning capture report created`
   - Note process improvements identified
   - Update metrics based on insights

Learning capture completes the documentation cycle!

Remember: The goal is to close the feedback loop between specification and reality. Every learning captured makes the next project more successful.