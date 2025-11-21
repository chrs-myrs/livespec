---
criticality: CRITICAL
failure_mode: Without context tree structure, agents suffer from context overload, lack specialized guidance, and cannot proactively load phase/domain/utility contexts, reducing focus efficiency and adoption
governed-by:
  - .livespec/standard/metaspecs/convention.spec.md
applies_to:
  - AGENTS.md
  - ctxt/
  - workspace/agent-contexts.spec.md
  - workspace/workspace-agent.spec.md
---

# Context Tree Structure

**Part of**: LiveSpec agent guidance system (optimizes how agents consume methodology)

## Requirements

### Hierarchical Context Architecture

- [!] LiveSpec uses hierarchical agent contexts enabling proactive specialized loading to improve agent focus efficiency
  - **Root AGENTS.md** (20-30KB): Compressed methodology routing to specialized sub-agents
  - **ctxt/phases/**: Phase specialists (0-define through 4-evolve, 8-12KB each)
  - **ctxt/domains/**: Domain patterns (governance/software/hybrid, 6-10KB each)
  - **ctxt/utils/**: Utility specialists (session-completion, drift-detection, msl-audit, 6-10KB each)
  - **Total tree**: <150KB complete, <50KB typical loaded (root + 1-2 sub-agents)
  - **Distribution**: Bootstrap AGENTS.md (dist/) instructs generation, full tree generated per-project after Phase 0

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
  - **Reference Library**: Navigation to detailed specs (.livespec/ paths)
  - **Size budget**: 20-30KB (compressed from typical 50-60KB monolithic)
  - **Compression applied**: Respects level from workspace/constitution.spec.md frontmatter

### Sub-Agent Structure

- [!] Sub-agents provide specialized methodology for phases, domains, and utilities
  - **NO frontmatter**: Clean context when loaded (frontmatter wastes tokens)
  - **Inline edit warning**: At top of file (not frontmatter)
  - **Specialized content**: Phase methodology, domain patterns, or utility workflows
  - **Load triggers**: Keywords matching natural user language (not technical jargon)
  - **References to .livespec/**: Links to detailed specs for deep detail
  - **Parent reference**: Footer text mentioning "Parent: AGENTS.md" (not frontmatter)
  - **Size budgets**: Phases 8-12KB, domains/utils 6-10KB
  - **Compression applied**: Same level as root

### Generation Governance

- [!] Context tree is generated from workspace specifications and protected from manual edits
  - **Source of truth**: workspace/*.spec.md + PURPOSE.md
  - **Regeneration required**: When workspace specs change, PURPOSE.md updates, or version upgrades
  - **Edit protection**: Files marked with inline warnings (regenerate, don't edit)
  - **Generation tool**: `.livespec/prompts/utils/regenerate-contexts.md`
  - **Context builder agent**: `.claude/agents/context-builder/` performs generation
  - **Isolated execution**: Generation runs via Task tool without polluting parent session

### Size Budget Rationale

- [!] Compact contexts optimize context window primacy and recency bias
  - **Research foundation**: Liu et al. "Lost in the Middle" (2023) - 22% retention boost from strategic positioning
  - **Primacy bias**: Beginning of context processed more thoroughly
  - **Recency bias**: End of context more accessible
  - **Smaller contexts**: Force essential-only content, improve processing speed
  - **Progressive disclosure**: Root provides 80%, sub-agents provide remaining 20% when needed
  - **Maximum loaded**: <65KB (root + multiple sub-agents in rare cases)

### Distribution Pattern

- [!] Context tree follows two-stage pattern: bootstrap then generation
  - **Bootstrap (dist/AGENTS.md)**: Minimal ~5KB, instructs generation after Phase 0
  - **Full tree**: Generated per-project from workspace specs (not pre-distributed)
  - **Why not distribute ctxt/**: Content depends on project's PURPOSE, domain, principles
  - **Bootstrap content**: Critical warnings, Phase 0 instructions, regeneration guidance
  - **Prerequisite**: Workspace specs must exist (created by Phase 0)

### Integration with Context Compression

- [!] Context tree applies compression level from workspace/constitution.spec.md
  - **Light**: More inline content in root and sub-agents
  - **Moderate**: Strategic extraction, balanced inline/reference (default)
  - **Aggressive**: Heavy extraction, minimal inline, maximum Reference Library
  - **Consistent application**: Same compression across all generated files
  - **Reference hierarchy**: Sub-agents reference .livespec/ specs based on compression level

## Validation

### Structure Validation
- Root AGENTS.md exists (20-30KB, no frontmatter, inline edit warning)
- Root has "When to Load Sub-Agents" section with decision tree
- ctxt/phases/ contains 5 files (0-define through 4-evolve)
- ctxt/domains/ contains files matching project taxonomy
- ctxt/utils/ contains 3 files (session-completion, drift-detection, msl-audit)
- Total tree size <150KB

### Sub-Agent Validation
- All sub-agents have NO frontmatter (clean context)
- All sub-agents have inline edit warning at top
- All sub-agents within size budgets
- All sub-agents reference parent AGENTS.md in footer text
- All sub-agents link to .livespec/ detailed specs

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
├── AGENTS.md (20-30KB, generated)
└── ctxt/
    ├── phases/
    │   ├── 0-define.md (8-12KB)
    │   ├── 1-design.md (8-12KB)
    │   ├── 2-build.md (8-12KB)
    │   ├── 3-verify.md (8-12KB)
    │   └── 4-evolve.md (8-12KB)
    ├── domains/
    │   ├── governance.md (6-10KB, if taxonomy: governance)
    │   ├── software.md (6-10KB, if taxonomy: software)
    │   └── hybrid.md (6-10KB, if taxonomy: hybrid)
    └── utils/
        ├── session-completion.md (6-10KB)
        ├── drift-detection.md (6-10KB)
        └── msl-audit.md (6-10KB)
```

### Load Trigger Examples

**Phase-specific work**:
- "new project", "setup", "define problem", "constraints" → ctxt/phases/0-define.md
- "design", "architecture", "behaviors", "contracts", "UX flow" → ctxt/phases/1-design.md
- "implement", "build", "tests", "TDD", "code" → ctxt/phases/2-build.md
- "validate", "verify", "acceptance", "review" → ctxt/phases/3-verify.md
- "drift", "extract specs", "sync", "evolve", "maintain" → ctxt/phases/4-evolve.md

**Domain patterns**:
- "methodology", "specs about specs", "dogfooding" → ctxt/domains/governance.md
- "API design", "user features", "system behavior" → ctxt/domains/software.md

**Utilities**:
- "complete session", "measure compliance", "analyze session" → ctxt/utils/session-completion.md
- "detect drift", "check sync", "spec-code alignment" → ctxt/utils/drift-detection.md
- "audit MSL", "check minimalism", "review specs" → ctxt/utils/msl-audit.md

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
- "What's in specs/3-behaviors/?" → Read files, no sub-agent needed
- "Update this requirement" → Edit using MSL format from AGENTS.md
- "Run validation" → Script paths already in AGENTS.md

## Generation Workflow

### Prerequisites (established by Phase 0)

**Required files**:
- specs/workspace/constitution.spec.md (development principles)
- specs/workspace/patterns.spec.md (conventions)
- specs/workspace/workflows.spec.md (5 phases)
- specs/workspace/agent-contexts.spec.md (project's context tree structure)
- specs/workspace/workspace-agent.spec.md (project's AGENTS.md content definition)
- PURPOSE.md (project vision)
- .livespec/templates/agents/spec-first-enforcement.md (template)

### Generation Process

1. **Validate prerequisites**: Check all required files exist
2. **Read sources**: Extract content from workspace specs and PURPOSE.md
3. **Apply compression**: Use level from constitution.spec.md frontmatter
4. **Generate root**: Create AGENTS.md with routing and compressed methodology
5. **Generate phases**: Create 5 phase specialists in ctxt/phases/
6. **Generate domains**: Create domain specialists based on taxonomy
7. **Generate utils**: Create 3 utility specialists in ctxt/utils/
8. **Validate structure**: Check sizes, structure, clean context
9. **Report results**: Comprehensive report with file sizes and validation status

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
- .livespec/ specs provide comprehensive documentation

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

**Migration path**: Projects can regenerate from monolithic to tree using `.livespec/prompts/utils/regenerate-contexts.md`

## Examples

### Software Project Context Tree

```
acme-api/
├── AGENTS.md (28KB)
└── ctxt/
    ├── phases/ (5 files, 10KB each)
    ├── domains/
    │   └── software.md (8KB)
    └── utils/ (3 files, 8KB each)
```

**Total**: ~130KB tree, ~46KB typical loaded (root + 1 phase)

### Governance Project Context Tree (LiveSpec itself)

```
livespec/
├── AGENTS.md (32KB)
└── ctxt/
    ├── phases/ (5 files, 12KB each)
    ├── domains/
    │   └── governance.md (9KB)
    └── utils/ (3 files, 9KB each)
```

**Total**: ~148KB tree, ~50KB typical loaded (root + 1 phase + governance)

### Hybrid Project Context Tree

```
platform/
├── AGENTS.md (30KB)
└── ctxt/
    ├── phases/ (5 files, 11KB each)
    ├── domains/
    │   ├── software.md (8KB)
    │   ├── governance.md (7KB)
    │   └── hybrid.md (6KB)
    └── utils/ (3 files, 8KB each)
```

**Total**: ~145KB tree, ~49KB typical loaded (root + 1 phase + 1 domain)
