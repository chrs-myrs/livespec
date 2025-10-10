# Test-Driven Development Guide (Optional)

Decision framework for when TDD (Test-Driven Development) adds value versus when it creates overhead.

## Philosophy

TDD is a **design tool** that creates robust, well-structured code through the red-green-refactor cycle. However, TDD isn't universally beneficial - use it where complexity justifies the overhead.

**Core belief:** Selective application. Use TDD for complex logic and critical functions, skip it for simple operations.

## When TDD Adds Value

### Complexity Indicators (Use TDD if ANY apply)
- **Business Logic**: Multiple conditional paths, edge cases, or rules
- **Algorithms**: Complex calculations, data transformations, or optimizations
- **State Management**: Objects with complex internal state transitions
- **Error Handling**: Non-trivial error recovery or validation logic
- **Integration Points**: APIs, message handlers, or external service interfaces

### Risk Factors (Use TDD if ANY apply)
- **High-Impact Failures**: Bugs cause significant user/business impact
- **Frequent Changes**: Code that evolves regularly needs test safety
- **Security Critical**: Authentication, authorization, data validation
- **Performance Sensitive**: Code where regressions have user impact

## When TDD is Overhead

### Simple Operations (Skip TDD for)
- **Basic CRUD**: Simple create, read, update, delete without complex logic
- **Data Mapping**: Straightforward object transformations
- **Configuration**: Environment setup, dependency injection wiring
- **Trivial Functions**: Getters, setters, simple property access

### Exploratory Work (Defer TDD for)
- **Prototypes**: Proof-of-concept code intended for throwaway
- **Spike Solutions**: Investigating technical approaches or APIs
- **Research Code**: Experimental algorithms or approaches

## The 5 Assessment Questions

Ask these to determine if TDD adds value (Yes = +2 points, ≥6 suggests TDD):

1. **Failure Impact**: Would a bug here significantly impact users or business?
2. **Change Frequency**: Will this code be modified regularly?
3. **Logic Complexity**: Does this involve multiple conditions or edge cases?
4. **External Dependencies**: Does this integrate with other systems?
5. **Team Collaboration**: Will multiple developers work on this code?

**Scoring:** Total ≥6 points → TDD recommended

## Integration with Spec-Driven Development

**TDD-Spec relationship:**
```
MSL Specification (WHAT) → Test Cases (VERIFY) → Implementation (HOW)
```

**Workflow:**
1. Read `.spec.md` file to understand requirements
2. Create test cases that verify each REQ-XXX requirement
3. Red phase: Write failing test
4. Green phase: Implement minimal code to pass
5. Refactor phase: Improve code while keeping tests green

**Requirement traceability:**
```python
def test_user_authentication_validates_password_strength_req_003():
    """Verify REQ-003: Passwords must be 12+ characters with mixed case"""
    # Test implementation
```

## Practical Examples

### ✅ TDD Recommended: User Authentication
```python
# High complexity, security critical, multiple edge cases
def test_user_login_blocks_brute_force_req_015():
    """Verify REQ-015: Block account after 3 failed attempts"""
    # Complexity score: 8 (security + state + business logic)
```

### ⚠️ TDD Optional: Simple Data Access
```python
# Simple CRUD operation, low complexity
def get_user_by_id(user_id):
    """Simple database lookup - integration test sufficient"""
    # Complexity score: 2 (straightforward query)
```

### ❌ TDD Not Recommended: Configuration
```python
# Infrastructure code - validation test more appropriate
def load_database_config():
    """Load config from environment - validate result, not process"""
    # Complexity score: 1 (environment variable reads)
```

## Success Criteria

TDD succeeds when:
- Developers can quickly decide when TDD adds value
- Tests serve as executable documentation of requirements
- Complex code has reliable test coverage
- Simple code avoids test overhead
- Refactoring is performed confidently

---

*Adapted from SpellForge Test-Driven Development policy for LiveSpec distribution. This is an OPTIONAL practice - use judgment based on project complexity.*
