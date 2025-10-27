---
criticality: CRITICAL
failure_mode: Without structured phases, development becomes chaotic and AI agents lack clear direction
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
---

# Five Phases Behavior

## Requirements
- [!] LiveSpec guides development through exactly five phases: DEFINE, DESIGN, BUILD, VERIFY, and EVOLVE, with clear entry and exit criteria for each.
  - Each phase has 2-5 prompts (cognitive load managed)
  - Phase transitions have clear criteria
  - Phases can cycle (not strictly waterfall)
  - AI agents know which phase they're in and what to do
  - Users understand current project state

## Phases

### Phase 0: DEFINE
- **Purpose**: Establish project vision, outcomes, and constraints
- **Entry**: Project idea or existing codebase
- **Exit**: Purpose, outcomes, constraints, and workspace defined
- **Outputs**: PURPOSE.md, specs/1-requirements/strategic/outcomes.spec.md, specs/1-requirements/strategic/constraints.spec.md, specs/workspace/

### Phase 1: DESIGN
- **Purpose**: Design solution architecture
- **Entry**: Problem and constraints defined
- **Exit**: Architecture and contracts specified
- **Outputs**: specs/3-behaviors/, specs/3-contracts/ (if needed)

### Phase 2: BUILD
- **Purpose**: Implement the solution
- **Entry**: Design specifications complete
- **Exit**: Implementation matches specifications
- **Outputs**: Working code following specs

### Phase 3: VERIFY
- **Purpose**: Validate solution meets requirements
- **Entry**: Implementation complete
- **Exit**: All behaviors validated
- **Outputs**: Test results, validation reports

### Phase 4: EVOLVE
- **Purpose**: Maintain synchronisation between specs and code
- **Entry**: System in production or active development
- **Exit**: Continuous (loop back to phases as needed)
- **Outputs**: Updated specifications, extracted learnings
