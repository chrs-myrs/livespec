---
derives_from:
  - PURPOSE.md
supports:
  - specs/constraints.spec.md
  - specs/strategy/architecture.spec.md
  - specs/workspace/
  - specs/prompts/
---

# LiveSpec Requirements

**Criticality**: CRITICAL
**Failure Mode**: Without clear requirements, LiveSpec lacks cohesive direction and becomes disconnected collection of features

## Specification

LiveSpec must provide methodology for bidirectional specification-code synchronization, support AI-assisted development across any agent, work for both greenfield and brownfield projects, and maintain specifications without becoming maintenance burden.

## Core Requirements

### 1. Bidirectional Synchronization
Support spec-first (design) and code-first (extraction) workflows.

**Satisfied by:**
- specs/strategy/architecture.spec.md (dogfooding section)
- specs/prompts/4a-detect-drift.spec.md (code→spec detection)
- specs/prompts/4b-extract-specs.spec.md (code→spec extraction)
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
- specs/behaviors/msl-format.spec.md (consistent format)
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
- specs/strategy/architecture.spec.md (both modes supported)

**Validated by:**
- Users adopt LiveSpec for greenfield projects
- Users adopt LiveSpec for brownfield projects
- Same methodology works for both

### 4. Minimal Maintenance
Specifications stay current without significant overhead.

**Satisfied by:**
- specs/behaviors/msl-format.spec.md (minimalism)
- specs/workspace/constitution.spec.md (trust implementers)
- prompts/4-evolve/ (continuous sync, not big-bang updates)

**Validated by:**
- Specs average <30 lines (MSL compliance)
- Phase 4 runs quickly (minutes, not hours)
- Developers voluntarily update specs

### 5. Voluntary Adoption
Developers maintain specs because they reduce cognitive load.

**Satisfied by:**
- specs/workspace/constitution.spec.md (minimal burden)
- specs/behaviors/folder-structure.spec.md (clear organization)
- All prompts/ (guided AI assistance)

**Validated by:**
- Developers continue using LiveSpec after initial setup
- No enforcement mechanisms required
- Developers report cognitive load reduction

## Validation

- All 5 core requirements satisfied by identified specs
- Traceability maintained via frontmatter dependencies
- Changes to requirements trigger cascade review of satisfying specs
