---
description: Incubate and birth child projects from within a parent livespec project
routes-to: skills/birth/SKILL.md
---

# LiveSpec Birth

Incubate child projects in `offspring/` and birth them into standalone repositories when ready.

## Usage

```
/livespec:birth                    # Interactive - choose incubate or birth
/livespec:birth new <name>         # Incubate a new project in offspring/<name>/
/livespec:birth <name>             # Birth offspring/<name>/ to standalone repo
```

## Examples

```
/livespec:birth                    # "What would you like to do?"
/livespec:birth new payment-api    # Creates offspring/payment-api/ with full LiveSpec structure
/livespec:birth payment-api        # Extracts offspring/payment-api/ to a new git repo
```

## Workflow

### Incubate → Birth cycle

```
1. /livespec:birth new my-project
   → Creates offspring/my-project/
   → Full specs/ hierarchy + PURPOSE.md

2. [Draft specs in offspring/my-project/specs/features/]

3. /livespec:birth my-project
   → Copies to destination
   → git init + initial commit
   → Optionally removes offspring/my-project/
```

### What offspring contains

Each incubated project gets the same structure as `/livespec:init`:

```
offspring/my-project/
├── PURPOSE.md
└── specs/
    ├── workspace/
    │   ├── constitution.spec.md
    │   └── taxonomy.spec.md
    ├── foundation/
    ├── strategy/
    ├── features/
    └── interfaces/
```
