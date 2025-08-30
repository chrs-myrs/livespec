# UX Requirements Discovery Prompt

You are tasked with discovering and documenting user experience requirements BEFORE any technical design begins. This is a mandatory gate that must be completed before writing system purpose.

## Your Mindset for UX Discovery

Before you begin, understand that you are:
- **A user advocate**, not a technologist
- **An experience designer**, focusing on user success
- **A researcher**, gathering evidence about user needs
- **A simplifier**, finding the 20% that serves 80% of needs

## Deep Thinking Framework

### User Understanding (THINK DEEPLY - 20+ minutes):
1. **Who is the primary user?**
   - Technical skill level?
   - Context of use?
   - Emotional state when using?
   - Alternative solutions they use now?

2. **What does success look like for them?**
   - Concrete, measurable outcomes?
   - Time constraints?
   - Quality expectations?
   - Emotional satisfaction?

3. **What could go wrong?**
   - Common mistakes?
   - Frustration points?
   - Abandonment triggers?
   - Trust breakers?

## Instructions

### Step 1: Analyze Available Information
1. Check for existing requirements in `reqs/hlr/`
2. Look for user feedback or requests
3. Identify implicit user needs in technical requirements
4. Note what's missing about users

### Step 2: Create User Personas

Create 1-3 personas in `reqs/0-ux/personas/`. Each should include:

```markdown
# Persona: [Descriptive Name]

## Profile
- **Technical Level**: [Novice/Intermediate/Expert]
- **Context**: [When/where they use this]
- **Frequency**: [Daily/Weekly/Occasional]
- **Motivation**: [Why they need this]

## Goals
1. [Primary goal - what success means]
2. [Secondary goals]
3. [Hidden goals - emotional needs]

## Frustrations with Current Solutions
- [What doesn't work now]
- [What takes too long]
- [What confuses them]

## Success Criteria
- [Measurable outcome 1]
- [Measurable outcome 2]
- [Time/effort expectations]

## Quotes
> "[Something they would actually say]"
> "[Their complaint about current state]"
> "[Their wish for ideal solution]"

## Anti-Patterns
Things this user would hate:
- [Specific friction point]
- [Deal breaker]
```

### Step 3: Map User Journeys

Create journey maps in `reqs/0-ux/journeys/` for primary scenarios:

```markdown
# User Journey: [Primary Task Name]

## Overview
**User**: [Which persona]
**Goal**: [What they're trying to achieve]
**Success**: [Measurable outcome]
**Current Pain**: [Why this is hard today]

## Journey Stages

### 1. Problem Recognition
**Trigger**: [What makes them realize they need help]
**User State**: [Emotional/mental state]
**Questions**: [What they're wondering]
```text
User thinks: "..."
```

### 2. Solution Discovery
**How They Find Us**: [Search? Recommendation? System prompt?]
**First Impression Needs**: [What must they see immediately]
**Trust Builders**: [What makes them proceed]
**Abandonment Risks**: [What makes them leave]

### 3. Initial Engagement
**Entry Point**: [First interaction]
**Information Needs**: 
```
┌─────────────────────────────────┐
│ They need to see:               │
│ • [Key info 1]                  │
│ • [Key info 2]                  │
│ • [Clear next action]           │
└─────────────────────────────────┘
```
**Cognitive Load**: [Low/Medium/High]
**Decision Support**: [What helps them decide]

### 4. Core Task Execution
**Progressive Disclosure**:
- Level 1: [Minimum viable info]
- Level 2: [Common additional needs]  
- Level 3: [Power user features]

**Interaction Pattern**:
```
User does → System shows → User decides → System confirms
```

### 5. Success Confirmation
**Success Indicators**: [How they know it worked]
**Emotional Payoff**: [How they should feel]
**Next Actions**: [What they do after success]

## Critical Moments
1. **Moment of Truth**: [When they decide to trust/proceed]
2. **Potential Failure**: [Where they might get stuck]
3. **Delight Opportunity**: [Where to exceed expectations]
```

### Step 4: Define Success Metrics

Create `reqs/0-ux/success-metrics.md`:

```markdown
# User Success Metrics

## Primary Success Metrics
1. **Task Completion Rate**: [X]% of users successfully [complete primary task]
2. **Time to Value**: Users achieve [outcome] within [X] minutes
3. **Confidence Score**: [X]% of users feel confident about [actions taken]

## Engagement Metrics
- **Abandonment Rate**: <[X]% leave without completing task
- **Return Usage**: >[X]% use again within [timeframe]
- **Recommendation Score**: >[X] NPS score

## Usability Targets
- **Learnability**: New users succeed without documentation
- **Efficiency**: Experienced users complete task in <[X] steps
- **Error Recovery**: 100% of errors have clear recovery paths
- **Accessibility**: Meets WCAG 2.1 AA standards

## Emotional Metrics
- Users feel: [empowered/confident/relieved]
- Users don't feel: [frustrated/confused/worried]

## Anti-Metrics (What We DON'T Optimize For)
- Feature count
- Technical sophistication  
- Comprehensive coverage at expense of clarity
```

### Step 5: Create Information Architecture

Create `reqs/0-ux/information-architecture.md`:

```markdown
# Information Architecture

## Core Principle
Show the minimum information needed for confident decisions, with optional depth available.

## Information Hierarchy

### Level 1: Executive Summary (Default)
**Purpose**: Enable decision in <30 seconds
**Contains**:
- [Single number/status that matters most]
- [Top 3-5 actions available]
- [Clearest next step]

**ASCII Mockup**:
```
┌────────────────────────────────────┐
│ [Primary Status]                   │
│                                    │  
│ [Key Metric]: [Value]              │
│                                    │
│ Top Actions:                       │
│ 1. [Most Common Action]      [Do]  │
│ 2. [Second Action]           [Do]  │
│ 3. [Third Action]            [Do]  │
│                                    │
│ [Primary CTA]  [Learn More]        │
└────────────────────────────────────┘
```

### Level 2: Grouped Details (One Click)
**Purpose**: Understand categories and scope
**Organized By**: [User mental model, not system architecture]

### Level 3: Full Details (Power Users)
**Purpose**: Complete control and visibility
**Access**: Progressive, not default
```

### Step 6: Write UX Requirements Summary

Create `reqs/0-ux/ux-requirements-summary.md`:

```markdown
# UX Requirements Summary

## Users First
**Primary User**: [Specific persona name and description]
**Core Need**: [What they're really trying to accomplish]
**Success**: [How they measure success]

## Design Principles
1. **[Principle 1]**: [How it manifests]
2. **[Principle 2]**: [How it manifests]
3. **[Principle 3]**: [How it manifests]

## Non-Negotiable UX Requirements
1. **First Contact**: User understands value in <10 seconds
2. **First Success**: User achieves meaningful outcome in <5 minutes
3. **Error Recovery**: Every error includes clear next steps
4. **Progressive Disclosure**: Start simple, depth on demand
5. **Context Over Data**: Every piece of information helps decision-making

## Interaction Patterns
- **Primary Pattern**: [e.g., Question→Answer→Action]
- **Feedback Loop**: [How system confirms actions]
- **Learning Curve**: [Flat/Gradual/Steep - must be Flat]

## What We're NOT Building
- [Feature that adds complexity without user value]
- [Technical capability that users don't need]
- [Optimization that hurts usability]

## Open UX Questions
1. [Question about user preference/behavior]
2. [Question about workflow integration]
3. [Question needing user testing]
```

## Quality Checks

Before proceeding to Stage 1:
- [ ] At least one detailed persona created
- [ ] Primary user journey mapped
- [ ] Success metrics defined and measurable
- [ ] Information architecture sketched
- [ ] Progressive disclosure strategy clear
- [ ] Anti-patterns explicitly listed

## Common Pitfalls to Avoid

1. **Generic Users**: "All users" is not a persona
2. **Feature Lists**: Focus on outcomes, not capabilities
3. **Technical Thinking**: Remove all technical jargon
4. **Assumptions**: Mark all assumptions for validation
5. **Complex Defaults**: If it needs explanation, it's too complex

## Output Format

When complete, you should have:
```
reqs/0-ux/
├── personas/
│   ├── primary-persona.md
│   └── secondary-persona.md
├── journeys/
│   ├── first-time-use.md
│   └── core-task-journey.md
├── success-metrics.md
├── information-architecture.md
└── ux-requirements-summary.md
```

## Remember

> "If users can't use it, nothing else matters."

The best technical implementation of the wrong user experience is still a failure. These UX requirements will drive ALL subsequent technical decisions.

## Next Steps

After completing UX discovery:
1. Proceed to `1a-write-purpose.md` with user-centric focus
2. Ensure purpose document references these UX requirements
3. All subsequent stages must align with these user needs

## Update Progress Report

After completing UX discovery:
1. Update `reqs/progress-report.md`:
   - Add new stage 0c task: `[x] UX requirements discovery (0c)`
   - Record number of personas created
   - Note key user success metrics
   - Add to activity log
   - Flag any major UX risks discovered