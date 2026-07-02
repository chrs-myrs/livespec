---
description: Initialize project for LiveSpec methodology
routes-to: skills/init/SKILL.md
---

# Init

Initialize a new project with LiveSpec folder structure and workspace specifications.

## Usage

```
/livespec:init           # Quick setup with defaults (recommended)
/livespec:init full      # Full customization with questions
```

## What It Creates

### Folder Structure

```
specs/
├── workspace/     # How we work (process, conventions)
├── foundation/    # Outcomes and constraints
├── strategy/      # Architectural decisions
├── features/      # Observable behaviors
└── interfaces/    # API/data contracts
```

### Files

- `PURPOSE.md` - Project purpose and success criteria
- `specs/workspace/constitution.spec.md` - Methodology enforcement rules
- `specs/workspace/taxonomy.spec.md` - Project classification

## Quick vs Full

**Quick (default):**
- Creates standard folder structure
- Asks only for project purpose
- Uses sensible defaults

**Full:**
- All of quick setup
- Asks about project domain (software/governance/operations)
- Asks about context compression level
- Asks about TDD discipline
- Customizes workspace specs based on answers

## After Initialization

```
/livespec:design feature <name>  # Create feature with spec-first
/livespec:audit context         # Generate AGENTS.md (optional)
```

## See Also

- `/livespec:design` - Create and refine specifications
- `/livespec:audit` - Health checks and context generation
