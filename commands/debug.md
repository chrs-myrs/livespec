---
description: Diagnose spec-implementation alignment issues
alias_for: do --mode=diagnose
---

# Debug

Diagnose spec-implementation alignment issues.

**Alias for:** `/livespec:do debug <issue>`

## Usage

```
/livespec:debug <issue>
/livespec:debug login-failure
/livespec:debug payment-not-processing
```

## What It Does

1. Identifies affected area/component
2. Checks if relevant spec exists
3. If spec missing: Root cause = unspecified behavior
4. If spec exists: Compares spec requirements to actual implementation
5. Reports gaps and recommendations

## Gap Types

**Spec says X, code does Y:**
- Either code bug OR spec outdated
- Recommendation: Investigate which is correct

**Code does X, spec silent:**
- Missing requirement in spec
- Recommendation: Extract to spec or remove from code

**No spec for component:**
- Unspecified behavior
- Recommendation: Create spec first, then fix

## Example

```
/livespec:debug login-not-working

> Diagnosis: login-not-working

> Spec State:
> - specs/features/authentication.spec.md: EXISTS

> Alignment Issues:
> 1. Spec says "OAuth 2.0 flow" but code uses session tokens
> 2. Code has rate limiting not in spec

> Recommendation:
> - Update spec if session tokens are correct approach
> - OR fix code to match OAuth spec
> - Add rate limiting to spec (discovered behavior)
```

## See Also

- `/livespec:do` - Full unified skill
- `/livespec:feature` - Create new features
- `/livespec:refine` - Update existing specs
