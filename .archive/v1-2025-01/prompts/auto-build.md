# Auto-Build Command

This prompt automatically builds a complete system from whatever documentation exists, running the entire process unsupervised. **WARNING**: This mode makes assumptions and should only be used for prototypes, proof-of-concepts, or non-critical builds.

## Your Mindset for Auto-Build

Before you begin, understand that you are:
- **An automation orchestrator**, running multiple prompts in sequence
- **A detective**, finding the most mature starting point
- **An assumption maker**, filling gaps with reasonable defaults
- **A progress reporter**, keeping the user informed

## Execution Arguments

This prompt accepts arguments via $ARGUMENTS:
- **`dry-run`** - Show what would be done without executing
- **`from:<stage>`** - Force start from specific stage (purpose/strategy/design/components/implementation)
- **`verbose`** - Show detailed progress and decisions

Arguments provided: $ARGUMENTS

## Pre-Flight Checks

### Minimum Requirements
Before proceeding, verify at least ONE of these exists:
1. **System Purpose** document in `reqs/1-purpose/`
2. **High-level requirements** (any of):
   - Product brief
   - Business requirements document
   - User stories or feature list
   - Even a simple description of what to build
3. **Existing codebase** (for reverse engineering)

If NONE exist, STOP and request minimum input.

## Discovery Phase

### Step 1: Analyze Current State (5 minutes)

Check each documentation level to find the most mature starting point:

```
DISCOVERY_PROCESS:
1. Check reqs/1-purpose/
   - If system-purpose.md exists → Purpose is complete ✓
   - If empty → Need to start from Purpose ⚠️
   
2. Check reqs/2-strategy/
   - If any strategy docs exist → Strategy started ✓
   - If empty but purpose exists → Start from Strategy ⚠️
   
3. Check reqs/3-design/
   - If design docs exist → Design started ✓
   - If empty but strategy exists → Start from Design ⚠️
   
4. Check reqs/4-components/
   - If component specs exist → Components defined ✓
   - If empty but design exists → Start from Components ⚠️
   
5. Check reqs/5-implementation/
   - If implementation specs exist → Ready to implement ✓
   - If empty but components exist → Start from Implementation ⚠️
   
6. Check for actual code
   - If code exists → System partially/fully implemented ✓
```

### Step 2: Determine Starting Point

Based on discovery, identify:
- **Most Mature Stage**: The last completed documentation level
- **Next Stage**: Where to begin the auto-build process
- **Missing Stages**: What needs to be generated
- **Existing Assets**: What can be leveraged

## Execution Pipeline

### Phase 1: Purpose Generation (if needed)

<IF_PURPOSE_MISSING>
If no purpose document exists:
1. Look for any requirements or descriptions
2. Use prompt: `1-write-purpose.md` with found requirements
3. Make reasonable assumptions about:
   - Business value (prototype/demo)
   - Success metrics (functional prototype)
   - Users (developers/demo audience)
   - Scope (MVP features only)
</IF_PURPOSE_MISSING>

### Phase 2: Strategy Documentation (if needed)

<IF_STRATEGY_MISSING>
If no strategy documents exist:
1. Use prompt: `2-write-strategy.md` in unsupervised mode
2. Make default choices:
   - Architecture: Start with monolith (simpler for prototypes)
   - Database: Use SQLite/PostgreSQL (depending on requirements)
   - API: REST (most common)
   - Deployment: Containers (standard)
   - Security: Basic JWT auth (if users mentioned)
</IF_STRATEGY_MISSING>

### Phase 3: System Design (if needed)

<IF_DESIGN_MISSING>
If no design documents exist:
1. Use prompt: `3-write-design.md` in unsupervised mode
2. Create simple, standard architecture:
   - API Gateway (if multiple services)
   - Core business logic service
   - Database
   - Basic frontend (if UI mentioned)
</IF_DESIGN_MISSING>

### Phase 4: Component Specifications (if needed)

<IF_COMPONENTS_MISSING>
If no component specs exist:
1. Use prompt: `4-write-components.md` in unsupervised mode
2. Define components based on design
3. Include basic test strategy for each
4. Keep components minimal for prototype
</IF_COMPONENTS_MISSING>

### Phase 5: Implementation Planning (if needed)

<IF_IMPLEMENTATION_MISSING>
If no implementation specs exist:
1. Use prompt: `5-write-implementation.md` in unsupervised mode
2. Create master plan with simplified phases:
   - Phase 1: Core infrastructure
   - Phase 2: Basic features
   - Phase 3: Integration
3. Focus on getting working prototype quickly
</IF_IMPLEMENTATION_MISSING>

### Phase 6: Validation Check

Run validation but in "advisory" mode:
1. Use prompt: `pre-implementation-validation.md`
2. Log any issues found
3. Continue even if not perfect (this is prototype mode)
4. Document assumptions made to work around issues

### Phase 7: Implementation

<IMPLEMENTATION_EXECUTION>
Execute implementation in unsupervised mode:
1. Use prompt: `implement-from-specs.md` with arguments "unsupervised"
2. Create all components in order
3. Use TDD where possible
4. Mock external dependencies
5. Focus on core functionality
</IMPLEMENTATION_EXECUTION>

## Progress Tracking

Throughout execution, maintain a progress report:

```markdown
# Auto-Build Progress Report

**Started**: <timestamp>
**Mode**: <dry-run|normal>
**Starting Point**: <discovered stage>

## Stages Completed
- [ ] Purpose Document
- [ ] Strategy Documents  
- [ ] Design Documents
- [ ] Component Specifications
- [ ] Implementation Plans
- [ ] Validation Check
- [ ] Code Implementation

## Assumptions Made
1. <assumption> - <reasoning>
2. <assumption> - <reasoning>

## Issues Encountered
1. <issue> - <resolution>

## Current Status
<what's happening now>
```

## Execution Flow Control

### Dry Run Mode
If `dry-run` argument provided:
1. Show what would be done at each stage
2. Display assumed defaults
3. Estimate time for full execution
4. Do not create any files

### Verbose Mode
If `verbose` argument provided:
1. Show detailed reasoning at each decision
2. Display all prompt executions
3. Log all assumptions explicitly
4. Show intermediate results

### Error Handling
For non-critical errors:
1. Log the error
2. Make reasonable assumption
3. Continue execution
4. Note in final report

For critical errors:
1. Stop execution
2. Report what was completed
3. Provide recovery instructions

## Final Output

Upon completion, provide:

```markdown
# Auto-Build Completion Report

**Total Time**: <duration>
**Result**: SUCCESS | PARTIAL | FAILED

## What Was Built
1. Documentation created:
   - <list of all documents>
2. Code implemented:
   - <list of components>

## Key Assumptions
<numbered list of important assumptions>

## Next Steps
1. Review generated documentation
2. Test the prototype
3. Refine based on actual requirements
4. Run validation for production readiness

## Warnings
- This is a PROTOTYPE build
- Assumptions were made for speed
- Not production-ready without review
- Security is basic/minimal
- Performance not optimized
```

## Usage Examples

### Basic Auto-Build
```bash
# Build from whatever exists
claude-code "Use prompts/auto-build.md"
```

### Dry Run First
```bash
# See what would be built
claude-code "Use prompts/auto-build.md" --arguments "dry-run"
```

### Force Starting Point
```bash
# Rebuild from design stage forward
claude-code "Use prompts/auto-build.md" --arguments "from:design"
```

### Verbose Execution
```bash
# See detailed progress
claude-code "Use prompts/auto-build.md" --arguments "verbose"
```

## Important Warnings

### ⚠️ PROTOTYPE MODE ONLY
This command is designed for:
- Rapid prototyping
- Proof of concepts  
- Learning/experimentation
- Non-critical demos

### ❌ NOT FOR PRODUCTION
Do not use for:
- Production systems
- Systems handling real data
- Security-critical applications
- Performance-critical systems

### 📋 ALWAYS REVIEW
After auto-build:
1. Review all generated documentation
2. Validate assumptions made
3. Run proper validation
4. Refine for actual requirements
5. Implement proper security
6. Add comprehensive tests

Remember: Auto-build trades accuracy for speed. It's a starting point, not a finished product!