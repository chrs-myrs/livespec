---
criticality: CRITICAL
failure_mode: Without context tree structure, agents suffer from context overload, lack specialized guidance, and cannot proactively load phase/domain/utility contexts, reducing focus efficiency and adoption
governed-by:
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

- [!] LiveSpec uses hierarchical agent contexts enabling proactive specialized loading to improve agent focus efficiency
  - **Root AGENTS.md** (30-40KB): Compressed methodology routing to specialized sub-agents
  - **ctxt/**: Flat specialist files — define.md, design.md, evolve.md, session.md, msl-audit.md, audit.md (4-10KB each), no phases/ or utils/ subfolders
  - **ctxt/domains/**: Domain patterns (governance/software/hybrid, 4-10KB each)
  - **Total tree**: <100KB complete, typical loaded well within that (root + 1-2 sub-agents)
  - **Generation**: Opt-in via `/livespec:audit context`, generated per-project after Phase 0 workspace specs exist

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
  - **"When to Load Sub-Agents" section**: Decision tree with load triggers
  - **Proactive loading guidance**: Agent decides what context to load based on task
  - **Reference Library**: Navigation to detailed specs (`references/` paths)
  - **Size budget**: 30-40KB (compressed from typical 50-60KB monolithic)
  - **Compression applied**: Respects level from workspace/constitution.spec.md frontmatter

### Sub-Agent Structure

- [!] Sub-agents provide specialized methodology for phases, domains, and utilities
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
  - **Prerequisite**: Workspace specs must exist (created by `/livespec:init` / Phase 0)

### Integration with Context Compression

- [!] Context tree applies compression level from workspace/constitution.spec.md
  - **Light**: More inline content in root and sub-agents
  - **Moderate**: Strategic extraction, balanced inline/reference (default)
  - **Aggressive**: Heavy extraction, minimal inline, maximum Reference Library
  - **Consistent application**: Same compression across all generated files
  - **Reference hierarchy**: Sub-agents reference `references/` specs based on compression level

## Validation

### Structure Validation
- Root AGENTS.md exists (30-40KB, no frontmatter, inline edit warning)
- Root has "When to Load Sub-Agents" section with decision tree
- ctxt/ contains define.md, design.md, evolve.md, session.md, msl-audit.md, audit.md (flat, no phases/ or utils/ subfolders)
- ctxt/domains/ contains files matching project taxonomy
- Total tree size <100KB

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
- Prerequisites exist (workspace specs, PURPOSE.md, templates)
- Compression level read from constitution.spec.md frontmatter
- Compression applied consistently across all files
- Edit warnings present in all generated files
- Regeneration workflow documented and functional

## Context Tree Topology

### Standard Structure

```
project-root/
├── AGENTS.md (30-40KB, generated)
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
- specs/workspace/constitution.spec.md (development principles)
- specs/workspace/patterns.spec.md (conventions)
- specs/workspace/workflows.spec.md (5 phases)
- specs/workspace/context-architecture.spec.md (project's context structure + content sources)
- PURPOSE.md (project vision)
- templates/agents/spec-first-enforcement.md (template)

### Generation Process

1. **Validate prerequisites**: Check all required files exist
2. **Read sources**: Extract content from workspace specs and PURPOSE.md
3. **Apply compression**: Use level from constitution.spec.md frontmatter
4. **Generate root**: Create AGENTS.md with routing and compressed methodology
5. **Generate sub-agents**: Create define.md, design.md, evolve.md, session.md, msl-audit.md, audit.md in ctxt/
6. **Generate domains**: Create domain specialists in ctxt/domains/ based on taxonomy
7. **Validate structure**: Check sizes, structure, clean context
8. **Report results**: Comprehensive report with file sizes and validation status

### Regeneration Triggers

**When to regenerate context tree**:
- After Phase 0 workspace setup (initial generation from bootstrap)
- Workspace specs modified (constitution, patterns, workflows, agent-contexts, workspace-agent)
- PURPOSE.md updated (project vision changed)
- New workspace spec added
- LiveSpec version upgrade (new methodology)
- Switching compression levels (light ↔ moderate ↔ aggressive)
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

**Hierarchical AGENTS.md + ctxt/**:
- Root 20-30KB (routing + compressed methodology)
- Specialized sub-agents loaded proactively
- Agent loads only needed context for task
- High signal-to-noise ratio (60%)
- Better focus efficiency through specialization

**Migration path**: Projects can regenerate from monolithic to tree using `/livespec:audit context`

## Examples

### Software Project Context Tree

```
acme-api/
├── AGENTS.md (35KB)
└── ctxt/
    ├── define.md, design.md, evolve.md, session.md, msl-audit.md, audit.md (6 files, ~7KB each)
    └── domains/
        └── software.md (8KB)
```

**Total**: ~85KB tree, well within budget when loaded (root + 1 sub-agent)

### Governance Project Context Tree (LiveSpec itself)

```
livespec/
├── AGENTS.md (34KB)
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
