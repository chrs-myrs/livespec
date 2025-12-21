---
implements: specs/3-artifacts/prompts/0a-quick-start.spec.md
phase: 0-define
estimated_time: "5 minutes"
---

# Prompt Behavior: Quick Start

**Purpose**: Initialize LiveSpec with sensible defaults (zero questions)

## Context

You're setting up a new project or adding LiveSpec to an existing codebase. This quick-start creates a standard workspace setup with defaults, getting you productive immediately.

**When to use this**: New projects or when you want to start fast and customize later.

**When to customize instead**: Use `0b-customize-workspace.md` if you need specific compression levels, domain classification, or have special requirements.

## Task

### Step 0: Verify LiveSpec Installation

**Before creating workspace specs**, ensure LiveSpec framework is installed.

**Check for installation:**
```bash
test -f .livespec/VERSION && echo "✓ Installed ($(cat .livespec/VERSION))" || echo "✗ Not installed"
```

**If "✗ Not installed"** appears:

Tell user:
"LiveSpec framework not detected. Installing now using the recommended method..."

**Install using helper script:**
```bash
# From LiveSpec source directory
bash /path/to/livespec/scripts/install-livespec.sh

# OR from URL (if accessible)
bash <(curl -fsSL https://raw.githubusercontent.com/chrs-myrs/livespec/master/scripts/install-livespec.sh)

# OR manual sparse submodule (see .livespec/README.md for instructions)
```

**After installation**, verify:
```bash
ls .livespec/VERSION .livespec/prompts/ .livespec/scripts/ .livespec/templates/
```

**If verification fails**:
"Installation incomplete. See `.livespec/README.md` for alternative installation methods."

**STOP** if installation cannot be completed.

**If "✓ Installed"** appears: Continue to Step 0.5.

### Step 0.5: Validate Project Domain (Quick Check)

**Before applying defaults**, verify project fits Software domain:

Ask user one quick question:
"**Is this project producing code/executables/libraries?** (Software domain)
- YES → Continue with defaults
- NO → Redirect to `.livespec/0-define/0b-customize-workspace.md` (handles Hybrid/Governance/Generation/Planning domains)"

If user says NO or uncertain:
"This quick-start assumes Software domain. For operational workspaces, hybrid projects, or governance frameworks, use `.livespec/0-define/0b-customize-workspace.md` instead."

**STOP and redirect.** Don't continue with Software defaults if domain doesn't match.

If YES (Software domain): Continue to Step 1.

### Step 1: Apply Sensible Defaults

Use these defaults (already confirmed Software domain):

**Context Compression**: Moderate (balanced inline/reference, suitable for most agents)

**Project Domain**: Software (produces code/executables/libraries)

**Workspace Scope**: Standard operating context (constitution, patterns, workflows, taxonomy)

**Specs Boundary**: specifications only (no data/research in specs/)

### Step 2: Create Standard Taxonomy

Create `specs/workspace/taxonomy.spec.md` with Software domain defaults:

```markdown
---
applies_to: all_projects
criticality: IMPORTANT
failure_mode: Without taxonomy, agents make incorrect file placement decisions
governed-by:
  - .livespec/standard/metaspecs/taxonomy.spec.md
---

# Project Taxonomy

## Project Domain

**Domain**: Software

This project produces executable code, libraries, or applications.

## Workspace Scope

**Operating Context** (workspace/):
- ✅ workspace/constitution.spec.md - Development principles
- ✅ workspace/patterns.spec.md - Conventions (naming, format, structure)
- ✅ workspace/workflows.spec.md - Development processes
- ✅ workspace/taxonomy.spec.md - This classification (check FIRST)

**Test**: "Is this ABOUT the workspace or IN the workspace?"
- ABOUT (operating context) → workspace/
- IN (deliverable) → numbered specs

**Deliverables** (NOT workspace/):
- ❌ Product architecture → specs/2-strategy/architecture.spec.md
- ❌ Feature behaviors → specs/3-behaviors/[feature].spec.md
- ❌ API contracts → specs/3-contracts/api/[endpoint].spec.md

## Specs Boundary

**specs/ contains ONLY .spec.md files**

- ❌ No source data (use data/ if needed)
- ❌ No research artifacts (use research/ if needed)
- ❌ No generated outputs (siblings of generating script)
- ✅ Only MSL specifications

## Validation
- Taxonomy declares Software domain clearly
- Workspace scope lists operating context explicitly
- Specs boundary prevents data/research/artifacts in specs/
- AI agents check this file FIRST before creating files
```

### Step 3: Create Standard Workspace Specs

Create remaining workspace specifications (taxonomy already created in Step 2):

**1. specs/workspace/constitution.spec.md**

```markdown
---
applies_to: all_projects
criticality: CRITICAL
failure_mode: Without constitution, development becomes inconsistent and methodology unclear
context_compression: moderate
governed-by:
  - .livespec/standard/metaspecs/workspace.spec.md
---

# Development Constitution

## Requirements
- [!] Project follows specification-driven development with progressive disposability.
  - Upper layers are durable (PURPOSE → REQUIREMENTS → STRATEGY → BEHAVIORS)
  - Code is always disposable and regenerable from specs
  - Specifications use MSL format (minimal, testable, justifiable)
  - Workspace specs generate AI context (AGENTS.md, context tree)
  - Human owns intention; AI manages specs, code, and alignment
  - Phase 4 (EVOLVE) triggers regeneration when specs change

## Validation
- Specs created before implementations
- All specs follow MSL format
- Specs contain WHAT/WHY only, never implementation HOW
- Code regenerable from specs at any time
```

**2. specs/workspace/patterns.spec.md**

```markdown
---
applies_to: all_projects
criticality: IMPORTANT
failure_mode: Without patterns, specifications become inconsistent
governed-by:
  - .livespec/standard/metaspecs/workspace.spec.md
---

# Development Patterns

## Requirements
- [!] Project follows LiveSpec naming and structure patterns.
  - Specs use .spec.md extension
  - Frontmatter declares criticality and failure_mode
  - Requirements section with [!] items
  - Validation section with observable criteria
  - Check taxonomy.spec.md FIRST before creating files

## Validation
- All specifications follow MSL format
- File naming conventions consistent
- Taxonomy checked before file creation
```

**3. specs/workspace/workflows.spec.md**

```markdown
---
applies_to: all_projects
criticality: IMPORTANT
failure_mode: Without workflows, phases unclear and development unstructured
governed-by:
  - .livespec/standard/metaspecs/workspace.spec.md
---

# Development Workflows

## Requirements
- [!] Project follows five-phase workflow (DEFINE → DESIGN → BUILD → VERIFY → EVOLVE).
  - Phase 0 (DEFINE): Problem, constraints, workspace setup (PURPOSE is most durable)
  - Phase 1 (DESIGN): Architecture, behaviors, contracts (specs before code)
  - Phase 2 (BUILD): Implementation, tests (TDD - acceptance tests semi-durable, unit tests disposable)
  - Phase 3 (VERIFY): Validation, acceptance
  - Phase 4 (EVOLVE): Regeneration workflow - code is disposable, regenerate from specs
  - Discoveries level up to appropriate spec layer or stay disposable

## Validation
- Phases followed in natural order for first pass
- Cycling back when discovering fundamental issues
- Phase 4 regenerates code from specs when needed
```

**4. specs/workspace/context-architecture.spec.md**

```markdown
---
criticality: IMPORTANT
failure_mode: Without context architecture, agents receive inappropriate or bloated context leading to focus inefficiency
applies_to: this_project
governed-by:
  - .livespec/standard/conventions/context-tree.spec.md
derives-from:
  - specs/workspace/constitution.spec.md
  - specs/workspace/taxonomy.spec.md
---

# Context Architecture

## Requirements

- [!] This project uses hierarchical agent context tree following context-tree convention.
  - Root AGENTS.md: Compressed methodology (20-30KB) with routing to sub-agents
  - Phase specialists (ctxt/phases/): 0-define through 4-evolve
  - Domain specialists (ctxt/domains/): Based on taxonomy classification
  - Utility specialists (ctxt/utils/): session-completion, drift-detection, msl-audit
  - Proactive loading: Agent decides what context to load based on task

- [!] This project defines what content populates agent contexts.

  Always Include (root AGENTS.md):
  - specs/workspace/constitution.spec.md - Development principles
  - specs/workspace/patterns.spec.md - Naming conventions
  - Key behaviors from specs/3-behaviors/ relevant to daily work

  Include When Relevant (sub-agent contexts):
  - Phase-specific behaviors when agent determines phase work
  - Domain-specific patterns when taxonomy indicates
  - Utility workflows when completing sessions or detecting drift

  Content Focus (balanced mix):
  - Behaviors: 40% - Observable outcomes from specs/3-behaviors/
  - Constraints: 30% - Requirements from specs/1-requirements/
  - Patterns: 30% - Workspace methodology from specs/workspace/

  Compression Level: moderate

## Validation
- Root AGENTS.md follows convention size budgets (20-30KB)
- Context tree structure matches taxonomy domain
- Load triggers functional (agent matches query to sub-agent)
- Context generation reads this spec before building AGENTS.md
- Compression level matches constitution.spec.md declaration
```

### Step 4: Regenerate AGENTS.md

**CRITICAL**: Now that workspace specs exist, regenerate AGENTS.md with project context.

Tell user:

"Workspace specs created! Now regenerating AGENTS.md with your project-specific context..."

**Use prompt 4d to regenerate**:
```
"Use .livespec/4-evolve/4d-regenerate-context.md to update AGENTS.md"
```

**What this does**:
- Incorporates YOUR workspace specs into AGENTS.md
- Preserves generic LiveSpec methodology
- Gives AI agents your project's specific context
- Critical for agent effectiveness going forward

**Wait for 4d completion** before proceeding to Step 4.5.

### Step 4.5: Verify Slash Commands

**Check that LiveSpec utilities are discoverable** via Claude Code slash commands.

Tell user:

"Standard slash commands were installed automatically during setup. They're ready to use via `/livespec/` autocomplete."

**What was installed**:
- 11 slash commands in `.claude/commands/livespec/` namespace
- Commands copied from `dist/.claude/commands/livespec/`
- Utilities discoverable via `/` autocomplete in Claude Code
- Parameterized commands available (`/livespec/audit minimalism`)

**For customization** (optional):
```
"Use dist/prompts/utils/generate-custom-slash-commands.md to create custom command variations"
```

**Commands generated**:
- `/livespec/complete-session` - End session with analysis
- `/livespec/rebuild-context` - Regenerate from specs
- `/livespec/refine-workspace` - Optimize structure
- `/livespec/suggest-improvements` - Strategic recommendations
- `/livespec/health-report` - Project health check
- `/livespec/validate` - Run validation
- `/livespec/audit [type]` - Quality audits
- `/livespec/next-steps` - Navigate workflow
- Plus 3 optional: run-spike, analyze-failure, upgrade

**Wait for generation completion** before proceeding to Step 5.

### Step 5: Confirm Setup

Tell user:

**✅ Quick start complete!**

Created:
- `specs/workspace/taxonomy.spec.md` - Software domain (agents check FIRST)
- `specs/workspace/constitution.spec.md` - Spec-driven development
- `specs/workspace/patterns.spec.md` - MSL format, naming conventions
- `specs/workspace/workflows.spec.md` - Five-phase workflow
- `specs/workspace/context-architecture.spec.md` - Context generation control
- `AGENTS.md` - **Regenerated** with your project context
- `.claude/commands/livespec/*.md` - 11 discoverable slash commands

**Context compression**: Moderate (balanced)

**Next steps**:
- **Recommended**: Validate understanding: Use `.livespec/0-define/0x-validate-understanding.md` (5-10 min concept check)
- Define problem: Use `.livespec/0-define/0c-define-problem.md`
- Or customize workspace: Use `.livespec/0-define/0b-customize-workspace.md`

**Defaults chosen for you**:
- Domain: Software (change taxonomy.spec.md if different)
- Compression: Moderate (change constitution.spec.md frontmatter if needed)
- Scope: Standard workspace (operating context)

## Output

Create five specification files in specs/workspace/ with standard defaults.

## Validation

- Prompt validates Software domain fit before applying defaults (one quick question)
- Redirects non-Software projects to customize-workspace.md
- Creates five workspace specs (taxonomy, constitution, patterns, workflows, context-architecture)
- All specs follow MSL format
- Taxonomy declares Software domain with workspace scope
- User can customize later if needed
- Setup completes in ~5 minutes

## Success Criteria

- User has working LiveSpec workspace in under 5 minutes
- Can immediately proceed to Phase 0b (define problem) or Phase 1 (design)
- Defaults suitable for 80% of projects
- Clear path to customization if needed
