---
type: workspace
category: workspace
fidelity: process
criticality: CRITICAL
failure_mode: Without context architecture, agents receive inappropriate or bloated context leading to focus inefficiency
governed-by: []
applies_to:
  - all_projects
  - agent_context_generation
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement 6: Sustainable Evolution)
derives-from:
  - specs/workspace/constitution.spec.md
  - specs/workspace/taxonomy.spec.md
supports:
  - specs/features/context-generation.spec.md
---

# Context Architecture

## Requirements

- [!] LiveSpec uses a flat agent context tree following the context-tree convention to enable specialized proactive loading.
  - **Root AGENTS.md**: Compressed methodology (30-40KB) with routing to sub-agents
  - **Sub-agents** (ctxt/): define.md, design.md, evolve.md, session.md, msl-audit.md, audit.md — one file per specialist, no phase/utility subfolders
  - **Domain specialists** (ctxt/domains/): governance.md (LiveSpec's domain)
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

  Methodology Skills Referenced:
  - skills/init/ (Phase 0 guidance)
  - skills/design/ (Phase 1 guidance)
  - skills/audit/ (Phase 3/4 guidance)
  - skills/learn/ (session completion)

  Guides Incorporated:
  - references/guides/msl-minimalism.md (spec writing)
  - references/guides/context-positioning.md (prompt structure)

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
  - "new project", "setup", "define" → ctxt/define.md
  - "design", "architecture", "behaviors" → ctxt/design.md
  - "implement", "build", "tests", "drift", "sync", "extract" → ctxt/evolve.md
  - "methodology", "dogfooding", "governance" → ctxt/domains/governance.md
  - "complete session", "measure compliance" → ctxt/session.md
  - "audit MSL", "minimalism" → ctxt/msl-audit.md
  - "health", "validate", "audit specs" → ctxt/audit.md

  **Content Focus** (governance domain balance):
  - Behaviors: 40% - Methodology behaviors from specs/features/
  - Constraints: 30% - Requirements from specs/foundation/
  - Patterns: 30% - Workspace methodology from specs/workspace/

- [!] LiveSpec documents which generated file(s) each source feeds, so a scoped update can target the right output without regenerating the whole tree.

  **Spec → Generated File Map:**

  | Source | Generated File(s) | Structural? |
  |--------|--------------------|-------------|
  | PURPOSE.md | AGENTS.md § Summary | No |
  | constitution.spec.md | AGENTS.md § Core Principles | Compression-level changes are structural (affect every file) |
  | patterns.spec.md | AGENTS.md § MSL Format/Folder Structure; ctxt/domains/governance.md | No |
  | workflows.spec.md | AGENTS.md § The 5 Phases; ctxt/evolve.md | No |
  | taxonomy.spec.md | AGENTS.md § Folder Organization Tests; ctxt/domains/*.md | Domain classification changes are structural (add/remove domain files) |
  | context-architecture.spec.md (this spec) | Tree structure itself — which files exist, size budgets, load triggers | Always structural |
  | context-compression.spec.md | AGENTS.md § Context Compression | Compression-level changes are structural (affect every file) |
  | cross-references.spec.md | AGENTS.md § Cross-Reference Updates; § Frontmatter Relationship Fields | No |
  | distribution.spec.md | AGENTS.md (Summary; Quick Start; Common Anti-Patterns — scattered mentions, one file) | No |
  | folder-organization.spec.md | AGENTS.md § Folder Organization Decision Tests | No, unless the change adds/removes a domain-classification category |
  | generated-files.spec.md | *(none — process-only, not inlined into AGENTS.md/ctxt)* | N/A — no generated target |
  | livespec.spec.md | AGENTS.md (diffused across Core Principles, Development Workflows, general tone — no clean single target) | Yes — no clean single-target scope, treat as structural |
  | third-party-dependencies.spec.md | *(none — process-only, not inlined)* | N/A — no generated target |
  | version-management.spec.md | AGENTS.md footer version stamp only | No |
  | workspace-agent.spec.md | Governs AGENTS.md's own structure, positioning, compression, and critical-section rules, including mandating inline of `templates/agents/spec-first-enforcement.md` | Always structural |

  **Structural** means the change can add, remove, or resize generated files beyond the mapped target(s) — it forces full regeneration regardless of how small the diff looks. Everything else can be scoped to the listed file(s) provided no spec or generated file is being added or removed. A changed source with **no generated target** (see `generated-files.spec.md`, `third-party-dependencies.spec.md` above) is excluded from the changed-target set entirely — it doesn't force FULL by itself, unlike a genuinely unclear mapping.

## Validation

- Root AGENTS.md follows convention size budgets (30-40KB)
- Root has NO frontmatter (clean context per convention)
- Root has "When to Load Sub-Agents" section with routing decision tree
- ctxt/ contains define.md, design.md, evolve.md, session.md, msl-audit.md, audit.md (flat, no phases/ or utils/ subfolders)
- ctxt/domains/governance.md exists (LiveSpec is governance domain)
- All sub-agents have NO frontmatter (clean context per convention)
- All sub-agents have inline edit warnings at top
- Load triggers functional (agent can match query to sub-agent)
- Total loaded context stays well within the <100KB total tree budget
- Proactive loading works (agent loads without user managing contexts)
- Context builder agent reads this spec before generating
- Always-include content appears in root context
- Compression level matches constitution.spec.md declaration
- Content focus produces balanced, relevant guidance
- Spec → Generated File Map covers every file in specs/workspace/ plus PURPOSE.md and taxonomy.spec.md
