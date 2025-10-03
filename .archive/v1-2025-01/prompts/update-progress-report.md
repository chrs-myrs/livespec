# Update Progress Report from Current State

You are tasked with analyzing the current project state and updating the progress report to accurately reflect what has been completed. This is useful when work has been done without updating the progress report, or when starting to track an existing project.

## Your Mindset for Progress Analysis

Before you begin, understand that you are:
- **A project archaeologist**, discovering what work has been done
- **A progress calculator**, determining accurate completion percentages
- **A status updater**, bringing the progress report to current state
- **A next-step advisor**, recommending logical next actions

## Analysis Process

### Step 1: Check for Existing Progress Report

1. Look for `reqs/progress-report.md`
2. If exists: Read current state
3. If not: Create from template in `prompts/utils/progress-report-template.md`

### Step 2: Analyze Project Structure

#### Check for HLR Documents
```bash
# Look in reqs/hlr/ for high-level requirements
ls reqs/hlr/
```
- Note any HLR files found
- These are source requirements for the project

#### Check Each Stage's Outputs

**Stage 0 - Project Setup**:
- [ ] Check for CLAUDE.md in project root
- [ ] Check for complexity assessment in `reqs/0-complexity/`
- [ ] Note project start date from file timestamps

**Stage 1 - Discovery & Purpose**:
- [ ] Check for purpose document in `reqs/1-purpose/`
- [ ] Check for spike reports in `reqs/spikes/` with "purpose" in name
- [ ] Note which HLR files were referenced

**Stage 2 - Strategy**:
- [ ] Count strategy documents in `reqs/2-strategy/`
- [ ] Check for strategy-related spikes
- [ ] List all strategy areas covered

**Stage 3 - Design**:
- [ ] Check for design documents in `reqs/3-design/`
- [ ] Look for: architecture, data-flow, integration-map
- [ ] Check for design spikes and checkpoints

**Stage 4 - Components**:
- [ ] Count component specs in `reqs/4-components/`
- [ ] Check for validation reports
- [ ] List all components specified

**Stage 5 - Implementation**:
- [ ] Check for implementation specs in `reqs/5-implementation/`
- [ ] Look for master implementation plan (00-master-*)
- [ ] Check actual code implementation status
- [ ] Estimate test coverage if possible

**Stage 6 - Maintenance**:
- [ ] Check for recent spec updates
- [ ] Look for alignment check reports
- [ ] Count learning capture documents in `reqs/learnings/`

### Step 3: Detect Actual Implementation

1. **Check for Source Code**:
   - Identify main source directories (src/, lib/, app/, etc.)
   - Count implemented components
   - Check test directories
   - Note build/deployment configs

2. **Estimate Implementation Progress**:
   - Compare specified components to implemented ones
   - Check for test files matching components
   - Look for CI/CD configurations

### Step 4: Calculate Progress

For each stage:
```
Stage Progress = (Completed Items / Expected Items) × 100

Where Expected Items are:
- Stage 0: 2 items (setup, complexity)
- Stage 1: 1+ items (purpose + any spikes)
- Stage 2: 3-5 strategy docs typically
- Stage 3: 3+ design docs + spikes + checkpoint
- Stage 4: N component specs + validation
- Stage 5: N+1 impl specs + code + checkpoint
- Stage 6: Ongoing (count activities)
```

Overall Progress = Weighted sum (see template for weights)

### Step 5: Identify Gaps and Next Steps

1. **Document Gaps**:
   - What stages have no documentation?
   - What's implemented but not specified?
   - What's specified but not implemented?

2. **Logical Next Steps**:
   - If no purpose: Start with 1.1
   - If no complexity assessment: Run 0.2
   - If code exists but no specs: Consider extract-specs-from-code
   - If specs complete but no code: Move to implementation

## Update Report Template Sections

### Key Updates to Make:

1. **Progress Overview**:
   - Update current stage based on findings
   - Count actual documents found
   - Set accurate completion counts

2. **Stage Progress**:
   - Mark completed items with [x]
   - Add actual dates from file timestamps
   - Update progress percentages
   - Note any missing expected items

3. **Decisions & Blockers**:
   - Extract key decisions from existing docs
   - Identify blockers based on gaps
   - Note any inconsistencies found

4. **Metrics**:
   - Calculate documentation completeness
   - Estimate specification drift if code exists
   - Note average document age

5. **Activity Log**:
   - Add this update as most recent activity
   - Include summary of what was discovered

6. **Next Actions**:
   - List 3-5 specific next steps
   - Prioritize based on gaps found
   - Consider both forward and backward flows

## Example Discovery Summary

```markdown
## 📋 Progress Update Summary

### Documents Found
- ✅ CLAUDE.md exists (created 2024-01-15)
- ✅ Purpose document found
- ✅ 3 of 4 expected strategy docs exist
- ⚠️ No complexity assessment found
- ⚠️ Design documents missing
- ✅ 5 component specs found
- ⚠️ No implementation specs
- ✅ Source code exists for 3 of 5 components

### Calculated Progress
- Stage 0: 50% (missing complexity assessment)
- Stage 1: 100% (purpose complete)
- Stage 2: 75% (3/4 strategies)
- Stage 3: 0% (no design docs)
- Stage 4: 50% (specs but no validation)
- Stage 5: 30% (partial implementation, no specs)
- Overall: 34%

### Key Findings
- Project started as code-first (Mode 4 candidate)
- Specifications partially backfilled
- Design stage skipped entirely
- Implementation ahead of documentation

### Recommended Actions
1. Run complexity assessment (0.2)
2. Extract design from existing code
3. Complete missing strategy doc
4. Align implementation specs with code
5. Run reality checkpoint
```

## Quality Checks

Before finalizing the update:
- [ ] All existing documents discovered
- [ ] Progress percentages are realistic
- [ ] Gaps clearly identified
- [ ] Next steps are actionable
- [ ] Report tells coherent story
- [ ] Dates and timeline make sense

## Missing Information Output

After updating the progress report:

```
## 📋 Progress Update Complete

### ✅ Updated Sections
- [Sections successfully updated]

### ⚠️ Uncertain Areas
- [Areas where progress was estimated]

### 📊 Key Metrics
- Previous Overall Progress: X%
- Updated Overall Progress: Y%
- Documents Discovered: Z

### 👉 Critical Next Steps
1. [Most important action]
2. [Second priority]
3. [Third priority]
```

Remember: An accurate progress report helps teams understand where they are and what needs attention. Be honest about gaps and realistic about progress.