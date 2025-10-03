# Progress Report Template and Update Instructions

This template defines the structure for `reqs/progress-report.md` and provides instructions for how each prompt should update it.

## Progress Report Template

```markdown
# Project Documentation Progress Report

**Project**: <Project Name>
**Started**: <YYYY-MM-DD>
**Last Updated**: <YYYY-MM-DD HH:MM>
**Overall Progress**: <X>%

## Progress Overview

### 🎯 Quick Status
- **Current Stage**: <Stage X: Name>
- **Documents Completed**: <X>/<Total>
- **Open Questions**: <Total Count> (H:<High> M:<Medium> L:<Low>)
- **Spikes Completed**: <X>/<Total>
- **Checkpoints Passed**: <X>/<Total>
- **Active Blockers**: <Count>

## Stage Progress

### Stage 0: Project Setup
**Status**: ⏸️ Not Started | 🔄 In Progress | ✅ Complete | ⚠️ Blocked
**Progress**: <X>%

- [ ] Project setup (0.1)
  - Created: <Date or "Pending">
  - Notes: <Any relevant notes>
- [ ] Complexity assessment (0.2)
  - Created: <Date or "Pending">
  - Complexity Score: <X/10 or "TBD">
  - Recommended Spikes: <Count or "TBD">
  - Recommended Buffer: <X% or "TBD">

### Stage 1: Discovery & Purpose
**Status**: ⏸️ Not Started | 🔄 In Progress | ✅ Complete | ⚠️ Blocked
**Progress**: <X>%

- [ ] Purpose document (1.1)
  - Created: <Date or "Pending">
  - Last Updated: <Date>
  - Open Questions: <Count> (H:<High> M:<Medium> L:<Low>)
  - Critical Gaps: <High priority questions or "None">
- [ ] Discovery spikes (1.2)
  - [ ] Spike: <Name> - <Status>
  - [ ] Spike: <Name> - <Status>

### Stage 2: Strategy
**Status**: ⏸️ Not Started | 🔄 In Progress | ✅ Complete | ⚠️ Blocked
**Progress**: <X>%

- [ ] Strategy documents (2.1)
  - [ ] <Strategy Name> - <Date or "Pending">
  - [ ] <Strategy Name> - <Date or "Pending">
  - Open Questions: <Count> (H:<High> M:<Medium> L:<Low>)
  - Critical Decisions: <High priority questions or "None">
- [ ] Discovery spikes (2.2)
  - [ ] Spike: <Name> - <Status>

### Stage 3: Design
**Status**: ⏸️ Not Started | 🔄 In Progress | ✅ Complete | ⚠️ Blocked
**Progress**: <X>%

- [ ] Design documents (3.1)
  - [ ] Component Architecture - <Date or "Pending">
  - [ ] Data Flow - <Date or "Pending">
  - [ ] Integration Map - <Date or "Pending">
  - Open Questions: <Count> (H:<High> M:<Medium> L:<Low>)
  - Architecture Risks: <High priority questions or "None">
- [ ] Discovery spikes (3.2)
  - [ ] Spike: <Name> - <Status>
- [ ] Reality checkpoint (3.3)
  - Status: <Not Run/Passed/Failed>
  - Alignment Score: <X%>

### Stage 4: Components
**Status**: ⏸️ Not Started | 🔄 In Progress | ✅ Complete | ⚠️ Blocked
**Progress**: <X>%

- [ ] Component specifications (4.1)
  - [ ] <Component Name> - <Date or "Pending">
  - [ ] <Component Name> - <Date or "Pending">
  - Open Questions: <Count> (H:<High> M:<Medium> L:<Low>)
  - Interface Gaps: <High priority questions or "None">
- [ ] Pre-implementation validation (4.2)
  - Status: <Not Run/Passed/Failed>
  - Issues Found: <Count>

### Stage 5: Implementation
**Status**: ⏸️ Not Started | 🔄 In Progress | ✅ Complete | ⚠️ Blocked
**Progress**: <X>%

- [ ] Implementation specifications (5.1)
  - [ ] Master Plan - <Date or "Pending">
  - [ ] <Component Name> - <Date or "Pending">
  - Open Questions: <Count> (H:<High> M:<Medium> L:<Low>)
  - Technical Gaps: <High priority questions or "None">
- [ ] Implementation (5.2)
  - Status: <Not Started/In Progress/Complete>
  - Test Coverage: <X%>
- [ ] Reality checkpoint (5.3)
  - Status: <Not Run/Passed/Failed>
  - Alignment Score: <X%>

### Stage 6: Maintenance
**Status**: ⏸️ Not Started | 🔄 In Progress | ✅ Complete
**Progress**: <X>%

- [ ] Specification updates (6.1)
  - Last Update Cycle: <Date>
  - Documents Updated: <Count>
- [ ] Alignment checks (6.2)
  - Last Check: <Date>
  - Drift Detected: <Yes/No>
- [ ] Learning capture (6.3)
  - Reports Created: <Count>
  - Key Learnings: <Count>

## Open Questions Summary

### Critical Questions Requiring Immediate Attention
| Stage | Question | Impact | Status |
|-------|----------|--------|--------|
| <Stage> | <Brief question> | Implementation Blocker | Open/Answered |

### Question Metrics by Stage
- **Stage 1 (Purpose)**: <Total> questions (<High>H, <Med>M, <Low>L)
- **Stage 2 (Strategy)**: <Total> questions (<High>H, <Med>M, <Low>L)
- **Stage 3 (Design)**: <Total> questions (<High>H, <Med>M, <Low>L)
- **Stage 4 (Components)**: <Total> questions (<High>H, <Med>M, <Low>L)
- **Stage 5 (Implementation)**: <Total> questions (<High>H, <Med>M, <Low>L)

### Questions Activity
- **Recently Answered**: <Count> in last 7 days
- **Newly Added**: <Count> in last 7 days
- **Long Outstanding**: <Count> open >30 days

## Key Decisions & Blockers

### Decisions Made
1. <Date>: <Decision description>
2. <Date>: <Decision description>

### Active Blockers
1. **<Blocker Title>**
   - Stage Affected: <Stage>
   - Description: <What's blocking>
   - Action Needed: <What needs to happen>

### Resolved Blockers
1. <Date>: <Blocker description> - <How resolved>

## Metrics & Insights

### Documentation Health
- **Completeness**: <X>% of expected documents created
- **Currency**: Average <X> days since last update
- **Missing Info**: <X> high priority gaps identified

### Development Velocity
- **Average Stage Duration**: <X> days
- **Spike Success Rate**: <X>% questions answered
- **Checkpoint Pass Rate**: <X>%

### Complexity Insights
- **Initial Complexity**: <X>/10
- **Actual Complexity**: <X>/10 (if known)
- **Surprise Discoveries**: <Count>

## Recent Activity Log

### Last 5 Updates
1. <Date Time>: <Action taken> by <Prompt>
2. <Date Time>: <Action taken> by <Prompt>
3. <Date Time>: <Action taken> by <Prompt>
4. <Date Time>: <Action taken> by <Prompt>
5. <Date Time>: <Action taken> by <Prompt>

## Next Recommended Actions

Based on current progress:
1. <Specific next action>
2. <Specific next action>
3. <Specific next action>

## Notes

<Any additional project-specific notes or context>
```

## Update Instructions for Prompts

### How to Update the Progress Report

Each prompt should update the progress report by:

1. **Reading the current report**:
   ```python
   # Read existing progress report
   progress_report_path = "reqs/progress-report.md"
   if exists(progress_report_path):
       current_report = read(progress_report_path)
   else:
       # Create from template
   ```

2. **Updating relevant sections**:
   - Mark tasks as complete with `[x]`
   - Update dates and statuses
   - Add to activity log
   - Update metrics
   - Add blockers or decisions

3. **Calculating progress**:
   - Stage progress = (completed items / total items) * 100
   - Overall progress = weighted average of stage progress

4. **Adding to activity log**:
   ```
   <YYYY-MM-DD HH:MM>: <Action> by <Prompt Name>
   ```

### Prompt-Specific Updates

#### 0.1 Setup Project
- Create initial progress report from template
- Set project name and start date
- Initialize all stages as "Not Started"

#### 0.2 Assess Complexity
- Update complexity score
- Add recommended spikes
- Set recommended buffer
- Update Stage 0 progress

#### 1.1 Write Purpose
- Mark purpose document as complete
- Note any missing information priorities
- Update Stage 1 progress
- Add key decisions from purpose

#### 1.2, 2.2, 3.2 Run Discovery Spike
- Add spike to relevant stage
- Update spike status
- Add key findings to decisions
- Note any new blockers discovered

#### 3.3, 5.3 Reality Checkpoint
- Update checkpoint status
- Record alignment score
- Note any drift requiring updates
- Add to metrics section

#### 4.2 Pre-Implementation Validation
- Update validation status
- Record issues found
- Add blockers if validation fails
- Update readiness metrics

### Progress Calculation Formula

```
Stage Progress = (Completed Items / Total Items) × 100

Overall Progress = 
  (Stage 0 Progress × 0.05) +  // Setup is 5%
  (Stage 1 Progress × 0.15) +  // Purpose is 15%
  (Stage 2 Progress × 0.15) +  // Strategy is 15%
  (Stage 3 Progress × 0.20) +  // Design is 20%
  (Stage 4 Progress × 0.20) +  // Components is 20%
  (Stage 5 Progress × 0.20) +  // Implementation is 20%
  (Stage 6 Progress × 0.05)    // Maintenance is 5%
```

### Example Update Code Block

Each prompt should include an update section like:

```markdown
## Update Progress Report

After completing this prompt:
1. Update `reqs/progress-report.md`:
   - Mark this task complete: `[x] <Task Name>`
   - Update stage status and progress percentage
   - Add to activity log: `<Date>: Created <Document> using <Prompt>`
   - Update overall progress percentage
   - Add any decisions or blockers discovered

The progress report helps track your documentation journey and identify next steps.
```

## Benefits of Progress Tracking

1. **Visibility**: See at a glance where the project stands
2. **Accountability**: Clear record of what's been done
3. **Planning**: Identify what needs to be done next
4. **Metrics**: Track velocity and quality over time
5. **Communication**: Easy status updates for stakeholders