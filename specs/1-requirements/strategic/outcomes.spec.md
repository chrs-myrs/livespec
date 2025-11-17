---
derives-from:
  - PURPOSE.md
supports:
  - specs/1-requirements/strategic/constraints.spec.md
  - specs/2-strategy/architecture.spec.md
  - specs/workspace/
  - specs/3-artifacts/prompts/
criticality: CRITICAL
failure_mode: Without clear outcomes, LiveSpec lacks cohesive direction and becomes disconnected collection of features
governed-by:
  - .livespec/standard/metaspecs/outcomes.spec.md
---

# LiveSpec Outcomes

## Requirements
- [!] LiveSpec must provide methodology for bidirectional specification-code synchronization, support AI-assisted development across any agent, work for both greenfield and brownfield projects, maintain specifications without becoming maintenance burden, and sustain evolution through balanced expansion/contraction forces.
  - All 6 core requirements satisfied by identified specs
  - Traceability maintained via frontmatter dependencies
  - Changes to requirements trigger cascade review of satisfying specs

## Core Requirements

### 1. Bidirectional Synchronization
Support spec-first (design) and code-first (extraction) workflows.

**Satisfied by:**
- specs/2-strategy/architecture.spec.md (dogfooding section)
- specs/3-artifacts/prompts/4a-detect-drift.spec.md (code→spec detection)
- specs/3-artifacts/prompts/4b-extract-specs.spec.md (code→spec extraction)
- prompts/1-design/ (spec→code design)
- prompts/2-build/ (spec→code implementation)

**Validated by:**
- Users create specs before code (Phase 1-2)
- Users extract specs from existing code (Phase 4b)
- Drift detection identifies misalignment (Phase 4a)

### 2. AI Agent Support
Provide structured context enabling effective AI assistance.

**Satisfied by:**
- AGENTS.md (cached reference for AI agents)
- llms.txt (Context7 integration)
- specs/3-behaviors/msl-format.spec.md (consistent format)
- specs/workspace/ (process guidance)

**Validated by:**
- Context7 integration functional
- AI agents successfully execute prompts
- Users report improved AI assistance quality

### 3. Universal Applicability
Work equally well for new projects and existing codebases.

**Satisfied by:**
- prompts/0-define/0a-setup-workspace.md (new projects)
- prompts/4-evolve/4b-extract-specs.md (existing codebases)
- specs/2-strategy/architecture.spec.md (both modes supported)

**Validated by:**
- Users adopt LiveSpec for greenfield projects
- Users adopt LiveSpec for brownfield projects
- Same methodology works for both

### 4. Minimal Maintenance
Specifications stay current without significant overhead.

**Satisfied by:**
- specs/3-behaviors/msl-format.spec.md (minimalism)
- specs/workspace/constitution.spec.md (trust implementers)
- prompts/4-evolve/ (continuous sync, not big-bang updates)

**Validated by:**
- Specs average <30 lines (MSL compliance)
- Phase 4 runs quickly (minutes, not hours)
- Developers voluntarily update specs

### 5. Voluntary Adoption
Developers maintain specs because they reduce cognitive load, choosing LiveSpec methodology means accepting AI-guided discipline.

**Satisfied by:**
- specs/workspace/constitution.spec.md (minimal burden, spec-first principle)
- specs/workspace/workspace-agent.spec.md (AI agents guide methodology adherence)
- specs/3-behaviors/folder-structure.spec.md (clear organization)
- All prompts/ (structured AI assistance)

**Validated by:**
- Developers continue using LiveSpec after initial setup
- AI agents provide structured guidance ensuring methodology consistency
- Developers report cognitive load reduction

### 6. Sustainable Evolution
Methodology prevents bloat through balanced expansion/contraction forces.

**Satisfied by:**
- specs/workspace/workspace-agent.spec.md (critical warning budget: max 3)
- .livespec/prompts/utils/regenerate-contexts.md (MSL minimalism during generation)
- specs/workspace/agent-contexts.spec.md (context tree clean evolution)
- prompts/utils/audit-workspace-specs.md (periodic consolidation)
- specs/3-behaviors/session-completion.spec.md (feedback loop identifying what doesn't work)

**Validated by:**
- Workspace specs trend stable or decreasing in size over time
- Critical warnings remain meaningful (≤3 total)
- AGENTS.md stays under 80KB target
- Yin-yang pairs exist for all accumulation pressures

**Yin-Yang Pairs**:
- Learning capture (adds) ⚔ MSL minimalism checks (consolidates/refuses)
- Critical warnings (seeks ⚠️ status) ⚔ Budget limit (max 3, strict criteria)
- AGENTS.md generation (expands from specs) ⚔ Generation MSL test (contracts)
- Behavior specs (grows with features) ⚔ Obsolescence deletion (prunes unused)

**Design principle**: Every one-way pressure must have counterbalancing force.

## Validation

- All 6 core requirements satisfied by identified specs
- Traceability maintained via frontmatter dependencies
- Changes to requirements trigger cascade review of satisfying specs
