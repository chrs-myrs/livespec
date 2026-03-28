---
type: outcomes
category: foundation
fidelity: behavioral
criticality: CRITICAL
failure_mode: Without clear outcomes, LiveSpec lacks cohesive direction and becomes disconnected collection of features
governed-by: []
derives-from:
  - PURPOSE.md
supports:
  - specs/foundation/constraints.spec.md
  - specs/strategy/architecture.spec.md
  - specs/workspace/
  - specs/artifacts/prompts/
---

# LiveSpec Outcomes

## Requirements
- [!] LiveSpec must provide information architecture where upper layers are durable assets and code is disposable, support AI-assisted development across any agent, work for both greenfield and brownfield projects, maintain specifications proportional to their durability level, generate AI context from workspace specs, and sustain evolution through balanced expansion/contraction forces.
  - All 6 core requirements satisfied by identified specs
  - Traceability maintained via frontmatter dependencies
  - Changes to requirements trigger cascade review of satisfying specs

## Core Requirements

### 1. Specification-Driven Architecture
Upper layers (purpose, requirements, strategy, behaviors) are durable assets that define the system. Lower layers are derived and regenerable.

**Satisfied by:**
- specs/strategy/architecture.spec.md (two-branch model, disposability)
- specs/features/abstraction-guidance.spec.md (layer placement)
- specs/features/spec-health.spec.md (spec quality monitoring)
- prompts/1-design/ (spec architecture design)

**Validated by:**
- Specs contain no implementation details (only WHAT/WHY, never HOW)
- Spec hierarchy maintains clear abstraction levels
- Discoveries are leveled up to appropriate spec layer

### 2. AI Context Generation
Workspace specs generate AI agent context (AGENTS.md, context tree) enabling effective AI management of the spec-code system.

**Satisfied by:**
- specs/workspace/ (source for context generation)
- AGENTS.md (generated from workspace specs)
- ctxt/ (context tree generated from workspace)
- specs/features/msl-format.spec.md (consistent format)
- llms.txt (Context7 integration)

**Validated by:**
- AGENTS.md regenerable from workspace specs
- Context7 integration functional
- AI agents successfully manage spec system
- Human remains stakeholder, AI manages specs

### 3. Universal Applicability
Work equally well for new projects and existing codebases.

**Satisfied by:**
- prompts/0-define/0a-quick-start.md (new projects)
- prompts/4-evolve/4b-extract-specs.md (existing codebases)
- specs/strategy/architecture.spec.md (both modes supported)

**Validated by:**
- Users adopt LiveSpec for greenfield projects
- Users adopt LiveSpec for brownfield projects
- Same methodology works for both

### 4. Maintenance Proportional to Durability
Invest maintenance energy proportional to layer durability. Upper layers maintained carefully; lower layers evolved or regenerated as needed.

**Satisfied by:**
- specs/features/msl-format.spec.md (minimalism for specs)
- specs/features/abstraction-guidance.spec.md (layer placement)
- specs/workspace/constitution.spec.md (trust implementers)
- prompts/4-evolve/ (spec evolution workflow)

**Validated by:**
- Specs average <30 lines (MSL compliance)
- Spec issues addressed at appropriate abstraction level
- Discoveries level up to appropriate spec layer or remain local

### 5. Voluntary Adoption
Developers maintain specs because they reduce cognitive load, choosing LiveSpec methodology means accepting AI-guided discipline.

**Satisfied by:**
- specs/workspace/constitution.spec.md (minimal burden, spec-first principle)
- specs/workspace/workspace-agent.spec.md (AI agents guide methodology adherence)
- specs/features/folder-structure.spec.md (clear organization)
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
- specs/workspace/context-architecture.spec.md (context tree clean evolution)
- prompts/utils/audit-workspace-specs.md (periodic consolidation)
- specs/features/session-completion.spec.md (feedback loop identifying what doesn't work)

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
- Specs contain WHAT/WHY only, never implementation HOW
- Lower layers derivable from upper layers at any time
