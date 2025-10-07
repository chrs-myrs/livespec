---
criticality: CRITICAL
failure_mode: Without clear folder structure, AI agents cannot find relevant context and users become confused about where to place specs
constrained_by:
  - .livespec/specs/metaspecs/base.spec.md
---

# Folder Structure Convention

## Requirements
- [!] LiveSpec projects separate workspace specifications (how to build) from product specifications (what to build) using standardized folder hierarchy.
  - `specs/workspace/` contains only development methodology (portable to any project)
  - `specs/behaviors/` contains observable system behaviors (user-facing)
  - `specs/strategy/` contains product-specific technical decisions and architecture
  - `specs/contracts/` contains API/data contracts (optional, only if needed)
  - `specs/requirements.spec.md` at root captures high-level requirements
  - `specs/constraints.spec.md` at root defines hard boundaries
  - `.livespec/` (or `prompts/`) contains LiveSpec methodology (copied from LiveSpec project)
  - `.livespec/specs/` contains metaspecs and conventions (validation rules)
  - Decision test: "Could I copy this spec to different project?" YES = workspace/, NO = behaviors/strategy/
  - AI agents can locate relevant context by folder (workspace for process, behaviors for features)

## Structure

```
project/
├── PURPOSE.md              # Why this exists
├── .livespec/              # LiveSpec methodology (symlink to prompts/)
│   ├── prompts/            # Phase-based prompts
│   ├── specs/              # Metaspecs and conventions
│   └── templates/          # Workspace templates
│
└── specs/
    ├── workspace/          # HOW you build (portable process)
    │   ├── constitution.spec.md
    │   ├── patterns.spec.md
    │   └── workflows.spec.md
    │
    ├── behaviors/          # WHAT system does (user-facing)
    │   └── *.spec.md
    │
    ├── strategy/           # HOW technically (product-specific)
    │   └── architecture.spec.md (or split files)
    │
    ├── contracts/          # API/data contracts (optional)
    │   └── api/v1/*.yaml
    │
    ├── requirements.spec.md  # High-level requirements
    └── constraints.spec.md   # Hard boundaries
```

## Notes

See individual metaspecs for what belongs in each folder:
- `.livespec/specs/metaspecs/workspace.spec.md` - Workspace rules
- `.livespec/specs/metaspecs/behavior.spec.md` - Behavior rules
- `.livespec/specs/metaspecs/strategy.spec.md` - Strategy rules
- `.livespec/specs/metaspecs/requirements.spec.md` - Requirements rules
- `.livespec/specs/metaspecs/constraints.spec.md` - Constraints rules
- `.livespec/specs/metaspecs/contract.spec.md` - Contract rules
