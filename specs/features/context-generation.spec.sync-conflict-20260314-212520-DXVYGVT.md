---
criticality: CRITICAL
failure_mode: Without valid agent context tree, agents lack specialized guidance, suffer from context overload, and cannot proactively load phase/domain/utility contexts, reducing focus efficiency and methodology adoption
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement 6: Sustainable Evolution)
  - specs/foundation/outcomes.spec.md (Requirement 5: Voluntary Adoption)
guided-by:
  - specs/strategy/architecture.spec.md
  - specs/strategy/ai-discoverability.spec.md
derives-from:
  - specs/workspace/context-architecture.spec.md
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
updated-by:
  - specs/features/ambient-architecture.spec.md (Distribution Pattern, Dynamic Plugin Reference)
---

# Agent Context Tree Generation

## Status

**Updated for ambient architecture.**

Key changes:
- Distribution pattern updated: Plugin provides methodology, /livespec:init generates project context
- References to .livespec/ now read from plugin at runtime
- CLAUDE.md generation includes inline essential rules (spec-first + layer boundaries)

## Requirements

### Context Tree Structure Generation

- [!] Agent context tree is successfully generated from workspace specifications, producing hierarchical structure that enables proactive specialized loading
  - **Universal mechanism**: See `.livespec/standard/conventions/context-tree.spec.md` for context tree pattern
  - Root AGENTS.md generated (20-30KB, no frontmatter, routing to sub-agents)
  - Phase specialists generated (ctxt/phases/0-define through 4-evolve, 8-12KB each)
  - Domain specialists generated (ctxt/domains/, 6-10KB each, based on taxonomy)
  - Utility specialists generated (ctxt/utils/session-completion, drift-detection, msl-audit, 6-10KB each)
  - Total tree size <150KB, typical loaded context <50KB (root + 1-2 sub-agents)
  - All generated files have clean context (no frontmatter, inline edit warnings only)

### Source Validation

- [!] Context generation validates prerequisites before building to prevent incomplete or invalid trees
  - Workspace specs verified (constitution, patterns, workflows, context-architecture)
  - context-architecture.spec.md is REQUIRED (provides content sources and structure)
  - PURPOSE.md verified (project vision)
  - Templates verified (.livespec/templates/agents/)
  - Context builder agent verified (.claude/agents/context-builder/)
  - Clear error messages if prerequisites missing, especially context-architecture.spec.md
  - Guidance provided to resolve missing prerequisites (e.g., "Run Phase 0 first")

### Spec-Driven Content Selection

- [!] Context generation reads context-architecture.spec.md to determine what content populates the context tree
  - Always-include content appears in root AGENTS.md
  - Include-when-relevant content goes in sub-agents with appropriate load triggers
  - Excluded content is referenced but not inlined
  - Content focus (behaviors/constraints/patterns balance) applied to achieve specified ratios
  - Compression level from spec applied consistently

### Proactive Loading Mechanism

- [!] Generated context tree enables agent autonomous proactive loading without user context management
  - Load triggers defined in root AGENTS.md (keyword patterns)
  - Triggers match natural user language (not technical jargon)
  - Agent analyzes user query autonomously
  - Agent loads relevant sub-agent(s) based on task classification
  - Conservative loading (1-2 sub-agents typical, not 3+)
  - User doesn't explicitly manage contexts (path of least resistance)

### Content Compression

- [!] Context tree respects compression level configuration and applies consistently across all generated files
  - Compression level read from constitution.spec.md frontmatter
  - Light: More inline content, less extraction
  - Moderate: Strategic extraction, balanced inline/reference (default)
  - Aggressive: Heavy extraction, minimal inline
  - Root AGENTS.md contains inline content (no external references to specs/workspace/)
  - Sub-agents reference .livespec/ for detailed specs (80/20 navigation)

### Size Budget Enforcement

- [!] Generated files respect size budgets to optimize context window efficiency
  - Root AGENTS.md: 20-30KB (compressed from typical 50-60KB monolithic)
  - Phase sub-agents: 8-12KB each
  - Domain sub-agents: 6-10KB each
  - Utility sub-agents: 6-10KB each
  - Maximum loaded context: <65KB (root + multiple sub-agents)
  - Size violations detected and reported during generation

### Regeneration Governance

- [!] Context tree generation is repeatable, auditable, and protected from manual edits
  - Generated files marked with edit warnings (not frontmatter - clean context)
  - Edit warnings instruct regeneration via .livespec/prompts/utils/regenerate-contexts.md
  - Regeneration reads workspace specs as source of truth
  - Workspace spec changes trigger regeneration need
  - Context builder agent (.claude/agents/context-builder/) performs generation
  - Generation isolated from parent session (via Task tool sub-agent)

### Auto-Trigger on Workspace Spec Changes

- [!] Context regeneration auto-triggers when workspace specs are modified
  - Detects modification to any file in specs/workspace/
  - Spawns context-builder in background immediately (no prompt)
  - Parent sees: "Workspace spec updated. Regenerating context in background..."
  - Notification on completion with summary
  - Progress written to var/context-generation.log for review

### Distribution Pattern

- [!] Context tree follows plugin-based distribution separating methodology from project-specific generation
  - Plugin provides methodology (skills, metaspecs, templates) - no copying
  - /livespec:init generates: CLAUDE.md (inline rules), AGENTS.md (project context), specs/ structure
  - Project AGENTS.md + ctxt/ = Generated per-project from workspace specs
  - No dist/ directory in target projects - plugin referenced dynamically
  - CLAUDE.md includes inline essential rules (spec-first + layer boundaries)

## Validation

### Structure Validation
- [ ] Root AGENTS.md exists (20-30KB)
- [ ] Root AGENTS.md has NO frontmatter (clean context)
- [ ] Root AGENTS.md has inline edit warning (not in frontmatter)
- [ ] Root AGENTS.md has "When to Load Sub-Agents" section (routing decision tree)
- [ ] Root AGENTS.md contains NO references to specs/workspace/*.spec.md (content inlined)
- [ ] ctxt/phases/ directory contains exactly 5 files (0-define through 4-evolve)
- [ ] ctxt/domains/ directory contains domain-specific files based on taxonomy
- [ ] ctxt/utils/ directory contains exactly 3 files (session-completion, drift-detection, msl-audit)
- [ ] Total tree size <150KB

### Content Validation (spot-check 2-3 sub-agents)
- [ ] Sub-agents have NO frontmatter (clean context)
- [ ] Sub-agents have inline edit warning at top
- [ ] Sub-agents have content immediately accessible (no metadata overhead)
- [ ] Sub-agents reference parent root AGENTS.md in footer text
- [ ] Sub-agents link to .livespec/ detailed specs in Reference Library sections
- [ ] Compression level applied consistently across all files

### Functional Validation
- [ ] Load triggers are intuitive keywords matching natural user language
- [ ] Root AGENTS.md routing matches sub-agent load triggers
- [ ] Agent can match typical queries to appropriate sub-agents
- [ ] Proactive loading works (agent loads without user managing contexts)
- [ ] Context builder runs in isolated context (no session pollution)

### Prerequisites Validation
- [ ] Generation validates workspace specs exist before starting
- [ ] Generation validates context-architecture.spec.md exists (REQUIRED)
- [ ] Generation validates PURPOSE.md exists before starting
- [ ] Generation validates templates exist before starting
- [ ] Clear error messages shown if prerequisites missing
- [ ] Specific error for missing context-architecture.spec.md with Phase 0 guidance
- [ ] Guidance provided to resolve missing prerequisites

### Spec-Driven Content Validation
- [ ] context-architecture.spec.md read before generation
- [ ] Always-include content appears in root
- [ ] Include-when-relevant content appears in sub-agents
- [ ] Excluded content not inlined
- [ ] Content focus balance achieved (behaviors/constraints/patterns)

### Size Budget Validation
- [ ] Root AGENTS.md: 20-30KB
- [ ] Each phase sub-agent: 8-12KB
- [ ] Each domain sub-agent: 6-10KB
- [ ] Each utility sub-agent: 6-10KB
- [ ] Typical loaded context <50KB (root + 1-2 sub-agents)
- [ ] Maximum loaded context <65KB (root + multiple sub-agents)

### Distribution Validation
- [ ] No dist/ or .livespec/ directory created in target projects
- [ ] Plugin provides methodology via skills (not file copying)
- [ ] /livespec:init generates CLAUDE.md with inline rules
- [ ] /livespec:init generates AGENTS.md with project context
- [ ] ctxt/ generated locally from workspace specs
- [ ] Generated CLAUDE.md contains spec-first + layer boundary rules inline
