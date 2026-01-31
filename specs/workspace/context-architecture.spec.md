---
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement 6: Sustainable Evolution)
applies_to:
  - all_projects
  - agent_context_generation
criticality: CRITICAL
failure_mode: Without context architecture, agents receive inappropriate or bloated context leading to focus inefficiency
derives-from:
  - specs/workspace/constitution.spec.md
  - specs/workspace/taxonomy.spec.md
governed-by:
  - .livespec/standard/conventions/context-tree.spec.md
  - .livespec/standard/metaspecs/workspace.spec.md
supports:
  - specs/features/context-generation.spec.md
  - .livespec/prompts/utils/regenerate-contexts.md
---

# Context Architecture

## Requirements

- [!] LiveSpec uses hierarchical agent context tree following context-tree convention to enable specialized proactive loading.
  - **Root AGENTS.md**: Compressed methodology (30-40KB) with routing to sub-agents
  - **Phase specialists** (ctxt/phases/): 0-define through 4-evolve (5 files)
  - **Domain specialists** (ctxt/domains/): governance.md (LiveSpec's domain)
  - **Utility specialists** (ctxt/utils/): session-completion, drift-detection, msl-audit (3 files)
  - **Load triggers**: Natural keywords matching workflow patterns
  - **Proactive loading**: Agent decides what context to load based on task

- [!] LiveSpec defines what content populates agent contexts to ensure focused, relevant guidance.

  **Content Sources** (what feeds AGENTS.md generation):

  Always Include (root AGENTS.md):
  - specs/workspace/constitution.spec.md - Development principles
  - specs/workspace/patterns.spec.md - Naming conventions
  - specs/workspace/workflows.spec.md - Phase guidance
  - Key behaviors from specs/features/ (spec-first enforcement, drift detection)

  Include When Relevant (sub-agent contexts):
  - Phase-specific methodology when agent determines phase work
  - Governance domain patterns when developing methodology
  - Utility workflows when completing sessions or detecting drift

  Exclude:
  - Detailed prompt specifications (reference, don't inline)
  - Implementation details (link to specs/artifacts/ instead)
  - Historical/archived content

  **LiveSpec Methodology Integration**:

  Methodology Prompts Referenced:
  - .livespec/prompts/0-define/ (Mode 0 guidance)
  - .livespec/prompts/1-design/ (Mode 1 guidance)
  - .livespec/prompts/4-evolve/ (Mode 2 guidance)
  - .livespec/prompts/utils/ (utility workflows)

  Guides Incorporated:
  - .livespec/guides/msl-minimalism.md (spec writing)
  - .livespec/guides/context-positioning.md (prompt structure)

  Compression Level: moderate
  - Strategic extraction of reusable content
  - Critical workflows inline, details referenced
  - Templates for repeated verification patterns

  **Structural Hints**:

  Root AGENTS.md Priorities (ordering):
  1. Spec-first enforcement (most critical)
  2. Core principles from constitution
  3. Folder organization decision tests
  4. Phase overview and when to load sub-agents
  5. MSL format quick reference
  6. Reference library navigation

  Sub-Agent Triggers (keyword → context mapping):
  - "new project", "setup", "define" → modes/0-define.md
  - "design", "architecture", "behaviors" → modes/1-design.md
  - "health", "extract", "sync", "evolve" → modes/2-evolve.md
  - "methodology", "dogfooding", "governance" → domains/governance.md
  - "complete session", "measure compliance" → utils/session-completion.md
  - "spec health", "validation" → utils/spec-health.md
  - "audit MSL", "minimalism" → utils/msl-audit.md

  **Content Focus** (governance domain balance):
  - Behaviors: 40% - Methodology behaviors from specs/features/
  - Constraints: 30% - Requirements from specs/foundation/
  - Patterns: 30% - Workspace methodology from specs/workspace/

## Validation

- Root AGENTS.md follows convention size budgets (30-40KB)
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
- Context builder agent reads this spec before generating
- Always-include content appears in root context
- Compression level matches constitution.spec.md declaration
- Content focus produces balanced, relevant guidance
