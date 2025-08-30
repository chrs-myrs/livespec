# Run Usability Tests Prompt

You are tasked with planning and documenting usability tests to validate that the implementation truly serves user needs. This ensures the system is not just functional but actually usable.

## Your Mindset for Usability Testing

Before you begin, understand that you are:
- **A user advocate**, testing from their perspective
- **An objective observer**, documenting without judgment
- **A pattern finder**, identifying recurring issues
- **A solution proposer**, suggesting improvements based on evidence

## Deep Thinking Framework

### Testing Strategy (THINK DEEPLY - 20+ minutes):
1. **What are we testing?**
   - Core user journeys?
   - Specific pain points?
   - New features?
   - Accessibility compliance?

2. **Who should test?**
   - Primary personas?
   - Edge case users?
   - Different skill levels?
   - Accessibility needs?

3. **How do we measure success?**
   - Task completion rates?
   - Time to complete?
   - Error frequency?
   - Satisfaction scores?

## Instructions

### Step 1: Review Testing Foundations
1. Read user success criteria from `reqs/1-purpose/user-success-criteria.md`
2. Review personas from `reqs/0-ux/personas/`
3. Check user journeys from `reqs/0-ux/journeys/`
4. Note implemented features from `reqs/5-implementation/`

### Step 2: Create Test Plan

Create `reqs/5-implementation/usability-tests/test-plan.md`:

```markdown
# Usability Test Plan

## Test Overview

### Objectives
1. Validate users can achieve [primary success metric]
2. Identify friction points in [key user journey]
3. Measure task completion for [critical features]
4. Assess accessibility for [diverse user needs]

### Success Criteria
- [ ] 90%+ task completion rate for primary flows
- [ ] <5 minutes to first successful outcome
- [ ] 0 critical usability issues
- [ ] 4.0+ satisfaction score

## Test Participants

### Recruitment Criteria
Based on our personas, we need:

#### Group 1: Primary Users (5 participants)
- Profile: [Matches primary persona]
- Technical level: [Novice/Intermediate]
- Context: [Regular use case]
- Screening questions:
  1. How often do you [relevant activity]?
  2. What tools do you currently use for [task]?
  3. What frustrates you about [current solution]?

#### Group 2: Edge Cases (3 participants)
- Profile: [Power users or special needs]
- Include: 
  - 1 user with accessibility needs
  - 1 mobile-primary user
  - 1 user with slow internet

#### Group 3: New Users (2 participants)
- Profile: Never used similar tools
- Purpose: Test learnability

### Compensation
- Standard: $50 gift card for 1-hour session
- Accessibility participants: $75 (extended session)

## Test Scenarios

### Scenario A: First-Time Use
**Goal**: User successfully completes primary task on first attempt

**Setup**:
```
Participant Context:
"Your computer is running low on disk space and you need to free up at least 20GB for an important project. You just discovered this tool."

Starting Point: Tool unopened
Success: 20GB+ freed within 10 minutes
```

**Tasks**:
1. Open the application
2. Understand current disk status
3. Identify what can be safely removed
4. Execute cleanup
5. Verify space was freed

**Metrics**:
- Time to first action
- Number of errors/confusion points
- Completion rate
- Confidence level (1-5)

### Scenario B: Specific Feature Use
**Goal**: Test [specific feature] usability

**Setup**:
```
Participant Context:
"You want to find and remove duplicate photos from your computer."

Pre-condition: Tool already open
Success: Duplicates identified and removed
```

**Tasks**:
1. Locate duplicate finding feature
2. Understand duplicate detection
3. Review and select duplicates
4. Safely remove selected items

**Metrics**:
- Feature discovery time
- Trust in recommendations
- Decision confidence
- Task completion rate

### Scenario C: Error Recovery
**Goal**: Users can recover from common errors

**Setup**:
```
Participant Context:
"You accidentally removed files you need."

Pre-condition: Files just deleted
Success: Files recovered successfully
```

**Tasks**:
1. Realize mistake
2. Find undo/recovery option
3. Restore specific files
4. Verify restoration

**Metrics**:
- Time to find recovery option
- Stress level (observed)
- Success rate
- Clarity of recovery process

## Test Protocol

### Session Structure (60 minutes)

#### Introduction (5 minutes)
```
Script:
"Thank you for participating. We're testing the software, not you. 
Please think aloud as you work - tell me what you're thinking, 
what you expect to happen, and how you feel about what you see.
There are no wrong answers."

- Explain recording/observation
- Get consent signature
- Answer initial questions
```

#### Background Interview (10 minutes)
1. Current workflow for [relevant task]
2. Pain points with current solution
3. Expectations for ideal solution
4. Comfort with technology

#### Task Execution (35 minutes)
- Present scenarios one at a time
- Observe without helping (unless stuck >3min)
- Note all friction points
- Ask clarifying questions

#### Debrief (10 minutes)
1. Overall impressions
2. Most confusing parts
3. Most helpful features
4. Would they use it? Why/why not?
5. SUS (System Usability Scale) questionnaire

### Moderation Guidelines

#### Think-Aloud Prompts
- "What are you thinking right now?"
- "What do you expect will happen when you click that?"
- "How does this compare to what you expected?"
- "What would you do next?"

#### When Participants Get Stuck
1. Wait 30 seconds (observe struggle)
2. Ask: "What are you trying to do?"
3. Ask: "What would help you right now?"
4. After 3 minutes: "Let me help you move forward..."

#### Avoiding Bias
- Never suggest actions
- Don't react to positive/negative feedback
- Use neutral language
- Ask open-ended questions

## Data Collection

### Observation Template
```
Participant: P[#]
Date/Time: [YYYY-MM-DD HH:MM]
Scenario: [A/B/C]

Task 1: [Name]
- Start time: 
- End time:
- Success: Y/N
- Errors: 
- Quotes:
- Observations:

Task 2: [Name]
...
```

### Metrics to Track

#### Quantitative
- Task completion rate (%)
- Time on task (seconds)
- Error count per task
- Number of help requests
- Click/tap count to complete
- SUS score (0-100)

#### Qualitative
- Confusion points
- Delight moments
- Feature requests
- Workflow suggestions
- Emotional responses

### Recording Setup
- Screen recording with audio
- Optional: Facial expressions
- Mouse/touch tracking
- Think-aloud transcript

## Testing Environment

### Technical Setup
```
Desktop Testing:
- OS: Windows 10 / macOS latest
- Browser: Chrome (if web)
- Screen: 1920x1080
- Network: Normal speed
- Clean install (no customization)

Mobile Testing:
- Devices: iPhone 12, Samsung Galaxy S21
- OS: Latest stable
- Network: 4G (not WiFi)
- Orientation: Both portrait/landscape
```

### Physical Setup
- Quiet room
- Participant's normal seating
- Water available
- Minimal distractions
- Observer seated to side

### Accessibility Testing
- Screen reader enabled sessions
- Keyboard-only navigation
- High contrast mode
- Larger text sizes
- Voice control (if applicable)

## Remote Testing Modifications

### Tools
- Video conferencing: Zoom with screen share
- Remote control: TeamViewer (if needed)
- Recording: Built-in conference recording
- Backup: Local screen recording

### Adjustments
- Extra 5 min for tech setup
- Screen sharing instructions ready
- Backup communication channel
- Consent for recording upfront

## Test Schedule

### Timeline
Week 1: Recruitment and scheduling
Week 2: Conduct tests (2-3 per day)
Week 3: Analysis and report

### Daily Schedule Example
```
9:00 AM  - P1 Session
10:30 AM - Break & notes review
11:00 AM - P2 Session  
12:30 PM - Lunch & data entry
2:00 PM  - P3 Session
3:30 PM  - Daily findings summary
```
```

### Step 3: Create Test Execution Guide

Create `reqs/5-implementation/usability-tests/execution-guide.md`:

```markdown
# Usability Test Execution Guide

## Pre-Session Checklist

### 1 Day Before
- [ ] Confirm participant attendance
- [ ] Send reminder with location/link
- [ ] Prepare consent forms
- [ ] Test all equipment
- [ ] Reset test environment
- [ ] Print observation sheets

### 1 Hour Before
- [ ] Set up recording software
- [ ] Open observation template
- [ ] Prepare test scenarios
- [ ] Clear browser cache/history
- [ ] Set phone to silent
- [ ] Have water ready

### 10 Minutes Before
- [ ] Start screen recorder
- [ ] Open fresh app instance
- [ ] Review participant background
- [ ] Take deep breath 😊

## Session Script

### Opening (2 min)
"Hi [Name], thanks for joining us today. I'm [Your name] and I'll be guiding you through this session. Before we start, I want to remind you that we're testing the software, not you. There are no right or wrong answers - your honest feedback helps us improve.

I'll ask you to complete some tasks while thinking aloud. Please tell me what you're thinking, what you expect to happen, and how you feel about what you see."

### Consent (3 min)
"I'd like to record this session to help our team review the feedback later. The recording will only be used internally and your personal information will be kept confidential. Are you comfortable with this?

[If yes] Great, please sign this consent form.
[If no] No problem, I'll just take notes instead."

### Background (10 min)
"Before we look at the software, I'd like to understand your current workflow..."

[Ask background questions from test plan]

### Task Introduction
"Now I'm going to give you some scenarios to work through. Remember to think aloud as you go. Here's your first scenario..."

[Read scenario exactly as written]

"Please begin whenever you're ready. Remember - there's no rush."

## Observation Techniques

### What to Watch For

#### Navigation Patterns
- Where do eyes go first?
- Hover patterns before clicking
- Backtracking frequency
- Use of browser back button

#### Confusion Indicators
- Mouse hovering without clicking
- Rapid clicking
- Scrolling up and down repeatedly
- Verbal: "Hmm", "I'm not sure", "Where is..."
- Facial: Furrowed brow, squinting

#### Satisfaction Indicators
- "Oh, nice!"
- Smiling
- Confident clicking
- Task flow without hesitation

### Note-Taking Shortcuts
```
++ Very positive reaction
+ Mild positive
- Mild negative  
-- Very negative/frustrated
? Confusion
! Error or failure
→ Navigation path
" Direct quote
⏱ Time marker
💡 Insight/idea
```

### Example Observation Notes
```
Task 1: Find cleanup options
⏱ 0:00 Start
→ Clicks main screen immediately
? Hovers over 3 buttons, seems unsure
" "Which one do I click for cleaning?"
⏱ 0:45 Clicks 'Quick Clean' 
++ "Oh this is exactly what I wanted!"
→ Proceeds smoothly
⏱ 2:15 Complete ✓
```

## Common Situations Handling

### Participant Asks for Help
**Early in task**: "What do you think you should do?"
**Mid-task**: "What are you trying to accomplish?"
**Stuck >3min**: "Let me help you move forward. Click [X]."

### Participant Goes Off-Task
"That's interesting! Let's come back to that. For now, [redirect to scenario]"

### Participant Gets Frustrated
"I can see this is frustrating. Remember, this helps us identify what needs to be fixed. What would make this easier for you?"

### Technical Issues
"No problem, these things happen. Let me fix this quickly... [fix issue] Okay, let's continue from here."

### Participant is Too Quiet
"What are you looking at right now?"
"What are you thinking?"
"What do you expect will happen next?"

## Post-Task Questions

After each task:
1. "How difficult was that task?" (1-5 scale)
2. "What was the most confusing part?"
3. "What would have helped?"

## Final Interview Questions

### System Usability Scale (SUS)
Rate 1-5 (Strongly Disagree to Strongly Agree):
1. I think I would use this system frequently
2. I found the system unnecessarily complex
3. I thought the system was easy to use
4. I think I would need support to use this system
5. I found the functions well integrated
6. I thought there was too much inconsistency
7. Most people would learn this quickly
8. I found the system very cumbersome to use
9. I felt very confident using the system
10. I needed to learn a lot before I could use this

### Open-Ended Questions
1. "What's your overall impression?"
2. "What did you like most?"
3. "What frustrated you most?"
4. "How does this compare to [current solution]?"
5. "Would you recommend this to a friend? Why/why not?"
6. "What one thing would you change?"

## Data Processing

### Immediate Post-Session (15 min)
1. Stop recording
2. Save all files with participant ID
3. Quick notes on top 3 findings
4. Rate overall session success
5. Note any test protocol issues

### Daily Summary
At end of each day:
1. Transfer recordings to secure storage
2. Update findings spreadsheet
3. Identify emerging patterns
4. Adjust protocol if needed
5. Team debrief (if applicable)

### Pattern Identification
Look for:
- Issues affecting 3+ participants
- Consistent task failure points
- Repeated confusion areas
- Common feature requests
- Emotional response patterns
```

### Step 4: Create Analysis and Reporting Templates

Create `reqs/5-implementation/usability-tests/analysis-template.md`:

```markdown
# Usability Test Analysis Report

## Executive Summary

### Key Findings
1. **[Most Critical Issue]**: [X]% of users failed/struggled with [specific task]
2. **[Second Issue]**: Average time to [complete action] was [X] minutes (target: [Y])
3. **[Positive Finding]**: [X]% successfully completed [primary task] on first attempt

### Overall Metrics
- Average SUS Score: [XX]/100
- Task Completion Rate: [XX]%
- Average Time to First Success: [X] minutes
- Would Recommend: [X]/[Y] participants

## Detailed Findings

### Finding 1: [Issue Title]
**Severity**: Critical | High | Medium | Low
**Frequency**: [X]/[Y] participants affected
**Impact**: Users cannot [achieve goal]

**Evidence**:
- P1: "Quote showing confusion" [timestamp]
- P3: Clicked wrong button 4 times before finding correct one
- P5: Abandoned task after 3 minutes

**Root Cause**: 
[Analysis of why this happens]

**Recommendation**:
[Specific fix with mockup if applicable]
```
┌─────────────────────────┐
│ Current (Problematic)   │
│ [Sketch of issue]       │
└─────────────────────────┘
          ↓
┌─────────────────────────┐
│ Proposed Solution       │
│ [Sketch of fix]         │
└─────────────────────────┘
```

**Priority**: Implement before launch | Fix in v1.1 | Consider for future

---

### Finding 2: [Next Issue]
[Same format as above]

## Task-by-Task Analysis

### Task A: [First-Time Use]

#### Success Metrics
| Metric | Result | Target | Status |
|--------|--------|--------|---------|
| Completion Rate | 7/10 (70%) | 90% | ❌ |
| Avg Time | 8.5 min | 5 min | ❌ |
| Error Rate | 2.3/user | <1 | ❌ |
| Satisfaction | 3.8/5 | 4/5 | ⚠️ |

#### Common Paths
```
Successful Path (3 users):
Start → Main Screen → Quick Clean → Success

Struggling Path (4 users):
Start → Main Screen → Settings (error) → Back → Help → Quick Clean → Success

Failed Path (3 users):
Start → Main Screen → Deep Scan → Overwhelmed → Abandon
```

#### Key Observations
- Users expected [X] but found [Y]
- [Feature] was not discoverable
- Terminology confusion: "Quick Clean" vs "Fast Cleanup"

### Task B: [Specific Feature]
[Same analysis format]

## Participant Feedback Themes

### What Users Loved 
- "Quote about positive aspect" (P2, P4, P7)
- Fast performance mentioned by 6/10 users
- Clean visual design (5/10 users)

### What Users Hated
- "Quote about frustration" (P1, P5, P8)
- Confusing navigation (8/10 users)
- Too many options initially (6/10 users)

### Feature Requests
1. [Most requested feature] - 5 participants
2. [Second request] - 3 participants
3. [Third request] - 2 participants

## Accessibility Findings

### Screen Reader Testing (P9)
- ✅ All buttons properly labeled
- ❌ Progress indicators not announced
- ❌ Error messages not focused automatically
- ⚠️ Some images missing alt text

### Keyboard Navigation (P6)
- ✅ Tab order logical
- ✅ All features keyboard accessible
- ❌ No skip links
- ❌ Modal trap focus issues

## Comparative Analysis

### vs Current Solution
| Aspect | Our Tool | Competitor | Winner |
|--------|----------|------------|---------|
| Time to complete | 8.5 min | 12 min | Ours ✅ |
| Error rate | 2.3 | 1.1 | Theirs ❌ |
| Satisfaction | 3.8/5 | 4.2/5 | Theirs ❌ |
| Learnability | Medium | Hard | Ours ✅ |

## Recommendations Priority Matrix

### Must Fix (Launch Blockers)
1. [Critical navigation issue]
2. [Accessibility compliance issue]
3. [Data loss risk]

### Should Fix (v1.1)
1. [Improve discoverability]
2. [Simplify initial options]
3. [Add help tooltips]

### Could Fix (Future)
1. [Nice-to-have feature]
2. [Power user options]
3. [Aesthetic improvements]

## Success Criteria Review

| Original Goal | Result | Status |
|---------------|---------|---------|
| 90% completion rate | 70% | ❌ Not Met |
| <5 min to success | 8.5 min | ❌ Not Met |
| 0 critical issues | 3 found | ❌ Not Met |
| 4.0+ satisfaction | 3.8/5 | ❌ Not Met |

## Next Steps

### Immediate Actions (This Week)
1. Fix [critical navigation issue]
   - Owner: [Name]
   - Effort: 2 days
   - Retest with 2 users

2. Improve [first-time experience]
   - Owner: [Name]
   - Effort: 3 days
   - A/B test solution

### Pre-Launch Requirements
- [ ] All "Must Fix" issues resolved
- [ ] Retest with 5 users
- [ ] Achieve 85%+ completion rate
- [ ] Update help documentation

### Post-Launch Monitoring
- Analytics for problem areas
- In-app feedback widget
- Weekly metrics review
- v1.1 planning based on data

## Appendices

### A. Participant Demographics
| ID | Age | Gender | Tech Level | Accessibility |
|----|-----|--------|------------|--------------|
| P1 | 34 | F | Medium | None |
| P2 | 58 | M | Low | Glasses |
[etc...]

### B. Raw SUS Scores
[Detailed breakdown]

### C. Video Clips
- Critical Issue 1: [Link to clip]
- Success Story: [Link to clip]
- Feature Request: [Link to clip]

### D. Test Materials
- [Link to scenarios]
- [Link to protocol]
- [Link to consent form]
```

## Quality Checks

Before proceeding:
- [ ] Test plan covers all user personas
- [ ] Scenarios match real-world usage
- [ ] Success metrics are measurable
- [ ] Protocol avoids leading questions
- [ ] Analysis framework is objective
- [ ] Recommendations are actionable

## Remember

> "The user is always right about their experience, even when they're wrong about the solution."

Usability testing reveals the gap between what we built and what users need. Embrace the findings, especially the painful ones - they're the path to a truly usable product.

## Next Steps

After usability testing:
1. Share findings with entire team immediately
2. Prioritize fixes based on severity and frequency
3. Create tickets for all Must Fix issues
4. Schedule retesting after fixes
5. Update documentation based on learnings

## Update Progress Report

After completing usability tests:
1. Update `reqs/progress-report.md`:
   - Add task: `[x] Run usability tests (5f)`
   - Record number of participants tested
   - Note critical issues found count
   - Record overall SUS score
   - Update activity log
   - Flag any launch blockers discovered