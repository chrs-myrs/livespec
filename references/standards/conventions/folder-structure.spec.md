---
criticality: CRITICAL
failure_mode: Without clear folder structure, AI agents cannot find relevant context and users become confused about where to place specs
governed-by:
  - references/standards/metaspecs/base.spec.md
---

# Folder Structure Convention

## Requirements
- [!] LiveSpec projects separate workspace specifications (how to build) from product specifications (what to build) using standardized folder hierarchy with optional organizational subfolders.
  - `PURPOSE.md` at root captures project vision and success criteria (free-form, not MSL)
  - `specs/foundation/` contains top-level project definition (outcomes + constraints)
  - `specs/workspace/taxonomy.spec.md` declares project classification (domain, workspace scope, specs boundary) - **AI agents check this FIRST**
  - `specs/workspace/` contains only operating context (how agents/humans/workspace interact)
  - `specs/features/` contains observable system behaviors (user-facing)
  - `specs/strategy/` contains product-specific technical decisions and architecture
  - `specs/interfaces/` contains API/data contracts (optional, only if needed)
  - Subfolders allowed within standard folders for organization (e.g., specs/features/prompts/, specs/strategy/architecture/)
  - `specs/foundation/outcomes.spec.md` captures high-level requirements
  - `specs/foundation/constraints.spec.md` defines hard boundaries
  - LiveSpec methodology is provided by the installed Claude Code plugin (skills, agent, references/, templates/) — not copied into the project
  - `references/standards/` contains metaspecs and conventions
  - `templates/` contains workspace spec starter files and taxonomy templates
  - **Decision process**: Check taxonomy.spec.md → Apply classification rules → Use "about vs in" test if needed
  - AI agents locate context by: taxonomy (classification) → workspace (process) → behaviors (features)

## Structure

```
project/
├── PURPOSE.md              # Why this exists (vision + success criteria)
│                           # LiveSpec methodology is provided by the installed plugin (no local copy)
│
└── specs/
    ├── foundation/     # Top-level project definition
    │   ├── strategic/      # Outcomes + constraints
    │   │   ├── outcomes.spec.md
    │   │   └── constraints.spec.md
    │   └── functional/     # Feature-level requirements
    │       └── *.spec.md
    │
    ├── workspace/          # HOW you operate (operating context)
    │   ├── taxonomy.spec.md        # Project classification (check FIRST)
    │   ├── constitution.spec.md
    │   ├── patterns.spec.md
    │   └── workflows.spec.md
    │
    ├── strategy/         # HOW technically (product-specific)
    │   └── architecture.spec.md (or split files)
    │
    ├── features/        # WHAT system does (user-facing)
    │   ├── prompts/        # Organizational subfolder example
    │   │   └── *.spec.md
    │   └── *.spec.md
    │
    └── interfaces/        # API/data contracts (optional)
        └── api/v1/*.yaml
```

## Folder Organization Decision Process

**Step 0: Check Project Taxonomy (FIRST)**

Before applying any decision test, read `specs/workspace/taxonomy.spec.md`:
- Declares **Project Domain** (Software, Generation, Planning, Documentation, Governance, Hybrid)
- Lists **Workspace Scope** explicitly (what's operating context vs deliverable)
- Defines **Specs Boundary** ("specs/ = specifications only", no data/research/artifacts)

**If taxonomy unclear or conflicts with intended action, update taxonomy first.**

**Step 1: Apply Classification from Taxonomy**
- Domain informs context (e.g., Generation projects have data/ → specs/ → generated/ pattern)
- Workspace scope explicitly lists what belongs in workspace/ (check against taxonomy)
- Specs boundary prevents data/research from entering specs/ folder

**Step 2: Use "About vs In" Test (If Still Unclear)**
- "Is this ABOUT the workspace or IN the workspace?" → ABOUT = workspace/, IN = behaviors/strategy/
- Examples: constitution (ABOUT), job-applications (IN), patterns (ABOUT), api-design (IN)

## Notes

See individual metaspecs for what belongs in each folder:
- `references/standards/metaspecs/taxonomy.spec.md` - Project classification rules (**check first**)
- `references/standards/metaspecs/purpose.spec.md` - Purpose document rules
- `references/standards/metaspecs/outcomes.spec.md` - Outcomes (high-level requirements) rules
- `references/standards/metaspecs/constraints.spec.md` - Constraints rules
- `references/standards/metaspecs/workspace.spec.md` - Workspace rules
- `references/standards/metaspecs/behavior.spec.md` - Behavior rules
- `references/standards/metaspecs/strategy.spec.md` - Strategy rules
- `references/standards/metaspecs/contract.spec.md` - Contract rules
