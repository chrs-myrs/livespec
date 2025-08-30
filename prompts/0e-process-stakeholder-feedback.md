# Process Stakeholder Feedback

You are tasked with processing stakeholder feedback and integrating it into the project documentation. This involves reading review responses, updating documents accordingly, and preparing for the next phase.

## Your Mindset

You are:
- **A feedback integrator** - Incorporating stakeholder input thoughtfully
- **A conflict resolver** - Handling conflicting feedback gracefully  
- **A change tracker** - Documenting what was modified and why
- **A progress enabler** - Unblocking the project to continue

## Process Overview

1. **Collect** all feedback documents
2. **Analyze** feedback for patterns and conflicts
3. **Integrate** approved changes into documents
4. **Document** decisions and rationale
5. **Update** status for next phase

## Detailed Process

### Step 1: Locate Feedback Documents

Look for feedback in these locations:
```bash
reqs/reviews/*-review-*.md       # Annotated review documents
reqs/reviews/feedback/           # Separate feedback files
git commits                      # Check for review commits
```

### Step 2: Parse Feedback

For each feedback document found:

1. **Extract Decisions**:
   ```markdown
   Decision: [Name]
   Status: [Approved/Rejected/Needs Discussion]
   Reviewer: [Name]
   Comments: [Any additional context]
   ```

2. **Collect Specific Feedback**:
   ```markdown
   Document: [Which doc]
   Section: [Which part]
   Feedback Type: [Correction/Enhancement/Question/Concern]
   Content: [The actual feedback]
   ```

3. **Gather Open Question Responses**:
   ```markdown
   Question: [Original question]
   Response: [Stakeholder answer]
   Respondent: [Who answered]
   ```

### Step 3: Analyze Feedback

Create a feedback summary at `reqs/reviews/[stage]-feedback-summary.md`:

```markdown
# [Stage] Feedback Summary

**Review Period**: [start] to [end]
**Reviewers**: [list of who responded]
**Overall Status**: [Approved/Changes Requested/Major Revision]

## Decision Summary

| Decision | Approvals | Rejections | Need Discussion | Final Status |
|----------|-----------|------------|-----------------|--------------|
| [Name]   | [count]   | [count]    | [count]         | [status]     |

## Feedback Themes

### Consistent Feedback (Multiple Reviewers)
1. **Theme**: [What multiple people mentioned]
   - Reviewers: [who]
   - Action: [what we'll do]

### Conflicting Feedback
1. **Conflict**: [Describe the disagreement]
   - Position A: [view] (supported by [names])
   - Position B: [view] (supported by [names])
   - Resolution: [how we'll handle it]

## Required Changes

### High Priority (Blocking)
1. [Change required before continuing]
2. [Another critical change]

### Medium Priority (Important)
1. [Should be addressed soon]
2. [Another important item]

### Low Priority (Nice to Have)
1. [Can be deferred]
2. [Another deferrable item]

## Open Questions Resolved

1. **Question**: [Original question]
   **Answer**: [Stakeholder response]
   **Impact**: [How this affects the project]
```

### Step 4: Update Documents

For each document requiring changes:

1. **Create a backup**:
   ```bash
   cp reqs/[stage]/[doc].md reqs/[stage]/[doc]-pre-review.md
   ```

2. **Apply changes** with clear marking:
   ```markdown
   ## [Section Name]
   
   [Updated content based on feedback]
   
   <!-- REVIEW UPDATE: [Date]
   Changed: [what was changed]
   Reason: [stakeholder feedback reference]
   Reviewer: [who requested]
   -->
   ```

3. **Update changelog**:
   ```markdown
   ## [Date] - Stakeholder Review Update
   
   ### Changed
   - [What changed] based on [reviewer] feedback
   - [Another change] per [reviewer] suggestion
   
   ### Added  
   - [New content] requested by [reviewer]
   
   ### Decisions
   - [Decision]: [Approved/Rejected] by [reviewers]
   ```

### Step 5: Handle Special Cases

#### Conflicting Feedback
```markdown
## Conflict Resolution

**Conflict**: [Describe]
**Option A**: [Description] - Supported by [names]
**Option B**: [Description] - Supported by [names]

**Resolution Approach**:
[ ] Schedule meeting with conflicting parties
[ ] Escalate to project sponsor
[ ] Use majority opinion
[ ] Defer decision to next phase

**Final Decision**: [What was decided]
**Rationale**: [Why this choice]
**Decided By**: [Who made the call]
**Date**: [When]
```

#### Rejected Decisions
```markdown
## Rejected Decision: [Name]

**Original Proposal**: [What was proposed]
**Rejection Reason**: [Why rejected]
**Rejected By**: [Who]

**Alternative Approach**:
[What we'll do instead]

**Impact**:
- Schedule: [Impact on timeline]
- Scope: [Impact on features]
- Resources: [Impact on team/budget]
```

#### Missing Reviews
```markdown
## Missing Reviews

**Required Reviewer**: [Name]
**Role**: [Why their input matters]
**Attempts**: [How we tried to get feedback]

**Resolution**:
[ ] Proceed with assumption: [what we assume]
[ ] Block until received
[ ] Escalate to sponsor
```

### Step 6: Update Project Status

1. **Update progress report**:
   - Mark stage as "Review Complete"
   - Note any blocked items
   - Update completion percentages

2. **Update approval tracking**:
   ```markdown
   ## Approval Status
   
   ### Stage 0: UX Discovery
   - Status: [Approved/Changes Made/Pending]
   - Reviewers: [names]
   - Date: [when]
   
   [Continue for each stage]
   ```

3. **Create next steps document** at `reqs/reviews/next-steps-after-[stage]-review.md`:
   ```markdown
   # Next Steps After [Stage] Review
   
   ## Immediate Actions
   1. [First thing to do]
   2. [Second thing]
   
   ## Deferred Items
   - [Item]: Deferred to [when]
   - [Reason]: [why deferred]
   
   ## Ready to Continue
   The following are now unblocked:
   - [ ] [Next stage work]
   - [ ] [Parallel work item]
   
   ## Run Next Step
   ```
   claude-code "Use prompts/0f-continue-workflow.md"
   ```
   ```

## Integration Patterns

### For Approved Changes
- Apply directly to documents
- Note in changelog
- Thank reviewer in commit message

### For Minor Corrections
- Fix immediately
- Document in changelog
- No need for re-review

### For Major Changes
- Implement changes
- May require re-review
- Document extensively

### For Deferred Items
- Add to backlog
- Note in open questions
- Set review date

## Output Files

You should create/update:
1. `reqs/reviews/[stage]-feedback-summary.md`
2. Updated documents in `reqs/[stage]/`
3. Changelog entries for modified docs
4. `reqs/reviews/next-steps-after-[stage]-review.md`
5. Updated progress report

## Final Instructions

End your response with:
1. Summary of changes made
2. Any unresolved issues
3. Clear next step:
   ```
   Review integration complete. To continue:
   claude-code "Use prompts/0f-continue-workflow.md"
   ```