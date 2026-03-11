---
description: Create and refine specifications (Phase 0 + Phase 1)
---

# Design

Unified command for all spec creation and refinement work. Handles problem definition (Phase 0) and solution design (Phase 1).

## Usage

```
/livespec:design                     # Interactive mode selection
/livespec:design feature <name>      # Create new feature spec
/livespec:design debug <issue>       # Diagnose spec-implementation gaps
/livespec:design refine <spec>       # Update existing spec
/livespec:design workspace           # Customize workspace specs
```

## Modes

### feature (Create New)

Creates feature with spec-first discipline:

1. Checks if spec exists
2. If missing, offers to create `specs/features/<name>.spec.md`
3. Gathers requirements via questions
4. Applies MSL four-question test
5. Creates behavior spec
6. Suggests next steps (TDD implementation)

### debug (Diagnose)

Identifies spec-implementation alignment issues:

1. Identifies affected component
2. Checks if relevant spec exists
3. If missing: Root cause = unspecified behavior
4. If exists: Compares spec to implementation
5. Reports gaps and recommendations

### refine (Update)

Updates existing specifications:

1. Reads current spec
2. Asks what change is needed
3. Applies MSL test to new content
4. Updates spec preserving format
5. Checks cross-references for impacts

### workspace (Setup)

For new projects or workspace customization:

1. Creates/updates specs/workspace/ files
2. Configures taxonomy, patterns, workflows
3. Sets up constitution (enforcement level)
4. Offers context rebuild when done

## MSL Gate

Before adding ANY requirement, verifies:

1. Is this essential? (would system fail?)
2. Is this WHAT not HOW? (not implementation detail)
3. What problem does this prevent? (proven, not theoretical)
4. Could this be inferred? (standard practice?)

If fails MSL gate, explains why and suggests alternative.

## See Also

- `/livespec:evolve` - Health checks and context generation
- `/livespec:learn` - Session completion and learning capture
