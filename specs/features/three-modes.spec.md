---
type: behavior
category: features
fidelity: behavioral
criticality: CRITICAL
failure_mode: Without structured modes, spec development becomes chaotic and AI agents lack clear direction
governed-by: []
satisfies: []
guided-by: []
updated-by:
  - specs/features/ambient-architecture.spec.md (Simplified Skill Set)
---

# Three Modes Behavior

## Status

**Updated to align with ambient architecture skill set.**

The conceptual modes remain valid but are now implemented through skills:
- DEFINE → `/livespec:init` (bootstrap) + `/livespec:go` (router)
- DESIGN → `/livespec:design` (guided spec creation)
- EVOLVE → `/livespec:audit` (health) + `/livespec:learn` (capture)

## Requirements

- [!] LiveSpec guides spec development through three conceptual modes, implemented via skills with clear purposes
  - Modes represent project lifecycle phases, not separate tools
  - Skills implement mode behaviors (one skill may span modes)
  - Mode transitions happen naturally as project evolves
  - AI agents understand current project state and appropriate actions
  - Users guided via `/livespec:go` router when uncertain

## Modes and Implementing Skills

### Mode 0: DEFINE (Bootstrap)
- **Purpose**: Establish project vision, outcomes, and constraints
- **Entry**: Project idea or existing codebase
- **Exit**: Purpose, outcomes, constraints, and workspace defined
- **Implementing Skills**:
  - `/livespec:init` - Creates scaffold, generates context
  - `/livespec:go` - Routes user to init if project uninitialized
- **Outputs**: PURPOSE.md, specs/foundation/, specs/workspace/, CLAUDE.md, AGENTS.md

### Mode 1: DESIGN (Specification)
- **Purpose**: Design spec architecture and behaviors
- **Entry**: Problem and constraints defined
- **Exit**: Architecture and behaviors specified
- **Implementing Skills**:
  - `/livespec:design` - Guided spec creation/refinement
  - Ambient behavior - Auto-creates specs before implementation
- **Outputs**: specs/features/, specs/interfaces/, specs/strategy/

### Mode 2: EVOLVE (Maintenance)
- **Purpose**: Maintain spec health, detect drift, extract learnings
- **Entry**: System in production or active development
- **Exit**: Continuous (loop back to modes as needed)
- **Implementing Skills**:
  - `/livespec:audit` - Health checks, drift detection
  - `/livespec:learn` - Capture session learnings, update specs
- **Outputs**: Updated specifications, health reports, extracted patterns

## Mode Transitions

| From | To | Trigger |
|------|-----|---------|
| None | DEFINE | New project, `/livespec:init` |
| DEFINE | DESIGN | Foundation specs complete |
| DESIGN | EVOLVE | Feature specs complete, implementation begins |
| EVOLVE | DESIGN | New feature needed |
| EVOLVE | DEFINE | Significant scope change |

## Validation

- [ ] `/livespec:go` correctly identifies project mode
- [ ] Skills implement their designated mode behaviors
- [ ] Mode transitions are clear to users
- [ ] Ambient behavior works across all modes
