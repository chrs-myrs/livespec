---
implements: specs/3-artifacts/prompts/0b-customize-workspace.spec.md
generated: '2025-10-10'
phase: 0-define
estimated_time: "20-30 minutes"
---

# Prompt Behavior: Customize Workspace

**Purpose**: Initialize LiveSpec methodology structure with full customization

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

### Step 3: Create Project Taxonomy

**CRITICAL**: Establish project classification to guide all subsequent file placement decisions.

Ask the user:

1. **"What domain best describes this project?"**
   - **Software** - Produces executable code, libraries, or applications (src/ → dist/)
   - **Documentation** - Produces published documentation (docs/ → public/)
   - **Planning** - Supports decision-making through analysis (research/ → analysis outputs)
   - **Generation** - Transforms data into tailored deliverables (data/ → generated outputs)
   - **Governance** - Produces methodology or frameworks (specs/ → dist/)
   - **Hybrid** - Combination (explain which domains)

2. **"Does this project process user-provided data or research materials?"**
   - If YES: "You'll need data/ or research/ folders. These stay OUT of specs/"
   - If NO: "specs/ will contain behavior specifications only"

3. **"Will this project have domain-specific processes or workflows?"**
   - Examples: job application workflows, deployment procedures, analysis methodologies
   - If YES: "These go in specs/3-behaviors/processes/ or specs/2-strategy/, NOT specs/workspace/"
   - If NO: "workspace/ will contain only portable methodology (constitution, patterns, workflows, taxonomy)"

4. **Select appropriate taxonomy template** from `.livespec/templates/workspace/taxonomy-[domain].spec.md.template`

5. **Create specs/workspace/taxonomy.spec.md**
   - Use selected domain template
   - Customize based on user responses
   - Explicitly list what's in workspace/ (typically: constitution, patterns, workflows, taxonomy)
   - Explicitly state product-specific content locations with examples
   - Confirm "specs/ = specifications only, no data/research/artifacts"

6. **Show user the taxonomy** and explain:
   - "This taxonomy defines your project's classification"
   - "AI agents will check taxonomy.spec.md FIRST before creating files"
   - "It prevents common mistakes like putting product features in workspace/ or data in specs/"
   - "Does this classification make sense for your project?" (allow user to refine)

7. **Validate taxonomy structure:**
   - Run: `bash scripts/validate-taxonomy-structure.sh`
   - Verify all four required sections present:
     - Project Domain
     - Workspace Scope
     - Specs Boundary
     - AI agents must
   - If validation fails, add missing sections using metaspec guidance
   - Validation ensures taxonomy provides complete agent guidance

### Step 4: Create Workspace Specifications

Using appropriate template from `dist/templates/workspace/constitution-[level].md.template` and referencing taxonomy, create three workspace specifications:

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

Note: taxonomy.spec.md created in Step 3 is also part of workspace/ (portable methodology).

### Step 5: Explain Context Compression Impact

Brief explanation of what the chosen compression level means:

- What will be inline vs extracted
- Where to find detailed guidance (templates/, prompts/)
- How this affects AGENTS.md structure
- Can be changed later via audit utility (`.livespec/prompts/utils/audit-context-compression.md`)

### Step 6: Regenerate AGENTS.md

**CRITICAL**: Now that workspace specs exist, regenerate AGENTS.md with project context.

Tell user:

"Workspace specs created! Now regenerating AGENTS.md with your project-specific context..."

**Use prompt 4d to regenerate**:
```
"Use .livespec/4-evolve/4d-regenerate-context.md to update AGENTS.md"
```

**What this does**:
- Incorporates YOUR workspace specs into AGENTS.md
- Applies chosen context compression level
- Preserves generic LiveSpec methodology
- Gives AI agents your project's specific context
- Critical for agent effectiveness going forward

**Wait for 4d completion** before proceeding to slash command generation.

### Step 6.5: Generate Slash Commands

**Make LiveSpec utilities discoverable** via Claude Code slash commands.

Tell user:

"Generating slash commands for LiveSpec utilities..."

**Use generation prompt**:
```
"Use dist/prompts/utils/generate-slash-commands.md to create discoverable commands"
```

**What this does**:
- Creates 11 slash commands in `.claude/commands/livespec/` namespace
- Makes utilities discoverable via `/` autocomplete in Claude Code
- Enables parameterized commands (`/livespec/audit minimalism`)
- Avoids polluting project root command namespace

**Wait for generation completion** before confirming setup.

Tell user after generation:

**✅ Workspace customization complete!**

Created:
- `specs/workspace/taxonomy.spec.md` - Your project domain
- `specs/workspace/constitution.spec.md` - Your development principles
- `specs/workspace/patterns.spec.md` - Your conventions
- `specs/workspace/workflows.spec.md` - Your processes
- `AGENTS.md` - **Regenerated** with your project context
- `.claude/commands/livespec/*.md` - 11 discoverable slash commands

## Output

Create or update specification files in specs/ directory with clear, testable requirements.

## Validation

- Prompt produces four workspace spec files (constitution, patterns, workflows, taxonomy)
- All specs follow MSL format (Criticality, Failure Mode, Requirements, Validation)
- taxonomy.spec.md declares project domain, workspace scope, and specs boundary
- Specs are specific to target project, not generic
- User understands workspace defines HOW to build, not WHAT to build
- User understands taxonomy.spec.md is checked FIRST before file creation
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
