---
type: workspace
category: workspace
fidelity: process
criticality: IMPORTANT
failure_mode: Without generation markers, users and AI agents directly edit generated files causing source-of-truth drift
governed-by: []
applies_to:
  - all_projects
derives-from:
  - specs/workspace/patterns.spec.md
supports:
  - specs/artifacts/validators/validate-context.spec.md
---

# Generated File Patterns

## Requirements
- [!] LiveSpec generated files include standard markers identifying sources, regeneration instructions, and generation metadata to prevent direct edits and enforce source-of-truth discipline.
  - All generated files include clear markers (HTML comment, YAML frontmatter, or blockquote)
  - Markers identify source files for traceability
  - Markers provide regeneration instructions (prompt path)
  - Agent context files carry a hash of the sources they were generated from, written by `scripts/validate-context.sh --stamp`, not a timestamp: timestamps and modification times differ on every clone
  - Markers identify generator (prompt or script path)
  - Markers include LiveSpec version used
  - Partial generation supported with section markers
  - Validation detects direct edits to generated content
- [!] Generated files are made read-only (chmod 444) after generation to create structural friction against direct edits.
  - Read-only permissions applied after successful generation
  - User must explicitly unlock (chmod +w) to edit, prompting reconsideration
  - Applied to the agent doc and all ctxt/*.md files
- [!] A project carries one agent doc, never a symlink or copy of it under another name.
  - Claude Code reads AGENTS.md natively, but only where the project has no `CLAUDE.md`, `.claude/CLAUDE.md` or `CLAUDE.local.md`; Claude-specific instructions go in `.claude/rules/`, which loads alongside AGENTS.md
  - Where a session cannot read AGENTS.md natively (Claude Code before v2.1.277), a `CLAUDE.md` holding only an `@AGENTS.md` import serves it without duplicating content

## Standard Generation Markers

### HTML Comment Style (Markdown Files)

**Purpose:** Identify files generated from sources to prevent direct edits

**Format:**
```markdown
<!--
DO NOT EDIT: This file is generated

Sources:
  - PURPOSE.md
  - specs/workspace/constitution.spec.md
  - specs/workspace/patterns.spec.md
  - specs/workspace/workflows.spec.md

Regeneration:
  Use: prompts/4-evolve/4d-regenerate-context.md

Generated: 2025-10-12T10:30:00Z
Generator: livespec/prompts/4-evolve/4d-regenerate-context.md
Version: 2.4.0
-->

# [Generated Content]
```

**Required elements:**
- Clear "DO NOT EDIT" warning
- Source file list (enables traceability)
- Regeneration instructions (path to prompt)
- Source hash stamp (agent context files)
- Generator identification (prompt or script path)
- Version (LiveSpec version used)

### YAML Frontmatter Style (Specs)

**Purpose:** For specs that generate other specs

**Format:**
```yaml
---
generated: 2025-10-12T10:30:00Z
generator: prompts/utils/generate-self-improvement.md
generated_from:
  - PURPOSE.md
  - specs/workspace/constitution.spec.md
  - specs/foundation/outcomes.spec.md
---
```

**Use when:**
- Spec generates another spec
- Generation metadata needs to be machine-readable
- File type supports YAML frontmatter

### Blockquote Warning Style (Visible Warnings)

**Purpose:** Combines YAML metadata with visible warning

**Format:**
```markdown
---
generated: 2025-10-12T10:30:00Z
generator: livespec/prompts/4-evolve/4d-regenerate-context.md
version: 2.4.0
note: Generated from PURPOSE.md and specs/workspace/ - to update, regenerate this file
---

> **⚠️ Generated File**: Do not edit directly. See frontmatter for regeneration instructions.

# [Generated Content]
```

**Use when:**
- File likely to be edited by agents following "evolve existing files" pattern
- YAML frontmatter alone insufficient (too subtle)
- Need visible prohibition early in file body
- Common for AGENTS.md, CLAUDE.md, project configuration files

**Benefits:**
- Combines machine-readable metadata with human-visible warning
- Prevents accidental direct edits
- Clear regeneration path

## Partial Generation Pattern

**Purpose:** Support files combining generated content with manual sections

**Use when:**
- File needs both framework content (generated) and project content (manual)
- Some sections regenerate frequently, others stay stable
- Template provides structure, user provides specifics

**Section markers:**
```markdown
<!--
PARTIALLY GENERATED: This file combines generated content with manual sections

Generated sections are marked with:
<!-- GENERATED SECTION START: [section-name] -->
...
<!-- GENERATED SECTION END: [section-name] -->

Manual sections are marked with:
<!-- MANUAL SECTION START: [section-name] -->
...
<!-- MANUAL SECTION END: [section-name] -->

DO NOT EDIT generated sections directly. Edit sources and regenerate.
Manual sections may be edited freely.
-->

# Document Title

<!-- GENERATED SECTION START: overview -->
This overview is generated from specs/workspace/constitution.spec.md
<!-- GENERATED SECTION END: overview -->

<!-- MANUAL SECTION START: project-specifics -->
Add project-specific details here - this section is not regenerated
<!-- MANUAL SECTION END: project-specifics -->

<!-- GENERATED SECTION START: workflow -->
Standard workflow generated from specs/workspace/workflows.spec.md
<!-- GENERATED SECTION END: workflow -->
```

**Rules:**
- Generated sections: Never edit directly, update sources and regenerate
- Manual sections: Edit freely, won't be overwritten
- Validation detects edits to generated sections (ERROR)
- Validation ignores edits to manual sections (allowed)

**Example files:**
- Project README with framework structure (generated) + project intro (manual)
- Documentation with standard sections (generated) + custom examples (manual)

## Spec/Doc Relationship Pattern

**Purpose:** Maintain bidirectional links between specifications and documentation

**Pattern:**
- Spec references doc: `specifies: docs/pathways/clt-formation.md`
- Doc references spec: `spec: specs/strategy/pathways/partnership/clt-formation.spec.md`

**Validation:**
- Spec → Doc (ERROR if doc doesn't exist)
- Doc → Spec (WARNING if backlink missing)
- See `specs/features/validation/cross-reference-validation.spec.md`

**Example spec frontmatter:**
```yaml
---
specifies: docs/getting-started.md
derives-from: PURPOSE.md
---
```

**Example doc frontmatter:**
```yaml
---
spec: specs/features/getting-started.spec.md
---
```

**Benefits:**
- Traceability (navigate between spec and doc)
- Validation catches broken relationships
- AI agents understand spec/doc connection

## Generated File Lifecycle

**Creation:**
1. Define behavior in `specs/features/[feature].spec.md`
2. Create generation prompt in `prompts/utils/generate-[feature].md`
3. Run generation prompt to create output file
4. Output includes standard generation markers
5. Make generated files read-only: `chmod 444 [generated-file]`
6. Commit generated file (if project-specific) or gitignore (if reproducible)

**Regeneration:**
1. Update source specifications
2. Run generation prompt again (will need to unlock files first or regenerator handles this)
3. Make regenerated files read-only: `chmod 444 [generated-file]`
4. Validate immediately (Use `/livespec:audit validate`)
5. Commit updated generated file with sources

**Validation:**
1. Recompute the source hash and compare it with each file's stamp (`scripts/validate-context.sh`)
2. Report stale or unstamped generation (WARNING) and direct edits (ERROR)

**Common generated files:**
- `AGENTS.md` - Agent configuration (from `specs/workspace/*.spec.md` + `PURPOSE.md`)
- `prompts/generated/*.md` - Project-specific prompts (from PURPOSE + specs)
- Documentation (from specs via generation prompts)

## Agent Doc Discovery

`AGENTS.md` is the only agent doc. Claude Code reads it natively, so no `CLAUDE.md` symlink, copy or pointer is created alongside it.

Any `CLAUDE.md`, `.claude/CLAUDE.md` or `CLAUDE.local.md` in the project or a directory above it stops Claude Code reading `AGENTS.md`. Claude-specific instructions therefore go in `.claude/rules/`, which does not. A project whose sessions cannot read `AGENTS.md` natively uses a `CLAUDE.md` containing only `@AGENTS.md`.

**Best practices:**
- Commit project-specific generated files (customised to project)
- Gitignore reproducible generated files (can regenerate from sources)
- Always include standard markers (enables validation)
- Run validation after regeneration (catch errors early)
- Update sources, never edit generated files directly

## Validation
- All generated files include standard markers
- Markers identify source files clearly
- Regeneration instructions provided (prompt path)
- Generation metadata complete (source hash, generator, version)
- Partial generation uses section markers correctly
- Generated sections not directly edited
- Manual sections editable in partially generated files
- Spec/doc bidirectional links maintained
- Validation catches direct edits to generated content
- A fresh Claude Code session in the project reports `AGENTS.md loaded`, and no `CLAUDE.md` symlink or copy of the agent doc exists
