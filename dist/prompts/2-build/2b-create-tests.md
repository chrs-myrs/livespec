---
spec: specs/prompts/2b-create-tests.spec.md
---

# 2b: Create Tests

**Phase**: BUILD
**Purpose**: Create tests that validate specifications are met
**Context**: Tests are executable specifications

## Task

Create comprehensive tests that validate all behaviors and contracts.

## Test Strategy

### 1. Behavior Tests

For each specification in `specs/behaviors/`, create tests that validate the behavior:

```markdown
# specs/behaviors/user-authentication.md
**Specification**: System authenticates users via email/password
**Validation**:
- Valid credentials allow login
- Invalid credentials are rejected
- Session persists after login
```

Becomes:

```python
# tests/test_authentication.py
def test_valid_credentials_allow_login():
    response = login("user@example.com", "correct_password")
    assert response.status == 200
    assert response.session_token is not None

def test_invalid_credentials_rejected():
    response = login("user@example.com", "wrong_password")
    assert response.status == 401

def test_session_persists_after_login():
    session = login_and_get_session()
    response = make_authenticated_request(session)
    assert response.status == 200
```

### 2. Contract Tests

For each contract in `specs/contracts/`, create validation tests:

**For OpenAPI contracts:**
```python
# Use tools like schemathesis or dredd
def test_api_matches_openapi_spec():
    validate_against_openapi("specs/contracts/api/users-api.yaml")
```

**For JSON Schema:**
```python
from jsonschema import validate

def test_user_data_matches_schema():
    user = create_user()
    schema = load_schema("specs/contracts/data/user.json")
    validate(instance=user, schema=schema)  # Raises if invalid
```

### 3. Constraint Tests

Validate all constraints from `specs/constraints.md`:

```markdown
# specs/constraints.md
**Specification**: API must respond within 200ms for 95th percentile
```

Becomes:

```python
def test_api_response_time():
    response_times = [call_api() for _ in range(100)]
    p95 = percentile(response_times, 95)
    assert p95 < 0.2  # 200ms
```

## Test Organization

```
tests/
├── behaviors/           # Behavior validation tests
│   ├── test_auth.py
│   └── test_export.py
├── contracts/           # Contract validation tests
│   ├── test_api.py
│   └── test_data.py
└── constraints/         # Constraint validation tests
    └── test_performance.py
```

## Guidelines

**Test specifications, not implementation:**
- ✅ Test observable behaviors
- ❌ Don't test internal methods
- ✅ Test contracts are met
- ❌ Don't test implementation details

**Use specification language in tests:**
```python
# Good: Maps directly to spec
def test_system_authenticates_users_via_email_password():
    ...

# Bad: Implementation-focused
def test_jwt_token_generation():
    ...
```

**One test per validation criteria:**
- Each bullet in "Validation" section becomes a test
- Makes traceability clear
- Easy to see coverage

**Tests as documentation:**
- Test names describe behavior
- Tests show how features work
- Tests serve as examples

## Test Coverage

Aim for:
- ✅ **100% of CRITICAL behaviors** tested
- ✅ **100% of contracts** validated
- ✅ **100% of constraints** verified
- ⚠️ **80%+ of IMPORTANT behaviors** tested

Don't aim for:
- ❌ 100% code coverage (tests implementation, not specs)
- ❌ Testing every internal function
- ❌ Testing framework code

## Exit Criteria

- [ ] All CRITICAL behaviors have passing tests
- [ ] All contracts validated by tests
- [ ] All constraints verified by tests
- [ ] Test names map to specifications
- [ ] Tests are executable documentation

## Phase Complete

When implementation and tests are complete:
- ✅ **Phase 2: BUILD is complete**
- → Proceed to **Phase 3: VERIFY** (`prompts/3-verify/`)
