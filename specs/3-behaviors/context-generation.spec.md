---
criticality: CRITICAL
failure_mode: Without valid agent context tree, agents lack specialized guidance, suffer from context overload, and cannot proactively load phase/domain/utility contexts, reducing focus efficiency and methodology adoption
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md (Requirement 6: Sustainable Evolution)
  - specs/1-requirements/strategic/outcomes.spec.md (Requirement 5: Voluntary Adoption)
guided-by:
  - .livespec/standard/conventions/context-tree.spec.md
  - specs/2-strategy/architecture.spec.md
  - specs/2-strategy/ai-discoverability.spec.md
derives-from:
  - specs/workspace/agent-contexts.spec.md
  - specs/workspace/workspace-agent.spec.md
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
supports:
  - .livespec/prompts/utils/regenerate-contexts.md
  - .claude/agents/context-builder/instructions.md
---

# Agent Context Tree Generation

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
  - Workspace specs verified (constitution, patterns, workflows, agent-contexts)
  - PURPOSE.md verified (project vision)
  - Templates verified (.livespec/templates/agents/)
  - Context builder agent verified (.claude/agents/context-builder/)
  - Clear error messages if prerequisites missing
  - Guidance provided to resolve missing prerequisites (e.g., "Run Phase 0 first")

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

### Distribution Pattern

- [!] Context tree follows correct distribution pattern separating bootstrap from project-specific generation
  - dist/AGENTS.md = Bootstrap version (minimal ~5KB, instructs to build tree)
  - Project AGENTS.md + ctxt/ = Generated per-project from workspace specs
  - dist/ does NOT contain pre-built ctxt/ (generated locally after Phase 0)
  - Bootstrap AGENTS.md provides clear path to full generation

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
- [ ] Generation validates PURPOSE.md exists before starting
- [ ] Generation validates templates exist before starting
- [ ] Clear error messages shown if prerequisites missing
- [ ] Guidance provided to resolve missing prerequisites

### Size Budget Validation
- [ ] Root AGENTS.md: 20-30KB
- [ ] Each phase sub-agent: 8-12KB
- [ ] Each domain sub-agent: 6-10KB
- [ ] Each utility sub-agent: 6-10KB
- [ ] Typical loaded context <50KB (root + 1-2 sub-agents)
- [ ] Maximum loaded context <65KB (root + multiple sub-agents)

### Distribution Validation
- [ ] dist/AGENTS.md is bootstrap (~5KB, not full tree)
- [ ] dist/AGENTS.md instructs generation after Phase 0
- [ ] Project AGENTS.md generated locally (not distributed)
- [ ] ctxt/ generated locally (not in dist/)
- [ ] Bootstrap clearly explains full tree comes after workspace specs
