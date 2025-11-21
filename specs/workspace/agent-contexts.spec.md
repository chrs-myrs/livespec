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
  - .livespec/standard/conventions/context-tree.spec.md
  - .livespec/standard/metaspecs/workspace.spec.md
supports:
  - specs/3-behaviors/context-generation.spec.md
  - .livespec/prompts/utils/regenerate-contexts.md
---

# Agent Context Structure

## Requirements

- [!] LiveSpec uses hierarchical agent context tree following context-tree convention to enable specialized proactive loading
  - **Root AGENTS.md**: Compressed LiveSpec methodology (30-40KB) with routing to sub-agents
  - **Context tree convention**: See `.livespec/standard/conventions/context-tree.spec.md` for universal mechanism
  - **LiveSpec's sub-agents** (defined below): 5 phases + 1 domain + 3 utilities = 9 total sub-agents
  - **Load triggers**: Natural keywords matching LiveSpec workflow patterns
  - **Proactive loading**: Agent analyzes task and loads needed ctxt/ specialists autonomously

- [!] LiveSpec phase specialists provide methodology guidance for each development phase
  - **ctxt/phases/0-define.md**: Problem space, constraints, workspace setup
  - **ctxt/phases/1-design.md**: Architecture, behaviors, contracts, UX flows
  - **ctxt/phases/2-build.md**: TDD workflow, implementation patterns
  - **ctxt/phases/3-verify.md**: Validation, acceptance review
  - **ctxt/phases/4-evolve.md**: Drift detection, spec extraction, synchronization
  - **Load triggers**: "new project", "design", "implement", "validate", "drift" (see convention for full list)

- [!] LiveSpec domain specialist provides governance patterns for methodology development
  - **ctxt/domains/governance.md**: Methodology development, specs about specs, dogfooding patterns
  - **Load triggers**: "methodology", "meta-spec", "dogfooding", "governance"
  - **Why governance domain**: LiveSpec is methodology framework (taxonomy: governance)

- [!] LiveSpec utility specialists provide specialized workflows for common operations
  - **ctxt/utils/session-completion.md**: Session analysis, compliance measurement, learning capture
  - **ctxt/utils/drift-detection.md**: Spec-code synchronization workflow
  - **ctxt/utils/msl-audit.md**: Minimalism enforcement guidance
  - **Load triggers**: "complete session", "detect drift", "audit MSL"

## Validation

- Root AGENTS.md compressed to 30-40KB (from typical 50-60KB monolithic)
- Root has NO frontmatter (clean context per convention)
- Root has "When to Load Sub-Agents" section with routing decision tree
- ctxt/phases/ contains exactly 5 files (0-define through 4-evolve)
- ctxt/domains/governance.md exists (LiveSpec is governance domain)
- ctxt/utils/ contains exactly 3 files (session-completion, drift-detection, msl-audit)
- All sub-agents have NO frontmatter (clean context per convention)
- All sub-agents have inline edit warnings at top
- Load triggers functional (agent can match query to sub-agent)
- Total loaded context <65KB (root + maximum sub-agents)
- Proactive loading works (agent loads without user managing contexts)
- Context builder agent exists (.claude/agents/context-builder/)
- Regeneration prompt exists (.livespec/prompts/utils/regenerate-contexts.md)
- Bootstrap AGENTS.md exists in dist/ (instructs generation after Phase 0)
- Generated files not edited directly (regeneration workflow used)
