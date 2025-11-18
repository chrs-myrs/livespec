---
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md (Requirement 6: Sustainable Evolution)
applies_to:
  - all_projects
  - agent_context_generation
criticality: CRITICAL
failure_mode: Without hierarchical agent contexts, agents lack specialized guidance and suffer from context overload, reducing focus efficiency
derives-from:
  - specs/workspace/constitution.spec.md
  - specs/workspace/taxonomy.spec.md
  - specs/workspace/workspace-agent.spec.md
governed-by:
  - .livespec/standard/metaspecs/workspace.spec.md
supports:
  - .livespec/prompts/utils/regenerate-contexts.md
---

# Agent Context Structure

## Requirements
- [!] LiveSpec uses hierarchical agent contexts with root AGENTS.md routing to specialized ctxt/ sub-agents, enabling proactive context loading based on task classification to improve agent focus efficiency.

  **Context Tree Structure:**
  - **Root AGENTS.md** (compressed ~30-40KB):
    - Project summary (PURPOSE.md)
    - Core principles (compressed from constitution)
    - Proactive loading decision tree (when to load which sub-agent)
    - Quick start (80% of cases - Phase 0 only)
    - MSL format quick reference
    - Reference Library (navigation to ctxt/ AND .livespec/)
  - **ctxt/phases/** (phase-specific methodology):
    - 0-define.md - Phase 0 specialist (problem space, constraints, workspace setup)
    - 1-design.md - Phase 1 specialist (architecture, behaviors, contracts, UX flows)
    - 2-build.md - Phase 2 specialist (TDD workflow, implementation patterns)
    - 3-verify.md - Phase 3 specialist (validation, acceptance review)
    - 4-evolve.md - Phase 4 specialist (drift detection, spec extraction, sync)
  - **ctxt/domains/** (domain-specific patterns):
    - governance.md - Governance domain patterns (methodology development)
    - software.md - Software domain patterns (code development)
    - hybrid.md - Multi-domain patterns (mixed projects)
  - **ctxt/utils/** (utility specialists):
    - session-completion.md - Session analysis and learning
    - drift-detection.md - Spec-code synchronization
    - msl-audit.md - Minimalism enforcement

  **Proactive Loading Mechanism:**
  - Root AGENTS.md contains load triggers (keyword patterns)
  - Agent analyzes user query/task
  - Agent autonomously loads relevant ctxt/ sub-agent(s)
  - User doesn't manage context explicitly (path of least resistance)
  - **Load conservatively** (1-2 sub-agents typical, avoid over-loading)

  **Load Trigger Patterns** (in root AGENTS.md):
  ```markdown
  ## When to Load Sub-Agents

  **Phase-specific work:**
  - "New project", "setup", "define problem" → Load ctxt/phases/0-define.md
  - "Design", "architecture", "UX flow" → Load ctxt/phases/1-design.md
  - "Implement", "write tests", "TDD", "build" → Load ctxt/phases/2-build.md
  - "Validate", "test", "acceptance" → Load ctxt/phases/3-verify.md
  - "Drift", "extract specs", "sync" → Load ctxt/phases/4-evolve.md

  **Domain patterns:**
  - Project taxonomy: governance → Load ctxt/domains/governance.md
  - Project taxonomy: software → Load ctxt/domains/software.md
  - Project taxonomy: hybrid → Load ctxt/domains/hybrid.md

  **Utilities:**
  - "Complete session", "measure compliance" → Load ctxt/utils/session-completion.md
  - "Detect drift", "check sync" → Load ctxt/utils/drift-detection.md
  - "Audit MSL", "check minimalism" → Load ctxt/utils/msl-audit.md
  ```

  **Sub-Agent Structure:**
  - NO frontmatter (clean context - frontmatter wastes tokens when agents read files)
  - Inline edit warning at top (like root AGENTS.md): "⚠️ **Generated file** - Do not edit directly. Regenerate using `.livespec/prompts/utils/regenerate-contexts.md`"
  - Metadata implicit from file location and governance spec (phase/domain/utility inferred from path)
  - Content immediately accessible to agents
  - Specialized methodology for scope
  - References back to root AGENTS.md for core principles
  - Cross-references to other sub-agents when needed
  - Links to .livespec/ detailed specs (Reference Library pattern)
  - Applied compression level (from constitution frontmatter)

  **Size Budgets:**
  - Root AGENTS.md: 30-40KB (compressed from typical 50-60KB)
  - Phase sub-agents: 10-15KB each (detailed phase methodology)
  - Domain sub-agents: 8-12KB each (domain-specific patterns)
  - Utility sub-agents: 8-12KB each (specialized utility guidance)
  - **Total loaded context** (root + 1-2 sub-agents): <60KB typical
  - **Maximum loaded context**: <80KB (root + multiple sub-agents)

  **Compression Application:**
  - Respects compression level from constitution.spec.md frontmatter
  - Same compression rules apply to sub-agents as to root
  - Moderate compression (LiveSpec default): Strategic extraction, balanced inline/reference
  - See .livespec/standard/conventions/context-compression.spec.md for framework

  **Generation Governance:**
  - Generated files (AGENTS.md, ctxt/*) MUST NOT be edited directly
  - Edit warning in frontmatter (not separate section - clean context)
  - Regenerate using .livespec/prompts/utils/regenerate-contexts.md
  - Generation reads workspace specs as source of truth
  - Workspace spec changes trigger regeneration
  - Context builder agent (.claude/agents/context-builder/) performs generation

  **Distribution Pattern:**
  - dist/AGENTS.md = Bootstrap version (minimal, instructs to build tree)
  - Project AGENTS.md + ctxt/ = Generated per-project from workspace specs
  - dist/ does NOT contain pre-built ctxt/ (generated locally)
  - Bootstrap AGENTS.md provides path to full generation

  **Relationship to Existing Patterns:**
  - **Context compression** (constitution): Forces extraction at Moderate+ levels → Context tree natural response
  - **Reference Library** (workspace-agent): 80/20 navigation pattern → Extended to ctxt/ sub-agents
  - **Template extraction** (spec-first-enforcement): Reusable content pattern → Applied to phase/domain/utility contexts
  - **Taxonomy** (classification): Project domain determines which domain sub-agent to load
  - **Active Agent Guidance** (constitution): Structural enforcement → Sub-agents enable specialized structural guidance

## Validation
- Root AGENTS.md compressed to 30-40KB (from typical 50-60KB)
- Root AGENTS.md has NO frontmatter (clean context)
- All phase sub-agents exist (ctxt/phases/0-define through 4-evolve)
- Domain sub-agents match project taxonomy
- Utility sub-agents provide specialized guidance
- Sub-agents have NO frontmatter (clean context - frontmatter wastes tokens)
- Edit warnings inline at top of each sub-agent file
- Load triggers functional (agent can match query to sub-agent)
- Total loaded context <80KB (root + maximum sub-agents)
- Proactive loading works (agent loads without user managing contexts)
- Context builder agent definition exists (.claude/agents/context-builder/)
- Regeneration prompt exists (.livespec/prompts/utils/regenerate-contexts.md)
- Bootstrap AGENTS.md exists in dist/ (instructs generation)
- Generated files not edited directly (regeneration workflow used)
