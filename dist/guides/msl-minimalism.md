# MSL Minimalism Decision Framework

MSL (Markdown Specification Language) minimalism: every requirement must justify its existence. Specifications capture the essential WHAT without prescribing the HOW.

## Core Belief

Less is more. Minimal specs are easier to understand, implement, and maintain. Trust implementers to make reasonable decisions within clearly defined boundaries.

## The 4 Essential Questions

Before adding any requirement, ask:

### 1. Is this essential?
- **Would system fail without it?** → Include
- **Is it just "nice to have"?** → Exclude

### 2. Am I specifying HOW instead of WHAT?
- **Does this dictate implementation?** → Remove
- **Does this describe observable outcome?** → Consider keeping

### 3. What specific problem does this prevent?
- **Prevents known, real issue?** → Include
- **Theoretical concern only?** → Exclude

### 4. Could this be inferred or conventional?
- **Standard practice in domain?** → Omit
- **Requires explicit statement?** → Include

## Precision Hierarchy

Default to the highest applicable level:

1. **Outcome Level**: "System must authenticate users"
2. **Behavioral Level**: "System must reject invalid credentials"
3. **Interface Level**: "Auth endpoint returns 401 for bad credentials"
4. **Implementation Level**: "Use bcrypt with 10 rounds" ← **Avoid unless critical**

## Requirement Justification Scale

- **Critical**: System fails without this → **Always include**
- **Important**: Quality degraded without this → **Usually include**
- **Useful**: Improves experience → **Rarely include**
- **Nice**: Preference only → **Never include**

## Hierarchical Minimalism

When 2+ sibling specs share requirements, abstract to parent:

**Before (duplication):**
```markdown
auth-login.spec.md:
  - Must validate input
  - Must log all attempts

auth-register.spec.md:
  - Must validate input
  - Must log all attempts
```

**After (abstracted):**
```markdown
auth.spec.md (parent):
  - Must validate input
  - Must log all attempts

auth-login.spec.md (extends: auth):
  - Must check credentials against database

auth-register.spec.md (extends: auth):
  - Must create new user account
```

## Application

**When creating specs:**
- Start minimal
- Focus on observable behavior
- Trust implementers
- Default to high-level descriptions

**When reviewing specs:**
- Question every line: "What breaks if we remove this?"
- Identify hidden implementation details
- Look for opportunities to abstract

---

*Adapted from SpellForge MSL Minimalism policy for LiveSpec distribution. For complete philosophy and examples, see https://github.com/chrs-myrs/msl-specification*
