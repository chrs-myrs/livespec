# Test-Driven Development Guide (Optional)

LiveSpec doesn't prescribe implementation methodology for Phase 2 (BUILD) — that's the coding agent's domain. LiveSpec's own involvement in Phase 2 stops at spec-first enforcement (see `templates/agents/spec-first-enforcement.md`). This guide is optional reference material for teams or agents who want a structured TDD approach; call on it deliberately, don't treat it as a default.

## Philosophy

TDD is **one approach available** for Phase 2 (BUILD) — not a LiveSpec requirement. Write tests before implementation when it suits the work: ensures correctness, enables refactoring, prevents regression.

**Core belief:** Use this guide when you want TDD discipline; skip it entirely when it doesn't fit. The escape-hatch scoring below is a tool for deciding *within* a TDD approach when to skip it for trivial code — not a claim that TDD itself is mandatory.

## When TDD is Required (Default)

**Use TDD for all code UNLESS escape hatch applies:**

### Complexity Indicators (TDD required)
- **Business Logic**: Multiple conditional paths, edge cases, or rules
- **Algorithms**: Complex calculations, data transformations, or optimizations
- **State Management**: Objects with complex internal state transitions
- **Error Handling**: Non-trivial error recovery or validation logic
- **Integration Points**: APIs, message handlers, or external service interfaces

### Risk Factors (TDD required)
- **High-Impact Failures**: Bugs cause significant user/business impact
- **Frequent Changes**: Code that evolves regularly needs test safety
- **Security Critical**: Authentication, authorization, data validation
- **Performance Sensitive**: Code where regressions have user impact

## When Escape Hatch Applies (Justification Required)

**You may skip TDD ONLY for truly trivial code with documented justification:**

### Simple Operations (Escape hatch permitted)
- **Basic CRUD**: Simple create, read, update, delete without complex logic
- **Data Mapping**: Straightforward object transformations
- **Configuration**: Environment setup, dependency injection wiring
- **Trivial Functions**: Getters, setters, simple property access

### Exploratory Work (Escape hatch permitted)
- **Prototypes**: Proof-of-concept code intended for throwaway
- **Spike Solutions**: Investigating technical approaches or APIs
- **Research Code**: Experimental algorithms or approaches

**Important**: Document why TDD was skipped (code comment or commit message). Be conservative - when uncertain, use TDD.

## The 5 Escape Hatch Assessment Questions

**TDD is default.** Ask these to determine if escape hatch applies (No = +2 points, ≥8 permits skipping TDD):

1. **Failure Impact**: Would a bug here have minimal impact on users or business?
2. **Change Frequency**: Is this code unlikely to be modified?
3. **Logic Complexity**: Is this straightforward with no edge cases?
4. **External Dependencies**: Does this avoid integration with other systems?
5. **Team Collaboration**: Is this isolated work by single developer?

**Scoring:** Total ≥8 points → Escape hatch may apply (justify in code/commit)
**Scoring:** Total <8 points → TDD required

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

When you do use this guide, it succeeds when:
- Test-first discipline is followed consistently for the work you chose it for
- Tests serve as executable documentation of requirements
- Non-trivial code has automated test coverage
- Escape hatch used conservatively with justification
- Refactoring is performed confidently with test safety
- Red-Green-Refactor cycle becomes natural workflow

---

*Adapted from SpellForge Test-Driven Development policy for LiveSpec distribution. Optional guidance — LiveSpec does not mandate TDD or any other implementation methodology in Phase 2 (BUILD).*
