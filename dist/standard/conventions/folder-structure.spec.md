---
criticality: CRITICAL
failure_mode: Without clear folder structure, AI agents cannot find relevant context and users become confused about where to place specs
governed-by:
  - .livespec/standard/metaspecs/base.spec.md
---

# Folder Structure Convention

## Requirements
- [!] LiveSpec projects separate workspace specifications (how to build) from product specifications (what to build) using standardized folder hierarchy with optional organizational subfolders.
  - `PURPOSE.md` at root captures project vision and success criteria (free-form, not MSL)
  - `specs/1-requirements/strategic/` contains top-level project definition (outcomes + constraints)
  - `specs/workspace/taxonomy.spec.md` declares project classification (domain, workspace scope, specs boundary) - **AI agents check this FIRST**
  - `specs/workspace/` contains only development methodology (portable to any project)
  - `specs/3-behaviors/` contains observable system behaviors (user-facing)
  - `specs/2-strategy/` contains product-specific technical decisions and architecture
  - `specs/3-contracts/` contains API/data contracts (optional, only if needed)
  - Subfolders allowed within standard folders for organization (e.g., specs/3-behaviors/prompts/, specs/2-strategy/architecture/)
  - `specs/1-requirements/strategic/outcomes.spec.md` captures high-level requirements
  - `specs/1-requirements/strategic/constraints.spec.md` defines hard boundaries
  - `.livespec/` contains LiveSpec methodology (copied from LiveSpec dist/)
  - `.livespec/standard/` contains metaspecs and conventions
  - `.livespec/templates/` contains workspace spec starter files and taxonomy templates
  - **Decision process**: Check taxonomy.spec.md → Apply classification rules → Use portability test if needed
  - AI agents locate context by: taxonomy (classification) → workspace (process) → behaviors (features)

## Structure

```
project/
├── PURPOSE.md              # Why this exists (vision + success criteria)
│
├── .livespec/              # LiveSpec methodology
│   ├── prompts/
│   │   ├── 0-define/
│   │   ├── 1-design/
│   │   ├── 2-build/
│   │   ├── 3-verify/
│   │   ├── 4-evolve/
│   │   └── utils/
│   ├── standard/           # Metaspecs and conventions
│   │   ├── metaspecs/
│   │   └── conventions/
│   └── templates/          # Spec starter files
│       ├── requirements/
│       └── workspace/
│
└── specs/
    ├── 1-requirements/     # Top-level project definition
    │   ├── strategic/      # Outcomes + constraints
    │   │   ├── outcomes.spec.md
    │   │   └── constraints.spec.md
    │   └── functional/     # Feature-level requirements
    │       └── *.spec.md
    │
    ├── workspace/          # HOW you build (portable process)
    │   ├── taxonomy.spec.md        # Project classification (check FIRST)
    │   ├── constitution.spec.md
    │   ├── patterns.spec.md
    │   └── workflows.spec.md
    │
    ├── 2-strategy/         # HOW technically (product-specific)
    │   └── architecture.spec.md (or split files)
    │
    ├── 3-behaviors/        # WHAT system does (user-facing)
    │   ├── prompts/        # Organizational subfolder example
    │   │   └── *.spec.md
    │   └── *.spec.md
    │
    └── 3-contracts/        # API/data contracts (optional)
        └── api/v1/*.yaml
```

## Folder Organization Decision Process

**Step 0: Check Project Taxonomy (FIRST)**

Before applying any decision test, read `specs/workspace/taxonomy.spec.md`:
- Declares **Project Domain** (Software, Generation, Planning, Documentation, Governance, Hybrid)
- Lists **Workspace Scope** explicitly (what's portable vs product-specific)
- Defines **Specs Boundary** ("specs/ = specifications only", no data/research/artifacts)

**If taxonomy unclear or conflicts with intended action, update taxonomy first.**

**Step 1: Apply Classification from Taxonomy**
- Domain informs context (e.g., Generation projects have data/ → specs/ → generated/ pattern)
- Workspace scope explicitly lists what belongs in workspace/ (check against taxonomy)
- Specs boundary prevents data/research from entering specs/ folder

**Step 2: Use Portability Test (If Still Unclear)**
- "Could I copy this exact spec to a different project?" → YES = workspace/, NO = behaviors/strategy/
- Examples: constitution (YES), job-applications (NO), patterns (YES), api-design (NO)

## Notes

See individual metaspecs for what belongs in each folder:
- `.livespec/standard/metaspecs/taxonomy.spec.md` - Project classification rules (**check first**)
- `.livespec/standard/metaspecs/purpose.spec.md` - Purpose document rules
- `.livespec/standard/metaspecs/outcomes.spec.md` - Outcomes (high-level requirements) rules
- `.livespec/standard/metaspecs/constraints.spec.md` - Constraints rules
- `.livespec/standard/metaspecs/workspace.spec.md` - Workspace rules
- `.livespec/standard/metaspecs/behavior.spec.md` - Behavior rules
- `.livespec/standard/metaspecs/strategy.spec.md` - Strategy rules
- `.livespec/standard/metaspecs/contract.spec.md` - Contract rules
