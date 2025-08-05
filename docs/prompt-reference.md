# Prompt Reference Guide

Quick reference for all prompts in the Bidirectional Specifications System, organized by stage and purpose.

## Stage 0: Project Setup

### 0.1 - Setup Project (`0.1-setup-project.md`)
**Purpose**: Initialize project with minimal CLAUDE.md and folder structure
**When to use**: Starting any new project
**Creates**: 
- Minimal CLAUDE.md (<50 lines)
- `reqs/` folder structure including `hlr/`
- Initial progress report

### 0.2 - Assess Complexity (`0.2-assess-complexity.md`)
**Purpose**: Evaluate project complexity and recommend approach
**When to use**: Before writing specifications
**Key features**:
- AI/ML complexity scoring
- Integration risk assessment
- Spike recommendations
- Buffer calculations

## Stage 1: Discovery & Purpose

### 1.1 - Write Purpose (`1.1-write-purpose.md`)
**Purpose**: Document WHY the system exists
**When to use**: Starting specifications or documenting existing system
**Key features**:
- Reads from `reqs/hlr/` folder
- Creates open questions document
- Works forward or backward

### 1.2 - Run Purpose Spike (`1.2-run-purpose-spike.md`)
**Purpose**: Explore unknowns about system purpose
**When to use**: When purpose is unclear or complex
**Time-boxed**: 1-3 days typically

## Stage 2: Strategy

### 2.1 - Write Strategy (`2.1-write-strategy.md`)
**Purpose**: Document HOW the system will be built (technical decisions)
**When to use**: After purpose is clear
**Creates**: Multiple strategy documents by area

### 2.2 - Run Strategy Spike (`2.2-run-strategy-spike.md`)
**Purpose**: Explore technical approach options
**When to use**: When technical decisions need validation
**Outputs**: Recommendations with evidence

## Stage 3: Design

### 3.1 - Write Design (`3.1-write-design.md`)
**Purpose**: Document system architecture and component structure
**When to use**: After strategies are defined
**Creates**: 
- System overview
- Component architecture
- Data flow diagrams
- Integration maps

### 3.2 - Run Design Spike (`3.2-run-design-spike.md`)
**Purpose**: Validate design decisions
**When to use**: Complex integrations or architectural patterns

### 3.3 - Design Reality Checkpoint (`3.3-design-checkpoint.md`)
**Purpose**: Validate design matches implementation reality
**When to use**: After initial implementation or periodically

## Stage 4: Components

### 4.1 - Write Components (`4.1-write-components.md`)
**Purpose**: Specify WHAT each component does
**When to use**: After design is complete
**Creates**: One spec per component

### 4.2 - Validate Components (`4.2-validate-components.md`)
**Purpose**: Component specification validation
**When to use**: Before creating implementation specs
**Validates**: Stages 1-4 completeness and alignment
**Note**: Does NOT check Stage 5 documents (they don't exist yet)

## Stage 5: Implementation

### 5.1 - Write Implementation (`5.1-write-implementation.md`)
**Purpose**: Detail HOW components work technically
**When to use**: After 4.2 validation passes
**Creates**: 
- Master implementation plan (FIRST!)
- Component implementation specs

### 5.2 - Validate Implementation (`5.2-validate-implementation.md`)
**Purpose**: Implementation specification validation
**When to use**: After 5.1, before coding begins
**Validates**: Stage 5 technical completeness
**Must pass**: To proceed with actual coding

### 5.3 - Implement from Specs (`5.3-implement-from-specs.md`)
**Purpose**: Guide TDD implementation
**When to use**: After 5.2 validation passes
**Enforces**: Test-first development

### 5.4 - Implementation Checkpoint (`5.4-implementation-checkpoint.md`)
**Purpose**: Validate implementation matches specs
**When to use**: After implementation phases

## Stage 6: Maintenance

### 6.1 - Update Specs (`6.1-update-specs.md`)
**Purpose**: Update specs from code changes
**When to use**: After code modifications
**Maintains**: Bidirectional sync

### 6.2 - Check Alignment (`6.2-check-alignment.md`)
**Purpose**: Detect drift between specs and code
**When to use**: Periodically or before major changes
**Identifies**: Misalignments to fix

### 6.3 - Capture Learnings (`6.3-capture-learnings.md`)
**Purpose**: Document lessons and patterns
**When to use**: After surprises or discoveries
**Feeds**: Process improvements

## Utility Prompts

### Extract Specs from Code (`extract-specs-from-code.md`)
**Purpose**: Reverse engineer documentation from existing code
**When to use**: Legacy systems with no docs
**Mode**: Backward (Mode 4)

### Update Progress Report (`update-progress-report.md`)
**Purpose**: Analyze project state and update progress
**When to use**: Catching up progress tracking
**Updates**: `reqs/progress-report.md`

### Integrate Question Answers (`integrate-question-answers.md`)
**Purpose**: Flow answered questions back into specs
**When to use**: After getting answers to open questions
**Updates**: Relevant specification documents

### Review Open Questions (`review-open-questions.md`)
**Purpose**: Triage and prioritize open questions
**When to use**: Weekly or at stage transitions
**Outputs**: Prioritized action items

### Run Discovery Spike (`run-discovery-spike.md`)
**Purpose**: General exploration framework
**When to use**: Any stage with unknowns
**Time-boxed**: Prevents analysis paralysis

### Reality Checkpoint (`reality-checkpoint.md`)
**Purpose**: General spec-to-code validation
**When to use**: Any stage to verify alignment
**Identifies**: Drift and inconsistencies

### Auto Build (`auto-build.md`)
**Purpose**: Prototype from any starting point
**When to use**: ⚠️ PROTOTYPES ONLY
**Warning**: Makes assumptions, not for production

## Common Workflows

### New Project from Idea
1. `0.1-setup-project.md` - Initialize
2. `1.1-write-purpose.md` - Define why
3. `0.2-assess-complexity.md` - Evaluate approach
4. Continue through stages 2-4...
5. `4.2-validate-components.md` - Validate before implementation
6. `5.1-write-implementation.md` - Create master plan & specs
7. `5.2-validate-implementation.md` - Validate technical completeness
8. `5.3-implement-from-specs.md` - Build with TDD

### Document Existing Code
1. `extract-specs-from-code.md` - Start analysis
2. `update-progress-report.md` - Set baseline
3. Fill gaps with stage prompts...

### Quick Prototype
1. Run validation first (4.2 or 5.2 depending on stage)
2. `auto-build.md` - Let it rip
3. Remember: PROTOTYPE ONLY!

### Maintain Living Docs
1. `6.1-update-specs.md` - After changes
2. `6.2-check-alignment.md` - Periodically
3. `integrate-question-answers.md` - As questions are resolved

## Pro Tips

1. **Always create master plan first** in implementation stage
2. **Update progress report** after each prompt
3. **Track open questions** - they're gold for improvement
4. **Run checkpoints** before major milestones
5. **Use spikes** when uncertain - time-boxed exploration
6. **Keep CLAUDE.md minimal** - under 100 lines
7. **Let prompts discover** - don't manually list files
8. **Two validation gates** - 4.2 validates specs, 5.2 validates implementation
9. **Validation prevents problems** - Failed validation saves time

## Quick Decision Tree

**Q: I have a new idea**
→ Use `0.1-setup-project.md`

**Q: I have existing code**
→ Use `extract-specs-from-code.md`

**Q: I need to explore something**
→ Use appropriate spike prompt

**Q: Specs and code don't match**
→ Use `6.2-check-alignment.md`

**Q: I have unanswered questions**
→ Use `review-open-questions.md`

**Q: I need a quick prototype**
→ Use `auto-build.md` (carefully!)

**Q: Ready to start coding?**
→ Run `4.2-validate-components.md` first
→ Then `5.1-write-implementation.md`
→ Then `5.2-validate-implementation.md`
→ Finally `5.3-implement-from-specs.md`

---

Remember: The system works bidirectionally - you can start from either end and maintain synchronization throughout the lifecycle.