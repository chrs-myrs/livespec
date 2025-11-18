---
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md (Requirement 5: Voluntary Adoption)
applies_to:
  - all_projects
criticality: IMPORTANT
failure_mode: Files placed in wrong locations cause organizational confusion and violate portability principles
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
  - workspace/ contains portable methodology only
  - strategy/ contains product-specific technical decisions
  - behaviors/ contains observable system outcomes
  - contracts/ contains interface definitions

## Folder Structure

### specs/workspace/ - Development Process (Portable)
**Contains:** How we develop ANY project using LiveSpec methodology

**Examples:**
- constitution.spec.md - Governance (MSL minimalism, dogfooding)
- patterns.spec.md - Conventions (naming, format, structure)
- workflows.spec.md - Process (when phases run, how to evolve)
- taxonomy.spec.md - Project classification (domain, scope, boundaries)

**Test:** "Could I copy this spec to a different project?" → YES = workspace

### specs/1-requirements/ - Strategic and Functional Requirements
**Contains:** WHY and high-level/specific requirements

**Subdirectories:**
- strategic/ - High-level outcomes and constraints (outcomes.spec.md, constraints.spec.md)
- functional/ - Specific feature requirements

### specs/2-strategy/ - Technical Approach (Product-Specific)
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

### specs/3-behaviors/ - Observable Outcomes
**Contains:** What the system must do (user-facing behaviors)

**Subfolders by domain:**
- Software: user-features/, system/, integrations/
- Governance: policies/, prompts/, processes/
- Planning: features/, milestones/
- Generation: outputs/, transformations/

### specs/3-contracts/ - Interface Definitions
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

## Folder Organization Decision Tests

**Step 0: Check Project Taxonomy (FIRST)**
Before applying any decision test, read `specs/workspace/taxonomy.spec.md`:
- Declares Project Domain (affects interpretation of patterns)
- Lists Workspace Scope explicitly (portable vs product-specific)
- Defines Specs Boundary (no data/research in specs/)

**workspace/ test:** "Could I copy this spec to ANY project?"
- YES → workspace/ (portable process)
- NO → Check 1-requirements/, 2-strategy/, or 3-behaviors/

**1-requirements/ test:** "Is this a strategic outcome or hard constraint?"
- YES, strategic → 1-requirements/strategic/ (outcomes, constraints)
- YES, functional → 1-requirements/functional/ (specific feature requirements)
- NO → Check 2-strategy/ or 3-behaviors/

**2-strategy/ test:** "Does this apply across the whole product?"
- YES → 2-strategy/ (cross-cutting technical decision)
- NO → Check 3-behaviors/

**3-behaviors/ test:** "Is this an observable outcome users/system must exhibit?"
- YES → 3-behaviors/ (what system does)
- NO → Re-examine classification

**Common Mistakes:**
- ❌ "API returns JSON" → NOT workspace (product-specific) → 2-strategy/
- ❌ "Use 4-space indentation" → NOT 2-strategy/ (not critical) → workspace/ (if it matters)
- ❌ "System authenticates users" → NOT 2-strategy/ (observable) → 3-behaviors/

**Correct Examples:**
- ✅ "Use MSL format for all specs" → workspace/patterns.spec.md (applies to any project)
- ✅ "API responses must be JSON" → 2-strategy/architecture.spec.md (product-wide decision)
- ✅ "System authenticates users via OAuth" → 3-behaviors/authentication.spec.md (observable outcome)

## Multi-Domain Organization

**Key insight:** behaviors/ and contracts/ abstractions work across ALL domains. Use subfolders for semantic organization.

### Domain-Agnostic Abstractions

**behaviors/** = Observable outcomes from any perspective:
- Software: "System authenticates users"
- Governance: "Only authorized entities access resources" (policy)
- Operations: "Backups complete daily" (service)
- Planning: "Feature meets success criteria" (requirement)

**contracts/** = Interface definitions of any kind:
- Software: API contracts (`GET /users/{id}`)
- Governance: Process contracts (procedures)
- Operations: Operational contracts (runbooks)
- Planning: Workflow contracts (delivery processes)

### Organization Patterns by Domain

**Software projects:**
```
specs/
├── workspace/           # How we work
├── 1-requirements/      # Strategic and functional requirements
├── 2-strategy/          # Cross-cutting decisions
├── 3-behaviors/
│   ├── user-features/  # User-facing behaviors
│   └── system/         # System behaviors
└── 3-contracts/
    └── api/v1/         # API contracts
```

**Governance projects (like LiveSpec):**
```
specs/
├── workspace/           # How we work
├── 1-requirements/      # Strategic and functional requirements
├── 2-strategy/          # Cross-cutting decisions
├── 3-behaviors/
│   ├── prompts/        # Prompt behaviors
│   └── processes/      # Process behaviors
└── 3-contracts/
    └── schemas/        # Data format contracts
```

**Hybrid projects:**
```
specs/
├── workspace/             # How we work
├── 1-requirements/        # Strategic and functional requirements
├── 2-strategy/            # Cross-cutting (all domains)
├── 3-behaviors/
│   ├── user-features/    # Software
│   ├── policies/         # Governance
│   └── services/         # Operations
└── 3-contracts/
    ├── api/              # Software
    ├── procedures/       # Governance
    └── runbooks/         # Operations
```

## Meta-Process Specs Location

**When specs govern creation of documentation (not system behavior):**

Place in `specs/3-behaviors/processes/[process].spec.md`

**Examples:**
- `specs/3-behaviors/processes/investigation.spec.md` - How to document investigations
- `specs/3-behaviors/processes/refactoring.spec.md` - How to document refactoring decisions
- `specs/3-behaviors/processes/incident.spec.md` - How to document production incidents

**Template:** Use `dist/templates/processes/meta-process.spec.md.template`

**Pattern:**
- Spec defines requirements for ALL instances
- Instances (e.g., `investigations/001-problem.md`) conform to spec
- Instances are governed documentation, not specs themselves

## Validation
- Taxonomy exists and checked first for all file placement decisions
- workspace/ contains only portable methodology (passes copy test)
- strategy/ contains only product-specific decisions (fails copy test)
- behaviors/ contains only observable outcomes
- contracts/ contains only interface definitions
- knowledge/ contains only reference material (not specs)
- AI agents verify placement using decision tests
- Cross-references maintained when files move
