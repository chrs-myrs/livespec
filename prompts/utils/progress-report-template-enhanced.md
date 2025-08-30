# Enhanced Progress Report Template with Review Tracking

This template extends the standard progress report to include stakeholder review tracking and approval workflows.

## Enhanced Progress Report Template

```markdown
# Project Documentation Progress Report

**Project**: <Project Name>
**Started**: <YYYY-MM-DD>
**Last Updated**: <YYYY-MM-DD HH:MM>
**Overall Progress**: <X>%
**Review Status**: 🟢 On Track | 🟡 Review Pending | 🔴 Blocked on Review

## Progress Overview

### 🎯 Quick Status
- **Current Stage**: <Stage X: Name>
- **Current Status**: 🔄 Working | 👀 In Review | ⏸️ Awaiting Feedback | ✅ Approved
- **Documents Completed**: <X>/<Total>
- **Reviews Completed**: <X>/<Total Required>
- **Approvals Received**: <X>/<Total Required>
- **Active Blockers**: <Count>

## Review Dashboard

### Review Status by Stage
| Stage | Documents | Review Status | Reviewers | Decision |
|-------|-----------|---------------|-----------|----------|
| 0: UX Discovery | <count> | ⏸️ Not Started | - | - |
| 1: Purpose | <count> | 🔄 In Progress | @name | Pending |
| 2: Strategy | <count> | ✅ Complete | @name, @name | Approved |
| 3: Design | <count> | 📝 Changes Requested | @name | Revise |
| 4: Components | <count> | ⏸️ Not Started | - | - |
| 5: Implementation | <count> | ⏸️ Not Started | - | - |

### Active Reviews
1. **[Stage Name] Review**
   - Sent: <date>
   - Due: <date>
   - Reviewers: [@name - ⏳ Pending], [@name - ✅ Complete]
   - Package: `reqs/reviews/[stage]-review.md`

### Pending Reviews
1. **[Stage Name]** - Ready for review, not yet sent
2. **[Stage Name]** - Blocked on: <previous stage approval>

## Stage Progress

### Stage 0: Project Setup & UX Discovery
**Status**: ⏸️ Not Started | 🔄 In Progress | 👀 In Review | ✅ Complete | ⚠️ Blocked
**Progress**: <X>%
**Review Status**: N/A | 📝 Preparing | 👀 In Review | ✅ Approved | 🔄 Revising

- [ ] Project setup (0a)
  - Created: <Date or "Pending">
  - Notes: <Any relevant notes>
- [ ] Complexity assessment (0b)
  - Created: <Date or "Pending">
  - Complexity Score: <X/10 or "TBD">
- [ ] UX discovery (0c)
  - Created: <Date or "Pending">
  - Personas: <count>
  - User Journeys: <count>
  - **Review Status**: 
    - [ ] Review package prepared
    - [ ] Sent to stakeholders: <date>
    - [ ] Feedback received: <date>
    - [ ] Approved by: <names>

### Stage 1: Discovery & Purpose
**Status**: ⏸️ Not Started | 🔄 In Progress | 👀 In Review | ✅ Complete | ⚠️ Blocked
**Progress**: <X>%
**Review Status**: N/A | 📝 Preparing | 👀 In Review | ✅ Approved | 🔄 Revising

- [ ] Purpose document (1a)
  - Created: <Date or "Pending">
  - Last Updated: <Date>
  - **Review Status**:
    - [ ] Business alignment confirmed
    - [ ] Success metrics approved
    - [ ] Stakeholders signed off
- [ ] User success criteria (1b)
  - Created: <Date or "Pending">
- [ ] Discovery spikes (1c)
  - [ ] Spike: <Name> - <Status>

### Stage 2: Strategy
**Status**: ⏸️ Not Started | 🔄 In Progress | 👀 In Review | ✅ Complete | ⚠️ Blocked
**Progress**: <X>%
**Review Status**: N/A | 📝 Preparing | 👀 In Review | ✅ Approved | 🔄 Revising

- [ ] Technical strategy documents (2a)
  - [ ] <Strategy Name> - <Date or "Pending">
  - [ ] <Strategy Name> - <Date or "Pending">
- [ ] UX strategy document (2b)
  - Created: <Date or "Pending">
- [ ] Strategy spikes (2c)
  - [ ] Spike: <Name> - <Status>
- **Review Status**:
  - [ ] Technical approach approved
  - [ ] Resource estimates validated
  - [ ] Risk assessment reviewed

### Stage 3: Design
**Status**: ⏸️ Not Started | 🔄 In Progress | 👀 In Review | ✅ Complete | ⚠️ Blocked
**Progress**: <X>%
**Review Status**: N/A | 📝 Preparing | 👀 In Review | ✅ Approved | 🔄 Revising

- [ ] System design documents (3a)
  - [ ] Component Architecture - <Date or "Pending">
  - [ ] Data Flow - <Date or "Pending">
  - [ ] Integration Map - <Date or "Pending">
- [ ] Interaction design (3b)
  - Created: <Date or "Pending">
- [ ] Design spikes (3c)
  - [ ] Spike: <Name> - <Status>
- [ ] Design checkpoint (3d)
  - Status: <Not Run/Passed/Failed>
- **Review Status**:
  - [ ] Architecture approved
  - [ ] Integration points validated
  - [ ] UI/UX designs approved

### Stage 4: Components
**Status**: ⏸️ Not Started | 🔄 In Progress | 👀 In Review | ✅ Complete | ⚠️ Blocked
**Progress**: <X>%
**Review Status**: N/A | 📝 Preparing | 👀 In Review | ✅ Approved | 🔄 Revising

- [ ] Component specifications (4a)
  - [ ] <Component Name> - <Date or "Pending">
  - [ ] <Component Name> - <Date or "Pending">
- [ ] Behavior definitions (4b)
  - [ ] <Component Name> behaviors - <Date or "Pending">
- [ ] Component validation (4c)
  - Status: <Not Run/Passed/Failed>
  - Issues Found: <Count>

### Stage 5: Implementation
**Status**: ⏸️ Not Started | 🔄 In Progress | 👀 In Review | ✅ Complete | ⚠️ Blocked
**Progress**: <X>%
**Review Status**: N/A | 📝 Preparing | 👀 In Review | ✅ Approved | 🔄 Revising

- [ ] Implementation specifications (5a)
  - [ ] Master Plan - <Date or "Pending">
  - [ ] <Component Name> - <Date or "Pending">
- [ ] UI specifications (5b)
  - Created: <Date or "Pending">
- [ ] Implementation validation (5c)
  - Status: <Not Run/Passed/Failed>
- [ ] Implementation (5d)
  - Status: <Not Started/In Progress/Complete>
- [ ] Implementation checkpoint (5e)
  - Status: <Not Run/Passed/Failed>
- [ ] Usability testing (5f)
  - Test Plan: <Created/Pending>
  - Tests Run: <X>/<Total>
- **Pre-Implementation Review**:
  - [ ] Final specs approved
  - [ ] Resources confirmed
  - [ ] Go/No-Go decision: <status>

### Stage 6: Maintenance
**Status**: ⏸️ Not Started | 🔄 In Progress | ✅ Complete
**Progress**: <X>%

- [ ] Specification updates (6a)
  - Last Update Cycle: <Date>
  - Documents Updated: <Count>
- [ ] Alignment checks (6b)
  - Last Check: <Date>
  - Drift Detected: <Yes/No>
- [ ] Learning capture (6c)
  - Reports Created: <Count>

## Review History

### Completed Reviews
| Stage | Review Date | Reviewers | Decision | Key Feedback |
|-------|-------------|-----------|----------|--------------|
| <stage> | <date> | <names> | Approved | <summary> |
| <stage> | <date> | <names> | Conditional | <conditions> |

### Review Metrics
- **Average Review Time**: <X> days
- **First-Pass Approval Rate**: <X>%
- **Average Revisions Required**: <X>
- **Stakeholder Participation**: <X>%

## Key Decisions & Blockers

### Decisions Made
1. <Date>: <Decision description> - Approved by <names>
2. <Date>: <Decision description> - Approved by <names>

### Review-Related Decisions
1. <Date>: <What was decided> - Based on <reviewer> feedback
2. <Date>: <Alternative chosen> - Due to <reviewer> concerns

### Active Blockers
1. **<Blocker Title>**
   - Type: 🔧 Technical | 📋 Review | 🤝 Stakeholder | 📚 Information
   - Stage Affected: <Stage>
   - Description: <What's blocking>
   - Action Needed: <What needs to happen>
   - Owner: <Who needs to act>

### Resolved Blockers
1. <Date>: <Blocker description> - Resolved by <action taken>

## Stakeholder Engagement

### Review Participation
| Stakeholder | Role | Reviews Assigned | Reviews Completed | Avg Response Time |
|-------------|------|------------------|-------------------|-------------------|
| <name> | <role> | <X> | <X> | <X> days |
| <name> | <role> | <X> | <X> | <X> days |

### Feedback Themes
1. **Common Concerns**: <recurring feedback>
2. **Positive Feedback**: <what's working well>
3. **Improvement Areas**: <consistent suggestions>

## Metrics & Insights

### Documentation Health
- **Completeness**: <X>% of expected documents created
- **Review Coverage**: <X>% of documents reviewed
- **Approval Rate**: <X>% approved without major revision
- **Currency**: Average <X> days since last update

### Process Velocity
- **Average Stage Duration**: <X> days
- **Review Cycle Time**: <X> days average
- **Rework Rate**: <X>% require revision
- **Blocker Resolution Time**: <X> days average

## Recent Activity Log

### Last 10 Activities
1. <Date Time>: 📝 <Document created> by <Prompt>
2. <Date Time>: 📤 <Review sent> to <stakeholders>
3. <Date Time>: 📥 <Feedback received> from <reviewer>
4. <Date Time>: ✅ <Approval received> from <reviewer>
5. <Date Time>: 🔄 <Document updated> based on feedback
6. <Date Time>: 🚫 <Blocker identified>: <description>
7. <Date Time>: ✓ <Blocker resolved>: <how>
8. <Date Time>: 📊 <Checkpoint run>: <result>
9. <Date Time>: 🎯 <Decision made>: <what>
10. <Date Time>: 🔄 <Stage completed>: <which>

## Next Recommended Actions

### Immediate (This Week)
1. <Specific next action with review consideration>
2. <Review package to prepare>
3. <Stakeholder to follow up with>

### Upcoming (Next 2 Weeks)
1. <Future review preparation>
2. <Dependency to resolve>
3. <Next stage planning>

### Review Schedule
- **Next Review Due**: <Stage> on <date>
- **Reviewers Needed**: <names/roles>
- **Prep Required**: <what needs to be ready>

## Workflow State

**Current Workflow Step**: <e.g., "Creating Stage 2 documents", "Awaiting Purpose review", "Processing Design feedback">
**Next Automatic Step**: <what happens when current step completes>
**Human Tasks Pending**: 
1. <task> - Assigned to: <who> - Due: <when>
2. <task> - Assigned to: <who> - Due: <when>

## Notes

### Review-Specific Notes
<Notes about review process, stakeholder preferences, special requirements>

### General Project Notes
<Any additional project-specific notes or context>
```

## Review Status Indicators

Use these consistently throughout the report:

### Document Status
- ⏸️ Not Started
- 🔄 In Progress
- ✅ Complete
- ⚠️ Blocked

### Review Status
- N/A - No review required
- 📝 Preparing - Getting ready for review
- 📤 Sent - Review package distributed
- 👀 In Review - Stakeholders reviewing
- 📥 Feedback Received - Input collected
- 🔄 Revising - Addressing feedback
- ✅ Approved - Sign-off received
- 🚫 Rejected - Requires rework

### Reviewer Status
- ⏳ Pending - Not yet reviewed
- 👀 Reviewing - Currently looking
- 💬 Commented - Feedback provided
- ✅ Approved - Signed off
- ❌ Rejected - Requested changes

## Integration with Review Prompts

### When Using 0d (Prepare Review)
Update:
- Change review status to "📝 Preparing"
- Add review to "Active Reviews"
- Note review package location
- List assigned reviewers

### When Using 0e (Process Feedback)
Update:
- Change review status based on outcome
- Move from "Active" to "Completed Reviews"
- Add key decisions to decision log
- Update any blockers
- Calculate review metrics

### When Using 0f (Continue Workflow)
Update:
- Update workflow state
- Clear completed human tasks
- Note next automatic step
- Update stage progress

This enhanced template ensures complete visibility into both documentation progress and the review/approval workflow.