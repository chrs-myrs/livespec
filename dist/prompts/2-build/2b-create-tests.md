---
implements: specs/3-behaviors/prompts/2b-create-tests.spec.md
generated: '2025-10-10'
phase: 2-build
estimated_time: "30-60 minutes per feature"
---

# Prompt Behavior: Create Tests (TDD - Red Phase)

**Purpose**: Write failing tests that validate specifications BEFORE implementation

## Context

You're in Phase 2 (BUILD - TDD), creating tests that verify behavior specifications. This is the **Red phase** of the Red-Green-Refactor cycle.

**⚠️ CRITICAL: In TDD, tests come BEFORE implementation.** Write failing tests first, then use 2a-implement-from-specs.md to make them pass (Green phase).

## Before This Prompt

⚠️ **STOP: Verify specifications exist before creating tests. Tests without specs test the wrong thing.**

**Check these artifacts exist:**
- [ ] `specs/3-behaviors/` directory with behavior specs - What to test
- [ ] `specs/workspace/workflows.spec.md` - Testing approach and patterns

**If ANY is missing → STOP:**
- Missing specs/3-behaviors/ → "Use `.livespec/1-design/1b-define-behaviors.md` to create behavior specs first"
- Missing workspace workflows → "Use `.livespec/0-define/0a-setup-workspace.md` to define testing patterns first"

**Only proceed when specifications exist.** Tests validate specs - can't test without them.

## Red-Green-Refactor Cycle (TDD Workflow)

**This prompt handles the RED phase**. The complete cycle:

### 1. RED (This Prompt) - Write Failing Test
**You are here** → Write test that verifies one behavior requirement

- Test reads like specification (executable documentation)
- Test should FAIL (feature not yet implemented)
- Test is specific and focused (one behavior at a time)
- Test name maps to spec requirement (e.g., `test_req_003_password_minimum_12_chars`)

**Example**:
```python
# From specs/3-behaviors/authentication.spec.md
# REQ-003: Password must be minimum 12 characters

def test_req_003_password_minimum_12_characters():
    """Verify REQ-003: System rejects passwords under 12 chars"""
    # This test will FAIL until implementation exists
    assert validate_password("Short1!") == False
    assert validate_password("LongEnough1!") == True
```

**At this stage**: Test fails (function doesn't exist yet). That's correct!

### 2. GREEN (Use 2a-implement-from-specs.md) - Make Test Pass
**Next step** → Write minimal code to make test pass

- Implement just enough to pass THIS test
- Don't add features beyond current test
- Keep it simple (refactor later)

**Example**:
```python
def validate_password(password: str) -> bool:
    return len(password) >= 12  # Minimal implementation
```

**At this stage**: Test passes. Move to refactor or next test.

### 3. REFACTOR (Part of 2a workflow) - Improve Design
**After green** → Improve code while keeping tests green

- Remove duplication
- Clarify intent
- Optimize if needed
- All tests still pass

### Repeat Cycle
**For each behavior requirement**:
1. Write failing test (RED - this prompt)
2. Make it pass (GREEN - 2a prompt)
3. Improve code (REFACTOR - 2a prompt)
4. Next requirement

## How to Map Specs to Tests

**Each [!] requirement in behavior spec → at least one test**

### Spec Structure
```markdown
# specs/3-behaviors/user-authentication.spec.md

## Requirements
- [!] System authenticates users via password
  - Password minimum 12 characters (REQ-001)
  - Password requires uppercase letter (REQ-002)
  - Password requires number (REQ-003)
  - Failed login after 3 attempts locks account (REQ-004)
```

### Test Structure
```python
# tests/test_user_authentication.py

def test_req_001_password_minimum_12_characters():
    """Verify REQ-001: Minimum password length"""
    # Boundary testing
    assert validate_password("Short1A!") == False  # 8 chars
    assert validate_password("Exactly12Ch1!") == True  # 12 chars
    assert validate_password("LongerPassword1!") == True  # 16 chars

def test_req_002_password_requires_uppercase():
    """Verify REQ-002: At least one uppercase letter"""
    assert validate_password("nouppercase1234!") == False
    assert validate_password("HasUpperCase123!") == True

def test_req_003_password_requires_number():
    """Verify REQ-003: At least one number"""
    assert validate_password("NoNumbersHere!") == False
    assert validate_password("HasNumber1Here!") == True

def test_req_004_account_lockout_after_three_failures():
    """Verify REQ-004: Account locks after 3 failed attempts"""
    user = create_test_user()

    # Three failed attempts
    login(user, "wrong_password")  # Attempt 1
    login(user, "wrong_password")  # Attempt 2
    login(user, "wrong_password")  # Attempt 3

    # Fourth attempt should fail even with correct password
    result = login(user, user.correct_password)  # Attempt 4
    assert result.locked == True
```

**Test naming convention**: `test_req_XXX_brief_description`
- Maps directly to spec requirement
- Enables traceability (test → spec → requirement)
- Self-documenting test suite

## Test Organization Patterns

### By Behavior Spec
**One test file per behavior spec**:
```
specs/3-behaviors/user-authentication.spec.md
→ tests/test_user_authentication.py

specs/3-behaviors/payment-processing.spec.md
→ tests/test_payment_processing.py
```

### Test Categories

**Unit tests**: Test individual functions/methods
```python
def test_password_hash_returns_bcrypt_hash():
    """Unit: hash_password uses bcrypt algorithm"""
    hashed = hash_password("password123")
    assert hashed.startswith("$2b$")  # bcrypt prefix
```

**Integration tests**: Test component interactions
```python
def test_user_registration_stores_in_database():
    """Integration: register_user persists to database"""
    register_user("test@example.com", "Password123!")
    user = db.query(User).filter_by(email="test@example.com").first()
    assert user is not None
```

**Behavior tests**: Test observable system behaviors
```python
def test_req_005_user_receives_welcome_email():
    """Behavior: New users get welcome email"""
    register_user("test@example.com", "Password123!")
    emails = get_sent_emails()
    assert any(e.to == "test@example.com" and "Welcome" in e.subject for e in emails)
```

## Writing Good Tests (RED Phase)

### Good Test Characteristics

✅ **Focused**: Tests one thing
```python
def test_req_001_password_minimum_length():
    assert validate_password("Short1!") == False  # Only tests length
```

✅ **Descriptive**: Name explains what's tested
```python
def test_account_lockout_after_three_failed_attempts():  # Clear intent
```

✅ **Independent**: Doesn't depend on other tests
```python
def test_user_login():
    user = create_test_user()  # Creates own test data
    assert login(user, "password") == True
```

✅ **Repeatable**: Same result every time
```python
def test_timestamp_format():
    # Use fixed time, not datetime.now()
    timestamp = format_timestamp(datetime(2025, 1, 1, 12, 0, 0))
    assert timestamp == "2025-01-01T12:00:00Z"
```

### Test Patterns to Avoid

❌ **Testing implementation details**
```python
# Bad: Tests HOW (implementation)
def test_password_uses_bcrypt_algorithm():
    assert "bcrypt" in get_hash_algorithm()

# Good: Tests WHAT (behavior)
def test_password_hash_is_one_way():
    original = "password123"
    hashed = hash_password(original)
    assert hashed != original  # Can't reverse
    assert verify_password(original, hashed) == True
```

❌ **Multiple assertions testing different things**
```python
# Bad: Tests length AND uppercase AND numbers
def test_password_validation():
    assert validate_password("short") == False  # Length
    assert validate_password("nouppercase123!") == False  # Uppercase
    assert validate_password("NONUMBERS!") == False  # Number

# Good: Separate tests
def test_password_minimum_length(): ...
def test_password_requires_uppercase(): ...
def test_password_requires_number(): ...
```

❌ **Brittle tests (fail when implementation changes)**
```python
# Bad: Assumes internal implementation
def test_user_stored_in_list():
    register_user("test@example.com", "Pass123!")
    assert len(USER_LIST) == 1  # Breaks if storage changes

# Good: Tests observable behavior
def test_registered_user_can_login():
    register_user("test@example.com", "Pass123!")
    assert login("test@example.com", "Pass123!") == True
```

## Task

1. Prompt guides AI agent to create tests that validate all behavior specifications, with test names and assertions mapping directly to validation criteria.

## Output

Produce working code or tests that satisfy specifications.

## Validation

- **Tests written BEFORE implementation exists** (RED phase - tests should FAIL initially)
- Each [!] requirement in behavior spec has at least one test
- All CRITICAL behaviors have tests (may be failing initially - that's correct!)
- All contracts validated by tests
- All constraints verified by tests
- Test names map to specification language (test_req_XXX format)
- Tests serve as executable documentation (readable by non-developers)
- Tests are focused (one behavior per test)
- Tests are independent (no interdependencies)

## Success Criteria

**This prompt succeeds when:**
- All requirements from spec are satisfied
- Output is actionable and immediately usable
- No ambiguity in what needs to be done
- Clear path from current state to desired state

---

**Criticality**: CRITICAL
**Failure Mode**: Specifications cannot be validated
