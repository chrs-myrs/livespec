---
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement 5: Voluntary Adoption)
applies_to:
  - all_projects
criticality: IMPORTANT
failure_mode: Files placed in wrong locations cause organizational confusion and blur workspace vs deliverable boundaries
governed-by:
  - .livespec/standard/metaspecs/workspace.spec.md
derives-from:
  - specs/workspace/patterns.spec.md
---

# Folder Organization Patterns

## Requirements
- [!] LiveSpec projects organize specifications by abstraction level with taxonomy as PRIMARY reference checked first, then decision tests applied based on project domain.
  - **PRIMARY REFERENCE**: `specs/workspace/taxonomy.spec.md` defines project-specific classification
  - AI agents check taxonomy FIRST before applying decision tests
  - Taxonomy declares: Project Domain, Workspace Scope, Specs Boundary
  - Decision tests verify correct placement based on domain
  - All .spec.md files go in specs/ (no data/research/artifacts)
  - workspace/ contains operating context (how agents/humans/workspace interact)
  - strategy/ contains product-specific technical decisions
  - behaviors/ contains observable system outcomes
  - contracts/ contains interface definitions

## Folder Structure

### specs/workspace/ - Operating Context
**Contains:** How agents, humans, and the workspace interact for THIS project

**Examples:**
- constitution.spec.md - Governance (MSL minimalism, dogfooding)
- patterns.spec.md - Conventions (naming, format, structure)
- workflows.spec.md - Process (when phases run, how to evolve)
- taxonomy.spec.md - Project classification (domain, scope, boundaries)

**Test:** "Is this ABOUT the workspace or IN the workspace?" → ABOUT = workspace

### specs/foundation/ - Strategic Requirements
**Contains:** WHY - high-level outcomes and hard constraints

**Examples:**
- outcomes.spec.md - High-level goals (mission-level)
- constraints.spec.md - Non-negotiable boundaries

### specs/strategy/ - Technical Approach (Product-Specific)
**Contains:** How we solve THIS SPECIFIC problem technically

**Examples:**
- architecture.spec.md - System structure, components, approach
- [For complex projects, can split into]:
  - integration.spec.md - APIs, messaging, service communication
  - data.spec.md - Storage, caching, data flow
  - security.spec.md - Authentication, authorization, encryption
  - deployment.spec.md - Infrastructure, CI/CD, environments

**Test:** "Is this a product-specific technical decision?" → YES = strategy

**Scaling guidance:**
- Simple projects: Single `strategy/architecture.spec.md` file
- When architecture.spec.md exceeds ~100 lines: Split by concern
- Each strategy file stays minimal (<50 lines per MSL)

### specs/features/ - Observable Outcomes
**Contains:** What the system must do (user-facing behaviors)

**Subfolders by domain:**
- Software: user-features/, system/, integrations/
- Governance: policies/, prompts/, processes/
- Planning: features/, milestones/
- Generation: outputs/, transformations/

### specs/interfaces/ - Interface Definitions
**Contains:** API contracts, data formats (YAML, JSON, OpenAPI)

**Examples:**
- API contracts: api/v1/users.spec.md
- Data contracts: schemas/user-profile.spec.md

### knowledge/ - Reference Material (Optional)
**Contains:** Integration notes, external documentation links, imported specs

**Purpose:** Consolidate reference material that doesn't belong in specifications

**Examples:**
- knowledge/integrations/auth0-notes.md - Integration discoveries, links to Auth0 docs
- knowledge/integrations/stripe-api.yaml - Imported OpenAPI spec (if needed for code generation)
- knowledge/research/ - Dependency evaluation research

**When to use:**
- Need to keep integration notes or research findings
- Want to import external OpenAPI specs for tooling
- External documentation scattered, need consolidated references

**Test:** "Is this information discoverable elsewhere?" → NO = knowledge/

**Note:** knowledge/ is NOT specifications - contains references, notes, imports. Not part of requirements.

### docs/registries/ - Registry Data (Project-Specific)
**Contains:** Actual registry entries (gaps, issues, improvements) for this project

**Examples:**
- docs/registries/gaps.md - Methodology gaps identified
- docs/registries/issues.md - Problems encountered
- docs/registries/improvements.md - Changes tried and results

**Three-layer pattern:**
- Format specs: `.livespec/standard/registries/*.spec.md` (defines entry structure)
- Data files: `docs/registries/*.md` (project-specific entries)
- Governance: `specs/artifacts/registries/registry-specs.spec.md` (governs format specs)

**Test:** "Is this operational record data (not a specification)?" → YES = docs/registries/

**Note:** Registry DATA is not distributed. Each project maintains its own registries following the format specs from `.livespec/standard/registries/`.

## Folder Organization Decision Tests

**Step 0: Check Project Taxonomy (FIRST)**
Before applying any decision test, read `specs/workspace/taxonomy.spec.md`:
- Declares Project Domain (affects interpretation of patterns)
- Lists Workspace Scope explicitly (what's operating context vs deliverable)
- Defines Specs Boundary (no data/research in specs/)

**workspace/ test:** "Is this ABOUT the workspace or IN the workspace?"
- ABOUT (operating context) → workspace/
- IN (deliverable) → Check foundation/, strategy/, or features/

**foundation/ test:** "Is this a strategic outcome or hard constraint?"
- YES → foundation/ (outcomes, constraints)
- NO → Check strategy/ or features/

**strategy/ test:** "Does this apply across the whole product?"
- YES → strategy/ (cross-cutting technical decision)
- NO → Check features/

**features/ test:** "Is this an observable outcome users/system must exhibit?"
- YES → features/ (what system does)
- NO → Re-examine classification

**Common Mistakes:**
- ❌ "API returns JSON" → NOT workspace (product deliverable) → strategy/
- ❌ "Use 4-space indentation" → NOT strategy/ (operating convention) → workspace/ (if it matters)
- ❌ "System authenticates users" → NOT strategy/ (observable) → features/

**Correct Examples:**
- ✅ "Use MSL format for all specs" → workspace/patterns.spec.md (operating context)
- ✅ "API responses must be JSON" → strategy/architecture.spec.md (product-wide decision)
- ✅ "System authenticates users via OAuth" → features/authentication.spec.md (observable outcome)

## Multi-Domain Organization

**Key insight:** features/ and interfaces/ abstractions work across ALL domains. Use subfolders for semantic organization.

### Domain-Agnostic Abstractions

**features/** = Observable outcomes from any perspective:
- Software: "System authenticates users"
- Governance: "Only authorized entities access resources" (policy)
- Operations: "Backups complete daily" (service)
- Planning: "Feature meets success criteria" (requirement)

**interfaces/** = Interface definitions of any kind:
- Software: API contracts (`GET /users/{id}`)
- Governance: Process contracts (procedures)
- Operations: Operational contracts (runbooks)
- Planning: Workflow contracts (delivery processes)

### Organization Patterns by Domain

**Software projects:**
```
specs/
├── workspace/           # How we work
├── foundation/          # Strategic outcomes and constraints
├── strategy/            # Cross-cutting decisions
├── features/
│   ├── user-features/  # User-facing behaviors
│   └── system/         # System behaviors
└── interfaces/
    └── api/v1/         # API contracts
```

**Governance projects (like LiveSpec):**
```
specs/
├── workspace/           # How we work
├── foundation/          # Strategic outcomes and constraints
├── strategy/            # Cross-cutting decisions
├── features/
│   ├── prompts/        # Prompt behaviors
│   └── processes/      # Process behaviors
└── interfaces/
    └── schemas/        # Data format contracts
```

**Hybrid projects:**
```
specs/
├── workspace/             # How we work
├── foundation/            # Strategic outcomes and constraints
├── strategy/              # Cross-cutting (all domains)
├── features/
│   ├── user-features/    # Software
│   ├── policies/         # Governance
│   └── services/         # Operations
└── interfaces/
    ├── api/              # Software
    ├── procedures/       # Governance
    └── runbooks/         # Operations
```

## Meta-Process Specs Location

**When specs govern creation of documentation (not system behavior):**

Place in `specs/features/processes/[process].spec.md`

**Examples:**
- `specs/features/processes/investigation.spec.md` - How to document investigations
- `specs/features/processes/refactoring.spec.md` - How to document refactoring decisions
- `specs/features/processes/incident.spec.md` - How to document production incidents

**Template:** Use `dist/templates/processes/meta-process.spec.md.template`

**Pattern:**
- Spec defines requirements for ALL instances
- Instances (e.g., `investigations/001-problem.md`) conform to spec
- Instances are governed documentation, not specs themselves

## Validation
- Taxonomy exists and checked first for all file placement decisions
- workspace/ contains only operating context (passes "about vs in" test)
- strategy/ contains only product-specific decisions
- behaviors/ contains only observable outcomes
- contracts/ contains only interface definitions
- knowledge/ contains only reference material (not specs)
- AI agents verify placement using decision tests
- Cross-references maintained when files move
