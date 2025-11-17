---
implements: specs/3-artifacts/prompts/4f-document-implementation.spec.md
phase: 4-EVOLVE
purpose: Create comprehensive implementation feedback report for methodology learning
---

# Phase 4f: Document Implementation Feedback

Create a comprehensive report documenting your LiveSpec implementation experience, capturing both successes and failures for continuous framework improvement.

## When to Use This Prompt

**Use after**:
- Completing significant feature implementation
- Finishing development sprint or milestone
- Major refactoring using LiveSpec methodology
- First-time LiveSpec trial on project
- Any implementation where methodology was partially skipped

**Timing matters**: Create report immediately while details are fresh, not days later.

## Purpose

This prompt helps you create honest, structured feedback that:
- **Identifies methodology gaps** - Where LiveSpec guidance was unclear or missing
- **Captures failure patterns** - Why you skipped steps (cognitive biases, ambiguities)
- **Documents successes** - Concrete examples where methodology added value
- **Enables learning** - Systematic cataloging for framework evolution
- **Prevents repetition** - Failure modes become guidance for future implementations

**Critical**: This is about **learning, not blame**. Be brutally honest about what you skipped and why.

## Output Location

```
var/implementation-reports/YYYY-MM-DD-[project-name]-[scope].md
```

Example: `var/implementation-reports/2025-11-06-slack-mcp-channel-operations.md`

## Step-by-Step Process

### Step 1: Review Your Work

**Before writing, gather evidence**:

1. **Review conversation history**
   - What was the original request?
   - What did you actually deliver?
   - Where did you deviate from methodology?

2. **Check specifications**
   - Which specs were created?
   - Which specs were skipped?
   - Where do specs not match implementation?

3. **Examine implementation**
   - What files were created/modified?
   - Were tests written? When?
   - What's incomplete or partially implemented?

4. **Identify methodology touchpoints**
   - Which LiveSpec prompts were used?
   - Which phases were followed?
   - Where did you shortcut the process?

### Step 2: Use the Template

Copy template from `.livespec/templates/reports/implementation-report.md.template` to your report location.

**Template sections** (fill all substantively):

#### Metadata
- Project name and scope
- Date and implementer
- LiveSpec version used
- Methodology approach

#### Executive Summary
- 2-3 sentences: What was built + key learning
- High-level methodology adherence assessment

#### Process Adherence
- **Checklist format**: What phases/steps were followed
- **What was skipped**: Honest accounting (no defensiveness)

#### Honest Failure Analysis
**Most important section for learning**

For each methodology step you skipped, identify:
1. **What I thought**: Your flawed reasoning at the time
2. **What I missed**: Consequences you didn't anticipate
3. **Lesson**: What you learned

**Common cognitive biases to watch for**:
- **Overconfidence bias**: "This is obvious, I don't need specs"
- **Efficiency instinct**: "Specs are overhead, I'll deliver faster without them"
- **Pattern matching**: "I've done this before, I know the patterns"
- **Ambiguity aversion**: "Asking questions will slow things down"

Be specific - generic "I should have followed the process" doesn't help learning.

#### Critical Failures
**Major methodology violations** - not minor deviations

For each:
- What you did vs what you should have done
- Impact of the failure
- Root cause (framework unclear? personal bias? time pressure?)
- Prevention strategy

**Examples of critical failures**:
- TDD skipped entirely (no automated tests)
- UX flows never documented
- Incomplete feature implementation (contract without behavior)
- Core domain models undefined
- File organization wrong

#### What Worked Well
**Concrete successes** where methodology provided value

Examples:
- Requirements phase caught missing dependencies
- Incremental review prevented wrong direction
- Behavior specs made implementation clearer
- Spec organization guided clean module boundaries

#### What Didn't Work Well
**Methodology pain points** (not implementation issues)

Examples:
- Ambiguous boundaries (behavior vs contract)
- Redundancy across spec types
- Missing decision log guidance
- Unclear when to create domain model specs

**For each**: Suggest improvement

#### Specific LiveSpec Benefits Observed
**Evidence-based value** - not theoretical

What concrete problems did LiveSpec solve?
What would have gone wrong without specs?
What rework was prevented?

#### Quantitative Results
**Metrics table** - actual numbers

Required metrics:
- Requirements/behaviors/contracts created
- Implementation files (new/updated)
- Test coverage (automated and manual)
- Issues found and resolved
- Rework cycles
- Incomplete implementations
- Time spent (if tracked)

#### Recommendations
**Actionable and specific** - not vague "improve X"

Categorize by:
- **For AI Assistants**: Guidance for implementers
- **For LiveSpec Methodology**: Framework improvements
  - Phase structure changes
  - AGENTS.md additions
  - New prompts needed
  - Template improvements
  - Guide clarifications

**Format**: [Recommendation] - [Specific change with acceptance criteria]

#### Conclusion
**Honest assessment**

- What you got right
- What you got wrong
- Root cause (framework or personal failure)
- Would you make same mistakes again?
- Overall methodology effectiveness verdict

### Step 3: Be Brutally Honest

**This report only helps if you're honest**

❌ **Don't write**:
- "The methodology worked great, I followed everything perfectly"
- "I would have done X but didn't have time" (why did you prioritize differently?)
- "The user changed requirements" (did you adapt methodology or abandon it?)

✅ **Do write**:
- "I skipped requirements because I assumed I understood the problem"
- "I didn't write tests first because it felt slower, then had to debug for 2 hours"
- "I thought the threading model was obvious, it wasn't, this caused bugs"

**Remember**: Reports are for learning, not performance review. Admitting mistakes helps improve the framework.

### Step 4: Provide Evidence

**Vague vs Specific**:

❌ Vague: "I didn't follow TDD"
✅ Specific: "I wrote `channel_ops.py` (120 lines) then manually tested via MCP inspector. Zero automated tests exist. When I tried to refactor later, I broke message formatting."

❌ Vague: "Requirements phase was helpful"
✅ Specific: "Creating FR-17 (Discovery) exposed missing dependency on user/channel listing that I hadn't considered. User spotted this gap reviewing requirements before I started coding. Saved ~2 hours of rework."

**Include**:
- File paths and line numbers
- Specific spec references
- Conversation timestamps
- Concrete examples (code snippets if relevant)

### Step 5: Distinguish Framework vs Implementation Issues

**Framework issue** (LiveSpec needs improvement):
- "Behavior vs contract boundary is ambiguous for URL parsing"
- "No guidance on when to create domain model specs"
- "TDD not explicit enough in phase naming"

**Implementation issue** (you didn't follow methodology):
- "I skipped writing tests because it felt slow"
- "I didn't create UX flow specs because I wanted to start coding"
- "I didn't read the constitution about TDD being mandatory"

**Be clear which is which** - helps prioritize framework improvements.

### Step 6: Suggest Improvements

**For each "What Didn't Work" or "Critical Failure"**:

Suggest specific framework improvement:

**Example**:
```markdown
### Problem: TDD Not Followed

**Framework issue**: Phase 2 named "BUILD" doesn't emphasize test-first

**Recommendation**:
- Rename Phase 2 to "BUILD (TDD)"
- Create 2a-create-tests.md prompt (before 2b-implement.md)
- Add TDD as explicit principle in constitution.spec.md
- Update AGENTS.md to emphasize "tests before code"

**Acceptance criteria**:
- [ ] Phase 2 name changed in all specs and prompts
- [ ] Test-first workflow documented in phase-workflow.spec.md
- [ ] Agent guidance includes TDD enforcement
```

## Examples

### Good Report Excerpt

```markdown
## Honest Failure Analysis

### Overconfidence Bias
**What I thought**: "Channel operations are straightforward - post message, read thread, parse URL. I've implemented messaging systems before."

**What I missed**:
- Discovery tools needed (how do users know channel IDs?)
- Username auto-resolution (users don't have Slack IDs memorized)
- Graceful degradation when OAuth scopes missing
- Threading model ambiguity (channel vs DM threading differs)

**Lesson**: Even "simple" features have hidden complexity. Spec-first forces you to think through dependencies before coding reveals them expensively.

**Evidence**: User had to ask "how do I discover channels?" after I'd already designed posting tools. Added FR-17 and 2 discovery tools retroactively. This was 1 hour rework that could have been prevented with 10 minutes of requirements thinking.
```

### Poor Report Excerpt (Don't Do This)

```markdown
## What Happened

I built some tools for Slack. The methodology was mostly followed. There were a few issues but overall it went well. TDD would have been nice but wasn't necessary for this project. The specs were good and implementation worked fine.
```

**Why this is bad**:
- No specific failures identified
- No honest analysis of skipped steps
- No quantitative metrics
- No actionable recommendations
- Defensive tone ("TDD wasn't necessary" vs admitting you skipped it)

## Cataloging and Pattern Analysis

**After creating multiple reports**:

1. **Look for patterns across reports**
   - Same biases recurring? (overconfidence, efficiency instinct)
   - Same methodology steps skipped repeatedly?
   - Same ambiguities confusing multiple implementations?

2. **Extract to common-pitfalls.md**
   - Patterns become guidance
   - "You will be tempted to skip X because Y - don't, here's why"

3. **Track recommendations**
   - Create issues for framework improvements
   - Prioritize by frequency (many reports request same change)
   - Validate improvements (did next report show improvement?)

4. **Update methodology**
   - Ambiguities get clarification guides
   - Weak enforcement gets structural changes
   - Missing prompts get created
   - Unclear guidance gets examples

## Success Criteria

✅ **Good implementation report**:
- Located in `var/implementation-reports/` with timestamp
- All template sections completed substantively (not placeholders)
- Honest analysis of failures (admitted skipped steps with reasons)
- Quantitative metrics included (numbers, not just narrative)
- Specific evidence (file paths, lines, conversation references)
- Actionable recommendations (not vague "improve X")
- Distinguishes framework vs implementation issues
- Framework version documented for tracking

❌ **Poor implementation report**:
- Generic template filled with "N/A" or "worked fine"
- Defensive rationalization ("I would have but...")
- No quantitative metrics
- Vague failures ("didn't follow process perfectly")
- No specific recommendations
- No evidence or examples

## Next Steps

After creating report:

1. **Share with team/maintainers** (if applicable)
2. **Create issues for framework improvements** (if patterns emerge)
3. **Update common-pitfalls.md** (if new failure mode discovered)
4. **File in cataloging system** (for pattern analysis across projects)
5. **Reflect on learnings** (what will you do differently next time?)

---

**Remember**: The goal is **continuous improvement**, not perfect execution. Every honest report makes LiveSpec better for future implementations. Your failures today become someone else's guidance tomorrow.
