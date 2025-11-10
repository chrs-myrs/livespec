---
criticality: IMPORTANT
failure_mode: Without taxonomy metaspec, projects lack consistent classification guidance and agents cannot determine correct file placement
governs: All specs/workspace/taxonomy.spec.md files
---

# Project Taxonomy Metaspecification

## Requirements
- [!] Every project's taxonomy.spec.md declares three classifications to guide AI agents: Project Domain (what type of project), Workspace Scope (what's portable methodology vs product-specific content), and Specs Boundary (specs/ contains only specifications, not data/research/artifacts).
  - **Project Domain** section defines project type
    - One of: Software, Documentation, Planning, Generation, Governance, or Hybrid
    - Brief explanation of what this domain means for THIS specific project
    - Describes primary transformation pattern (e.g., "data → specifications → generated outputs")
  - **Workspace Scope** section explicitly lists workspace/ contents
    - Lists files that ARE workspace (portable methodology): constitution.spec.md, patterns.spec.md, workflows.spec.md, taxonomy.spec.md
    - Explicitly states what's NOT workspace (product-specific content) with examples
    - Includes rationale: "These are product behaviors/strategy, not portable methodology"
    - Guides agents: "Portable to any project?" test determines workspace membership
  - **Specs Boundary** section declares specs/ purity
    - Clear statement: "specs/ contains ONLY .spec.md files defining system behavior"
    - Explicit locations for non-spec content: "Source data → data/, Research → research/, Generated artifacts → [location]"
    - Rationale: "specs/ defines WHAT to do, not actual data or outputs"
  - **AI agents must** section lists agent obligations
    - Check taxonomy.spec.md FIRST before creating files
    - Verify workspace/ additions pass portability test
    - Keep data/research/outputs OUT of specs/
    - Update taxonomy when project classification changes
  - Taxonomy reviewed and updated when project fundamentals change
  - Frontmatter includes `applies_to: this_project`

## Validation

### Manual Validation
- Every LiveSpec project has specs/workspace/taxonomy.spec.md
- Taxonomy contains all four required sections (Domain, Workspace Scope, Specs Boundary, AI agents must)
- Workspace scope explicitly lists portable vs product-specific content
- Specs boundary clearly separates specifications from data/artifacts
- AI agents reference taxonomy before file creation decisions

### Automated Validation

**Taxonomy structure validation:**
```bash
bash scripts/validate-taxonomy-structure.sh
```

**Checks:**
- Presence of all four required section headings
- Reports missing sections with remediation guidance
- Blocks commit if sections missing (via pre-commit hook)

**Workspace scope audit:**
```bash
bash scripts/audit-workspace-scope.sh
```

**Checks:**
- Applies portability test to each workspace/ file
- Detects product-specific indicators (features, organization names, architecture constraints)
- Reports violations with relocation suggestions

**When to validate:**
- After Phase 0 (DEFINE) workspace setup
- Before releases (verify clean boundary)
- Monthly maintenance (prevent scope creep)
- After adding files to workspace/

**Exit codes:**
- 0 = All validations pass
- 1 = Violations detected (see output for remediation)

## Domain Classification Guidance

**Common patterns by domain type:**

**Software**: Code → Executables
- Primary: Produces software (libraries, applications, services)
- Workspace: Development methodology (how we build)
- Example: React library, API service, CLI tool

**Documentation**: Specs → Published Docs
- Primary: Documentation from specifications
- Workspace: Documentation standards
- Example: Technical documentation site

**Planning**: Research → Decisions
- Primary: Analysis and planning artifacts
- Workspace: Planning methodology
- Example: Strategic analysis, feasibility studies

**Generation**: Data → Tailored Deliverables
- Primary: Generated artifacts from data/templates
- Workspace: Generation methodology
- Example: CV generator, report builder

**Governance**: Methodology → Framework
- Primary: Portable methodologies and frameworks
- Workspace: Framework development process (demonstrates patterns)
- Example: LiveSpec itself

**Hybrid**: Multiple combined
- **Pattern A - Operational/Workspace Projects**:
  - Primary activity: Workspace operations (investigations, orchestration, protocols)
  - Secondary output: Built artifacts (agents, scripts, runbooks, documents)
  - Workspace scope split:
    - `workspace/` = What you DO (operations, protocols, methodologies)
    - `numbered specs/` = What you BUILD (artifacts from specifications)
  - Test: "Is this about HOW we operate (workspace) or WHAT we build (specs)?"
  - Example: TechOps workspace, DevOps platform

- **Pattern B - Multi-Domain Projects**:
  - Combines domains: Software + Documentation, or Software + Generation
  - Workspace: Unified development methodology
  - Specs: Organized by domain (see Multi-Domain Organization in AGENTS.md)
  - Example: SaaS product (Software) with auto-generated reports (Generation)

**When Hybrid is unclear**: Ask these questions:
1. What's the PRIMARY activity/output?
2. What's the SECONDARY activity/output?
3. Does workspace/ represent operations or development methodology?
4. Are you building artifacts FROM specs or IS the operation itself the deliverable?

**Decision priority**: Choose most specific domain if 80%+ fits. Use Hybrid only when genuinely multi-domain or operational/workspace pattern applies.

## Documentation Project Example

**Complete worked example for Documentation domain:**

### Project Structure

```
technical-docs/
├── PURPOSE.md                           # Document architecture for developers
├── AGENTS.md                            # Regenerated after workspace setup
├── .livespec/                           # Copied from livespec/dist/
│
├── specs/
│   ├── workspace/
│   │   ├── taxonomy.spec.md             # Domain: Documentation
│   │   ├── constitution.spec.md         # Spec-driven docs
│   │   ├── patterns.spec.md             # Doc conventions
│   │   └── workflows.spec.md            # Doc creation process
│   │
│   ├── 1-requirements/
│   │   └── strategic/
│   │       └── outcomes.spec.md         # Developers understand arch in 2hrs
│   │
│   ├── 2-strategy/
│   │   └── documentation-approach.spec.md  # Progressive disclosure pattern
│   │
│   └── 3-behaviors/
│       └── documentation/
│           ├── architecture-docs.spec.md   # System overview content
│           ├── api-reference.spec.md       # API doc completeness
│           └── onboarding-guide.spec.md    # Getting started content
│
└── docs/                                # Actual documentation (implementation)
    ├── architecture/
    │   ├── README.md                    # implements: specs/3-behaviors/documentation/architecture-docs.spec.md
    │   ├── overview.md
    │   └── components.md
    ├── api/
    │   └── reference.md                 # implements: specs/3-behaviors/documentation/api-reference.spec.md
    └── guides/
        └── getting-started.md           # implements: specs/3-behaviors/documentation/onboarding-guide.spec.md
```

### Example Spec: Documentation Behavior

**File**: `specs/3-behaviors/documentation/architecture-docs.spec.md`

```yaml
---
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
guided-by:
  - specs/2-strategy/documentation-approach.spec.md
specifies:
  - docs/architecture/README.md
  - docs/architecture/overview.md
  - docs/architecture/components.md
criticality: CRITICAL
failure_mode: Developers cannot understand system architecture, onboarding fails
---

# Architecture Documentation

## Requirements
- [!] Documentation enables developers to understand system architecture within 2 hours.
  - System overview with high-level components diagram
  - Component responsibilities clearly explained (1-2 paragraphs each)
  - Data flow between components visualized (Mermaid diagram)
  - Integration points documented (APIs, events, data stores)
  - No implementation details (focus on conceptual architecture)
  - Updated when architecture changes

## Validation
- New developer completes architecture comprehension in <2 hours
- All major components documented with clear responsibilities
- Data flow diagram includes all primary paths
- Integration points have complete interface descriptions
- Mermaid diagrams render correctly
- Content reviewed when architecture changes
```

### Key Patterns for Documentation Projects

**What needs specs in docs projects**:
- ✅ **Content requirements**: What docs must contain (architecture-docs.spec.md)
- ✅ **Completeness criteria**: How to know docs are sufficient (api-reference.spec.md)
- ✅ **Structure patterns**: How to organize content (documentation-approach.spec.md)
- ✅ **Update triggers**: When to refresh docs (in each behavior spec)

**What doesn't need specs**:
- ❌ Individual paragraphs or sentences (too granular)
- ❌ Exact wording (that's implementation, not requirement)
- ❌ Specific examples (unless example IS the requirement)
- ❌ Navigation structure (unless critical to UX)

**MSL in docs projects**:
- **Requirements section** = What information must docs convey
- **Validation section** = How to verify docs achieve purpose
- **Frontmatter** = Links to strategic outcomes (WHY docs exist)

**Common mistake**: Over-specifying content
```yaml
# ❌ Too specific (implementation detail)
## Requirements
- [!] Architecture section starts with "Welcome to our architecture documentation..."
  - First paragraph explains microservices
  - Second paragraph lists 15 components
  - ...

# ✅ Correct level (observable outcome)
## Requirements
- [!] Architecture documentation explains system design to new developers.
  - Component overview with responsibilities
  - Integration patterns visualized
  - Sufficient detail for onboarding
```

**Value pyramid for docs**:
```
PURPOSE.md: "Enable developer onboarding"
    ↓
1-requirements/outcomes.spec.md: "Developers understand arch in 2hrs"
    ↓
3-behaviors/architecture-docs.spec.md: "Docs contain components, data flow, integrations"
    ↓
docs/architecture/README.md: [Actual content implementing spec]
```

**Benefits of spec-driven docs**:
- Clear success criteria before writing
- Prevents scope creep (only write what's specified)
- Validates against user needs (requirements), not author assumptions
- Enables multiple writers (spec defines consistency)
- Detects drift (when docs no longer meet spec)
