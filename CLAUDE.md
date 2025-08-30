# LiveSpec - Living Specification Framework

## Quick Reference
- **Purpose**: Framework for maintaining living documentation synchronized with code
- **Type**: Meta-framework with executable prompts
- **Stack**: Markdown prompts, bash scripts
- **Started**: 2024-01-01
- **Stage**: Maintenance/Enhancement

## Project-Specific Focus

### Complexity Areas
- Bidirectional sync between docs and code
- Stage-based workflow orchestration
- Context optimization for AI effectiveness

### Critical Constraints
- Prompts must be self-contained for .claude/commands
- Documentation reflects state, not plans
- Minimal context maximizes engineering effectiveness

## Working Agreements

### Code Standards
- Prompts use Stage-Letter numbering (0a, 1b, 2c, etc.)
- Templates separated from execution logic
- Missing info detection with priority levels
- Progress tracking integrated throughout

### Prompt Numbering Convention
- Format: [stage][letter]-[description].md
- Stage: 0-6 representing workflow stages
- Letter: a-z showing sequence within stage
- Execution order: 0a, 0b, 0c, 1a, 1b, etc.
- When inserting new prompts, use next available letter
- Letters allow insertion without renumbering

### Workflow Orchestration

The system now includes comprehensive workflow orchestration with stakeholder review gates:

1. **Workflow Control**
   - Use `0-orchestrate-workflow.md` to analyze project state and determine next steps
   - Automatically identifies when stakeholder reviews are needed
   - Guides users through both automated and manual processes

2. **Review Gates**
   Mandatory review points occur after:
   - Stage 0: UX Discovery (personas, journeys, IA)
   - Stage 1: Purpose (business alignment, success metrics)
   - Stage 2: Strategy (technical/UX approach)
   - Stage 3: Design (architecture, interactions)
   - Stage 4: Pre-Implementation (final go/no-go)

3. **Review Process Flow**
   ```
   Work Complete → Prepare Review (0d) → Stakeholder Review → 
   Process Feedback (0e) → Continue Workflow (0f)
   ```

4. **Stakeholder Interaction**
   - Review packages are created as markdown documents
   - Stakeholders can annotate directly or use feedback forms
   - All feedback is tracked and integrated systematically
   - Approval history is maintained for audit trail

5. **Progress Tracking**
   - Enhanced progress reports track review status
   - Review metrics (cycle time, approval rate, etc.)
   - Blocker tracking with ownership
   - Clear visualization of what's waiting on whom

### Documentation Flow
- User docs in docs/ (not prompts/)
- Templates in prompts/templates/
- HLR support via reqs/hlr/
- Change logs separate from main specs

## Current Version
Version 1.0.0 - Initial release of LiveSpec framework

## Key Technical Decisions
- **Minimal CLAUDE.md**: <50 lines beats 450+ lines for AI performance
- **Stage-based workflow**: Clear progression through specification levels
- **HLR input mechanism**: Requirements can flow from external sources
- **Progress tracking**: Weighted calculation across all stages