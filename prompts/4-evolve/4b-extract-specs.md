---
spec: specs/prompts/4b-extract-specs.spec.md
---

# 4b: Extract Specifications

**Phase**: EVOLVE
**Purpose**: Extract specifications from code changes
**Context**: When code implements behaviors not yet documented in specs

## Task

Generate specifications from implementation when drift detection reveals new behaviors.

## When to Extract

Extract specifications when:
- **New features added** without specs
- **Behaviors changed** without spec updates
- **Existing codebase** being documented for first time
- **Contracts modified** without documentation

## Extraction Process

### 1. Identify New Behaviors

From the drift report (4a), identify what needs specification:
```markdown
## Requiring Specification
1. Password reset via email (new feature)
2. CSV export includes timestamps (behavior change)
3. API pagination (contract change)
```

### 2. Analyze Implementation

For each behavior, understand:
- **What it does** (observable outcome)
- **Why it exists** (problem it solves)
- **How to validate** (test criteria)
- **Criticality** (CRITICAL or IMPORTANT)

**Example Analysis:**
```python
# Code: password reset feature
@app.post("/auth/reset-password")
def reset_password(email: str):
    """Send password reset email to user"""
    user = find_user_by_email(email)
    token = generate_reset_token(user)
    send_email(user.email, token)
    return {"message": "Reset email sent"}
```

**Extracted Understanding:**
- **What**: System sends password reset email when requested
- **Why**: Users need ability to recover accounts
- **Validation**: Email received, token works, password can be reset
- **Criticality**: CRITICAL (users locked out without this)

### 3. Write MSL Specification

Create spec in appropriate folder:

`specs/behaviors/password-reset.md`:
```markdown
# Password Reset

**Criticality**: CRITICAL
**Failure Mode**: Users cannot recover locked-out accounts

## Specification

System sends password reset email containing unique token when user requests password reset via email address.

## Validation

- User can request reset via email address
- Reset email received within 2 minutes
- Token in email is unique and time-limited
- Token allows single password reset
- Old password no longer works after reset
- New password works immediately
```

### 4. Update Contracts (If Needed)

If new APIs or data formats were added:

`specs/contracts/api/auth-api.yaml`:
```yaml
paths:
  /auth/reset-password:
    post:
      summary: Request password reset
      requestBody:
        content:
          application/json:
            schema:
              type: object
              properties:
                email:
                  type: string
                  format: email
      responses:
        '200':
          description: Reset email sent
```

### 5. Extract from Tests

Tests provide validation criteria:

```python
def test_password_reset_sends_email():
    """Reset email received within 2 minutes"""
    ...

def test_reset_token_is_unique():
    """Token in email is unique and time-limited"""
    ...
```

These tests become validation bullets in the spec.

## Extraction Guidelines

**Keep MSL minimal:**
- Extract WHAT, not HOW
- No implementation details
- Only critical validation criteria
- Use test names as validation points

**Focus on observable:**
- ✅ "System sends reset email" (observable)
- ❌ "System generates JWT token" (implementation)

**Use code as evidence:**
- Code tells you what's implemented
- Tests tell you what's validated
- API signatures tell you contracts
- But specs describe intent

**Validate criticality:**
- Would system fail without this?
- Is this CRITICAL or IMPORTANT?
- Can users accomplish goals?

## Existing Codebase Extraction

For extracting specs from existing code:

### Full Codebase Approach

1. **Identify major features:**
   - What are the main capabilities?
   - What do users actually use?

2. **Start with critical path:**
   - What must work for system to function?
   - Extract these behaviors first

3. **Work outward:**
   - Then important features
   - Then nice-to-haves
   - Ignore dead code

4. **Use tests as guide:**
   - Tests reveal intended behaviors
   - Test names become spec names
   - Test assertions become validation

5. **Interview domain experts:**
   - Why does this feature exist?
   - What problem does it solve?
   - What's critical vs nice-to-have?

## Exit Criteria

- [ ] All new behaviors have specifications
- [ ] All modified behaviors have updated specs
- [ ] All new contracts documented
- [ ] All specs follow MSL format
- [ ] Specs validated against implementation
- [ ] Tests cover all validation criteria

## Next Step

Once specifications are extracted, proceed to `4c-update-docs.md`
