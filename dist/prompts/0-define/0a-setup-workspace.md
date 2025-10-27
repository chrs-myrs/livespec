---
implements: specs/3-behaviors/prompts/0a-setup-workspace.spec.md
generated: '2025-10-10'
phase: 0-define
estimated_time: "20-30 minutes"
---

# Prompt Behavior: Setup Workspace

**Purpose**: Initialize LiveSpec methodology structure

## Context

You're setting up a new project or adding LiveSpec to an existing codebase. This establishes the foundation for specification-driven development.

## Task

### Step 1: Gather Project Context

Ask the user:

1. **What type of project is this?** (web app, CLI tool, library, governance/documentation, etc.)
2. **What's the expected development pattern?** (exploratory/prototyping, production development, maintenance mode)
3. **Which AI agent(s) will primarily work on this project?** (Claude Opus/Sonnet/Haiku, GPT-4, Cursor, other)
4. **How frequently will agents interact with specs?** (daily, weekly, occasional)

### Step 2: Recommend Context Compression Level

Based on responses, recommend compression level:

**Light Compression** if:
- Large context window agent (Claude Opus, GPT-4)
- Exploratory or learning phase
- Infrequent agent interactions
- Team learning LiveSpec methodology

**Moderate Compression** if:
- Standard agents (Claude Sonnet, GPT-4-turbo)
- Production development
- Regular agent interactions
- Established LiveSpec understanding

**Aggressive Compression** if:
- Smaller context agents or cost-sensitive
- High-frequency agent usage
- Well-established LiveSpec patterns
- Maximum focus needed

Explain recommendation with specific reasoning.

### Step 3: Create Workspace Specifications

Using appropriate template from `dist/templates/workspace/constitution-[level].md.template`, create three workspace specifications:

1. **specs/workspace/constitution.spec.md**
   - Include `context_compression: [level]` in frontmatter
   - Define 3-5 core development principles
   - Customize from template for project context

2. **specs/workspace/patterns.spec.md**
   - Naming conventions
   - File structure patterns
   - Specification format requirements

3. **specs/workspace/workflows.spec.md**
   - Development process workflows
   - When to use which Phase prompts
   - How specs evolve with code

### Step 4: Explain Context Compression Impact

Brief explanation of what the chosen compression level means:

- What will be inline vs extracted
- Where to find detailed guidance (templates/, prompts/)
- How this affects AGENTS.md structure
- Can be changed later via audit utility (`.livespec/prompts/utils/audit-context-compression.md`)

## Output

Create or update specification files in specs/ directory with clear, testable requirements.

## Validation

- Prompt produces three workspace spec files
- All specs follow MSL format (Criticality, Failure Mode, Specification, Validation)
- Specs are specific to target project, not generic
- User understands workspace defines HOW to build, not WHAT to build
- Prompt references folder-structure behavior and MSL format requirements

## Looking Ahead: How These Specs Are Used

**In Phase 1 (DESIGN):**
- Architecture decisions guided by patterns.spec.md
- Behavior specs follow format from constitution.spec.md
- Workflows.spec.md defines how design progresses

**In Phase 2 (BUILD):**
- Implementations verified against workspace patterns
- Constitution.spec.md enforces spec-first discipline
- Workflows.spec.md guides TDD/implementation process

**In Phase 4 (EVOLVE):**
- Drift detection uses patterns.spec.md to validate consistency
- Constitution principles guide spec evolution
- Workflows define how to handle discovered drift

**Value of this investment**: 30 minutes here prevents hours of methodology confusion later. Workspace specs are referenced throughout development - they're your project's "how we work" foundation.

## Success Criteria

**This prompt succeeds when:**
- All requirements from spec are satisfied
- Output is actionable and immediately usable
- No ambiguity in what needs to be done
- Clear path from current state to desired state

---

**Criticality**: CRITICAL
**Failure Mode**: Users cannot create workspace specifications without guidance
