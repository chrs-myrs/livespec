# Continue Workflow After Human Tasks

You are tasked with resuming the workflow after human tasks have been completed. This includes checking what was done, validating completeness, and determining the next automated steps.

## Your Mindset

You are:
- **A task validator** - Confirming human work is complete
- **A workflow resumption expert** - Getting things moving again
- **A progress tracker** - Updating status accurately
- **A helpful guide** - Providing clear next actions

## Process

### Step 1: Identify What Was Paused

Check for workflow markers:
```bash
# Look for pause markers
reqs/reviews/next-steps-after-*-review.md
reqs/.workflow-state
Progress report status indicators
```

Determine what type of pause:
- Stakeholder review completion
- Manual document creation
- External dependency resolution
- Information gathering

### Step 2: Validate Task Completion

Based on the pause type, verify completion:

#### For Stakeholder Reviews
```markdown
Checklist:
- [ ] Feedback documents exist in reqs/reviews/
- [ ] Feedback has been processed (feedback-summary.md exists)
- [ ] Documents updated with feedback
- [ ] Approval status documented
```

#### For Manual Document Creation
```markdown
Checklist:
- [ ] Required documents exist
- [ ] Documents follow templates
- [ ] Content is complete (no TODOs)
- [ ] Documents are in correct location
```

#### For Information Gathering
```markdown
Checklist:
- [ ] Open questions have answers
- [ ] Decisions are documented
- [ ] Dependencies resolved
- [ ] Blockers removed
```

### Step 3: Assess Current State

Run a comprehensive state check:

1. **Document Inventory**:
   ```
   Stage 0: [count] documents - [status]
   Stage 1: [count] documents - [status]
   Stage 2: [count] documents - [status]
   Stage 3: [count] documents - [status]
   Stage 4: [count] documents - [status]
   Stage 5: [count] documents - [status]
   ```

2. **Review Status**:
   ```
   Completed Reviews: [list stages]
   Pending Reviews: [list stages]
   In Progress: [current work]
   ```

3. **Blockers Check**:
   ```
   Open Questions: [count]
   Missing Dependencies: [list]
   Pending Decisions: [list]
   ```

### Step 4: Determine Next Action

Based on the validation and assessment:

```markdown
## Workflow Resumption Plan

### Completed Since Last Run ✅
- [What human tasks were completed]
- [What reviews were processed]
- [What decisions were made]

### Current Stage
**Stage**: [Number and name]
**Status**: [In progress/Ready for next/Blocked]
**Completion**: [X]%

### Validation Results
| Check | Status | Notes |
|-------|--------|--------|
| Required docs exist | ✅/❌ | [details] |
| Reviews complete | ✅/❌ | [details] |
| No blockers | ✅/❌ | [details] |

### Next Action Required

[Choose one of the following based on state:]
```

#### Option A: Continue Current Stage
```markdown
**Continue with current stage work:**

The [stage name] stage is partially complete. Continue with:

```bash
claude-code "Use prompts/[specific-prompt].md"
```

This will:
- [What it will do]
- [Expected outcome]
- [Next step after]
```

#### Option B: Move to Next Stage
```markdown
**Ready for next stage:**

[Current stage] is complete and reviewed. Proceed to [next stage]:

```bash
claude-code "Use prompts/[next-stage-prompt].md"
```

This will:
- Begin [stage name] phase
- Create [what documents]
- Require review after [what milestone]
```

#### Option C: Prepare for Review
```markdown
**Stage complete, needs review:**

[Stage name] work is complete. Prepare for stakeholder review:

```bash
claude-code "Use prompts/0d-prepare-stakeholder-review.md for [stage]"
```

This will:
- Package documents for review
- Create review templates
- Set review timeline
```

#### Option D: Address Blockers
```markdown
**Blocked on dependencies:**

Cannot proceed due to:
1. [Blocker 1]
2. [Blocker 2]

Required actions:
1. [Human task needed]
2. [External dependency]

Once resolved, run:
```bash
claude-code "Use prompts/0f-continue-workflow.md"
```
```

### Step 5: Update Progress Tracking

Always update the progress report:

```markdown
## Progress Update

### Work Completed
- [Stage/Task]: [What was done] ([date])
- Review Status: [Approved/Pending/N/A]

### Currently Active
- Stage: [Current stage]
- Task: [Current task]
- Blockers: [Any blockers]

### Next Milestone
- [What]: [Description]
- [When]: [Expected date]
- [Who]: [Stakeholders needed]
```

## Special Handling

### After First Run
If this is the first time continuing:
- Be extra thorough in validation
- Provide context about the project
- Suggest reading key documents

### After Long Pause
If significant time has passed:
- Summarize what was done before
- Check for external changes
- Verify assumptions still valid

### After Failed Validation
If human tasks incomplete:
- List specifically what's missing
- Provide templates/examples
- Offer to help create missing items

## Integration with Orchestrator

This prompt works with the orchestrator:
1. Orchestrator pauses for human tasks
2. Humans complete work
3. This prompt validates and continues
4. Returns control to orchestrator

## Output

Your response should:
1. Validate task completion
2. Assess current state
3. Provide single clear next action
4. Update progress tracking

End with exactly one command the user can run to continue.