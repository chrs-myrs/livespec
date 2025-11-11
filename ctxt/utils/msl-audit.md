# MSL Audit Utility

⚠️ **Generated file** - Do not edit directly. Regenerate using `.livespec/prompts/utils/regenerate-contexts.md`

## Summary

MSL audit enforces minimalism in specifications, preventing spec bloat and maintaining focus on essential requirements. This utility applies the MSL decision framework to identify non-essential content and improve spec quality.

## When to Use

**Run MSL audit:**
- **Periodically** (quarterly or after major features)
- **Before releases** (ensure specs are minimal)
- **When specs feel too long** (ad-hoc simplification)
- **During reviews** (specification quality check)

**Signs audit needed:**
- Specs growing over time (not shrinking)
- Implementation details in specs (HOW instead of WHAT)
- "Nice to have" requirements
- Theoretical concerns without evidence

## MSL Minimalism Framework

### Core Principle

**Before adding any requirement, ask four essential questions:**

1. **Is this essential?** Would system fail without it?
2. **Am I specifying HOW instead of WHAT?** Implementation detail?
3. **What specific problem does this prevent?** Theoretical only?
4. **Could this be inferred or conventional?** Standard practice?

**Decision:**
- YES to question 1 + NO to 2-4 → Include requirement
- Any other combination → Exclude or simplify

### Precision Hierarchy

**Express requirements at highest applicable level:**

**Outcome** (highest level - prefer this):
- "System authenticates users securely"
- "API responses are fast enough for good UX"
- "Data remains consistent under concurrent access"

**Behavioral** (observable - use when outcome too vague):
- "System authenticates users via OAuth 2.0"
- "API responses return within 200ms for 95th percentile"
- "Database uses transactions with serializable isolation"

**Interface** (exact contract - use when integration required):
- "POST /auth/login accepts {email, password}, returns JWT"
- "GET /users/{id} returns JSON with fields: id, name, email"
- "Database transaction isolation level: SERIALIZABLE"

**Implementation** (lowest level - avoid unless truly essential):
- "Use bcrypt with cost factor 12 for password hashing"
- "Cache layer uses Redis with 1-hour TTL"
- "Database connection pool size: 20"

**Rule:** Default to highest level, descend only when necessary.

### Requirement Justification Hierarchy

**CRITICAL** (always include):
- System fails completely without this
- Legal/compliance requirement (must-have)
- Security vulnerability if missing
- Data corruption/loss possible

**IMPORTANT** (usually include):
- System degraded significantly without this
- User experience severely impacted
- Maintenance becomes very difficult
- Technical debt accumulates rapidly

**USEFUL** (rarely include):
- Nice improvement but not essential
- Convenience feature (not core)
- Optimization without clear benefit
- "We might need this someday"

**NICE** (never include):
- Personal preferences
- Aesthetic choices (not UX-impacting)
- Theoretical concerns without evidence
- Gold-plating

**Rule:** Include CRITICAL always, IMPORTANT usually, USEFUL rarely, NICE never.

## Audit Workflow

### Step 1: Identify Audit Targets

**Review all specs:**
```bash
# Find large specs (likely candidates for reduction)
find specs/ -name "*.spec.md" -exec wc -l {} \; | sort -rn | head -20

# Focus on:
# - Specs >200 lines (likely over-specified)
# - Specs growing over time (check git log)
# - Specs with many sub-bullets (excessive detail)
```

### Step 2: Apply Decision Framework

**For each requirement in spec:**

#### Question 1: Is this essential?

**Test:** Would system fail without this requirement?

**Examples:**
- "System authenticates users" → YES (system fails without auth)
- "Login button is blue" → NO (system works with any color)

#### Question 2: Am I specifying HOW?

**Test:** Does requirement prescribe implementation method?

**Examples:**
- ❌ "Use bcrypt with cost factor 12" (HOW - implementation)
- ✅ "Passwords hashed securely" (WHAT - outcome)

**Exception:** HOW is essential when:
- Legal requirement (e.g., "HTTPS required by regulation")
- Integration constraint (e.g., "OAuth 2.0 for third-party compatibility")
- Security critical (e.g., "TLS 1.3 minimum")

#### Question 3: What specific problem does this prevent?

**Test:** Has this problem actually occurred, or is it theoretical?

**Examples:**
- ✅ "Rate limiting prevents abuse" (problem: abuse occurs without it)
- ❌ "Support for 10 million users" (problem: no evidence we'll reach this)

#### Question 4: Could this be inferred?

**Test:** Would competent implementer assume this anyway?

**Examples:**
- ❌ "Use version control" (conventional practice)
- ❌ "Write clean code" (too vague, assumed)
- ✅ "Maintain audit log for 7 years" (specific, not conventional)

### Step 3: Categorize and Remove

**Mark each requirement:**

**KEEP (essential, minimal):**
- Passes question 1 (essential)
- Fails questions 2-4 (not HOW, proven problem, not conventional)
- Criticality: CRITICAL or IMPORTANT

**SIMPLIFY (over-specified):**
- Passes question 1 but fails others
- Move up precision hierarchy (implementation → behavioral → outcome)
- Remove excessive detail

**REMOVE (non-essential):**
- Fails question 1 (not essential)
- Criticality: USEFUL or NICE
- Delete from spec

### Step 4: Generate Audit Report

**Report format:**

```markdown
# MSL Audit Report

**Date:** 2025-11-10
**Spec:** specs/3-behaviors/user-authentication.spec.md
**Before:** 87 lines, 12 requirements
**After:** 52 lines, 8 requirements

## Changes

### Removed (4 requirements)

1. ❌ "Login button uses #007bff color"
   - **Reason:** Not essential (Q1 fail - aesthetic choice)
   - **Impact:** None (color not critical)

2. ❌ "Password hashing uses bcrypt with cost factor 12"
   - **Reason:** Implementation detail (Q2 fail - specifies HOW)
   - **Simplified to:** "Passwords hashed securely"

3. ❌ "System supports 1 million concurrent users"
   - **Reason:** Theoretical concern (Q3 fail - no evidence needed)
   - **Impact:** Will add if scaling becomes issue

4. ❌ "Use industry-standard authentication practices"
   - **Reason:** Too vague (Q4 pass - conventional)
   - **Impact:** Implied by "Passwords hashed securely"

### Kept (8 requirements)

1. ✅ "System authenticates users via OAuth 2.0"
   - **Reason:** Essential (Q1 pass), proven need (Q3 pass)
   - **Level:** Behavioral (third-party integration requires specific protocol)

2. ✅ "Invalid credentials return 401 error"
   - **Reason:** Essential (Q1 pass), API contract (interface level)

... (remaining requirements)

## Summary

- **Reduction:** 35% (87 → 52 lines)
- **Requirements removed:** 4
- **Requirements simplified:** 2
- **Requirements kept:** 8
- **Quality improvement:** Focused on essential behaviors
```

## Common Audit Findings

### Over-Specification (Implementation Details)

**Before (implementation HOW):**
```yaml
Requirements:
- System uses Redis for caching
- Cache TTL set to 3600 seconds
- Cache key format: "user:{id}:profile"
- Cache invalidation uses pub/sub pattern
```

**After (outcome WHAT):**
```yaml
Requirements:
- System caches user profiles for fast retrieval
- Cache invalidates when user data changes
```

**Reduction:** 4 requirements → 2 (removed HOW details)

### Theoretical Concerns

**Before (unproven needs):**
```yaml
Requirements:
- System scales to 10 million users
- System handles 100,000 requests/second
- System supports multi-region deployment
```

**After (proven needs):**
```yaml
Requirements:
- System handles current load (5,000 users, 500 req/sec)
```

**Note:** Add scaling requirements when evidence shows they're needed.

### Aesthetic Preferences

**Before (personal preferences):**
```yaml
Requirements:
- Login button is blue (#007bff)
- Font is 16px Helvetica
- Spacing follows 8px grid
```

**After (UX outcomes):**
```yaml
Requirements:
- Login button is clearly visible and accessible
```

**Reduction:** 3 aesthetic details → 1 UX outcome

### Conventional Practices

**Before (assumed practices):**
```yaml
Requirements:
- Code uses version control
- Code follows style guide
- Code has comments explaining complex logic
```

**After:**
```yaml
(All removed - conventional practices, not behavioral requirements)
```

**Note:** Coding standards belong in team docs, not behavior specs.

## Examples

### Example 1: API Spec Audit

```bash
# Audit large API spec
Before: specs/3-contracts/api/v1/users.spec.md (142 lines, 18 endpoints)

# Apply framework to each endpoint
# - Question 1: Is endpoint essential? (used by clients?)
# - Question 2: Am I over-specifying response format?
# - Question 3: Are validation rules proven necessary?
# - Question 4: Are error codes conventional?

After: specs/3-contracts/api/v1/users.spec.md (87 lines, 12 endpoints)

# Removed:
# - 6 rarely-used endpoints (not essential)
# - Excessive response field documentation (simplified)
# - Conventional error codes (inferred)

# Result: 39% reduction, clearer contract
```

### Example 2: Behavior Spec Simplification

```bash
# Audit implementation-heavy spec
Before: specs/3-behaviors/payment-processing.spec.md (95 lines, 8 requirements)

# Finding: Too many implementation details
# - "Use Stripe API for payments" (HOW)
# - "Retry failed payments 3 times with exponential backoff" (HOW)
# - "Log all payment attempts to CloudWatch" (HOW)

# Simplify to behavioral outcomes
After: specs/3-behaviors/payment-processing.spec.md (52 lines, 5 requirements)

# Kept (WHAT):
# - "System processes payments securely"
# - "Failed payments retry automatically"
# - "Payment attempts are auditable"

# Result: 45% reduction, focuses on WHAT not HOW
```

## Decision Points

**When to run full audit?**
- Quarterly (regular maintenance)
- Before major releases (quality gate)
- When specs feel bloated (ad-hoc)

**What reduction target?**
- No fixed target (minimize until essential only)
- Typical: 20-40% reduction on first audit
- Goal: Every line justified

**Should I remove this requirement?**
- Apply four questions rigorously
- When in doubt → Remove (can always add back if proven necessary)
- Trust implementers to make reasonable choices

**How to handle disagreements?**
- Apply framework objectively (not opinions)
- If team disagrees, document rationale in spec
- Revisit during next audit (was it essential in practice?)

## Reference Library

**For detailed guidance:**
- Parent: AGENTS.md (root context)
- Complete framework: `.livespec/guides/msl-minimalism.md`
- MSL specification: https://github.com/chrs-myrs/msl-specification
- Context7: Query `msl` for MSL docs

**Cross-references:**
- Constitution: specs/workspace/constitution.spec.md (Principle #2: MSL Minimalism)
- Patterns: specs/workspace/patterns.spec.md (spec format patterns)

---

*MSL audit specialist for LiveSpec*
*Parent: AGENTS.md*
