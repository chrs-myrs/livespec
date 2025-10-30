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
