# Define User Success Criteria Prompt

You are tasked with defining concrete, measurable user success criteria that will drive all subsequent design decisions. This transforms the system purpose from "what it does" to "how users succeed."

## Your Mindset for User Success Definition

Before you begin, understand that you are:
- **A success architect**, defining what winning looks like for users
- **A measurement expert**, making success quantifiable
- **An outcome focuser**, not a feature lister
- **A user champion**, ensuring their goals drive technical goals

## Deep Thinking Framework

### Success Understanding (THINK DEEPLY - 15+ minutes):
1. **What does the user really want?**
   - Underlying need, not surface request?
   - Emotional outcome, not just functional?
   - Time/effort they're willing to invest?
   - How they'll know they succeeded?

2. **What would failure look like?**
   - Task abandonment scenarios?
   - Partial success frustrations?
   - Trust-breaking moments?
   - Wasted effort patterns?

3. **How do we measure success?**
   - Quantifiable user outcomes?
   - Time-based benchmarks?
   - Emotional satisfaction indicators?
   - Behavior change evidence?

## Instructions

### Step 1: Review Foundation Documents
1. Read user personas from `reqs/0-ux/personas/`
2. Review journey maps from `reqs/0-ux/journeys/`
3. Check success metrics from `reqs/0-ux/success-metrics.md`
4. Read current purpose document from `reqs/1-purpose/system-purpose.md`

### Step 2: Create/Update User Success Document

Create or update `reqs/1-purpose/user-success-criteria.md`:

```markdown
# User Success Criteria

## Primary Success Definition

### For [Primary Persona Name]
**When**: [Context/trigger for using system]
**Success Means**: [Specific, measurable outcome]
**Measured By**: [Concrete metric with target]
**Time Frame**: [Expected duration to success]
**Emotional Outcome**: [How they should feel]

### Success Scenario
```
1. User encounters [trigger/problem]
2. User [action with system] 
3. System [response that enables success]
4. User achieves [specific outcome]
5. User feels [emotional state]
Time elapsed: [target duration]
Effort required: [minimal/moderate/significant]
```

## Success Metrics Hierarchy

### Level 1: Critical Success (Must Have)
| Metric | Target | Why It Matters |
|--------|--------|----------------|
| [Core outcome metric] | [Specific value] | [User impact] |
| [Time to value] | <[X] minutes | [Frustration prevention] |
| [Error recovery rate] | 100% | [Trust maintenance] |

### Level 2: Quality Success (Should Have)
| Metric | Target | Why It Matters |
|--------|--------|----------------|
| [Efficiency metric] | [Value] | [User satisfaction] |
| [Learnability] | [Target] | [Adoption speed] |
| [Repeat usage] | >[X]% | [Ongoing value] |

### Level 3: Delight Success (Nice to Have)
| Metric | Target | Why It Matters |
|--------|--------|----------------|
| [Recommendation rate] | >[X] NPS | [Organic growth] |
| [Feature discovery] | [Value] | [Full value realization] |
| [Power user conversion] | [Target] | [Deep engagement] |

## Anti-Success Patterns

What would indicate failure even if technical goals are met:

1. **Silent Abandonment**: User completes task but never returns
   - Indicator: One-time usage >80%
   - Root cause: Too much effort for value received

2. **Grudging Usage**: User succeeds but frustrated
   - Indicator: Low satisfaction despite task completion
   - Root cause: Unnecessary complexity

3. **Partial Success**: User achieves less than intended
   - Indicator: Features unused, goals unmet
   - Root cause: Poor discovery or guidance

## Success Journey Milestones

### First Contact (0-30 seconds)
**Success**: User understands what's possible
**Failure**: User confused about purpose
**Metric**: Bounce rate <20%

### First Value (0-5 minutes)  
**Success**: User achieves meaningful outcome
**Failure**: User stuck in setup/learning
**Metric**: First success rate >80%

### First Return (1-7 days)
**Success**: User comes back voluntarily
**Failure**: One-time usage
**Metric**: 7-day retention >60%

### Habit Formation (30 days)
**Success**: Regular usage pattern established
**Failure**: Sporadic or declining usage
**Metric**: Weekly active usage >50%

## Context-Specific Success

### Scenario A: [Common Use Case]
- **User State**: [Starting context]
- **Success Looks Like**: [Specific outcome]
- **Success Metric**: [Measurable result]
- **Acceptable Duration**: [Time limit]

### Scenario B: [Edge Case]
- **User State**: [Challenging context]
- **Success Looks Like**: [Graceful handling]
- **Success Metric**: [Recovery rate]
- **Acceptable Duration**: [Extended time OK]

## Success Validation Questions

To verify our success criteria are correct:

1. Would [primary persona] agree this is success?
2. Can we measure this without invading privacy?
3. Is this achievable for 80%+ of target users?
4. Does this differentiate us from alternatives?
5. Will this drive the right technical decisions?

## Success-Driven Requirements

Based on these success criteria, the system MUST:

1. **[Requirement]** to enable **[Success Metric]**
2. **[Requirement]** to prevent **[Failure Mode]**
3. **[Requirement]** to ensure **[Emotional Outcome]**

## Open Questions About Success

1. [Assumption about user behavior needing validation]
2. [Uncertainty about success measurement]
3. [Trade-off between different success metrics]
```

### Step 3: Create Success Measurement Plan

Create `reqs/1-purpose/success-measurement-plan.md`:

```markdown
# Success Measurement Plan

## Measurement Strategy

### Pre-Launch Baseline
- Current state metrics (if applicable)
- User pain point quantification
- Alternative solution benchmarks

### Launch Metrics
- First interaction success rate
- Time to first value
- Task completion rate
- Error encounter and recovery rates

### Ongoing Metrics  
- Daily/Weekly/Monthly active usage
- Feature adoption rates
- User satisfaction scores
- Support ticket patterns

## Measurement Methods

### Quantitative Measures
1. **Analytics Events**
   - [Event]: Measures [metric]
   - [Event]: Measures [metric]

2. **Performance Metrics**
   - [Timing]: Indicates [success factor]
   - [Count]: Shows [usage pattern]

### Qualitative Measures
1. **User Feedback Loops**
   - In-app feedback prompts
   - Post-task micro-surveys  
   - Periodic satisfaction surveys

2. **Behavioral Observation**
   - Usage pattern analysis
   - Feature discovery tracking
   - Abandonment point identification

## Success Dashboard Mockup

```
┌──────────────────────────────────────────┐
│          Success Metrics Dashboard        │
├──────────────────────────────────────────┤
│                                          │
│ Primary Success Rate:    [85%] ✅        │
│ Time to First Value:     [3.2 min] ✅    │
│ 7-Day Retention:         [72%] ✅        │
│                                          │
│ Trending:                                │
│ • Task completion:       ↑ 5% this week  │
│ • User satisfaction:     → Stable at 4.2 │
│ • Error rate:           ↓ 2% improvement │
│                                          │
│ Needs Attention:                         │
│ • Feature X discovery:   Only 23% find   │
│ • Mobile experience:     Lower success   │
└──────────────────────────────────────────┘
```

## Success Review Cadence

- **Daily**: Critical error rates, abandonment spikes
- **Weekly**: Success rate trends, user feedback themes
- **Monthly**: Retention analysis, satisfaction scores
- **Quarterly**: Success criteria validation, metric evolution
```

### Step 4: Align Purpose with Success

Update the main purpose document to be success-driven:

1. Add a "User Success Summary" section at the top
2. Reframe purpose statements around user outcomes
3. Link business value to user success metrics
4. Ensure all stakeholders understand success = user success

## Quality Checks

Before proceeding:
- [ ] Success is defined from user perspective, not system
- [ ] All success criteria are measurable
- [ ] Time boundaries are set for each success metric
- [ ] Emotional outcomes are acknowledged
- [ ] Failure modes are explicitly defined
- [ ] Success drives requirements, not vice versa

## Common Pitfalls to Avoid

1. **Vanity Metrics**: Page views ≠ user success
2. **Feature Completion**: Built ≠ valuable
3. **Technical Success**: Working ≠ usable  
4. **Assumption-Based Targets**: Verify with user research
5. **Success Theater**: Real outcomes > impressive dashboards

## Integration with Existing Documents

This user success definition should:
1. Enhance (not replace) the system purpose document
2. Drive all subsequent strategy decisions
3. Inform component behavior specifications
4. Guide implementation priorities
5. Define testing scenarios

## Remember

> "User success is the only success that matters."

Every technical decision should trace back to enabling user success. If it doesn't help users succeed, it shouldn't be built.

## Next Steps

After defining user success:
1. Update system purpose to be success-driven
2. Proceed to strategy with success metrics as constraints
3. Ensure all team members understand success definitions
4. Set up measurement infrastructure early

## Update Progress Report

After completing user success definition:
1. Update `reqs/progress-report.md`:
   - Add task: `[x] Define user success criteria (1b)`
   - Record primary success metrics
   - Note any conflicts with original purpose
   - Update activity log
   - Flag if success criteria require purpose revision