# Project Complexity Assessment Prompt

You are tasked with performing an initial complexity assessment of a proposed system. This assessment will guide project planning, identify areas needing exploration, and set realistic expectations for specification evolution.

## Your Mindset for Complexity Assessment

Before you begin, understand that you are:
- **A risk identifier**, spotting areas of uncertainty and complexity
- **A planning advisor**, recommending appropriate buffers and iterations
- **An exploration guide**, identifying what needs discovery spikes
- **A realism advocate**, setting honest expectations

## Deep Thinking Framework

### Step 1: System Analysis (THINK DEEPLY - 15+ minutes)

1. **Core Functionality Assessment**:
   - What is the system trying to achieve?
   - How clear are the requirements?
   - What aspects are well-defined vs. exploratory?

2. **Technical Complexity Factors**:
   - AI/ML components and their predictability
   - Integration touchpoints and dependencies
   - Performance/scale requirements
   - Cross-platform needs

3. **Unknown Identification**:
   - What do we know we don't know?
   - What might we not know we don't know?
   - Where might requirements change?

## Instructions

### Automatic Processing:
1. **Check for HLR Documents**:
   - Look in `reqs/hlr/` for any requirements files
   - Read all .md, .txt, .doc files found
   - If no HLR files exist, ask user for system description
2. Analyze provided system description/requirements
3. Check for AI/ML components
4. Identify integration points
5. Assess requirement clarity
6. Generate complexity report

### Complexity Factors Checklist

#### AI/ML Complexity Indicators
- [ ] **Non-deterministic behavior**: System behavior varies with same inputs
- [ ] **Natural language processing**: Understanding/generating human language
- [ ] **Agent-based architecture**: Autonomous decision-making components
- [ ] **Learning/adaptation required**: System improves over time
- [ ] **Complex prompt engineering**: Sophisticated LLM interactions
- [ ] **Multi-step reasoning**: Chain-of-thought or similar patterns
- [ ] **Tool use by AI**: AI systems selecting and using tools

#### Integration Complexity
- [ ] **Multiple external systems**: 3+ external dependencies
- [ ] **Cross-platform requirements**: Must work on different OS/environments
- [ ] **Real-time constraints**: Strict latency requirements
- [ ] **State synchronization**: Maintaining consistency across components
- [ ] **Cascading timeouts**: Timeout effects across system layers
- [ ] **Data format transformations**: Complex ETL requirements
- [ ] **Authentication/authorization**: Multiple auth systems

#### Discovery Requirements
- [ ] **User experience undefined**: Key UX patterns need exploration
- [ ] **Technical approach uncertain**: Multiple viable approaches exist
- [ ] **Performance characteristics unknown**: Need benchmarking
- [ ] **Scale requirements unclear**: Growth patterns undefined
- [ ] **Integration behavior unpredictable**: Component interactions unclear
- [ ] **Error patterns unknown**: Failure modes need discovery

#### Requirements Volatility
- [ ] **Stakeholder alignment pending**: Different visions exist
- [ ] **Market conditions changing**: External factors may shift requirements
- [ ] **Regulatory uncertainty**: Compliance requirements evolving
- [ ] **Technology decisions pending**: Key tech choices unmade
- [ ] **Success metrics undefined**: No clear measurement criteria

## Complexity Assessment Report Template

```markdown
# Complexity Assessment Report

**System**: <Name>
**Date**: <YYYY-MM-DD>
**Assessor**: <Who performed assessment>
**HLR Source**: <List HLR files analyzed, or "User provided" if no HLR>

## Executive Summary

**Overall Complexity**: <Low|Medium|High|Extreme>
**Confidence Level**: <High|Medium|Low>
**Recommended Approach**: <Waterfall|Iterative|Highly Exploratory>

## Detailed Assessment

### 1. System Complexity Factors

#### AI/ML Components
<List each AI/ML aspect and its complexity contribution>

**AI/ML Complexity Score**: <0-10>
**Key Risks**:
- <Specific AI-related risks>

#### Integration Requirements
<List integration points and complexity>

**Integration Complexity Score**: <0-10>
**Key Risks**:
- <Specific integration risks>

#### Discovery Needs
<List areas requiring exploration>

**Discovery Score**: <0-10>
**Key Unknown Areas**:
- <What needs to be discovered>

### 2. Complexity Scoring

| Factor | Score (0-10) | Weight | Weighted Score |
|--------|--------------|--------|----------------|
| AI/ML Complexity | X | 0.3 | X.X |
| Integration Complexity | X | 0.25 | X.X |
| Discovery Needs | X | 0.25 | X.X |
| Requirements Volatility | X | 0.2 | X.X |
| **Total** | | | **X.X** |

**Overall Complexity Level**:
- 0-2.5: Low - Traditional development appropriate
- 2.5-5.0: Medium - Some iteration expected
- 5.0-7.5: High - Significant exploration needed
- 7.5-10: Extreme - Highly exploratory approach required

### 3. Recommended Development Approach

#### Spike Phases Recommended
1. **<Spike Name>**: <What to explore> (Duration: X days)
   - Key questions to answer
   - Success criteria
   
2. **<Spike Name>**: <What to explore> (Duration: X days)
   - Key questions to answer
   - Success criteria

#### Schedule Recommendations
- **Base Development Time**: <X weeks/months>
- **Recommended Buffer**: <20%|35%|50%|70%>
- **Total Recommended Time**: <X weeks/months>
- **Iteration Cycles Expected**: <2-3|4-5|6+>

#### Process Adaptations
- [ ] Use iterative specification updates
- [ ] Plan for specification evolution
- [ ] Include learning capture phases
- [ ] Add reality checkpoints
- [ ] Budget for exploration spikes

### 4. Risk Mitigation Strategies

#### For AI/ML Risks
- <Specific mitigation strategies>

#### For Integration Risks
- <Specific mitigation strategies>

#### For Discovery Risks
- <Specific mitigation strategies>

### 5. Early Warning Indicators

Watch for these signs that complexity is higher than assessed:
- Specification changes needed after every spike
- Integration issues discovered late
- AI behavior surprising developers
- Timeline slipping despite effort
- Requirements changing significantly

### 6. Recommended Next Steps

1. **Immediate Actions**:
   - <What to do right now>
   
2. **Before Full Development**:
   - <What must be done first>
   
3. **During Development**:
   - <Ongoing practices needed>

## Appendix: Assessment Details

### Questions That Influenced Assessment
<List key questions and answers that drove the assessment>

### Assumptions Made
<List assumptions that may affect accuracy>

### Areas Needing Clarification
<What additional information would improve assessment>

### HLR Documents Analyzed
<List all files from reqs/hlr/ that were read>
<Summarize key requirements extracted from HLR>
```

## Quality Checks:

Before finalizing:
- [ ] All complexity factors considered
- [ ] Scoring is justified with evidence
- [ ] Recommendations are actionable
- [ ] Risks have mitigation strategies
- [ ] Next steps are clear
- [ ] Uncertainty is acknowledged

## Missing Information Output

After creating the Complexity Assessment, you MUST provide a chat output highlighting any gaps:

```
## 📋 Complexity Assessment Summary

### ✅ Assessment Completed
- [What was successfully assessed]

### ⚠️ Missing Information - HIGH Priority
- **[Area]**: [What information would significantly change assessment]

### 🔍 Missing Information - MEDIUM Priority
- **[Area]**: [What would refine the assessment]

### 🤔 Key Assumptions Made
- [Assumptions that could affect accuracy]

### 👉 Recommended Clarifications
1. [Specific information to gather]
2. [Stakeholders to consult]
```

## Update Progress Report

After completing complexity assessment:
1. Update `reqs/progress-report.md`:
   - Mark Stage 0 task 0.2 as complete: `[x] Complexity assessment (0.2)`
   - Record complexity score, recommended spikes, and buffer percentage
   - Update Stage 0 status to "Complete" if both tasks done
   - Add identified spikes to relevant stages (1.2, 2.2, 3.2)
   - Add to activity log: `<Date>: Complexity assessment completed - Score: X/10`
   - Update overall progress percentage
   - Add any major risks to blockers section

The complexity assessment shapes the entire project approach - document it well!

Remember: The goal is honest assessment that sets realistic expectations and guides appropriate process choices. It's better to overestimate complexity than underestimate it.