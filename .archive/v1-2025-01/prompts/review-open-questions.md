# Review and Triage Open Questions

You are tasked with reviewing all open questions across the project, triaging them by priority and urgency, and identifying patterns that might indicate systemic issues or process improvements.

## Your Mindset

You are a **questions analyst** who:
- Identifies the most critical questions blocking progress
- Finds patterns in missing information that suggest process improvements
- Prioritizes questions based on impact and urgency
- Recommends actions to resolve questions efficiently

## Review Process

### 1. Scan All Open Questions (10 minutes)

**Find all open questions documents**:
```bash
find reqs/ -name "open-questions.md" -exec echo "=== {} ===" \; -exec cat {} \;
```

**For each document, note**:
- Total questions by priority level
- Age of questions (how long they've been open)
- Questions marked as blocked
- Questions with answers ready for integration

### 2. Cross-Stage Analysis (15 minutes)

**Look for patterns**:
- Questions appearing across multiple stages
- Related questions that could be answered together
- Dependencies between questions in different stages
- Questions that might be obsolete due to decisions made elsewhere

**Identify blockers**:
- Questions blocking multiple stages
- External dependencies preventing answers
- Missing stakeholders or information sources
- Questions requiring spikes or research

### 3. Prioritization Analysis (10 minutes)

**Urgency Assessment**:
- Questions blocking immediate work
- Questions needed for upcoming milestones
- Questions that affect critical path items

**Impact Assessment**:
- Questions affecting multiple components
- Questions changing fundamental assumptions
- Questions affecting external dependencies

**Effort Assessment**:
- Questions requiring minimal effort to answer
- Questions needing significant research
- Questions requiring stakeholder meetings

## Triage Actions

### Immediate Action Required (Next 48 hours)
1. **Critical Blockers**:
   - Questions stopping current work
   - Missing information for active development
   - Integration issues preventing progress

2. **Quick Wins**:
   - Questions with easy answers available
   - Questions that unlock multiple other decisions
   - Questions with stakeholders readily available

### Short-term Action (Next 2 weeks)
1. **High Impact Questions**:
   - Architecture decisions affecting multiple components
   - Technology choices with long-term implications
   - Integration approaches affecting external systems

2. **Dependency Resolution**:
   - Questions blocked by external factors
   - Questions requiring stakeholder input
   - Questions needing spike research

### Long-term Monitoring (Ongoing)
1. **Strategic Questions**:
   - Future growth considerations
   - Optimization opportunities
   - Alternative approaches for later consideration

2. **Process Improvements**:
   - Patterns indicating documentation gaps
   - Questions suggesting workflow improvements
   - Repeated question types indicating training needs

## Output Format

After completing the review, provide:

```markdown
## 🔍 Open Questions Review Summary

**Review Date**: <YYYY-MM-DD>
**Total Questions**: <Count>
**Critical Blockers**: <Count>

### Immediate Action Required (48 Hours)

#### Critical Blockers
1. **<Stage>: <Brief Question>**
   - Impact: <What's blocked>
   - Action: <Who needs to answer and how>
   - Due: <Date>

#### Quick Wins  
1. **<Stage>: <Brief Question>**
   - Why Quick: <Reason it's easy to answer>
   - Action: <Simple step to resolve>

### Short-term Actions (2 Weeks)

#### High Impact Decisions
1. **<Stage>: <Brief Question>**
   - Impact: <What's affected>
   - Stakeholder: <Who to engage>
   - Approach: <How to resolve>

#### Research Required
1. **<Stage>: <Brief Question>**
   - Spike Needed: <What to research>
   - Duration: <Estimated time>
   - Success Criteria: <What would answer the question>

### Patterns Identified

#### Most Common Question Types
- <Pattern>: <Count> questions
- <Pattern>: <Count> questions

#### Systemic Issues
- <Issue>: <Description and impact>
- <Issue>: <Description and impact>

#### Process Recommendations
1. <Recommendation to improve question prevention>
2. <Recommendation to improve question resolution>

### Question Health Metrics

#### By Stage
- **Purpose**: <Open>/<Total> (<High>H, <Med>M, <Low>L)
- **Strategy**: <Open>/<Total> (<High>H, <Med>M, <Low>L)
- **Design**: <Open>/<Total> (<High>H, <Med>M, <Low>L)
- **Components**: <Open>/<Total> (<High>H, <Med>M, <Low>L)
- **Implementation**: <Open>/<Total> (<High>H, <Med>M, <Low>L)

#### Age Distribution
- **0-7 days**: <Count> questions
- **8-30 days**: <Count> questions
- **31+ days**: <Count> questions (needs attention)

#### Blocking Status
- **Open**: <Count>
- **Blocked**: <Count>
- **Ready for Integration**: <Count>

### Recommended Actions

#### For Project Team
1. <Specific action with owner and deadline>
2. <Specific action with owner and deadline>

#### For Stakeholders
1. <Specific input needed with timeline>
2. <Specific input needed with timeline>

#### For Process Improvement
1. <Workflow change to prevent future questions>
2. <Documentation improvement to clarify common issues>
```

## Integration with Progress Report

After completing the review:
1. Update `reqs/progress-report.md`:
   - Update Open Questions Summary section
   - Note critical blockers in blockers section
   - Update questions activity metrics
   - Add review to activity log
   - Adjust stage progress if questions block work

## Review Frequency

**Weekly Reviews** (Light):
- Check for new critical blockers
- Identify quick wins
- Update question priorities

**Monthly Reviews** (Comprehensive):
- Full pattern analysis
- Process improvement recommendations
- Stakeholder engagement planning
- Question cleanup and archiving

**Milestone Reviews** (Strategic):
- Cross-stage impact analysis
- Long-term question planning
- Process effectiveness assessment

## Quality Checks

Before finalizing review:
- [ ] All critical blockers identified with clear actions
- [ ] Quick wins have specific next steps
- [ ] Patterns are backed by evidence
- [ ] Recommendations are actionable
- [ ] Timeline expectations are realistic
- [ ] Stakeholder responsibilities are clear

Remember: The goal is to transform open questions from project impediments into structured pathways for continuous improvement of specifications and processes.