---
description: Create a new feature with spec-first discipline
alias_for: do --mode=feature
---

# Feature

Create a new feature following spec-first discipline.

**Alias for:** `/livespec:do feature <name>`

## Usage

```
/livespec:feature <name>
/livespec:feature auth
/livespec:feature user-profile
```

## What It Does

1. Checks if spec exists for feature
2. If missing, offers to create `specs/features/<name>.spec.md`
3. Gathers requirements via interactive questions
4. Applies MSL four-question test
5. Creates behavior spec with proper format
6. Suggests next steps (TDD implementation)

## Workflow Injected

**Soft enforcement:** Spec-first discipline is injected at step 1-2. If no spec exists, agent offers creation before proceeding.

## Example

```
/livespec:feature authentication

> No spec found for "authentication"
> Create specs/features/authentication.spec.md? (Recommended)

[User confirms]

> What should this feature do?
[User describes]

> Created: specs/features/authentication.spec.md

> Next:
> - Implement with TDD
> - Run /livespec:validate
```

## See Also

- `/livespec:do` - Full unified skill
- `/livespec:debug` - Diagnose alignment issues
- `/livespec:refine` - Update existing specs
