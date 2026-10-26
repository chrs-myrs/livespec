---
type: workspace
category: workspace
fidelity: process
criticality: CRITICAL
failure_mode: Without context tree structure, agents suffer from context overload, lack specialized guidance, and cannot proactively load phase/domain/utility contexts, reducing focus efficiency and adoption
governed-by: []
extends:
  - references/standards/metaspecs/base.spec.md
applies_to:
  - AGENTS.md
  - ctxt/
  - workspace/context-architecture.spec.md
  - workspace/workspace-agent.spec.md
---

# Context Tree Structure

**Part of**: LiveSpec agent guidance system (optimizes how agents consume methodology)

## Requirements

### Hierarchical Context Architecture

- [!] Each project declares the shape of its context tree in its own `specs/workspace/context-architecture.spec.md`, and generation follows that declaration rather than a fixed shape
  - **Root ceiling**: the largest the root AGENTS.md may be
  - **ctxt/ files**: the specialist files the project wants, flat plus `ctxt/domains/`, 4-10KB each. The list may be empty: then there is no ctxt/ and no routing section
  - **Methodology sections**: which LiveSpec method sections the root carries, from the five phases, phases vs layers, multi-domain organisation and session completion. An undeclared section is left out
  - **Default** (the template): a root of 10KB or less, no ctxt/ files and no methodology sections, sized for a small project
  - **Total tree**: within `agent.context_budget` in `project.yaml` (100KB by default); typical loaded context is the root plus 1-2 sub-agents
  - Sizes are in bytes, 1KB being 1,024
  - **Generation**: Opt-in via `/livespec:audit context`, once PURPOSE.md and the context-architecture spec exist

### Proactive Loading Mechanism

- [!] Agents autonomously load specialized contexts based on task classification without user context management
  - **Load triggers**: Keyword patterns in root AGENTS.md matching natural user language
  - **Agent analyzes**: User query/task to determine needed context
  - **Agent loads**: Relevant ctxt/ sub-agent(s) proactively (1-2 typical, not 3+)
  - **Path of least resistance**: User doesn't explicitly manage contexts
  - **Conservative loading**: Most tasks use root AGENTS.md alone (80% coverage)

### Root AGENTS.md Structure

- [!] Root AGENTS.md provides compressed methodology with routing to specialized sub-agents
  - **NO frontmatter**: Clean context for agents (frontmatter wastes tokens)
  - **Inline edit warning**: At top (not in frontmatter), instructs regeneration
  - **Content inlined**: Essential methodology (NOT references to workspace specs)
  - **Project constraints near the top**: the project's own constraints come before any methodology content
  - **"When to Load Sub-Agents" section**: Decision tree with load triggers, present only when the project declares ctxt/ files
  - **Proactive loading guidance**: Agent decides what context to load based on task
  - **Reference Library**: Navigation to detailed specs (`references/` paths)
  - **Size budget**: within the project's declared root ceiling
  - **Compression applied**: Respects the level declared in `project.yaml`

### Sub-Agent Structure

- [!] Sub-agents, where declared, provide specialized methodology for phases, domains, and utilities
  - **NO frontmatter**: Clean context when loaded (frontmatter wastes tokens)
  - **Inline edit warning**: At top of file (not frontmatter)
  - **Specialized content**: Phase methodology, domain patterns, or utility workflows
  - **Load triggers**: Keywords matching natural user language (not technical jargon)
  - **References to `references/`**: Links to detailed specs for deep detail
  - **Parent reference**: Footer text mentioning "Parent: AGENTS.md" (not frontmatter)
  - **Size budgets**: 4-10KB per specialist file
  - **Compression applied**: Same level as root

### Generation Governance

- [!] Context tree is generated from workspace specifications and protected from manual edits
  - **Source of truth**: workspace/*.spec.md + PURPOSE.md
  - **Regeneration required**: When workspace specs change, PURPOSE.md updates, or version upgrades
  - **Edit protection**: Files marked with inline warnings (regenerate, don't edit)
  - **Generation tool**: `/livespec:audit context`
  - **Context builder agent**: `agents/context-builder.md` performs generation
  - **Isolated execution**: Generation runs as a dedicated sub-agent without polluting parent session

### Size Budget Rationale

- [!] Compact contexts optimize context window primacy and recency bias
  - **Research foundation**: Liu et al. "Lost in the Middle" (2023) - 22% retention boost from strategic positioning
  - **Primacy bias**: Beginning of context processed more thoroughly
  - **Recency bias**: End of context more accessible
  - **Smaller contexts**: Force essential-only content, improve processing speed
  - **Progressive disclosure**: Root provides 80%, sub-agents provide remaining 20% when needed
  - **Maximum loaded**: <65KB (root + multiple sub-agents in rare cases)

### Opt-In Generation

- [!] Context tree generation is opt-in, not a plugin-install prerequisite
  - Skills are self-contained and work correctly with no AGENTS.md/ctxt/ present
  - Full tree generated per-project from workspace specs, on request via `/livespec:audit context`
  - **Why not pre-generate ctxt/**: Content depends on the project's PURPOSE, domain, and principles — there is nothing generic to distribute
  - **Prerequisite**: PURPOSE.md and `specs/workspace/context-architecture.spec.md` must exist (both created by `/livespec:init`)

### Integration with Context Compression

- [!] Context tree applies the compression level declared in `project.yaml`
  - **Light**: More inline content in root and sub-agents
  - **Moderate**: Strategic extraction, balanced inline/reference (default)
  - **Aggressive**: Heavy extraction, minimal inline, maximum Reference Library
  - **Consistent application**: Same compression across all generated files
  - **Reference hierarchy**: Sub-agents reference `references/` specs based on compression level

## Validation

### Structure Validation
- Root AGENTS.md exists within the declared root ceiling, with no frontmatter and an inline edit warning
- Root carries the project's constraints before any methodology content
- Root carries exactly the methodology sections the project declares
- ctxt/ holds exactly the declared files (flat, plus ctxt/domains/), and does not exist when none are declared
- Root has a "When to Load Sub-Agents" section if and only if ctxt/ files are declared
- Total tree size within `agent.context_budget`

### Sub-Agent Validation
- All sub-agents have NO frontmatter (clean context)
- All sub-agents have inline edit warning at top
- All sub-agents within size budgets
- All sub-agents reference parent AGENTS.md in footer text
- All sub-agents link to `references/` detailed specs

### Functional Validation
- Load triggers are intuitive keywords (not technical jargon)
- Root routing matches sub-agent load triggers
- Agent can match typical queries to appropriate sub-agents
- Proactive loading works (agent loads without user managing contexts)
- Context builder runs in isolated context (no session pollution)

### Generation Validation
- Prerequisites exist (PURPOSE.md, context-architecture.spec.md)
- Compression level read from `project.yaml`
- Compression applied consistently across all files
- Edit warnings present in all generated files
- Regeneration workflow documented and functional

## Context Tree Topology

### Default Structure (small project)

```
project-root/
└── AGENTS.md (≤10KB, generated)
```

### Full Structure (declared by projects that need it)

```
project-root/
├── AGENTS.md (declared ceiling, e.g. 40KB, generated)
└── ctxt/
    ├── define.md (4-10KB)
    ├── design.md (4-10KB)
    ├── evolve.md (4-10KB)
    ├── session.md (4-10KB)
    ├── msl-audit.md (4-10KB)
    ├── audit.md (4-10KB)
    └── domains/
        ├── governance.md (4-10KB, if taxonomy: governance)
        ├── software.md (4-10KB, if taxonomy: software)
        └── hybrid.md (4-10KB, if taxonomy: hybrid)
```

A project lists whichever of these files it wants; the names above are the
conventional ones, not a required set.

### Load Trigger Examples

**Phase-specific work**:
- "new project", "setup", "define problem", "constraints" → ctxt/define.md
- "design", "architecture", "behaviors", "contracts", "UX flow" → ctxt/design.md
- "implement", "build", "tests", "TDD", "validate", "verify", "drift", "extract specs", "regenerate" → ctxt/evolve.md

**Domain patterns**:
- "methodology", "specs about specs", "dogfooding" → ctxt/domains/governance.md
- "API design", "user features", "system behavior" → ctxt/domains/software.md

**Utilities**:
- "complete session", "measure compliance" → ctxt/session.md
- "audit MSL", "check minimalism" → ctxt/msl-audit.md
- "health", "drift", "spec health", "validation", "audit" → ctxt/audit.md

## When NOT to Load Sub-Agents

**Root AGENTS.md is sufficient for**:
- Reading/understanding existing specs
- Making small edits to files
- Basic questions about project structure
- Running single validation scripts
- Creating simple specs following templates
- General development work

**Examples that DON'T need sub-agents**:
- "Fix this spec" → Use AGENTS.md guidance directly
- "What's in specs/features/?" → Read files, no sub-agent needed
- "Update this requirement" → Edit using MSL format from AGENTS.md
- "Run validation" → Script paths already in AGENTS.md

## Generation Workflow

### Prerequisites (established by Phase 0)

**Required files**:
- PURPOSE.md (project vision)
- specs/workspace/context-architecture.spec.md (the tree's shape and content sources)

**Read when present**: constitution, taxonomy, patterns and workflows workspace specs; a content section a missing spec would feed is left out

### Generation Process

1. **Validate prerequisites**: Check the required files exist
2. **Read sources**: Extract content from the specs and PURPOSE.md, and the shape from context-architecture.spec.md
3. **Apply compression**: Use the level declared in `project.yaml`
4. **Generate root**: Create AGENTS.md within the declared ceiling, constraints near the top, with only the declared methodology sections
5. **Generate sub-agents**: Create the declared ctxt/ files, if any
6. **Validate structure**: Check sizes against the declared ceiling and budgets, structure, clean context
7. **Report results**: Comprehensive report with file sizes and validation status

### Regeneration Triggers

**When to regenerate context tree**:
- After Phase 0 workspace setup (initial generation from bootstrap)
- Workspace specs modified (constitution, patterns, workflows, agent-contexts, workspace-agent)
- PURPOSE.md updated (project vision changed)
- New workspace spec added
- LiveSpec version upgrade (new methodology)
- Switching compression levels in `project.yaml` (light ↔ moderate ↔ aggressive)
- Context tree feels stale or misaligned with current specs

## Relationship to Other Patterns

**Context Compression** (orthogonal force):
- Context tree provides structure (root + sub-agents)
- Compression determines extraction within that structure
- Both apply to same files (AGENTS.md, ctxt/)
- Tree optimizes discovery, compression optimizes density

**Reference Library** (80/20 navigation):
- Root AGENTS.md provides 80% coverage
- Reference Library section points to remaining 20%
- Sub-agents extend reference to deep detail
- `references/` specs provide comprehensive documentation

**Taxonomy** (determines structure):
- Project domain classification in workspace/taxonomy.spec.md
- Determines which domain sub-agents exist
- Software → ctxt/domains/software.md
- Governance → ctxt/domains/governance.md
- Hybrid → Multiple domain sub-agents

**Active Agent Guidance** (structural enforcement):
- Sub-agents enable specialized structural guidance
- Load triggers make guidance proactive (not reactive)
- Context tree makes compliance path of least resistance
- Agents get focused guidance without user managing contexts

## Evolution from Monolithic Pattern

### Legacy Pattern (Pre-Context Tree)

**Monolithic AGENTS.md**:
- Single 50-60KB file with all methodology
- No specialized contexts for phases/domains
- Agent loads everything regardless of task
- High noise-to-signal ratio (20%)
- Context overload reduces focus efficiency

### Current Pattern (Context Tree)

**Project-sized AGENTS.md, plus ctxt/ where declared**:
- Root within the project's declared ceiling (routing + compressed methodology)
- Specialized sub-agents loaded proactively, for projects that declare them
- Agent loads only needed context for task
- High signal-to-noise ratio (60%)
- Better focus efficiency through specialization

**Migration path**: Projects can regenerate from monolithic to tree using `/livespec:audit context`

## Examples

### Small Software Project (template default)

```
acme-api/
└── AGENTS.md (8KB)
```

**Total**: 8KB; the root is the whole context

### Governance Project Context Tree (LiveSpec itself, declared 40KB root)

```
livespec/
├── AGENTS.md (38KB)
└── ctxt/
    ├── define.md, design.md, evolve.md, session.md, msl-audit.md, audit.md (6 files, ~7KB each)
    └── domains/
        └── governance.md (10KB)
```

**Total**: ~86KB tree, well within budget when loaded (root + 1-2 sub-agents)

### Hybrid Project Context Tree

```
platform/
├── AGENTS.md (36KB)
└── ctxt/
    ├── define.md, design.md, evolve.md, session.md, msl-audit.md, audit.md (6 files, ~8KB each)
    └── domains/
        ├── software.md (8KB)
        ├── governance.md (7KB)
        └── hybrid.md (6KB)
```

**Total**: ~85KB tree, well within budget when loaded (root + 1 sub-agent + 1 domain)
