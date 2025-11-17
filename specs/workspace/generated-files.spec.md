---
applies_to:
  - all_projects
criticality: IMPORTANT
failure_mode: Without generation markers, users and AI agents directly edit generated files causing source-of-truth drift
governed-by:
  - .livespec/standard/metaspecs/workspace.spec.md
derives-from:
  - specs/workspace/patterns.spec.md
---

# Generated File Patterns

## Requirements
- [!] LiveSpec generated files include standard markers identifying sources, regeneration instructions, and generation metadata to prevent direct edits and enforce source-of-truth discipline.
  - All generated files include clear markers (HTML comment, YAML frontmatter, or blockquote)
  - Markers identify source files for traceability
  - Markers provide regeneration instructions (prompt path)
  - Markers include generation timestamp (ISO-8601)
  - Markers identify generator (prompt or script path)
  - Markers include LiveSpec version used
  - Partial generation supported with section markers
  - Validation detects direct edits to generated content

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
- Generation timestamp (ISO-8601 format)
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
  - specs/1-requirements/strategic/outcomes.spec.md
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
- Doc references spec: `spec: specs/2-strategy/pathways/partnership/clt-formation.spec.md`

**Validation:**
- Spec → Doc (ERROR if doc doesn't exist)
- Doc → Spec (WARNING if backlink missing)
- See `specs/3-behaviors/validation/cross-reference-validation.spec.md`

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
spec: specs/3-behaviors/getting-started.spec.md
---
```

**Benefits:**
- Traceability (navigate between spec and doc)
- Validation catches broken relationships
- AI agents understand spec/doc connection

## Generated File Lifecycle

**Creation:**
1. Define behavior in `specs/3-behaviors/[feature].spec.md`
2. Create generation prompt in `prompts/utils/generate-[feature].md`
3. Run generation prompt to create output file
4. Output includes standard generation markers
5. Commit generated file (if project-specific) or gitignore (if reproducible)

**Regeneration:**
1. Update source specifications
2. Run generation prompt again
3. Validate immediately (Use `prompts/utils/validate-project.md`)
4. Commit updated generated file with sources

**Validation:**
1. Check generation timestamp vs file modification time
2. Check source file timestamps vs generation timestamp
3. Report direct edits (ERROR) or stale generation (WARNING)

**Common generated files:**
- `AGENTS.md` - Agent configuration (from `specs/workspace/*.spec.md` + `PURPOSE.md`)
- `CLAUDE.md` - Project instructions (from workspace specs)
- `prompts/generated/*.md` - Project-specific prompts (from PURPOSE + specs)
- Documentation (from specs via generation prompts)

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
- Generation metadata complete (timestamp, generator, version)
- Partial generation uses section markers correctly
- Generated sections not directly edited
- Manual sections editable in partially generated files
- Spec/doc bidirectional links maintained
- Validation catches direct edits to generated content
