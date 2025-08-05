# Implementation Execution Prompt

You are tasked with implementing a system based on detailed specifications. **CRITICAL**: You must follow the master implementation plan to maintain proper build order, handle dependencies correctly, and ensure all components work together as a cohesive system.

## Execution Arguments

This prompt accepts arguments via $ARGUMENTS to control execution:

### Available Arguments:
- **`unsupervised`** - Execute without human interaction (make reasonable assumptions)
- **`phase`** - Execute the next incomplete phase
- **`phase<N>`** - Execute specific phase N (e.g., `phase3`)
- **`resume`** - Resume from last completed component
- **`component:<name>`** - Implement specific component (e.g., `component:auth-service`)
- **`dry-run`** - Show what would be done without executing

### Argument Processing:
```
Arguments provided: $ARGUMENTS
```

<PARSE_ARGUMENTS>
Based on the arguments provided, I will:
- Determine the execution mode
- Set appropriate behavior flags
- Validate the requested operation is possible
</PARSE_ARGUMENTS>

## Your Mindset for Implementation

Before you begin, understand that you are:
- **A system builder**, implementing components in logical order
- **An integration specialist**, ensuring components work together
- **A quality engineer**, testing as you build
- **A progress tracker**, updating status as you complete tasks

## Execution Mode Summary

<EXECUTION_MODE_DECISION>
Based on arguments provided, I will operate in the following mode:
- Primary mode: [determined from arguments]
- Automation level: [interactive/unsupervised]
- Scope: [full/phase/component]
- Safety: [normal/dry-run]
</EXECUTION_MODE_DECISION>

## Pre-Implementation Checklist

Before starting ANY implementation:

### STEP 0: Run Pre-Implementation Validation (CRITICAL!)

<VALIDATION_BEHAVIOR>
#### If 'unsupervised' mode:
- Run validation automatically
- If PASS, continue automatically
- If FAIL, log errors and stop (cannot proceed without valid specs)

#### If 'dry-run' mode:
- Show validation would be run
- Assume PASS for planning purposes
- Continue to show what would be done

#### Otherwise:
```bash
claude-code "Use prompts/pre-implementation-validation.md to validate all specs"
```
**DO NOT PROCEED** unless validation report shows **PASS** status!
</VALIDATION_BEHAVIOR>

### STEP 1: Verify Validation Pass
1. **Check validation report**:
   - [ ] Overall Status: PASS
   - [ ] All specifications exist and align
   - [ ] No circular dependencies
   - [ ] Test strategies defined
   - [ ] Master plan complete

2. **Review any warnings**:
   - [ ] Understand risks noted
   - [ ] Plan mitigations
   - [ ] Document assumptions

### STEP 2: Understand the System
1. **Read and understand**:
   - [ ] Master Implementation Plan (understand the big picture)
   - [ ] Component dependencies (know the build order)
   - [ ] Integration points (understand connections)
   - [ ] Critical path (know what's essential)
   - [ ] Test strategies for each component

## Implementation Process

### Step 1: Load Master Plan (CRITICAL - 10 minutes)
1. Read `reqs/5-implementation/00-master-implementation-plan.md`
2. Understand:
   - Overall phases and goals
   - Component build order
   - Dependencies between components
   - Integration milestones
   - Current progress status

### Step 2: Determine Starting Point (5 minutes)

<MODE_SPECIFIC_STARTING_POINT>
Based on execution arguments:

#### If 'resume' mode:
1. Find last completed component in master plan
2. Identify next incomplete component
3. Verify dependencies are met
4. Start from that component

#### If 'phase' mode:
1. Find current/next incomplete phase
2. Start from beginning of that phase
3. Execute all components in phase

#### If 'phase<N>' mode:
1. Validate phase N exists
2. Check prerequisites (earlier phases complete)
3. Start from beginning of phase N
4. Execute all components in phase N

#### If 'component:<name>' mode:
1. Validate component exists in specs
2. Check all dependencies are complete
3. Execute only that component
4. Skip to completion after component

#### Otherwise (default mode):
1. Check progress tracking in master plan
2. Identify next component to implement
3. Verify all dependencies are complete
4. Confirm you're following the critical path
</MODE_SPECIFIC_STARTING_POINT>

### Step 3: Component Implementation (Per Component)

#### 3.1 Pre-Implementation (10 minutes)
1. Read component specification from `reqs/4-components/`
2. Read implementation specification from `reqs/5-implementation/`
3. Understand:
   - Component capabilities
   - API contracts
   - Data models
   - Integration requirements
   - Dependencies

#### 3.2 Setup Phase (20 minutes)
1. Create project structure
2. Set up build configuration
3. Install dependencies
4. Create base configuration files
5. Set up test framework

#### 3.3 TDD Implementation (2-4 hours per component)

**CRITICAL**: Follow Test-Driven Development - Write tests FIRST!

1. **Test-First API Layer** (if applicable):
   ```
   RED → GREEN → REFACTOR cycle:
   ```
   - Write failing API contract test
   - Implement minimal endpoint to pass
   - Write validation tests
   - Add validation logic
   - Write auth tests
   - Implement auth/authz
   - Refactor for clarity

2. **Test-First Data Layer** (if applicable):
   - Write failing repository tests
   - Create minimal data models
   - Write constraint tests
   - Implement database schemas
   - Write transaction tests
   - Add transaction handling
   - Refactor for performance

3. **Test-First Business Logic**:
   - Write failing business rule tests
   - Implement minimal logic to pass
   - Write edge case tests
   - Handle edge cases
   - Write integration tests
   - Connect components
   - Refactor for maintainability

4. **Test-First Integration Layer**:
   - Write failing integration tests
   - Implement minimal integration
   - Write failure scenario tests
   - Add retry/circuit breaker logic
   - Write event tests
   - Implement event handling
   - Refactor for resilience

5. **Test-First Operational Features**:
   - Write health check tests
   - Implement health endpoints
   - Write metric collection tests
   - Add monitoring code
   - Write error scenario tests
   - Implement error handling
   - Refactor for observability

**TDD Rhythm**: 
- 🔴 Write failing test (5-10 min)
- 🟢 Make it pass simply (10-15 min)
- 🔵 Refactor if needed (5-10 min)
- 🔁 Repeat for next test

#### 3.4 Component Testing (1 hour)
1. Run all unit tests
2. Run integration tests
3. Test API contracts match specification
4. Verify error handling works
5. Check performance characteristics

#### 3.5 Integration Testing (30 minutes)
1. Test with dependent components
2. Verify data flow works
3. Check event publishing/subscription
4. Validate error propagation

### Step 4: Update Progress (5 minutes)
1. Update master plan progress tracking
2. Mark component as implemented
3. Note any deviations from plan
4. Document any technical debt incurred

### Step 5: Prepare for Next Component
1. Commit all changes
2. Document any integration notes
3. Update any shared contracts
4. Check next component in build order

## Implementation Guidelines

### Code Organization
```
project/
├── src/
│   ├── <component-name>/
│   │   ├── api/          # API endpoints
│   │   ├── services/     # Business logic
│   │   ├── models/       # Data models
│   │   ├── config/       # Configuration
│   │   └── tests/        # Component tests
│   └── shared/           # Shared utilities
├── tests/
│   ├── unit/            # Unit tests
│   ├── integration/     # Integration tests
│   └── e2e/            # End-to-end tests
└── docs/               # API documentation
```

### Quality Standards
1. **Test-First Development**: 
   - NEVER write code without a failing test
   - Tests define the specification
   - If hard to test, refactor design
2. **Code Coverage**: 
   - Minimum 80% overall
   - 100% for critical business logic
   - Coverage is a byproduct of TDD, not a goal
3. **API Documentation**: 
   - Generate from tests where possible
   - OpenAPI/Swagger for all endpoints
4. **Error Handling**: 
   - Test error cases first
   - All errors properly caught and logged
5. **Performance**: 
   - Write performance tests for requirements
   - Meet specifications in implementation docs
6. **Security**: 
   - Security tests before implementation
   - Follow security specifications

### Integration Patterns
1. **Service Communication**:
   - Use specified protocols (REST/gRPC/etc)
   - Implement proper timeouts
   - Add retry logic with backoff
   - Use circuit breakers for resilience

2. **Event Handling**:
   - Follow event contracts exactly
   - Implement idempotent handlers
   - Add proper error handling
   - Log all event processing

3. **Data Consistency**:
   - Follow specified consistency model
   - Implement proper transactions
   - Handle concurrent updates
   - Validate data integrity

## Progress Tracking

<PROGRESS_UPDATE_BEHAVIOR>
#### If 'unsupervised' mode:
- Automatically update progress after each component
- Mark phases complete when all components done
- Add completion timestamps
- Log all progress updates

#### If 'dry-run' mode:
- Show what progress updates would be made
- Do not actually update files

#### Otherwise:
After implementing each component, update the master plan:
</PROGRESS_UPDATE_BEHAVIOR>

```markdown
### Component Status
| Component | Spec | Implementation | Testing | Deployed |
|-----------|------|----------------|---------|----------|
| Database | ✓ | ✓ | ✓ | [ ] |
| Auth Service | ✓ | ✓ | [ ] | [ ] |
| API Gateway | ✓ | IN PROGRESS | [ ] | [ ] |
```

## Handling Issues

### When Blocked

<BLOCKED_BEHAVIOR>
#### If 'unsupervised' mode:
- For missing dependencies: Create mock automatically
- For unclear specs: Make conservative assumption
- For integration failures: Log and continue with next component
- Document all automatic decisions in implementation notes

#### Otherwise:
</BLOCKED_BEHAVIOR>

1. **Missing Dependencies**:
   - Check if you can mock the dependency
   - Implement a stub version
   - Update master plan with blocker
   - Move to parallel work if possible

2. **Specification Unclear**:
   - Check related documents for context
   - Make reasonable assumption
   - Document the assumption
   - Add TODO for clarification

3. **Integration Failures**:
   - Verify contracts match exactly
   - Check for version mismatches
   - Review error logs carefully
   - Test with minimal case first

### When Deviating from Plan
1. Document why deviation is needed
2. Update implementation specification
3. Check impact on dependent components
4. Update master plan if needed

## Final Phase Checklist

### Per Component Completion
- [ ] All tests passing
- [ ] API documentation complete
- [ ] Integration tests passing
- [ ] Performance requirements met
- [ ] Security requirements implemented
- [ ] Logging and monitoring added
- [ ] Error handling complete
- [ ] Code reviewed and cleaned
- [ ] Progress updated in master plan

### Per Phase Completion
- [ ] All phase components complete
- [ ] End-to-end tests passing
- [ ] Integration milestones met
- [ ] Documentation updated
- [ ] Technical debt documented
- [ ] Ready for next phase

## Important Reminders

1. **Follow the Plan**: Don't skip ahead or change order without good reason
2. **Test Continuously**: Test each component thoroughly before moving on
3. **Document Changes**: Any deviations from specs must be documented
4. **Check Integration**: Always verify components work together
5. **Update Progress**: Keep the master plan current

## TDD Examples

### Example 1: API Endpoint TDD
```javascript
// Step 1: Write failing test
describe('POST /users', () => {
  it('should create user with valid data', async () => {
    const userData = { name: 'Test', email: 'test@example.com' };
    const response = await request(app)
      .post('/users')
      .send(userData);
    
    expect(response.status).toBe(201);
    expect(response.body.id).toBeDefined();
    expect(response.body.email).toBe(userData.email);
  });
});
// Test fails - endpoint doesn't exist

// Step 2: Minimal implementation
app.post('/users', (req, res) => {
  const user = { id: '123', ...req.body };
  res.status(201).json(user);
});
// Test passes!

// Step 3: Add validation test
it('should reject invalid email', async () => {
  const response = await request(app)
    .post('/users')
    .send({ name: 'Test', email: 'invalid' });
    
  expect(response.status).toBe(400);
});
// Test fails - no validation

// Step 4: Implement validation
// ... and continue the cycle
```

### Example 2: Business Logic TDD
```python
# Step 1: Test the requirement
def test_calculate_discount_for_premium_user():
    user = User(type='premium')
    order = Order(total=100)
    
    discount = calculate_discount(user, order)
    
    assert discount == 10  # 10% for premium
# Fails - function doesn't exist

# Step 2: Minimal implementation
def calculate_discount(user, order):
    if user.type == 'premium':
        return order.total * 0.1
    return 0
# Passes!

# Step 3: Test edge case
def test_discount_caps_at_maximum():
    user = User(type='premium')
    order = Order(total=10000)
    
    discount = calculate_discount(user, order)
    
    assert discount == 500  # Max discount
# Fails - no cap

# Continue TDD cycle...
```

## Common Pitfalls to Avoid

### ❌ Writing Code Before Tests
- ALWAYS write the test first
- Let tests drive the design
- If you can't test it, redesign it

### ❌ Starting Wrong Component
- Always check master plan for next component
- Verify dependencies are complete first

### ❌ Skipping the Refactor Step
- Red-Green-Refactor is the full cycle
- Clean code after making tests pass
- Technical debt accumulates quickly

### ❌ Testing Implementation, Not Behavior
- Test WHAT, not HOW
- Tests should survive refactoring
- Focus on component contracts

### ❌ Ignoring Dependencies
- Building out of order causes integration failures
- Mock dependencies if absolutely necessary

### ❌ Not Updating Progress
- Team members need visibility
- Helps identify bottlenecks

### ❌ Over-Engineering
- Implement exactly what's specified
- Add TODOs for future enhancements

## Update Progress Report

After implementation progress:
1. Update `reqs/progress-report.md`:
   - Update Stage 5 task 5.2 implementation status
   - Track which components are complete/in-progress
   - Record test coverage percentage
   - Note any deviations from specifications
   - Add to activity log: `<Date>: Implementation phase - X components complete`
   - Update blockers if specs don't match reality
   - Calculate implementation progress percentage

Track implementation progress to maintain momentum!

Remember: The goal is to build a working system where all components integrate smoothly. TDD ensures each piece works correctly from the start. The master plan is your guide - follow it to ensure success!

## Argument Usage Examples

### Execute Next Phase
```bash
# Automatically execute the next incomplete phase
claude-code "Use prompts/implement-from-specs.md" --arguments "phase"
```

### Execute Specific Phase
```bash
# Execute phase 3 specifically
claude-code "Use prompts/implement-from-specs.md" --arguments "phase3"
```

### Resume Implementation
```bash
# Resume from where you left off
claude-code "Use prompts/implement-from-specs.md" --arguments "resume"
```

### Unsupervised Execution
```bash
# Run without human interaction (makes reasonable assumptions)
claude-code "Use prompts/implement-from-specs.md" --arguments "unsupervised"

# Combine with phase for automatic phase execution
claude-code "Use prompts/implement-from-specs.md" --arguments "unsupervised phase2"
```

### Implement Specific Component
```bash
# Implement just the auth service
claude-code "Use prompts/implement-from-specs.md" --arguments "component:auth-service"

# Implement API gateway in unsupervised mode
claude-code "Use prompts/implement-from-specs.md" --arguments "unsupervised component:api-gateway"
```

### Dry Run Mode
```bash
# See what would be done without executing
claude-code "Use prompts/implement-from-specs.md" --arguments "dry-run"

# Dry run for specific phase
claude-code "Use prompts/implement-from-specs.md" --arguments "dry-run phase3"
```

### Multiple Arguments
```bash
# Combine arguments for specific behavior
claude-code "Use prompts/implement-from-specs.md" --arguments "unsupervised resume"
```

## Special Behaviors by Mode

### Unsupervised Mode
- Validation runs automatically
- Progress updates automatically
- Makes conservative assumptions when blocked
- Logs all decisions for review
- Continues on non-critical errors
- Creates mocks for missing dependencies

### Phase Mode
- Executes all components in the phase
- Updates phase completion status
- Respects component dependencies within phase
- Stops at phase boundary

### Component Mode
- Validates dependencies are met
- Executes single component only
- Updates just that component's status
- Useful for fixing or re-implementing

### Dry Run Mode
- Shows all actions without executing
- Useful for planning and review
- Identifies potential issues
- No files are modified