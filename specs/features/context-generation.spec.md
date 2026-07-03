---
type: behavior
category: features
fidelity: behavioral
criticality: CRITICAL
failure_mode: Without valid agent context tree, agents lack specialized guidance, suffer from context overload, and cannot proactively load domain/utility contexts, reducing focus efficiency and methodology adoption
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement 6: Sustainable Evolution)
  - specs/foundation/outcomes.spec.md (Requirement 5: Voluntary Adoption)
guided-by:
  - specs/strategy/architecture.spec.md
  - specs/strategy/ai-discoverability.spec.md
derives-from:
  - specs/workspace/context-architecture.spec.md
supports:
  - agents/context-builder.md
---

# Agent Context Tree Generation

## Requirements

### Context Tree Structure Generation

- [!] Agent context tree is successfully generated from workspace specifications, producing a flat structure that enables proactive specialized loading
  - **Universal mechanism**: See `references/standards/conventions/context-tree.spec.md` for context tree pattern
  - Root AGENTS.md generated (30-40KB, no frontmatter, routing to sub-agents)
  - Sub-agents generated in ctxt/ — define.md, design.md, evolve.md, session.md, msl-audit.md, audit.md (4-10KB each, flat, no phases/ or utils/ subfolders)
  - Domain specialists generated (ctxt/domains/, 4-10KB each, based on taxonomy)
  - Total tree size <100KB, typical loaded context well within that (root + 1-2 sub-agents)
  - All generated files have clean context (no frontmatter, inline edit warnings only)

### Source Validation

- [!] Context generation validates prerequisites before building to prevent incomplete or invalid trees
  - Workspace specs verified (constitution, patterns, workflows, context-architecture)
  - context-architecture.spec.md is REQUIRED (provides content sources and structure)
  - PURPOSE.md verified (project vision)
  - Templates verified (templates/agents/)
  - Context builder agent verified (agents/context-builder.md)
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
  - Sub-agents reference `references/` for detailed specs (80/20 navigation)

### Size Budget Enforcement

- [!] Generated files respect size budgets to optimize context window efficiency
  - Root AGENTS.md: 30-40KB (compressed from typical 50-60KB monolithic)
  - Each ctxt/ sub-agent: 4-10KB
  - Total tree: <100KB
  - Size violations detected and reported during generation

### Regeneration Governance

- [!] Context tree generation is repeatable, auditable, and protected from manual edits
  - Generated files marked with edit warnings (not frontmatter - clean context)
  - Edit warnings instruct regeneration via `/livespec:audit context`
  - Regeneration reads workspace specs as source of truth
  - Workspace spec changes trigger regeneration need
  - Context builder agent (agents/context-builder.md) performs generation
  - Generation isolated from parent session (runs as a dedicated sub-agent)

### Incremental Update Mode

- [!] Context generation classifies each regeneration request as MINOR (scoped patch) or FULL (whole-tree rebuild) and defaults to acting on that classification without a confirmation gate
  - Diffs workspace specs and PURPOSE.md against the last generation (git history) to determine what changed
  - Consults `specs/workspace/context-architecture.spec.md` Spec → Generated File Map to find the target file(s) for each change
  - A changed spec with no generated target in the map is excluded from the changed-target set — it doesn't force FULL by itself, unlike a genuinely unclear mapping
  - Classifies **MINOR** when every remaining changed spec maps to existing content in a single target file/section, and none of the changes are marked "Structural" in the map (an empty remaining set after exclusions also classifies MINOR, with nothing to regenerate)
  - Classifies **FULL** when any remaining changed spec is marked "Structural" in the map, a workspace spec was added or removed, multiple unrelated targets are touched at once, or the mapping is unclear
  - On ambiguity or low confidence in a clean mapping, defaults to FULL rather than guessing at a narrow patch that might miss something
  - States the classification and a one-line reason in its report either way; this is judgement, not a rigid rule — the user can always request the other path explicitly (e.g. "full regenerate")
  - MINOR path: context-builder is invoked with a scope limited to the mapped target file(s) — see Scoped Generation below
  - FULL path: behaves exactly as whole-tree generation always has

- [!] Scoped generation regenerates and validates only the target file(s) identified by the classification, leaving the rest of the tree untouched
  - Only the mapped file(s) are read, rewritten, and size-validated
  - Files outside the scope are not opened or touched
  - Report explicitly labels the run "scoped update: [files]" so it's clear less than the full tree ran
  - Same edit-warning and footer conventions as full generation apply to touched files

### Opt-In Generation

- [!] AGENTS.md + ctxt/ generation is optional, not a plugin-install prerequisite
  - Skills are self-contained and work correctly with no AGENTS.md/ctxt/ present
  - `/livespec:init` scaffolds specs/ + PURPOSE.md but does not generate AGENTS.md
  - A project generates its own AGENTS.md + ctxt/ on request via
    `/livespec:audit context`, once workspace specs exist
  - There is no separate "bootstrap" AGENTS.md shipped by the plugin — the first
    real generation IS the full tree

## Validation

### Structure Validation
- [ ] Root AGENTS.md exists (30-40KB)
- [ ] Root AGENTS.md has NO frontmatter (clean context)
- [ ] Root AGENTS.md has inline edit warning (not in frontmatter)
- [ ] Root AGENTS.md has "When to Load Sub-Agents" section (routing decision tree)
- [ ] Root AGENTS.md contains NO references to specs/workspace/*.spec.md (content inlined)
- [ ] ctxt/ contains define.md, design.md, evolve.md, session.md, msl-audit.md, audit.md (flat, no phases/ or utils/ subfolders)
- [ ] ctxt/domains/ directory contains domain-specific files based on taxonomy
- [ ] Total tree size <100KB

### Content Validation (spot-check 2-3 sub-agents)
- [ ] Sub-agents have NO frontmatter (clean context)
- [ ] Sub-agents have inline edit warning at top
- [ ] Sub-agents have content immediately accessible (no metadata overhead)
- [ ] Sub-agents reference parent root AGENTS.md in footer text
- [ ] Sub-agents link to `references/` detailed specs in Reference Library sections
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
- [ ] Root AGENTS.md: 30-40KB
- [ ] Each ctxt/ sub-agent (including domain files): 4-10KB
- [ ] Total tree: <100KB

### Incremental Update Validation
- [ ] Classification (MINOR/FULL) and its reasoning appear in the generation report
- [ ] MINOR only fires when no changed spec is marked "Structural" in the Spec → Generated File Map
- [ ] FULL fires automatically on any Structural change, added/removed spec, or unclear mapping
- [ ] A changed spec with no generated target (per the map) is excluded from classification, not treated as unclear/FULL
- [ ] Scoped runs only read/write/validate the mapped target file(s), never the rest of the tree
- [ ] No confirmation gate blocks either path — classification is reported, not asked

### Opt-In Generation Validation
- [ ] Skills execute correctly with no AGENTS.md/ctxt/ present in the project
- [ ] `/livespec:init` does not generate AGENTS.md
- [ ] `/livespec:audit context` is the only path that generates AGENTS.md/ctxt/
- [ ] No spec or generated file references a separate "bootstrap AGENTS.md"
