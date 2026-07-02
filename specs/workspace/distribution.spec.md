---
type: workspace
category: workspace
fidelity: process
criticality: IMPORTANT
failure_mode: Distribution pattern unclear causes duplication and drift between canonical and project copies
governed-by: []
applies_to:
  - livespec_projects
derives-from:
  - specs/workspace/patterns.spec.md
---

# Distribution Pattern

## Requirements

- [!] LiveSpec distributes as a Claude Code plugin — no file copying, symlinks, or submodules in target projects
  - `/plugin install livespec@livespec` makes `skills/`, `commands/`, and `agents/` available directly
  - Updates via `/plugin update livespec`
  - No canonical `dist/` copy step: the installed plugin *is* the canonical source
  - Project customization happens entirely in `specs/workspace/` (constitution, patterns, workflows, taxonomy) — the plugin content itself is never edited

- [!] Templates and reference material are read directly from the plugin, not copied per-project
  - `templates/` (root-level) provides bootstrap and enforcement content
  - `references/standards/`, `references/guides/` provide conventions and detailed guidance
  - `agents/context-builder.md` reads `templates/agents/spec-first-enforcement.md` directly when generating `AGENTS.md` — no distribution step required

## Template Architecture Pattern

**Purpose:** Reusable markdown content for consistent agent guidance

**When to Create Template:**
- Content reused across multiple generated files
- Key process/checklist needing consistent application
- Content requiring independent updates without touching skill/agent logic

**Template Structure:**
- **Location**: `templates/{domain}/` (e.g., `agents/`, `workspace/`, `governance/`)
- **Format**: Complete standalone markdown (not fragment)
- **Naming**: Descriptive (e.g., `spec-first-enforcement.md`, `constitution-moderate.md.template`)

**Template Flow:**
1. **Templates provide** reusable content (`templates/agents/*.md`)
2. **Specs reference** templates by their real root-level path (e.g. "Include `templates/agents/spec-first-enforcement.md`")
3. **`agents/context-builder.md` inserts** template content during `AGENTS.md` generation
4. **Generated files** are the product (e.g. `AGENTS.md` includes template content inline)

**Example:** Agent verification template
- `templates/agents/spec-first-enforcement.md` - Four-layer spec-first enforcement content
- Referenced by: `specs/workspace/workspace-agent.spec.md`
- Inserted by: `agents/context-builder.md` (triggered via `/livespec:audit context`)
- Result: `AGENTS.md` includes verification content in its spec-first protocol section

**Benefits:**
- Explicit and manageable (not embedded in skill logic)
- Independently updatable (change template, regenerate `AGENTS.md`)
- No distribution step — read directly from the installed plugin

## Reference Library Pattern

**Purpose**: Enable agents to navigate from AGENTS.md summary (80%) to deep detail (20%)

**Path convention**: Use the real plugin-relative path
- `references/standards/...` for conventions and metaspecs
- `references/guides/...` for applied guidance
- Consistent whether working in the LiveSpec repo itself or in a project with the plugin installed

**Structure**:
- **Categories**: Conventions (how to structure), Metaspecs (spec types), Guides (how to apply)
- **Entry format**:
  - **Fetch when**: Action-oriented trigger conditions
  - **Provides**: What detail this reference contains
  - **Cross-ref**: Where in AGENTS.md this topic is summarized

**Example**:
```markdown
**Context Compression** - `references/standards/conventions/context-compression.spec.md`
- **Fetch when**: Deciding inline vs extract, optimizing AGENTS.md size
- **Provides**: Full compression framework, decision criteria, extraction patterns
- **Cross-ref**: See "Context Compression" section for summary
```

**Location**: MIDDLE or END section of AGENTS.md (detailed navigation, not critical rules)

**Integration**: Cross-reference from AGENTS.md summary sections
```markdown
## Context Compression
[Brief summary]

**Framework reference**: See Reference Library: `context-compression.spec.md`
```

**Validation**:
- All reference paths use the real `references/` location, not `.livespec/` or `dist/`
- "Fetch when" conditions are action-oriented (not passive descriptions)
- Cross-references bidirectional (AGENTS.md ↔ Reference Library)
- Categories logical (Conventions, Metaspecs, Guides)

## Validation
- `/plugin install livespec@livespec` makes skills/commands/agents available with no file copying
- No spec or generated file references `dist/`, `.livespec/`, `.livespec-repo/`, or a submodule
- Templates read directly from `templates/` at the plugin root
- `agents/context-builder.md` generates `AGENTS.md`/`ctxt/` on request, reading templates and references directly from the plugin
- Project customization lives entirely in `specs/workspace/`, never in the plugin content itself
