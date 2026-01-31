---
name: init
description: Initialize LiveSpec in current project. Creates workspace specs and generates AGENTS.md context.
argument-hint: [--full]
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
---

# LiveSpec Initialization

Initialize LiveSpec methodology in the current project.

## Usage

- `/livespec:init` - Quick start with defaults (5 min)
- `/livespec:init --full` - Full customization (20-30 min)

## Quick Start (Default)

When invoked without arguments, perform zero-question setup with sensible defaults.

### Step 1: Verify Project State

```bash
# Check for existing LiveSpec
test -d specs/workspace && echo "existing" || echo "new"
```

If "existing": Ask user if they want to reinitialize (this will regenerate workspace specs).

### Step 2: Create Directory Structure

```bash
mkdir -p specs/{workspace,foundation/{strategic,functional},strategy,features,interfaces}
```

### Step 3: Create Workspace Specs

Create these files in `specs/workspace/`:

**taxonomy.spec.md**:
```markdown
---
applies_to: all_projects
criticality: IMPORTANT
failure_mode: Without taxonomy, agents make incorrect file placement decisions
---

# Project Taxonomy

## Project Domain

**Domain**: Software

This project produces executable code, libraries, or applications.

## Workspace Scope

**Operating Context** (workspace/):
- workspace/constitution.spec.md - Development principles
- workspace/patterns.spec.md - Conventions (naming, format, structure)
- workspace/workflows.spec.md - Development processes
- workspace/taxonomy.spec.md - This classification (check FIRST)

**Test**: "Is this ABOUT the workspace or IN the workspace?"
- ABOUT (operating context) -> workspace/
- IN (deliverable) -> numbered specs

## Specs Boundary

**specs/ contains ONLY .spec.md files**

- No source data (use data/ if needed)
- No research artifacts (use research/ if needed)
- Only MSL specifications

## Validation
- Taxonomy declares Software domain clearly
- Workspace scope lists operating context explicitly
- AI agents check this file FIRST before creating files
```

**constitution.spec.md**:
```markdown
---
applies_to: all_projects
criticality: CRITICAL
failure_mode: Without constitution, development becomes inconsistent
context_compression: moderate
---

# Development Constitution

## Requirements
- [!] Project follows specification-driven development with progressive disposability.
  - Upper layers are durable (PURPOSE -> REQUIREMENTS -> STRATEGY -> BEHAVIORS)
  - Code is always disposable and regenerable from specs
  - Specifications use MSL format (minimal, testable, justifiable)
  - Human owns intention; AI manages specs, code, and alignment

## Validation
- Specs created before implementations
- All specs follow MSL format
- Specs contain WHAT/WHY only, never implementation HOW
```

**patterns.spec.md**:
```markdown
---
applies_to: all_projects
criticality: IMPORTANT
failure_mode: Without patterns, specifications become inconsistent
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
```

**workflows.spec.md**:
```markdown
---
applies_to: all_projects
criticality: IMPORTANT
failure_mode: Without workflows, modes unclear and development unstructured
---

# Development Workflows

## Requirements
- [!] Project follows three-mode workflow.
  - Mode 0 (DEFINE): Problem, constraints, workspace setup
  - Mode 1 (DESIGN): Architecture, behaviors, contracts
  - Mode 2 (EVOLVE): Spec health, learning capture, continuous evolution

## Validation
- Modes followed in natural order
- Cycling back when discovering fundamental issues
```

### Step 4: Create PURPOSE.md (if missing)

If PURPOSE.md doesn't exist, create template:

```markdown
# Project Purpose

## Why This Exists

[Describe the problem this project solves]

## What Success Looks Like

- [Success criterion 1]
- [Success criterion 2]
- [Success criterion 3]
```

Ask user to fill in the placeholders.

### Step 5: Generate AGENTS.md

Read the workspace specs and PURPOSE.md, then generate AGENTS.md following the structure in `${CLAUDE_PLUGIN_ROOT}/references/standards/conventions/context-tree.spec.md`.

The generated AGENTS.md should:
- Be under 40KB (target 30KB)
- Include project summary from PURPOSE.md
- Include spec-first enforcement rules
- Include MSL format reference
- Include folder organization decision tests
- Reference plugin commands for utilities

Add frontmatter:
```yaml
---
generated: [ISO timestamp]
generator: livespec/init
version: 4.0.0
note: Generated from PURPOSE.md and specs/workspace/ - to update, use /livespec:rebuild-context
---
```

### Step 6: Confirm Setup

Report to user:

```
LiveSpec initialized!

Created:
- specs/workspace/taxonomy.spec.md - Project classification
- specs/workspace/constitution.spec.md - Development principles
- specs/workspace/patterns.spec.md - Naming conventions
- specs/workspace/workflows.spec.md - Three-mode workflow
- AGENTS.md - Agent context (regenerate with /livespec:rebuild-context)

Next steps:
- Fill in PURPOSE.md with your project vision
- Use /livespec:validate to check project health
- Start DESIGN mode with /livespec:design
```

## Full Customization (--full)

When `--full` argument provided, ask these questions before creating specs:

1. **Domain**: Software / Governance / Hybrid / Other?
2. **Compression**: Light (verbose) / Moderate (balanced) / Aggressive (focused)?
3. **Specs Boundary**: Specifications only / Include data / Include research?

Then create workspace specs with the specified options rather than defaults.

## Existing Project Migration

If the project has existing code but no specs:

1. Create workspace specs as above
2. Suggest running `/livespec:evolve` to extract specs from existing code
3. Point to EVOLVE mode workflow for spec extraction

## References

For detailed guidance on each topic:
- MSL Format: `${CLAUDE_PLUGIN_ROOT}/references/guides/msl-minimalism.md`
- Folder Structure: `${CLAUDE_PLUGIN_ROOT}/references/standards/conventions/folder-structure.spec.md`
- Context Generation: `${CLAUDE_PLUGIN_ROOT}/references/guides/context-positioning.md`

## Validation

After initialization, the project should:
- Have specs/workspace/ with 4 spec files
- Have AGENTS.md under 40KB
- Have PURPOSE.md (even if template)
- Pass `/livespec:validate` without errors
