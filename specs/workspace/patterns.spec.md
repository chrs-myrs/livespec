# LiveSpec Development Patterns

**Criticality**: IMPORTANT
**Failure Mode**: Inconsistent patterns make LiveSpec harder to understand and maintain

## Specification

LiveSpec follows strict patterns: MSL format for all specs (.spec.md extension with four sections), British English for user docs, phase-letter naming for prompts (0a-), one spec per behavior, workspace/strategy separation in folder structure, and YAML frontmatter declaring specification dependencies.

## Folder Organization

### specs/workspace/ - Development Process (Portable)
**Contains:** How we develop ANY project using LiveSpec methodology

**Examples:**
- constitution.spec.md - Governance (MSL minimalism, dogfooding)
- patterns.spec.md - Conventions (naming, format, structure)
- workflows.spec.md - Process (when phases run, how to evolve)

**Test:** "Could I copy this spec to a different project?" → YES = workspace

### specs/strategy/ - Technical Approach (Product-Specific)
**Contains:** How we solve THIS SPECIFIC problem technically

**Examples:**
- architecture.spec.md - System structure, components, approach
- [For complex projects, can split into]:
  - integration.spec.md - APIs, messaging, service communication
  - data.spec.md - Storage, caching, data flow
  - security.spec.md - Authentication, authorization, encryption
  - deployment.spec.md - Infrastructure, CI/CD, environments

**Test:** "Could I copy this spec to a different project?" → NO = strategy

**Scaling guidance:**
- Simple projects: Single `strategy/architecture.spec.md` file
- When architecture.spec.md exceeds ~100 lines: Split by concern
- Each strategy file stays minimal (<50 lines per MSL)

### specs/behaviors/ - Observable Outcomes
**Contains:** What the system must do (user-facing behaviors)

### specs/contracts/ - Interface Definitions
**Contains:** API contracts, data formats (YAML, JSON, OpenAPI)

## Specification Patterns

### MSL Format
- All specs use .spec.md extension with four sections
- Criticality (CRITICAL/IMPORTANT), Failure Mode, Specification, Validation

### Naming Conventions
- Prompts: [0-4][a-z]-descriptive-name.md (e.g., 1a-design-architecture.md)
- Specs: descriptive-name.spec.md (matches prompt or behavior)
- British English for user documentation (synchronisation, behaviour)
- American English for code elements

### Dependency Traceability
Specifications declare dependencies via YAML frontmatter:
- `derives_from` - Parent specs this is based on
- `constrained_by` - Boundaries this must respect
- `satisfies` - Requirements this fulfills
- `supports` - What this spec enables
- `applies_to` - Scope (for workspace specs)

## Validation

- All .spec.md files pass MSL format validation
- Documentation uses British spellings (synchronisation, behaviour)
- Prompt files follow [0-4][a-z]-*.md pattern
- Each behavior has single dedicated spec file
- specs/workspace/ contains only portable development methodology
- specs/strategy/ contains only product-specific technical decisions
- Specifications declare dependencies via YAML frontmatter
- Strategy files stay minimal (single file <100 lines, split files <50 lines each)
- AGENTS.md references specs/workspace/agents.spec.md in frontmatter
- Agent integration behaviors defined in specs/workspace/livespec.spec.md
- Regeneration prompt exists at prompts/4-evolve/4d-regenerate-agents.md
