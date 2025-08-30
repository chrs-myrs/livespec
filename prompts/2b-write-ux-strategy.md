# Write UX Strategy Documentation Prompt

You are tasked with documenting the user experience strategy that will guide all design and implementation decisions. This complements technical strategy with human-centered design principles.

## Your Mindset for UX Strategy

Before you begin, understand that you are:
- **An experience strategist**, designing for human needs
- **A complexity reducer**, finding simplest paths to value  
- **An interaction designer**, crafting conversations not features
- **A cognitive load minimizer**, respecting user mental capacity

## Deep Thinking Framework

### Strategic UX Decisions (THINK DEEPLY - 20+ minutes):
1. **What interaction paradigm fits our users?**
   - Conversational vs. dashboard?
   - Guided vs. exploratory?
   - Proactive vs. reactive?
   - Visual vs. textual?

2. **How do we handle complexity?**
   - What to hide vs. show?
   - Progressive disclosure strategy?
   - Sensible defaults?
   - Power user accommodations?

3. **What emotional tone do we set?**
   - Professional vs. friendly?
   - Serious vs. playful?
   - Minimal vs. rich?
   - Trust-building approach?

## Instructions

### Step 1: Review Foundation
1. Read UX requirements from `reqs/0-ux/`
2. Review user success criteria from `reqs/1-purpose/user-success-criteria.md`
3. Understand technical strategies from `reqs/2-strategy/`
4. Note constraints and opportunities

### Step 2: Create Core UX Strategy

Create `reqs/2-strategy/ux-interaction-strategy.md`:

```markdown
# UX Interaction Strategy

## Strategy Overview

### Core Principle
[One sentence capturing the essence of our UX approach]

### Interaction Paradigm
**Primary Model**: [Conversational/Dashboard/Wizard/Exploratory]
**Why This Works**: [Connection to user needs and context]
**Mental Model**: [What users already understand that we build on]

## Information Strategy

### Progressive Disclosure Philosophy
```
Level 0 (Pre-engagement):
- What: [Single value prop]
- How: [One-line description]

Level 1 (Default View):
- What: [20% that solves 80%]
- How: [Executive summary + top actions]

Level 2 (Engaged User):
- What: [Detailed options and controls]
- How: [Grouped by user mental model]

Level 3 (Power User):
- What: [Full access and customization]
- How: [Command palette / advanced mode]
```

### Information Hierarchy Principles
1. **Most Important**: [What always shows]
2. **Contextually Important**: [What shows when relevant]
3. **Available on Demand**: [What users can access]
4. **Hidden Complexity**: [What we handle invisibly]

### Decision Support Strategy
- **Default Recommendations**: [How we guide choices]
- **Comparison Display**: [How we show options]
- **Confidence Building**: [How we ensure good decisions]
- **Undo/Recovery**: [How we handle mistakes]

## Interaction Patterns

### Primary Interaction Loop
```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Trigger   │ --> │  System     │ --> │   User      │
│   (User     │     │  Response   │     │   Action    │
│   Need)     │     │  (Guide)    │     │  (Decide)   │
└─────────────┘     └─────────────┘     └─────────────┘
                            │
                            v
                    ┌─────────────┐     ┌─────────────┐
                    │  Outcome    │ <-- │  System     │
                    │  (Success)  │     │  Confirm    │
                    └─────────────┘     └─────────────┘
```

### Conversation Design
**Tone**: [Professional/Friendly/Neutral]
**Reading Level**: [Grade level target]
**Personality**: [How the system "speaks"]

**Example Interactions**:
```
System: "I found 3 quick ways to free up 50GB. Want to see them?"
User: [Yes]
System: "Here's the easiest one: Old downloads from 2019 (20GB). 
         These haven't been opened in 4 years. Safe to remove?"
User: [Yes / Let me check / Skip]
```

### Error Handling Philosophy
1. **Prevent Before Correct**: Stop errors before they happen
2. **Explain Don't Blame**: "This needs..." not "You failed to..."
3. **Provide Next Steps**: Every error includes recovery path
4. **Learn From Patterns**: Adapt to prevent repeated errors

## Cognitive Load Management

### Attention Budget
- **First Glance** (2 seconds): [What must be understood]
- **Initial Scan** (10 seconds): [Key information absorbed]
- **Decision Point** (30 seconds): [Enough context to act]
- **Deep Dive** (2+ minutes): [Optional additional detail]

### Complexity Reduction Tactics
1. **Smart Defaults**: 
   - [Default 1]: Covers [X]% of use cases
   - [Default 2]: Based on [user context]

2. **Bundled Decisions**:
   - Group related choices
   - Offer "recommended sets"
   - Allow unbundling for power users

3. **Just-in-Time Information**:
   - Show info when decision needed
   - Hide until relevant
   - Teach through usage

### Memory Load Minimization
- **Recognition Over Recall**: Show options, don't require memory
- **Consistent Patterns**: Same action = same location
- **Visual Anchors**: Icons/colors for quick recognition
- **State Persistence**: Remember user context

## Engagement Strategy

### Onboarding Approach
**First-Run Experience**:
```
1. Welcome & Value Prop (10 seconds)
   "Help you [achieve outcome] in [time]"

2. Minimal Setup (30 seconds)
   - Only essential config
   - Smart defaults
   - Skip option

3. Quick Win (2 minutes)
   - Immediate value delivery
   - Success confirmation
   - What's next prompt
```

### Habit Formation
- **Trigger Design**: [What brings users back]
- **Variable Rewards**: [Surprise delight moments]
- **Progress Indicators**: [Show advancement]
- **Investment Capture**: [User customization that adds value]

### Learning Curve Strategy
```
Day 1:  Basic success with one feature
Week 1: Discover 2-3 core features naturally
Month 1: Comfortable with 80% of common tasks
Month 3: Power user features discovered organically
```

## Emotional Design

### Trust Building
1. **Transparency**: Show what will happen before it happens
2. **Control**: User can always undo/stop/adjust
3. **Competence**: System demonstrates intelligence appropriately
4. **Benevolence**: System acts in user's interest

### Delight Moments
- [Moment 1]: Unexpected helpfulness
- [Moment 2]: Celebrating user success
- [Moment 3]: Anticipating needs

### Stress Reduction
- Clear escape routes
- No irreversible actions without confirmation
- Calm error messages
- Progress save points

## Responsive Design Strategy

### Context Adaptation
1. **Device Awareness**:
   - Desktop: Full information density
   - Tablet: Touch-optimized, medium density
   - Mobile: Essential actions only
   - CLI: Keyboard-driven efficiency

2. **Situation Awareness**:
   - First use: More guidance
   - Returning: Skip to action
   - Power mode: Dense information
   - Accessibility: Full compatibility

### Performance Perception
- **Instant** (<100ms): Interface reactions
- **Fast** (<1second): Simple operations
- **Loading** (1-3s): Show progress
- **Background** (3s+): Allow other actions

## Anti-Patterns to Avoid

1. **Feature Creep**: Every feature adds cognitive load
2. **Democracy Design**: Not all user requests improve UX
3. **Power User Bias**: Don't design for edge cases
4. **Analysis Paralysis**: Too many options = no decision
5. **Dark Patterns**: Never trick or trap users

## Success Metrics for UX Strategy

- **Task Success Rate**: >90% complete primary task
- **Time to Value**: <5 minutes to first success
- **Error Recovery**: 100% of errors have clear paths
- **Feature Discovery**: Core features found naturally
- **Satisfaction Score**: >4.0/5.0 consistently

## Open UX Strategy Questions

1. [Trade-off between simplicity and power]
2. [Assumption about user behavior]
3. [Design pattern that needs testing]
```

### Step 3: Create Feedback and Learning Strategy

Create `reqs/2-strategy/feedback-learning-strategy.md`:

```markdown
# Feedback and Learning Strategy

## Continuous Learning Approach

### Implicit Learning
What the system learns without asking:
- Usage patterns
- Feature preferences  
- Error frequencies
- Time-of-day patterns
- Success/failure ratios

### Explicit Learning
When and how we ask users:
- Post-success micro-feedback
- Periodic preference checks
- Feature request capture
- Frustration point identification

### Adaptive Behavior
How the system evolves:
1. **Personalized Defaults**: Based on past choices
2. **Suggested Actions**: Based on similar users
3. **Hidden Complexity**: Features not used fade
4. **Proactive Help**: Assistance for struggled areas

## Feedback Collection Strategy

### In-Context Feedback
```
After successful action:
┌────────────────────────────────┐
│ ✅ Space freed: 25GB           │
│                                │
│ Was this helpful?              │
│ [😊] [😐] [😟]                 │
└────────────────────────────────┘
```

### Periodic Check-ins
- Weekly: "How's it going?" (if actively used)
- Monthly: "Any frustrations?" (if sporadic use)
- Quarterly: "What would make this better?"

### Behavioral Feedback
Actions that indicate satisfaction/frustration:
- Rapid repeated attempts = confusion
- Quick task completion = good flow
- Session abandonment = frustration
- Feature exploration = engagement

## Privacy-First Learning

What we track (with permission):
- Aggregated usage patterns
- Feature success rates
- Error frequencies

What we never track:
- Personal data content
- Individual file information
- Identifying behaviors

User Control:
- Clear data usage explanation
- Opt-out always available
- Data deletion on request
- Export personal adaptations
```

### Step 4: Create Accessibility and Inclusion Strategy

Create `reqs/2-strategy/accessibility-inclusion-strategy.md`:

```markdown
# Accessibility and Inclusion Strategy

## Core Commitment
Every user, regardless of ability or context, can successfully use our system.

## Accessibility Standards
- **WCAG 2.1 AA** compliance minimum
- **Section 508** compatibility
- **Mobile Accessibility** guidelines
- **Cognitive Accessibility** considerations

## Inclusive Design Principles

### 1. Perceivable
- All information available in multiple formats
- Text alternatives for visual elements
- Sufficient contrast ratios (4.5:1 minimum)
- Resizable text without breaking layout

### 2. Operable  
- Keyboard navigation for everything
- No time limits without extensions
- Skip navigation options
- Clear focus indicators

### 3. Understandable
- Plain language (8th grade level)
- Consistent navigation patterns
- Error messages that help
- Contextual help available

### 4. Robust
- Standards-compliant code
- Assistive technology compatible
- Progressive enhancement
- Graceful degradation

## Specific Accommodations

### Visual Impairments
- Screen reader optimization
- High contrast mode
- Large text options
- No color-only information

### Motor Impairments
- Large click targets (44x44px minimum)
- Keyboard shortcuts
- Voice control support
- No precision timing required

### Cognitive Differences
- Clear, simple language
- One task per screen
- Consistent patterns
- No cognitive overload

### Temporary Impairments
- One-handed operation
- Work in bright sunlight
- Noisy environments
- Slow connections

## Testing Strategy
- Automated accessibility testing
- Screen reader testing
- Keyboard-only testing
- User testing with diverse abilities
```

## Quality Checks

Before proceeding:
- [ ] UX strategy aligns with user success criteria
- [ ] Progressive disclosure strategy is clear
- [ ] Cognitive load is actively managed
- [ ] Emotional design is intentional
- [ ] Accessibility is built-in, not bolted-on
- [ ] Learning strategy respects privacy

## Remember

> "Good UX is invisible. Great UX is inevitable."

The UX strategy should make success feel natural and failure feel impossible. Every interaction should move users closer to their goals with minimal friction.

## Next Steps

After completing UX strategy:
1. Ensure technical strategy aligns with UX strategy
2. Proceed to design with these principles
3. Create interaction pattern library
4. Set up feedback collection infrastructure

## Update Progress Report

After completing UX strategy:
1. Update `reqs/progress-report.md`:
   - Add task: `[x] Write UX strategy (2b)`
   - Note key interaction paradigm chosen
   - Record accessibility commitment level
   - Update activity log
   - Flag any conflicts with technical strategy