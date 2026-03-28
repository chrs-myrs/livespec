# MSL Audit

> **Generated file** - Do not edit directly. Regenerate using `.livespec/prompts/utils/regenerate-contexts.md`

Sub-agent context for minimalism enforcement and spec quality.

## Summary

MSL audit enforces minimalism in specifications, preventing spec bloat and maintaining focus on essential requirements. Applies the MSL decision framework to identify non-essential content. Distinct from frontmatter compliance (see ctxt/audit.md) — this focuses on WHAT is in specs, not schema correctness.

## When to Use

- Periodically (quarterly or after major features)
- Before releases (ensure specs minimal)
- When specs feel too long
- During reviews (specification quality check)

**Signs audit needed:**
- Specs growing over time (not shrinking)
- Implementation details in specs (HOW instead of WHAT)
- "Nice to have" requirements
- Theoretical concerns without evidence

## MSL Four-Question Test

Before adding any requirement, ask:

### 1. Is this essential?

Would system fail without it?

**Examples:**
- "System authenticates users" → YES (fails without auth)
- "Login button is blue" → NO (works with any color)

### 2. Am I specifying HOW instead of WHAT?

Does requirement prescribe implementation method?

**Examples:**
- "Use bcrypt with cost factor 12" — HOW (remove or simplify)
- "Passwords hashed securely" — WHAT (keep)

**Exceptions:** Legal requirement, integration constraint, security critical

### 3. What specific problem does this prevent?

Has this problem actually occurred, or theoretical?

**Examples:**
- "Rate limiting prevents abuse" (proven need) — keep
- "Support 10 million users" (no evidence needed) — remove

### 4. Could this be inferred or conventional?

Would competent implementer assume this anyway?

**Examples:**
- "Use version control" — conventional (remove)
- "Maintain audit log for 7 years" — specific (keep)

## Decision Matrix

**Include if:** YES to #1 AND NO to #2-4

| Q1 Essential? | Q2 HOW? | Q3 Proven? | Q4 Inferred? | Decision |
|---------------|---------|------------|--------------|----------|
| YES | NO | YES | NO | **INCLUDE** |
| YES | YES | — | — | Simplify to WHAT |
| NO | — | — | — | **REMOVE** |
| — | — | NO | — | **REMOVE** |
| — | — | — | YES | **REMOVE** |

## Precision Hierarchy

Express at highest applicable level:

**Outcome** (highest — prefer):
- "System authenticates users securely"

**Behavioral** (use when outcome too vague):
- "System authenticates users via OAuth 2.0"

**Interface** (use when integration required):
- "POST /auth/login accepts {email, password}, returns JWT"

**Implementation** (lowest — avoid):
- "Use bcrypt with cost factor 12"

**Rule:** Default to highest level, descend only when necessary.

## Criticality Levels

**CRITICAL** (always include in spec):
- System fails completely without this
- Legal/compliance requirement
- Security vulnerability if missing

**IMPORTANT** (usually include):
- System degraded significantly
- User experience severely impacted

**USEFUL** (rarely include — question first):
- Nice improvement but not essential
- Convenience feature

**NICE** (never include in spec):
- Personal preferences
- Theoretical concerns

**Note:** `criticality` frontmatter field is document-level (CRITICAL or IMPORTANT only). The USEFUL/NICE categories apply to individual requirements, not the spec document itself.

## Audit Workflow

### Step 1: Identify Audit Targets

```bash
# Find large specs
find specs/ -name "*.spec.md" -exec wc -l {} \; | sort -rn | head -20
```

Focus on:
- Specs >200 lines
- Specs growing over time
- Specs with many sub-bullets

### Step 2: Apply Decision Framework

For each requirement:
1. Apply four-question test
2. Check precision hierarchy
3. Verify criticality level
4. Mark: KEEP / SIMPLIFY / REMOVE

### Step 3: Check Minimalism of Frontmatter

Frontmatter should be accurate, not overloaded:
- `governed-by` should be empty or reference only truly governing content specs
- `satisfies` should reference specific requirements, not whole spec files speculatively
- `guided-by` should reference strategies that actually constrain this spec's approach

### Step 4: Generate Audit Report

```markdown
# MSL Audit Report

**Spec:** specs/features/authentication.spec.md
**Before:** 87 lines, 12 requirements
**After:** 52 lines, 8 requirements
**Reduction:** 40%

## Removed (4 requirements)

1. "Login button uses #007bff"
   - Reason: Not essential (aesthetic)

2. "Use bcrypt with cost factor 12"
   - Reason: Implementation detail
   - Simplified to: "Passwords hashed securely"

## Kept (8 requirements)

1. "System authenticates via OAuth 2.0"
   - Essential + proven need
```

## Common Audit Findings

### Over-Specification

**Before:**
```markdown
- System uses Redis for caching
- Cache TTL set to 3600 seconds
- Cache key format: "user:{id}:profile"
```

**After:**
```markdown
- System caches user profiles for fast retrieval
- Cache invalidates when user data changes
```

### Theoretical Concerns

**Before:**
```markdown
- System scales to 10 million users
- System handles 100,000 req/sec
```

**After:**
```markdown
- System handles current load (5,000 users)
```

### Aesthetic Preferences

**Before:**
```markdown
- Button is blue (#007bff)
- Font is 16px Helvetica
```

**After:**
```markdown
- Submit button is clearly visible
```

### Conventional Practices

**Before:**
```markdown
- Code uses version control
- Code follows style guide
```

**After:**
*(All removed — conventional practices)*

### Overfull Frontmatter

**Before:**
```yaml
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md  # WRONG: format, not content
  - specs/foundation/outcomes.spec.md
  - specs/workspace/constitution.spec.md
  - specs/workspace/patterns.spec.md
```

**After:**
```yaml
governed-by: []  # or only truly constraining content specs
```

## References

- MSL Framework: `.livespec/guides/msl-minimalism.md`
- MSL Specification: https://github.com/chrs-myrs/msl-specification
- Audit command: `/livespec:audit`
- Frontmatter compliance (separate): `ctxt/audit.md`
- Parent context: AGENTS.md

---

*MSL audit specialist for LiveSpec v5.4.0*
*Parent: AGENTS.md*
