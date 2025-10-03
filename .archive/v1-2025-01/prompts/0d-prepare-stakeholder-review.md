# Prepare Stakeholder Review Package

You are tasked with preparing documentation for stakeholder review. This involves creating a consolidated, readable package that stakeholders can review offline, annotate, and return for processing.

## Your Mindset

You are:
- **A document packager** - Creating clear, reviewable documents
- **A context provider** - Ensuring stakeholders have what they need
- **A decision facilitator** - Highlighting what needs approval
- **A complexity reducer** - Making technical content accessible

## Review Package Components

Each review package should include:

1. **Executive Summary** - One page max
2. **Key Decisions** - What needs approval
3. **Review Documents** - The actual content
4. **Feedback Template** - How to provide input
5. **Context Documents** - Supporting information

## Process

### Step 1: Identify Review Stage

Determine which stage is being reviewed:
- Stage 0: UX Discovery Review
- Stage 1: Purpose Review
- Stage 2: Strategy Review
- Stage 3: Design Review
- Stage 4: Component Review
- Stage 5: Pre-Implementation Review

### Step 2: Gather Documents

Based on the stage, collect relevant documents:

```bash
# For each stage, gather:
- Primary documents (from reqs/[stage]/)
- Supporting documents (from related stages)
- Open questions document
- Any spike reports
```

### Step 3: Create Review Package

Create a comprehensive review document at `reqs/reviews/[stage]-[name]-review.md`:

```markdown
# [Stage Name] Review Package

**Review ID**: [stage]-[timestamp]
**Prepared**: [current date]
**Review Deadline**: [date, typically +3-5 business days]
**Required Reviewers**: [list stakeholders]

---

## Executive Summary

### What We've Completed
[2-3 paragraphs summarizing the work done in this stage]

### What We Need From You
1. **Approval of**: [Key items needing sign-off]
2. **Feedback on**: [Areas where input is valuable]
3. **Decisions about**: [Open questions requiring answers]

### Review Timeline
- **Document Prepared**: [date]
- **Review Deadline**: [date]
- **Implementation Blocked Until**: Review complete

---

## Key Decisions Requiring Approval

### Decision 1: [Title]
**Context**: [Why this matters]
**Recommendation**: [What we propose]
**Alternatives Considered**: [Other options]
**Impact**: [What this affects]

**[ ] Approved [ ] Rejected [ ] Needs Discussion**

### Decision 2: [Title]
[Repeat format]

---

## Documents for Review

### 1. [Document Name]
**Purpose**: [What this document covers]
**Key Points**:
- [Highlight 1]
- [Highlight 2]
- [Highlight 3]

[Include full document content or excerpt]

---

## Open Questions Needing Input

### Question 1: [Question]
**Context**: [Why we're asking]
**Options**:
- A: [Option with pros/cons]
- B: [Option with pros/cons]
**Recommendation**: [If any]

**Your Input**: ________________________________

---

## Risk and Concerns

### Identified Risks
1. **Risk**: [Description]
   **Mitigation**: [Proposed approach]
   **Your Assessment**: [ ] Acceptable [ ] Needs Work

### Stakeholder Concerns
[Space for stakeholders to raise concerns]

---

## How to Provide Feedback

### Option 1: Inline Comments (Preferred)
1. Add comments directly in this document using [COMMENT: text] format
2. Mark decisions using the checkboxes provided
3. Save as `[stage]-review-[your-name]-[date].md`

### Option 2: Separate Feedback Document  
Use the feedback template below

### Option 3: Meeting Discussion
Schedule review meeting for verbal feedback

---

## Feedback Template

```
REVIEWER: [Your name]
DATE: [Review date]
OVERALL STATUS: [ ] Approved [ ] Approved with changes [ ] Needs major revision

DECISION APPROVALS:
- Decision 1: [ ] Approved [ ] Rejected [ ] Discuss
- Decision 2: [ ] Approved [ ] Rejected [ ] Discuss

SPECIFIC FEEDBACK:
Section: [Document/Section name]
Feedback: [Your comments]

OPEN QUESTION RESPONSES:
Q1: [Your answer]
Q2: [Your answer]

ADDITIONAL CONCERNS:
[Any other feedback]
```

---

## Next Steps

1. **Reviewers**: Please complete review by [deadline]
2. **Return Reviews**: Email to [contact] or commit to repo
3. **Questions**: Contact [project lead]
4. **After Review**: We'll process feedback and continue

---

## Appendix: Context Documents

[Include or reference any supporting documents that provide context but don't need review]
```

### Step 4: Create Stakeholder Instructions

Also create `reqs/reviews/review-instructions.md`:

```markdown
# Stakeholder Review Instructions

## How to Review Documents

1. **Read the Executive Summary** first
2. **Focus on Key Decisions** - these need your approval
3. **Review documents** in the order presented
4. **Answer open questions** with your expertise
5. **Note any concerns** in the appropriate section

## Providing Feedback

### For Technical Reviewers
- Focus on technical feasibility
- Identify risks or concerns
- Suggest alternatives if needed

### For Business Stakeholders  
- Validate business value alignment
- Confirm requirements are met
- Approve resource implications

### For UX Reviewers
- Verify user needs are addressed
- Check accessibility considerations
- Validate user journey accuracy

## Making Decisions

When reviewing decisions:
- **Approved**: You agree with the recommendation
- **Rejected**: You disagree (please explain why)
- **Needs Discussion**: Requires team conversation

## Timeline Expectations

- Reviews typically take 3-5 business days
- Complex reviews may take up to 1 week  
- Urgent reviews can be expedited (24-48 hours)

## Questions?

Contact the project lead or use the workflow orchestrator:
```
claude-code "Use prompts/0-orchestrate-workflow.md"
```
```

## Special Handling by Stage

### UX Discovery Review (Stage 0)
- Include all personas
- Show user journey maps
- Highlight assumption validations needed

### Purpose Review (Stage 1)
- Emphasize business value
- Show success metrics
- Connect to organizational goals

### Strategy Review (Stage 2)
- Compare alternative approaches
- Show cost/benefit analysis
- Highlight technical risks

### Design Review (Stage 3)
- Include architecture diagrams
- Show integration points
- Emphasize scalability

### Component Review (Stage 4)
- List all components
- Show dependencies
- Highlight interfaces

### Pre-Implementation Review (Stage 5)
- Show implementation timeline
- List resource needs
- Confirm test strategy

## Output

Create these files:
1. `reqs/reviews/[stage]-[name]-review.md` - The review package
2. `reqs/reviews/review-instructions.md` - How to review (first time only)
3. Update progress report to show "Awaiting Review"

End with instructions for the user on distributing the review package.