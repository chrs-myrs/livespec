---
description: Update and refine existing specs
alias_for: do --mode=update
---

# Refine

Update and refine existing specifications.

**Alias for:** `/livespec:do refine <spec>`

## Usage

```
/livespec:refine <spec>
/livespec:refine authentication
/livespec:refine specs/features/payment.spec.md
```

## What It Does

1. Reads current spec
2. Asks what change is needed
3. Applies MSL four-question test to new content
4. Updates spec preserving MSL format
5. Checks cross-references for impacts
6. Offers context rebuild if workspace spec changed

## When to Use

- New requirement discovered
- Clarification from user
- Behavior changed intentionally
- Constraint added/removed
- Error in existing spec found

## Example

```
/livespec:refine authentication

> Current spec: specs/features/authentication.spec.md
>
> What change is needed?
> [User: "Add requirement for 2FA support"]

> Applying MSL test:
> 1. Essential? YES - security requirement
> 2. HOW or WHAT? WHAT - observable behavior
> 3. Problem prevents? YES - account takeover
> 4. Conventional? NO - specific to this system

> Updated: specs/features/authentication.spec.md
> Added: "Users can enable two-factor authentication"

> Cross-references checked:
> - No impacts to other specs
```

## MSL Gate

Before adding to spec, verifies:
1. Is this essential? (would system fail?)
2. Is this WHAT not HOW? (not implementation detail)
3. What problem does this prevent? (proven, not theoretical)

If fails MSL gate, explains why and suggests alternative.

## See Also

- `/livespec:do` - Full unified skill
- `/livespec:feature` - Create new features
- `/livespec:debug` - Diagnose alignment issues
