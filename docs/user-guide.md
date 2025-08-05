# Bidirectional Specifications System - User Guide

Welcome to the Bidirectional Specifications System! This guide will help you get started quickly and use the system effectively for your documentation needs.

---

## Table of Contents

1. [Quick Start](#quick-start)
2. [Understanding the System](#understanding-the-system)
3. [Choosing Your Mode](#choosing-your-mode)
4. [Using the Prompts](#using-the-prompts)
5. [Common Workflows](#common-workflows)
6. [Best Practices](#best-practices)
7. [Troubleshooting](#troubleshooting)
8. [FAQ](#faq)

---

## Quick Start

### I have an existing codebase with no documentation

```bash
# 1. Navigate to your project root
cd /path/to/your/project

# 2. Create the reqs directory structure
mkdir -p reqs/{hlr,0-complexity,1-purpose,2-strategy,3-design,4-components,5-implementation,spikes,learnings}

# 3. Use Claude Code with the extraction prompt
claude-code "Use the prompt at prompts/extract-specs-from-code.md to document this codebase"
```

### I'm starting a new project

```bash
# 1. Navigate to your project directory
cd my-project

# 2. Set up the bidirectional specs system
claude-code "Use prompts/0.1-setup-project.md"

# 3. If you have requirements documents, add them
cp ~/my-requirements/*.md reqs/hlr/

# 4. Define your system purpose
claude-code "Use the prompt at prompts/1.1-write-purpose.md for my new inventory system"
```

### I have existing requirements documents

```bash
# 1. Set up the project
claude-code "Use prompts/0.1-setup-project.md"

# 2. Place requirements in hlr folder
cp my-requirements.docx reqs/hlr/
cp user-stories.md reqs/hlr/

# 3. Run purpose extraction
claude-code "Use prompts/1.1-write-purpose.md - it will read from hlr/"
```

### I need to update existing documentation

```bash
# After making code changes
claude-code "Use the prompt at prompts/6.1-update-specs.md to sync documentation"
```

### I want to check if my docs match my code

```bash
# Run alignment check
claude-code "Use the prompt at prompts/6.2-check-alignment.md"
```

### I want to update my progress report

```bash
# Analyze current state and update progress
claude-code "Use the prompt at prompts/update-progress-report.md"
```

---

## Understanding the System

### What Makes This Different?

Traditional documentation flows one way: Ideas → Docs → Code → Outdated Docs 😢

This system works **bidirectionally**:
- **Forward**: Ideas → Living Specs → Code
- **Backward**: Code → Extracted Specs → Understanding  
- **Continuous**: Code ↔ Specs (always in sync)

### Five Levels of Specification

```
1. System Purpose      (WHY does this exist?)
   ↓
2. Technical Strategy  (WHAT key decisions were made?)
   ↓
3. System Design      (HOW is it structured?)
   ↓
4. Component Specs    (WHAT does each part do?)
   ↓
5. Implementation     (HOW does it work technically?)
```

Each level serves different audiences:
- **Level 1**: Business stakeholders, product managers
- **Level 2**: Architects, tech leads
- **Level 3**: Development teams
- **Level 4**: Component developers
- **Level 5**: Implementers, maintainers

---

## Choosing Your Mode

### Decision Flowchart

```
Do you have existing code?
├─ No → Use Mode 1 (New Project)
└─ Yes → Do you have documentation?
         ├─ No → Use Mode 4 (Extract from Code)
         └─ Yes → Is it up to date?
                  ├─ No → Use Mode 3 (Check Alignment)
                  └─ Yes → Use Mode 2 (Keep it Updated)
```

### Mode Details

#### Mode 1: New Project Development
**When to use**: Starting fresh with an idea

**Process**:
1. Define purpose (why build this?)
2. Document key technical decisions
3. Design system architecture
4. Specify component capabilities
5. Detail implementation approach

**Example scenario**: "We need a new customer portal"

#### Mode 2: Synchronized Updates
**When to use**: Code is evolving, docs need updating

**Process**:
1. Make code changes
2. Run update prompt
3. Review suggested doc updates
4. Commit code and docs together

**Example scenario**: "Added payment processing to the system"

#### Mode 3: Alignment Checking  
**When to use**: Periodic health checks or before major changes

**Process**:
1. Run alignment check
2. Review misalignment report
3. Prioritize fixes by severity
4. Update docs or code as needed

**Example scenario**: "Quarterly documentation review"

#### Mode 4: Reverse Engineering
**When to use**: Existing code needs documentation

**Process**:
1. Run extraction on codebase
2. Review generated specs
3. Clean up unclear sections
4. Establish as baseline

**Example scenario**: "Inherited legacy system"

---

## Using the Prompts

### Stage-Based Workflow

The system now follows numbered stages with integrated progress tracking:

#### Stage 0: Project Setup
```bash
# 0.1 - Initialize project
claude-code "Use prompts/0.1-setup-project.md"

# 0.2 - Assess complexity
claude-code "Use prompts/0.2-assess-complexity.md"
```

#### Stage 1: Discovery & Purpose
```bash
# 1.1 - Write purpose (reads from reqs/hlr/)
claude-code "Use prompts/1.1-write-purpose.md for our new expense tracking system"

# 1.2 - Run purpose-level spikes if needed
claude-code "Use prompts/1.2-run-purpose-spike.md to explore market viability"
```

#### Stage 2: Strategy
```bash
# 2.1 - Document technical strategies
claude-code "Use prompts/2.1-write-strategy.md to document our technical decisions"

# 2.2 - Run strategy spikes if needed
claude-code "Use prompts/2.2-run-strategy-spike.md to test technology choices"
```

#### Stage 3: Design
```bash
# 3.1 - Create system design
claude-code "Use prompts/3.1-write-design.md to create architecture diagrams"

# 3.2 - Run design spikes if needed
claude-code "Use prompts/3.2-run-design-spike.md to test integration approach"

# 3.3 - Validate design before proceeding
claude-code "Use prompts/3.3-design-checkpoint.md"
```

#### Stage 4: Components
```bash
# 4.1 - Write component specifications
claude-code "Use prompts/4.1-write-components.md to specify component capabilities"

# 4.2 - Validate components are ready for implementation planning
claude-code "Use prompts/4.2-validate-components.md"
# Note: This validates Stages 1-4 only, NOT implementation specs
```

#### Stage 5: Implementation
```bash
# 5.1 - Write implementation specs (master plan first!)
claude-code "Use prompts/5.1-write-implementation.md for detailed technical specs"

# 5.2 - Validate implementation specs before coding
claude-code "Use prompts/5.2-validate-implementation.md"
# Note: This validates Stage 5 specs are ready for coding

# 5.3 - Implement from specifications
claude-code "Use prompts/5.3-implement-from-specs.md"

# 5.4 - Validate implementation matches specs
claude-code "Use prompts/5.4-implementation-checkpoint.md"
```

#### Stage 6: Maintenance
```bash
# 6.1 - Update specs after code changes
claude-code "Use prompts/6.1-update-specs.md"

# 6.2 - Check alignment
claude-code "Use prompts/6.2-check-alignment.md"

# 6.3 - Capture learnings
claude-code "Use prompts/6.3-capture-learnings.md"
```
### Utility Prompts

#### Progress Tracking
```bash
# Update progress report from current state
claude-code "Use prompts/update-progress-report.md"
```
- Analyzes project state
- Updates progress percentages
- Identifies completed work
- Recommends next steps

#### Reverse Engineering (Mode 4)
```bash
# Extract specs from existing code
claude-code "Use prompts/extract-specs-from-code.md"
```
- Documents existing systems
- Creates specs from code
- Useful for legacy systems

#### Quick Prototyping
```bash
# Auto-build from minimal info
claude-code "Use prompts/auto-build.md"
```
- Rapid prototyping mode
- Makes assumptions
- Not for production
- Requires validation PASS first
- Follows TDD approach strictly
- Implements per master plan order
- Handles dependencies properly
- Maintains system coherence

**Advanced Arguments**:
- `resume` - Continue from last completed component
- `phase` - Execute next incomplete phase
- `phase3` - Execute specific phase number
- `component:name` - Implement specific component
- `unsupervised` - Run without confirmations
- `dry-run` - Show what would be done

#### `extract-specs-from-code.md` - Reverse Engineering (Mode 4)
```bash
claude-code "Use prompts/extract-specs-from-code.md to generate complete documentation"
```
- Analyzes entire codebase
- Creates full spec hierarchy
- Marks inferences clearly

#### `update-specs-with-code.md` - Synchronized Updates (Mode 2)
```bash
claude-code "Use prompts/update-specs-with-code.md after these code changes"
```
- Detects what changed
- Updates affected specs
- Maintains change logs

#### `align-specs-to-code.md` - Alignment Checking (Mode 3)
```bash
claude-code "Use prompts/align-specs-to-code.md for quarterly review"
```
- Compares specs to code
- Reports misalignments
- Suggests fixes

---

## Project Setup Workflow

### Setting Up a New Project for Specs + TDD

When starting a new project, use the setup prompt to configure everything properly:

```bash
# Navigate to your project directory
cd my-new-project

# Run the comprehensive setup
claude-code "Use prompts/setup-project-claude-md.md"
```

**What the setup does**:
- Analyzes your project type and technology stack
- Generates a tailored CLAUDE.md with TDD rules
- Configures bidirectional specs integration
- Sets up quality gates and error prevention
- Establishes maintenance schedules

**After setup**:
1. Review the generated CLAUDE.md with your team
2. Set up recommended git hooks and CI/CD integration
3. Begin with `1-write-purpose.md` to define your system
4. Follow the established TDD and specification workflows

## Common Workflows

### Workflow 1: Starting with High-Level Requirements

```bash
# Step 1: Set up project and add requirements
claude-code "Use prompts/0.1-setup-project.md"
cp ~/requirements/*.md reqs/hlr/

# Step 2: Assess complexity
claude-code "Use prompts/0.2-assess-complexity.md"

# Step 3: Transform HLR to purpose
claude-code "Use prompts/1.1-write-purpose.md"
# The prompt will read from reqs/hlr/ automatically

# Step 4: Continue through stages...
```

### Workflow 2: Documenting a Legacy System

```bash
# Step 1: Set up and extract
claude-code "Use prompts/0.1-setup-project.md"
claude-code "Use prompts/extract-specs-from-code.md"

# Step 2: Update progress to current state
claude-code "Use prompts/update-progress-report.md"

# Step 3: Review and refine extracted docs
# Check reqs/ folders and improve as needed

# Step 4: Set up maintenance workflow
# Regular alignment checks and updates
```

### Workflow 3: New Feature Development

```bash
# Step 1: Check current progress
cat reqs/progress-report.md

# Step 2: Update relevant stage documents
claude-code "Update purpose for new feature using prompts/1.1-write-purpose.md"

# Step 3: Run any needed spikes
claude-code "Use prompts/3.2-run-design-spike.md for integration testing"

# Step 4: Update progress report
claude-code "Use prompts/update-progress-report.md"

# Step 4: Specify the new component
claude-code "Create specs for reporting service using prompts/4-write-components.md"

# Step 5: Detail the implementation
claude-code "Create implementation spec using prompts/5.1-write-implementation.md"
```

### Workflow 3: Pre-Release Documentation Check

```bash
# Step 1: Run alignment check
claude-code "Use prompts/align-specs-to-code.md"

# Step 2: Address critical misalignments
# Fix any HIGH severity issues immediately

# Step 3: Update documentation
claude-code "Use prompts/update-specs-with-code.md to fix misalignments"

# Step 4: Verify alignment
claude-code "Re-run prompts/align-specs-to-code.md to verify fixes"
```

### Workflow 4: Implementing a New System (IMPORTANT)

```bash
# Step 1: Create all specifications first
claude-code "Use prompts/1-write-purpose.md for our inventory system"
claude-code "Use prompts/2-write-strategy.md to document technical approach"
claude-code "Use prompts/3-write-design.md to design the architecture"
claude-code "Use prompts/4-write-components.md to specify all components"

# Step 2: Create implementation specifications WITH MASTER PLAN
claude-code "Use prompts/5.1-write-implementation.md to create technical specs"
# This creates:
# - reqs/5-implementation/00-master-implementation-plan.md (CRITICAL!)
# - Individual component implementation specs
# - Dependency graph and build order

# Step 3: Review the master plan
# Check reqs/5-implementation/00-master-implementation-plan.md
# - Understand phases and dependencies
# - Review build order
# - Check critical path

# Step 4: VALIDATE everything is ready (CRITICAL!)
claude-code "Use prompts/pre-implementation-validation.md"
# This validates:
# - All specs are complete and aligned
# - No missing documents or sections  
# - Dependencies are correctly mapped
# - Test strategies are defined
# - No circular dependencies exist
# MUST show PASS before proceeding!

# Step 5: Execute implementation following the plan
claude-code "Use prompts/5.3-implement-from-specs.md to build the system"
# This will:
# - Use TDD approach (tests first!)
# - Follow the master plan's build order
# - Implement components with proper dependencies
# - Update progress tracking
# - Maintain system coherence

# Advanced execution options:
# Resume where you left off:
claude-code "Use prompts/5.3-implement-from-specs.md" --arguments "resume"

# Execute specific phase:
claude-code "Use prompts/5.3-implement-from-specs.md" --arguments "phase2"

# Run unsupervised (no confirmations):
claude-code "Use prompts/5.3-implement-from-specs.md" --arguments "unsupervised"

# Implement specific component:
claude-code "Use prompts/5.3-implement-from-specs.md" --arguments "component:auth-service"

# Dry run to see what would be done:
claude-code "Use prompts/5.3-implement-from-specs.md" --arguments "dry-run"
```

**Why the Master Plan Matters**: Without it, components get built in isolation and integration becomes a nightmare. The master plan ensures everything fits together!

### Workflow 5: Auto-Build for Rapid Prototyping (⚠️ PROTOTYPE ONLY)

For rapid prototyping or proof-of-concepts where assumptions are acceptable:

```bash
# Auto-build from whatever documentation exists
claude-code "Use prompts/auto-build.md"

# Dry run to see what would be built
claude-code "Use prompts/auto-build.md" --arguments "dry-run"

# Force rebuild from specific stage
claude-code "Use prompts/auto-build.md" --arguments "from:design"

# Verbose mode to see all decisions
claude-code "Use prompts/auto-build.md" --arguments "verbose"
```

**⚠️ WARNING - PROTOTYPE MODE**: 
- Makes assumptions to fill gaps
- Not for production systems
- Always review generated artifacts
- Security/performance not optimized
- Use ONLY for:
  - Prototypes
  - Proof of concepts
  - Learning/experimentation
  - Non-critical demos

**Process**:
1. Discovers most mature documentation
2. Runs all subsequent prompts automatically
3. Makes reasonable assumptions
4. Generates complete system
5. Reports all assumptions made

---

## Best Practices

### DO's ✅

1. **Start with extraction for existing code**
   - Don't try to write docs from memory
   - Let the code tell its story first

2. **Keep specifications at the right level**
   - Business value in Purpose
   - Technical choices in Strategy
   - Implementation details in Implementation

3. **Always create a master implementation plan**
   - Use prompt 5 to generate it automatically
   - Review dependencies before implementing
   - Follow the build order it defines
   - Track progress systematically

4. **Always validate before implementing**
   - Run pre-implementation validation
   - Fix any issues found
   - Don't skip this step!
   - Re-validate after fixes

5. **Follow Test-Driven Development**
   - Write tests BEFORE code
   - Red-Green-Refactor cycle
   - Let tests drive design
   - 100% coverage for critical paths

6. **Update docs with code changes**
   - Make it part of your PR process
   - Small, incremental updates are easier

7. **Run regular alignment checks**
   - Quarterly for stable systems
   - Monthly for rapidly evolving systems

8. **Mark uncertainties honestly**
   - Use "Inferred:" when guessing
   - Document what you don't know

### DON'Ts ❌

1. **Don't document wishes**
   - Document what IS, not what should be
   - Use issue trackers for future plans

2. **Don't skip validation**
   - NEVER start implementation without validation PASS
   - Fix issues before coding
   - Validation prevents integration nightmares

3. **Don't write code before tests**
   - TDD means test FIRST
   - No exceptions for "simple" code
   - Tests are your specification

4. **Don't skip levels**
   - Each level builds on the previous
   - Missing levels create gaps

5. **Don't let docs drift**
   - Set up regular sync cycles
   - Address misalignments quickly

6. **Don't over-document**
   - One page per document ideal
   - Link to details elsewhere

7. **Don't mix concerns**
   - Keep business separate from technical
   - Each level has its audience

---

## Troubleshooting

### "The extraction missed important components"

**Solution**: 
- Check if components are in non-standard locations
- Ensure code is accessible to Claude Code
- Manually guide with: `"Focus on the services/ directory"`

### "Too many strategy documents were created"

**Solution**:
- Consolidate related decisions
- Remove duplicate strategies
- Keep 3-7 strategy docs typically

### "Alignment check shows everything as misaligned"

**Causes**:
- Specs were written as wishes, not reality
- Major refactoring without doc updates
- Extraction wasn't run first

**Solution**:
- Re-run extraction to baseline
- Focus on high-severity items first
- Update incrementally

### "Documentation is too technical for stakeholders"

**Solution**:
- Ensure Level 1 (Purpose) is business-focused
- Add executive summaries to design docs
- Create separate stakeholder views

### "Implementation stopped after one component"

**Cause**: 
- No master implementation plan to coordinate
- Components treated as independent
- Lost track of the big picture

**Solution**:
- Always use `5.1-write-implementation.md` first to create master plan
- Check `reqs/5-implementation/00-master-implementation-plan.md` exists
- Use `5.3-implement-from-specs.md` which follows the plan
- Master plan tracks progress across ALL components

**Prevention**:
- Review master plan before starting implementation
- Understand component dependencies
- Follow the documented build order
- Update progress tracking after each component

---

## FAQ

### Q: How often should I run alignment checks?

**A**: Depends on your development pace:
- Rapid development: Weekly
- Normal pace: Monthly  
- Maintenance mode: Quarterly
- Before major changes: Always

### Q: Can I use this with multiple programming languages?

**A**: Yes! The system is language-agnostic. It extracts patterns and structures regardless of the implementation language.

### Q: Should documentation live with code or separately?

**A**: Best practice is to keep them together:
```
my-project/
├── src/          # Your code
├── reqs/         # Your specifications
└── README.md
```

### Q: How do I handle microservices?

**A**: Two approaches:

1. **Monorepo**: One reqs/ folder at root documenting all services
2. **Polyrepo**: Each service has its own reqs/ folder

The system design level shows how services interact.

### Q: What if I only need component-level documentation?

**A**: While you can start anywhere, higher levels provide valuable context. At minimum, create:
- A basic purpose document (why this component exists)
- The component specification
- The implementation specification

### Q: How do I document external integrations?

**A**: External integrations appear at multiple levels:
- **Strategy**: Decision to use external service
- **Design**: Integration points and data flow
- **Component**: Which component handles integration
- **Implementation**: API contracts and error handling

### Q: Can I customize the templates?

**A**: Yes! The prompts provide templates, but you can:
- Add sections relevant to your domain
- Remove sections you don't need
- Maintain consistency across documents

### Q: How does this relate to ADRs?

**A**: They're complementary:
- **Strategy docs**: Current technical approach
- **ADRs**: Historical record of decisions
- Strategy docs can reference relevant ADRs

### Q: When should I define test strategy?

**A**: Test strategy is defined at multiple levels:
- **Component Specs (Level 4)**: Define WHAT to test - behaviors, scenarios, edge cases
- **Implementation Specs (Level 5)**: Define HOW to test - frameworks, TDD approach, test data
- **Master Plan**: Define WHEN to test - phases, milestones, integration points
- **Pre-Implementation**: Validates test strategy exists before coding starts

Early test planning ensures testable design and prevents untestable code.

### Q: What if validation fails?

**A**: A failed validation is good! It prevents bigger problems:
1. **Review the validation report** - understand all issues
2. **Fix blockers first** - these prevent implementation
3. **Address warnings** - these may cause problems
4. **Update specifications** - don't just patch, fix properly
5. **Re-run validation** - ensure all issues resolved
6. **Only then proceed** - with confidence!

---

## Getting Help

### Resources

1. **Example Documentation**: Check the `examples/` directory
2. **Prompt Reference**: Read the prompts directly for details
3. **Community**: Share experiences and get tips

### Common Starting Points

- **Have code, need docs?** Start with `extract-specs-from-code.md`
- **Starting fresh?** Begin with `1-write-purpose.md`
- **Docs out of date?** Run `align-specs-to-code.md`
- **Just made changes?** Use `update-specs-with-code.md`

### Remember

The goal is living documentation that helps you understand and maintain your systems. Start small, be consistent, and let the automation help you maintain quality documentation that actually reflects reality.

Happy documenting! 🚀