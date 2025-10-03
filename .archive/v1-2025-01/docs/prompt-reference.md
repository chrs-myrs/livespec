# Prompt Reference Guide

Quick reference for all prompts in the Bidirectional Specifications System, organized by stage and purpose.

## Workflow Orchestration

### 0 - Orchestrate Workflow (`0-orchestrate-workflow.md`)
**Purpose**: Analyze project state and guide next steps
**When to use**: Anytime you need guidance on what to do next
**Key features**:
- Project state analysis
- Next step recommendations
- Review gate identification
- Blocker tracking

## Stage 0: Project Setup

### 0a - Setup Project (`0a-setup-project.md`)
**Purpose**: Initialize project with minimal CLAUDE.md and folder structure
**When to use**: Starting any new project
**Creates**: 
- Minimal CLAUDE.md (<50 lines)
- `reqs/` folder structure including `hlr/`
- Initial progress report

### 0b - Assess Complexity (`0b-assess-complexity.md`)
**Purpose**: Evaluate project complexity and recommend approach
**When to use**: Before writing specifications
**Key features**:
- AI/ML complexity scoring
- Integration risk assessment
- Spike recommendations
- Buffer calculations

### 0c - Discover UX Requirements (`0c-discover-ux-requirements.md`)
**Purpose**: Document user experience requirements before technical design
**When to use**: Before writing system purpose
**Creates**:
- User personas
- User journey maps
- Success metrics
- Information architecture

### 0d - Prepare Stakeholder Review (`0d-prepare-stakeholder-review.md`)
**Purpose**: Package documentation for stakeholder review
**When to use**: When stage work is complete and needs approval
**Creates**:
- Consolidated review package
- Decision summary
- Feedback templates

### 0e - Process Stakeholder Feedback (`0e-process-stakeholder-feedback.md`)
**Purpose**: Integrate stakeholder feedback into documentation
**When to use**: After receiving review feedback
**Updates**:
- Relevant specifications
- Progress tracking
- Decision log

### 0f - Continue Workflow (`0f-continue-workflow.md`)
**Purpose**: Resume workflow after human tasks complete
**When to use**: After reviews or manual work
**Features**:
- Task validation
- State assessment
- Next step guidance

## Stage 1: Discovery & Purpose

### 1a - Write Purpose (`1a-write-purpose.md`)
**Purpose**: Document WHY the system exists
**When to use**: Starting specifications or documenting existing system
**Key features**:
- Reads from `reqs/hlr/` folder
- Creates open questions document
- Works forward or backward

### 1b - Define User Success (`1b-define-user-success.md`)
**Purpose**: Transform system purpose into measurable user success criteria
**When to use**: After defining system purpose, before technical strategy
**Creates**:
- User success metrics
- Value propositions
- Outcome-based goals
- Success indicators

### 1c - Run Purpose Spike (`1c-run-purpose-spike.md`)
**Purpose**: Explore unknowns about system purpose
**When to use**: When purpose is unclear or complex
**Time-boxed**: 1-3 days typically

## Stage 2: Strategy

### 2a - Write Strategy (`2a-write-strategy.md`)
**Purpose**: Document HOW the system will be built (technical decisions)
**When to use**: After purpose is clear
**Creates**: Multiple strategy documents by area

### 2b - Write UX Strategy (`2b-write-ux-strategy.md`)
**Purpose**: Document user experience strategy and interaction paradigms
**When to use**: After user success criteria are defined
**Creates**:
- Interaction strategies
- Progressive disclosure plans
- Cognitive load management
- Accessibility approach

### 2c - Run Strategy Spike (`2c-run-strategy-spike.md`)
**Purpose**: Explore technical approach options
**When to use**: When technical decisions need validation
**Outputs**: Recommendations with evidence

## Stage 3: Design

### 3a - Write Design (`3a-write-design.md`)
**Purpose**: Document system architecture and component structure
**When to use**: After strategies are defined
**Creates**: 
- System overview
- Component architecture
- Data flow diagrams
- Integration maps

### 3b - Design Interactions (`3b-design-interactions.md`)
**Purpose**: Create detailed interaction designs using markdown
**When to use**: After UX strategy is defined
**Creates**:
- ASCII UI mockups
- Interaction flows
- State transitions
- Error handling patterns

### 3c - Run Design Spike (`3c-run-design-spike.md`)
**Purpose**: Validate design decisions
**When to use**: Complex integrations or architectural patterns

### 3d - Design Reality Checkpoint (`3d-design-checkpoint.md`)
**Purpose**: Validate design matches implementation reality
**When to use**: After initial implementation or periodically

## Stage 4: Components

### 4a - Write Components (`4a-write-components.md`)
**Purpose**: Specify WHAT each component does
**When to use**: After design is complete
**Creates**: One spec per component

### 4b - Define Behaviors (`4b-define-behaviors.md`)
**Purpose**: Specify user-facing behaviors of components
**When to use**: After component capabilities are defined
**Creates**:
- Observable behaviors
- User feedback patterns
- State visibility
- Response characteristics

### 4c - Validate Components (`4c-validate-components.md`)
**Purpose**: Component specification validation
**When to use**: Before creating implementation specs
**Validates**: Stages 1-4 completeness and alignment
**Note**: Does NOT check Stage 5 documents (they don't exist yet)

## Stage 5: Implementation

### 5a - Write Implementation (`5a-write-implementation.md`)
**Purpose**: Detail HOW components work technically
**When to use**: After 4.2 validation passes
**Creates**: 
- Master implementation plan (FIRST!)
- Component implementation specs

### 5b - Create UI Specs (`5b-create-ui-specs.md`)
**Purpose**: Create detailed UI specifications in markdown
**When to use**: After interaction designs are complete
**Creates**:
- Design tokens
- Component specifications
- Layout systems
- Responsive breakpoints

### 5c - Validate Implementation (`5c-validate-implementation.md`)
**Purpose**: Implementation specification validation
**When to use**: After 5.1, before coding begins
**Validates**: Stage 5 technical completeness
**Must pass**: To proceed with actual coding

### 5d - Implement from Specs (`5d-implement-from-specs.md`)
**Purpose**: Guide TDD implementation
**When to use**: After 5c validation passes
**Enforces**: Test-first development

### 5e - Implementation Checkpoint (`5e-implementation-checkpoint.md`)
**Purpose**: Validate implementation matches specs
**When to use**: After implementation phases

### 5f - Run Usability Tests (`5f-run-usability-tests.md`)
**Purpose**: Plan and document usability testing
**When to use**: After UI implementation
**Creates**:
- Test scenarios
- Testing protocols
- Findings documentation
- Improvement recommendations

## Stage 6: Maintenance

### 6a - Update Specs (`6a-update-specs.md`)
**Purpose**: Update specs from code changes
**When to use**: After code modifications
**Maintains**: Bidirectional sync

### 6b - Check Alignment (`6b-check-alignment.md`)
**Purpose**: Detect drift between specs and code
**When to use**: Periodically or before major changes
**Identifies**: Misalignments to fix

### 6c - Capture Learnings (`6c-capture-learnings.md`)
**Purpose**: Document lessons and patterns
**When to use**: After surprises or discoveries
**Feeds**: Process improvements

## Utility Prompts

### Migrate to Latest (`migrate-to-latest.md`)
**Purpose**: Migrate older project structures to latest version
**When to use**: Projects using older versions of the framework
**Key features**:
- Version detection
- Automated migration plan
- Gap analysis
- Preservation of existing content

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
1. `0a-setup-project.md` - Initialize
2. `1a-write-purpose.md` - Define why
3. `0b-assess-complexity.md` - Evaluate approach
4. Continue through stages 2-4...
5. `4c-validate-components.md` - Validate before implementation
6. `5a-write-implementation.md` - Create master plan & specs
7. `5c-validate-implementation.md` - Validate technical completeness
8. `5d-implement-from-specs.md` - Build with TDD

### Document Existing Code
1. `extract-specs-from-code.md` - Start analysis
2. `update-progress-report.md` - Set baseline
3. Fill gaps with stage prompts...

### Quick Prototype
1. Run validation first (4c or 5c depending on stage)
2. `auto-build.md` - Let it rip
3. Remember: PROTOTYPE ONLY!

### Maintain Living Docs
1. `6a-update-specs.md` - After changes
2. `6b-check-alignment.md` - Periodically
3. `integrate-question-answers.md` - As questions are resolved

## Pro Tips

1. **Always create master plan first** in implementation stage
2. **Update progress report** after each prompt
3. **Track open questions** - they're gold for improvement
4. **Run checkpoints** before major milestones
5. **Use spikes** when uncertain - time-boxed exploration
6. **Keep CLAUDE.md minimal** - under 100 lines
7. **Let prompts discover** - don't manually list files
8. **Two validation gates** - 4c validates specs, 5c validates implementation
9. **Validation prevents problems** - Failed validation saves time

## Quick Decision Tree

**Q: I have a new idea**
→ Use `0a-setup-project.md`

**Q: I have existing code**
→ Use `extract-specs-from-code.md`

**Q: I need to explore something**
→ Use appropriate spike prompt

**Q: Specs and code don't match**
→ Use `6b-check-alignment.md`

**Q: I have unanswered questions**
→ Use `review-open-questions.md`

**Q: I need a quick prototype**
→ Use `auto-build.md` (carefully!)

**Q: Ready to start coding?**
→ Run `4c-validate-components.md` first
→ Then `5a-write-implementation.md`
→ Then `5c-validate-implementation.md`
→ Finally `5d-implement-from-specs.md`

---

Remember: The system works bidirectionally - you can start from either end and maintain synchronization throughout the lifecycle.