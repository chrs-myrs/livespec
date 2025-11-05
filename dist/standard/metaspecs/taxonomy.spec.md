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
- Every LiveSpec project has specs/workspace/taxonomy.spec.md
- Taxonomy contains all three required classifications (Domain, Workspace Scope, Specs Boundary)
- Workspace scope explicitly lists portable vs product-specific content
- Specs boundary clearly separates specifications from data/artifacts
- AI agents reference taxonomy before file creation decisions

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
