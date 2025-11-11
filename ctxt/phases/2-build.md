# Phase 2: BUILD (TDD)

⚠️ **Generated file** - Do not edit directly. Regenerate using `.livespec/prompts/utils/regenerate-contexts.md`

## Summary

Phase 2 implements the solution using test-driven development (TDD). This phase follows RED-GREEN-REFACTOR cycle: write failing tests first, make them pass with minimal code, then improve design. TDD is mandatory by default with escape hatch for trivial scripts (justification required).

## When to Use This Phase

**Entry conditions:**
- Phase 1 complete (architecture, behaviors, contracts specified)
- Specs clearly define WHAT to build
- Ready to write code

**Exit conditions:**
- All tests pass (100% of specified behaviors validated)
- Implementation matches specifications
- Code quality acceptable (refactored, maintainable)
- Ready for acceptance testing (proceed to Phase 3)

## Phase Workflow

### TDD Cycle: RED → GREEN → REFACTOR

**Core discipline:** Tests before implementation, always

#### RED Phase: Write Failing Tests

**Prompt:** `.livespec/2-build/2b-create-tests.md`

1. **Read behavior spec** (specs/3-behaviors/*.spec.md)
2. **Map requirements to tests:**
   - Each `[!]` requirement → At least one test
   - Each validation criterion → Test case
   - Edge cases from spec → Additional tests

3. **Write failing tests:**
   - Test structure: Arrange, Act, Assert
   - Test names describe behavior (not implementation)
   - Tests are precise (not vague assertions)

4. **Run tests → ALL FAIL** (expected)

**Example:**
```yaml
# Spec: specs/3-behaviors/authentication.spec.md
Requirement: "System authenticates users via OAuth flow"
  - Valid credentials return JWT token
  - Invalid credentials return 401 error
  - Missing credentials return 400 error

# Tests:
test_valid_credentials_returns_jwt_token()
test_invalid_credentials_returns_401()
test_missing_credentials_returns_400()
```

#### GREEN Phase: Make Tests Pass

**Prompt:** `.livespec/2-build/2a-implement-from-specs.md`

1. **Write minimal code to pass tests**
   - Focus on making tests pass (not perfect code yet)
   - Simplest implementation that works
   - Don't optimize prematurely

2. **Run tests → ALL PASS**
   - If tests still fail → Fix implementation
   - If tests pass → Proceed to REFACTOR

#### REFACTOR Phase: Improve Design

**Still in:** `.livespec/2-build/2a-implement-from-specs.md`

1. **Improve code quality:**
   - Extract duplicated logic
   - Improve naming
   - Simplify complex logic
   - Apply design patterns

2. **Keep tests passing:**
   - Run tests after each refactor
   - Tests should still pass (behavior unchanged)
   - Refactoring changes HOW, not WHAT

3. **When satisfied → Commit**

### TDD Workflow Summary

```
1. Read spec → Understand behavior
2. Write failing tests (RED)
3. Run tests → Confirm failure
4. Write minimal code (GREEN)
5. Run tests → Confirm pass
6. Improve code (REFACTOR)
7. Run tests → Still pass
8. Commit
9. Repeat for next behavior
```

## Key Prompts

| Prompt | When to Use | TDD Phase |
|--------|-------------|-----------|
| 2b-create-tests.md | ALWAYS FIRST | RED (failing tests) |
| 2a-implement-from-specs.md | After tests exist | GREEN + REFACTOR (passing code) |

**Critical:** 2b before 2a (tests before implementation)

## Escape Hatch (Trivial Scripts Only)

**When TDD not required:**
- Trivial scripts (<50 lines, single purpose, no business logic)
- Justification MUST be documented in implementation
- Example: "Trivial wrapper script calling single API - TDD overhead exceeds value"

**When TDD still required:**
- Anything with business logic
- Anything that could fail in production
- Anything that will be maintained
- Default assumption: TDD required (justify opt-out, not opt-in)

**Governance:** Constitution.spec.md mandates TDD as Principle #3

## Common Patterns

### Unit Testing Pattern

**Test:** Individual functions/methods in isolation

```python
# Test file: tests/unit/test_auth.py

def test_valid_token_returns_user():
    token = "valid_jwt_token"
    user = auth.verify_token(token)
    assert user.id == "user123"

def test_invalid_token_raises_error():
    token = "invalid_token"
    with pytest.raises(AuthenticationError):
        auth.verify_token(token)
```

**Spec mapping:** specs/3-behaviors/authentication.spec.md

### Integration Testing Pattern

**Test:** Multiple components working together

```python
# Test file: tests/integration/test_api.py

def test_user_login_flow():
    # Arrange
    client = TestClient(app)
    credentials = {"email": "user@example.com", "password": "secret"}

    # Act
    response = client.post("/auth/login", json=credentials)

    # Assert
    assert response.status_code == 200
    assert "token" in response.json()
```

**Spec mapping:** specs/3-behaviors/user-authentication.spec.md + specs/3-contracts/api/v1/auth.spec.md

### Behavior Validation Pattern

**Test:** System exhibits observable behavior from spec

```python
# Test file: tests/behavior/test_caching.py

def test_cache_invalidates_on_update():
    # Arrange
    cache.set("user:123", {"name": "Alice"})

    # Act
    update_user(123, {"name": "Bob"})

    # Assert
    cached_user = cache.get("user:123")
    assert cached_user is None  # Cache invalidated
```

**Spec mapping:** specs/3-behaviors/caching.spec.md

## Spec-to-Test Mapping

**Rule:** Every spec requirement → At least one test

**Mapping process:**

1. **Read spec frontmatter:**
   - `criticality: CRITICAL` → Must have 100% test coverage
   - `criticality: IMPORTANT` → Should have test coverage
   - `failure_mode` → Test should verify this doesn't happen

2. **Map requirements:**
   ```yaml
   # Spec: specs/3-behaviors/user-management.spec.md

   Requirement: "System creates users with validated email"
     - Email format validated (test: test_invalid_email_rejected)
     - Duplicate emails rejected (test: test_duplicate_email_rejected)
     - Valid creation returns user ID (test: test_valid_creation_returns_id)
   ```

3. **Test organization:**
   - `tests/unit/` → Unit tests (functions/classes)
   - `tests/integration/` → Integration tests (components)
   - `tests/behavior/` → Behavior validation (specs)

## Examples

### Example 1: Simple REST Endpoint

```bash
# Spec: specs/3-behaviors/user-retrieval.spec.md
# Contract: specs/3-contracts/api/v1/users.spec.md

# Step 1: Write failing tests (RED)
Use .livespec/2-build/2b-create-tests.md

# Creates: tests/integration/test_users_api.py
# test_get_user_returns_200_with_user_data()
# test_get_missing_user_returns_404()
# test_get_user_with_invalid_id_returns_400()

# Run: pytest → ALL FAIL ✓

# Step 2: Implement endpoint (GREEN)
Use .livespec/2-build/2a-implement-from-specs.md

# Creates: src/api/users.py (minimal implementation)
# Run: pytest → ALL PASS ✓

# Step 3: Refactor (still GREEN)
# Improve code quality, extract helpers
# Run: pytest → STILL PASS ✓

# Commit and move to next behavior
```

### Example 2: Complex Business Logic

```bash
# Spec: specs/3-behaviors/payment-processing.spec.md

# Step 1: Write failing tests (RED)
Use .livespec/2-build/2b-create-tests.md

# Creates: tests/unit/test_payment_validation.py
#         tests/integration/test_payment_flow.py
#         tests/behavior/test_payment_processing.py

# Many edge cases:
# - Valid payment succeeds
# - Insufficient funds fails
# - Invalid card fails
# - Network timeout retries
# - Idempotency (duplicate requests)

# Run: pytest → ALL FAIL ✓ (expected)

# Step 2: Implement incrementally (GREEN)
Use .livespec/2-build/2a-implement-from-specs.md

# Implement one test at a time:
# 1. Make test_valid_payment_succeeds pass
# 2. Make test_insufficient_funds_fails pass
# 3. Continue until all tests pass

# Run: pytest → ALL PASS ✓

# Step 3: Refactor (improve design)
# Extract payment validation
# Extract retry logic
# Extract error handling

# Run: pytest → STILL PASS ✓

# Commit
```

## Decision Points

**Do I need TDD for this?**
- Default: YES (TDD mandatory)
- Exception: Trivial script (<50 lines, single purpose, documented justification)
- When in doubt: Use TDD (safe default)

**What type of tests?**
- Unit tests: Fast, isolate functions/classes
- Integration tests: Verify components work together
- Behavior tests: Validate specs/3-behaviors/ requirements
- All three: Use all types (comprehensive coverage)

**How many tests per requirement?**
- Minimum: One test per validation criterion
- Typical: 2-5 tests per requirement (happy path + edge cases)
- Complex: 10+ tests (complex business logic, many edge cases)

**When do I stop testing?**
- All spec requirements covered (100%)
- All edge cases from spec tested
- Failure mode from spec prevented
- Code meets quality standards

## Reference Library

**For detailed guidance:**
- Parent: AGENTS.md (root context)
- Prompts: `.livespec/2-build/*.md` (full prompt text)
- TDD guide: `.livespec/guides/tdd.md` (complete framework)
- Test patterns: Language-specific testing frameworks

**Cross-references:**
- Phase 1 (DESIGN): Where specs come from
- Phase 3 (VERIFY): Where acceptance testing happens
- Constitution: specs/workspace/constitution.spec.md (TDD mandate)

---

*Phase 2 specialist for LiveSpec*
*Parent: AGENTS.md*
