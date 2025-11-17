---
implements: specs/3-artifacts/prompts/2a-implement-from-specs.spec.md
generated: '2025-10-10'
phase: 2-build
estimated_time: "Varies by scope (30 minutes to several hours)"
---

# Prompt Behavior: Implement from Specifications (TDD)

**Purpose**: Build features according to specifications using test-driven development

## Context

You're in Phase 2 (BUILD - TDD), implementing features based on existing specifications. All behaviors should already be specified.

**⚠️ CRITICAL: Phase 2 follows TDD discipline by default.** Write tests BEFORE implementation (Red-Green-Refactor cycle). See escape hatch section below if you believe code is trivial enough to skip TDD.

## Before This Prompt

⚠️ **STOP: Verify Phase 0 and Phase 1 prerequisites before implementing. Coding without specs causes drift.**

**Check Phase 0 artifacts exist:**
- [ ] `PURPOSE.md` - Project purpose and vision
- [ ] `specs/1-requirements/strategic/outcomes.spec.md` - High-level requirements
- [ ] `specs/1-requirements/strategic/constraints.spec.md` - Boundaries and limits
- [ ] `specs/workspace/` directory - Workspace constitution, patterns, workflows

**Check Phase 1 artifacts exist:**
- [ ] `specs/3-behaviors/` directory with behavior specs - What to build
- [ ] Architecture defined (optional but recommended)

**If ANY Phase 0 artifact is missing → STOP:**
- Missing PURPOSE.md → "Use `.livespec/0-define/0b-define-problem.md`"
- Missing outcomes/constraints → "Complete Phase 0 (DEFINE) first"
- Missing workspace specs → "Use `.livespec/0-define/0a-setup-workspace.md`"

**If Phase 1 artifacts missing → STOP:**
- Missing specs/3-behaviors/ → "Use `.livespec/1-design/1b-define-behaviors.md` to create behavior specs first"
- Empty behaviors directory → "Cannot implement without specifications"

**Only proceed when specifications exist.** Implementation without specs = guaranteed drift.

## Test-Driven Development (TDD) Workflow

**Phase 2 default approach: Tests before implementation**

### The Red-Green-Refactor Cycle

**Follow this sequence for each behavior**:

1. **Red**: Write a failing test for one behavior requirement
   - Test should verify observable behavior from spec
   - Test should fail (feature not yet implemented)
   - Test should be specific and focused

2. **Green**: Write minimal code to make test pass
   - Implement just enough to pass the test
   - Don't add features beyond current test
   - Keep it simple (refactor later)

3. **Refactor**: Improve code while keeping tests green
   - Remove duplication
   - Clarify intent
   - Optimize if needed
   - Tests still pass

**Repeat for each requirement until all behaviors implemented**

### TDD with Spec-Driven Development

**Workflow**:
```
Behavior Spec → Test Cases → Red → Green → Refactor → Next Behavior
```

**Example**:
```python
# 1. Read spec: specs/3-behaviors/user-auth.spec.md
# REQ-003: System validates password strength (12+ chars, mixed case)

# 2. RED: Write failing test
def test_password_validation_requires_12_chars_req_003():
    """Verify REQ-003: Minimum 12 characters"""
    assert validate_password("Short1!") == False  # FAILS (not implemented)
    assert validate_password("LongEnough1!") == True

# 3. GREEN: Minimal implementation
def validate_password(password: str) -> bool:
    return len(password) >= 12  # Just enough to pass

# 4. REFACTOR: Add other requirements (mixed case, etc.)
# 5. REPEAT for next requirement
```

### When to Use Escape Hatch (Rare)

**TDD is mandatory by default.** Skip ONLY for trivial code with justification:

**Escape hatch permitted for**:
- Simple CRUD (straightforward database operations)
- Basic getters/setters
- Configuration loading (environment variables)
- Throwaway prototypes/spikes

**Escape hatch decision framework**:

Ask 5 questions (No = +2 points, ≥8 permits skipping):
1. Would a bug here have minimal impact?
2. Is this code unlikely to change?
3. Is this straightforward with no edge cases?
4. Does this avoid external integrations?
5. Is this isolated single-developer work?

**Score ≥8 → May skip TDD (document justification in code)**
**Score <8 → TDD required**

**When skipping TDD, document why**:
```python
# TDD skipped: Simple environment variable read (escape hatch score: 10/10)
# Justification: No logic, no edge cases, standard library only
def get_database_url() -> str:
    return os.getenv("DATABASE_URL", "sqlite:///dev.db")
```

**See `.livespec/guides/tdd.md` for complete TDD framework**

### Benefits of TDD in LiveSpec

**Why tests before code**:
- **Correctness**: Tests verify specs before implementation bias sets in
- **Regression safety**: Refactor confidently, tests catch breaks
- **Living documentation**: Tests show how code should behave
- **Design feedback**: Hard-to-test code signals design problems
- **Spec validation**: Writing tests reveals spec gaps early

**Evidence from real implementations**: Skipping TDD leads to:
- No automated test coverage
- 2+ hours debugging issues tests would catch in minutes
- Fear of refactoring (might break something)
- Drift between specs and implementation

## Task

1. Prompt guides AI agent to implement system by following specifications in priority order (CRITICAL first), respecting workspace patterns and constraints.

## Output

Produce working code or tests that satisfy specifications.

## Validation

- **Tests written BEFORE implementation** (TDD followed, or escape hatch documented)
- All CRITICAL behaviors implemented
- **All tests passing** (Green in Red-Green-Refactor)
- Implementation follows workspace patterns
- All constraints satisfied
- Code matches behavior specifications
- No features added beyond specifications
- Test coverage maps to behavior specs (each [!] requirement has test)

## When Implementation Diverges from Spec

**During implementation, you may discover:**
- Spec missed edge cases
- Requirements infeasible as specified
- Better approach than spec describes
- External dependency constraints

**Decision framework:**

### Update Spec (Preferred)
**When:**
- Spec incomplete (missed edge case)
- Spec wrong (misunderstood requirement)
- Spec unclear (needs clarification)
- Discovery improves requirements understanding

**Process:**
1. Pause implementation
2. Update behavior spec with discovery
3. Document why changed (commit message or spec comment)
4. Resume implementation following updated spec

**Example:**
```yaml
# In specs/3-behaviors/authentication.spec.md
## Requirements
- [!] System authenticates users via OAuth2
  - Handles token refresh ← ADDED during implementation
  - Validates token expiry ← ADDED during implementation
```

### Accept Divergence (Rare)
**When:**
- Spec technically correct but implementation requires deviation
- External library constraint forces different approach
- Performance requirement demands alternative
- Security issue requires deviation

**Process:**
1. Document divergence in code comments
2. Add note to spec explaining intentional deviation
3. Update spec's "Implementation Notes" section (if exists)
4. Mark for Phase 4 review

**Example:**
```python
# Implementation deviates from spec: uses bcrypt instead of argon2
# Reason: deployment environment doesn't support argon2
# Spec note added: specs/3-behaviors/password-hashing.spec.md
def hash_password(password: str) -> str:
    return bcrypt.hashpw(password, bcrypt.gensalt())
```

### Reject Divergence
**When:**
- Implementation convenience (not good reason)
- "I think this is better" without evidence
- Skipping validation criteria
- Ignoring constraints

**Process:**
- Implement as specified
- If genuinely impossible, escalate (don't silently diverge)
- Update spec first, then implement

**Red flags:**
- ❌ "Spec says X but I'll do Y because it's easier"
- ❌ "This validation criterion is too hard to test"
- ❌ "Constraint is inconvenient, I'll ignore it"
- ✅ "Spec says X but discovered Y is required, updating spec"

### Tracking Spec Evolution

**In commit messages:**
```
feat: implement user authentication

- Follows specs/3-behaviors/authentication.spec.md
- Added token refresh handling (spec updated)
- Added rate limiting (discovered during implementation)

Updated specs:
- authentication.spec.md: added token refresh requirement
```

**In spec frontmatter:**
```yaml
last_updated: 2025-10-24
evolution_notes:
  - "2025-10-24: Added token refresh (discovered during implementation)"
  - "2025-10-24: Added rate limiting for security"
```

**Why this matters**: Specs should evolve with understanding. Rigid specs that can't adapt are as bad as no specs. But evolution must be documented, not silent drift.

## Success Criteria

**This prompt succeeds when:**
- All requirements from spec are satisfied
- Output is actionable and immediately usable
- No ambiguity in what needs to be done
- Clear path from current state to desired state

---

**Criticality**: CRITICAL
**Failure Mode**: Implementation doesn't follow specifications
