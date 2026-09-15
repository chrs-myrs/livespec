---
type: constraints
category: foundation
fidelity: behavioral
criticality: CRITICAL
failure_mode: Violating these constraints makes LiveSpec unusable or defeats its purpose
governed-by: []
derives-from:
  - PURPOSE.md
  - specs/foundation/outcomes.spec.md
supports:
  - specs/strategy/architecture.spec.md
---

# LiveSpec Constraints

## Requirements
- [!] LiveSpec must operate within eight critical boundaries:
  - Projects are workable by any AI agent (agent agnostic)
  - Project work never requires the authoring toolchain (toolchain independence)
  - A project's behaviour changes only by deliberate acceptance (no action at a distance)
  - All specs follow 4-section MSL format (MSL minimalism)
  - All content is standard markdown in standard folders (no lock-in)
  - Every spec has testable validation criteria (testable behaviors)
  - Specifications are durable assets that define the system (spec durability)
  - Specs contain WHAT/WHY only, never implementation HOW (abstraction purity)

## Agent Agnostic

The claim applies to projects, not to the authoring toolchain. Conflating the two
makes the constraint untestable and, in practice, false.

| Layer | Covers | Harness coupling |
|-------|--------|------------------|
| Authoring toolchain | init, workspace design, audit | May be harness-specific |
| Project artefacts | PURPOSE.md, specs/, AGENTS.md, ctxt/ | Must be harness-neutral |

**Validation criteria:**
- A project can be implemented, reviewed and delivered by an agent with no LiveSpec tooling installed
- Project artefacts are standard markdown carrying no tool-specific syntax
- No project artefact references a path that exists only inside a plugin cache
- Slash commands are optional convenience for project work, never a requirement
- Generated AGENTS.md is self-sufficient for the 80% case without fetching toolchain files

### Toolchain Independence
The authoring toolchain enhances LiveSpec work. It is never a hard dependency for
building a project's deliverables.

**Validation criteria:**
- Removing the toolchain leaves the project buildable
- No generated project file instructs the reader to run a command the project does not ship
- Every path referenced by a project artefact resolves within that project

### No Action at a Distance
A project's behaviour is a function of what it has accepted, never of what its
toolchain happens to be today. Updating LiveSpec must not change how an existing
project behaves until that project deliberately accepts the change.

**Validation criteria:**
- Conventions a project depends on exist as local files within that project
- Each vendored convention records its source, version and content hash
- Upgrades present changes for explicit acceptance and never apply silently
- No project spec resolves through a version-pinned or machine-local path

### MSL Minimalism
All specifications follow MSL principles. Specifications cannot be further reduced without losing essential information.

### No Framework Lock-in
Pure information architecture with no proprietary formats. Specs are readable markdown, folder structure is standard, no custom parsers required.

### Testable Behaviors
All behaviors must be observable and verifiable. Every specification includes concrete validation criteria.

### Spec Durability
Specifications are durable assets that define the system. Upper layers (purpose, requirements, strategy) are most durable; lower layers are derived. Essential knowledge lives in specs.

**Validation criteria:**
- Specs contain no implementation details
- Discoveries level up to appropriate spec layer or remain local
- Spec hierarchy maintains clear abstraction levels
- Technical debt cannot accumulate in spec layers

### Abstraction Purity
Specifications contain WHAT and WHY, never implementation HOW. Implementation details pollute specs and prevent clean regeneration.

**Validation criteria:**
- No technology choices in behavior specs (unless strategic)
- No performance tuning numbers in specs
- No syntax patterns or idioms in specs
- Qualitative descriptions preferred over quantitative implementation details

## Validation

- Projects are workable by any AI agent (agent agnostic)
- Project work never requires the authoring toolchain (toolchain independence)
- Project behaviour changes only by deliberate acceptance (no action at a distance)
- All specs follow 4-section MSL format (MSL minimalism)
- All content is standard markdown in standard folders (no lock-in)
- Every spec has testable validation criteria (testable behaviors)
- Specifications are durable assets that define the system (spec durability)
- Specs contain WHAT/WHY only, never implementation HOW (abstraction purity)
