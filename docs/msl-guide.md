# MSL: Minimal Specification Language

## Philosophy

Traditional specifications are too long. They include nice-to-haves, obvious statements, and implementation details. MSL strips everything to the absolute minimum while remaining complete.

**The MSL Test**: Can I remove any word without losing essential meaning?

If yes → remove it.

## The Four Sections

Every MSL specification has exactly four sections:

```markdown
# [Specification Name]

**Criticality**: CRITICAL | IMPORTANT
**Failure Mode**: [What breaks without this]

## Specification
[Minimal description of the requirement]

## Validation
[How to verify this is met]
```

**No other sections allowed.**

## Section 1: Criticality

Only two levels allowed:

### CRITICAL
System fails without this. Literally breaks.

**Examples:**
- "Users cannot access the system" → CRITICAL
- "Data is lost" → CRITICAL
- "Security breach possible" → CRITICAL

### IMPORTANT
System works but quality degrades significantly.

**Examples:**
- "Performance is poor" → IMPORTANT
- "User experience suffers" → IMPORTANT
- "Maintenance is difficult" → IMPORTANT

### NOT ALLOWED

❌ **"Should have"** - Too vague
❌ **"Nice to have"** - Not minimal
❌ **"Could have"** - Remove it
❌ **"Recommended"** - Not a requirement

**If it's not CRITICAL or IMPORTANT, delete it.**

## Section 2: Failure Mode

**Purpose**: Explain specifically what breaks.

**Format**: One sentence describing the concrete failure.

### Good Failure Modes

✅ "Users cannot log in without authentication"
✅ "Data corruption occurs without validation"
✅ "System unusable on mobile without responsive design"
✅ "Integration breaks without API versioning"

### Bad Failure Modes

❌ "Not having authentication would be problematic" - Vague
❌ "Users might have issues" - Not specific
❌ "System quality degrades" - What does this mean?
❌ "This is important because security" - Not a failure mode

## Section 3: Specification

**Purpose**: Describe WHAT, not HOW.

**Format**: One sentence or short paragraph.

### The Test

Before writing, ask:
1. **Would the system fail without this?** (Validates criticality)
2. **Am I specifying HOW instead of WHAT?** (Remove implementation)
3. **What specific problem does this prevent?** (Focus on real need)
4. **Could this be inferred?** (Remove obvious)

### Examples

**Before MSL (verbose):**
```markdown
The system should implement a secure authentication mechanism using
industry-standard practices. Users will be able to register with email
and password, and the password should be hashed using bcrypt with a
cost factor of 12. The system will validate email format and enforce
password complexity rules including minimum 8 characters, at least one
number, and one special character. Session tokens will expire after
30 minutes of inactivity...
```

**After MSL (minimal):**
```markdown
# User Authentication

**Criticality**: CRITICAL
**Failure Mode**: System unsecured without authentication

## Specification
System authenticates users via email and password before allowing access
to protected resources.

## Validation
- Valid credentials allow login
- Invalid credentials rejected
- Sessions persist until logout
- Protected resources require authentication
```

**What changed:**
- ❌ Removed HOW (bcrypt, cost factor 12)
- ❌ Removed nice-to-haves (complexity rules)
- ❌ Removed implementation (session timeout value)
- ✅ Kept WHAT (authenticate users)
- ✅ Kept observable outcomes (login works/fails)

### Common Mistakes

❌ **Implementation details:**
"Use React hooks for state management" → HOW, not WHAT

❌ **Technology choices:**
"Store data in PostgreSQL" → Implementation

❌ **Nice-to-haves:**
"UI should be user-friendly" → Too vague, not critical

❌ **Obvious statements:**
"Code should be well-structured" → Every project

✅ **What system does:**
"System exports data as CSV"

✅ **Observable behavior:**
"API returns 200 on success"

✅ **Critical constraints:**
"Must handle 10K concurrent users"

## Section 4: Validation

**Purpose**: Define how to verify the specification is met.

**Format**: Bulleted list of observable, testable criteria.

### Good Validation Criteria

✅ **Objective**: "API responds within 200ms"
✅ **Observable**: "User can download CSV file"
✅ **Testable**: "All tests in test_auth.py pass"
✅ **Specific**: "Supports Chrome, Firefox, Safari"

### Bad Validation Criteria

❌ **Subjective**: "UI looks good"
❌ **Vague**: "Works correctly"
❌ **Untestable**: "Code is maintainable"
❌ **Implementation**: "Uses proper design patterns"

### Validation from Tests

Tests are excellent validation criteria:

```python
# test_authentication.py
def test_valid_credentials_allow_login():
    ...

def test_invalid_credentials_rejected():
    ...

def test_session_persists_after_login():
    ...
```

Becomes:

```markdown
## Validation
- Valid credentials allow login
- Invalid credentials rejected
- Session persists after login
```

**The test name IS the validation criterion.**

## The Minimization Process

### Step 1: Write Everything

First draft - include everything you think matters:

```markdown
# User Dashboard

The user dashboard is a critical component that provides users with
an overview of their account activity. It should display recent
transactions, account balance, and pending notifications. The design
should be responsive and work on mobile devices. Performance is
important, so data should load quickly. Users should be able to refresh
the data manually. The dashboard should update automatically every 60
seconds. It needs to handle users with thousands of transactions
efficiently...
```

### Step 2: Ask MSL Questions

For each statement:

- **Would system fail without this?**
  - Fail → Keep
  - Degrade → Maybe keep
  - Nice to have → Delete

- **Is this HOW not WHAT?**
  - "refresh button" → Implementation
  - "users can refresh data" → Keep

- **Is this obvious?**
  - "should work correctly" → Delete
  - "should be secure" → Delete (covered elsewhere)

### Step 3: Reduce to Minimum

```markdown
# User Dashboard

**Criticality**: CRITICAL
**Failure Mode**: Users cannot view account activity without dashboard

## Specification
Dashboard displays user's recent transactions, current balance, and
pending notifications with data refreshed automatically.

## Validation
- Recent transactions shown (last 30 days)
- Current balance displayed
- Pending notifications visible
- Data refreshes without manual action
- Handles 10K+ transactions without degradation
```

**70% reduction. Same essential information.**

## Criticality Decision Tree

```
START: Do I need this requirement?
  ↓
Does system literally FAIL without it?
  YES → CRITICAL
  NO → ↓

Does quality significantly DEGRADE without it?
  YES → IMPORTANT
  NO → ↓

Would users notice if missing?
  YES → IMPORTANT (maybe)
  NO → DELETE

Is this a preference or nice-to-have?
  YES → DELETE
  NO → Reconsider if truly IMPORTANT
```

### Concrete Examples Across Domains

Here are real-world examples to help you classify criticality correctly:

#### Web Application

**CRITICAL:**
- User authentication (system unsecured without it)
- Data persistence (data loss without it)
- Payment processing (core function fails)
- Password validation (security breach possible)
- HTTPS encryption (credentials exposed)

**IMPORTANT:**
- Response caching (performance degrades significantly)
- Search functionality (major UX degradation)
- Input validation error messages (user experience suffers)
- Mobile responsive layout (system unusable on mobile)
- Loading indicators (users confused about system state)

**DELETE (Not minimal):**
- ❌ Dark mode toggle (user preference)
- ❌ Animated transitions (aesthetic preference)
- ❌ Multiple theme options (nice-to-have)
- ❌ Social media sharing buttons (optional feature)
- ❌ "Powered by" footer (branding preference)

#### REST API

**CRITICAL:**
- Request authentication (API unsecured)
- Rate limiting (API abuse possible)
- Data validation (data corruption possible)
- Error responses (clients cannot handle failures)
- CORS configuration (browser clients blocked)

**IMPORTANT:**
- API versioning (breaking changes impact users)
- Request logging (debugging becomes difficult)
- Response pagination (performance degrades with large datasets)
- Idempotency for POST/PUT (duplicate operations possible)
- Response time < 200ms (user experience suffers)

**DELETE (Not minimal):**
- ❌ GraphQL support in addition to REST (preference)
- ❌ Webhooks for all events (nice-to-have)
- ❌ Batch operations endpoint (convenience feature)
- ❌ Response compression (optimization detail)
- ❌ JSON vs XML format options (implementation choice)

#### Data Model

**CRITICAL:**
- Primary keys (data integrity fails)
- Foreign key constraints (orphaned records possible)
- NOT NULL on critical fields (invalid data possible)
- Unique constraints on identifiers (duplicate records possible)
- Transaction support (data corruption possible)

**IMPORTANT:**
- Indexes on query fields (performance degrades)
- Cascade delete rules (manual cleanup required)
- Timestamp fields (audit trail missing)
- Data type validation (quality degrades)
- Default values (inconsistent data)

**DELETE (Not minimal):**
- ❌ Specific database engine (PostgreSQL vs MySQL - implementation)
- ❌ Table naming convention (style preference)
- ❌ Field naming (camelCase vs snake_case - implementation)
- ❌ Materialized views (optimization detail)
- ❌ Partitioning strategy (performance optimization)

#### Mobile App

**CRITICAL:**
- Offline mode for core features (app unusable without network)
- Data synchronization (data loss possible)
- Touch target sizing ≥ 44px (app unusable on mobile)
- Authentication (app unsecured)
- Crash reporting (cannot diagnose failures)

**IMPORTANT:**
- Swipe gestures for navigation (UX degrades significantly)
- Pull-to-refresh (poor UX without it)
- Loading states (users confused)
- Network error handling (user experience suffers)
- App launch time < 2s (UX degrades)

**DELETE (Not minimal):**
- ❌ Custom app icon themes (preference)
- ❌ Haptic feedback (nice-to-have)
- ❌ 3D touch support (platform-specific feature)
- ❌ Widget support (optional feature)
- ❌ Siri shortcuts (convenience feature)

#### Infrastructure/DevOps

**CRITICAL:**
- Automated backups (data loss possible)
- Deployment rollback capability (cannot recover from bad deploys)
- Health check endpoints (cannot detect failures)
- SSL/TLS certificates (security breach possible)
- Database connection pooling (app fails under load)

**IMPORTANT:**
- Monitoring and alerting (cannot detect issues proactively)
- Log aggregation (debugging becomes difficult)
- Auto-scaling (performance degrades under load)
- Blue-green deployment (downtime during deploys)
- Container resource limits (resource contention possible)

**DELETE (Not minimal):**
- ❌ Specific CI/CD tool (Jenkins vs GitLab - implementation)
- ❌ Infrastructure as code format (Terraform vs Ansible - choice)
- ❌ Container orchestration (Kubernetes vs Docker Swarm - implementation)
- ❌ Log retention 90 days vs 30 days (policy detail)
- ❌ Monitoring dashboard aesthetics (preference)

#### Business Logic

**CRITICAL:**
- Inventory deduction on purchase (overselling possible)
- Tax calculation (incorrect billing)
- Refund processing (financial loss possible)
- Discount code validation (revenue loss possible)
- Order confirmation emails (users unaware of purchase)

**IMPORTANT:**
- Abandoned cart recovery (revenue impact)
- Product recommendation engine (conversion rate degrades)
- Shipping cost calculation accuracy (customer experience suffers)
- Stock level warnings (inventory management difficult)
- Multiple payment method support (limits customer base)

**DELETE (Not minimal):**
- ❌ Wishlist functionality (nice-to-have feature)
- ❌ Gift wrapping option (optional add-on)
- ❌ Product comparison tool (convenience feature)
- ❌ Recently viewed items (preference)
- ❌ Social proof badges (marketing enhancement)

### Pattern Recognition

After reviewing these examples, notice the patterns:

**CRITICAL = System literally fails**
- Security breach possible
- Data loss or corruption
- Core functionality unavailable
- Legal/compliance violation
- Financial loss

**IMPORTANT = Quality significantly degrades**
- Performance problems
- Major UX issues
- Debugging impossible
- Business metrics impacted
- Accessibility barriers

**DELETE = Preference or optimization**
- "Would be nice"
- "Looks better"
- "More convenient"
- "Follows best practice" (without specific failure mode)
- Technology choices (unless constrained)

When in doubt, ask: **"What specifically breaks if we omit this?"** If the answer is vague or starts with "it would be better if...", delete it.

## Red Flags

Watch for these phrases that indicate non-MSL:

❌ "should be" - Probably not critical
❌ "would be nice" - Delete it
❌ "best practice" - Implementation
❌ "follows standard X" - How, not what
❌ "high quality" - Vague
❌ "user-friendly" - Subjective
❌ "scalable" - Be specific (how much scale?)
❌ "maintainable" - Implementation concern

## Real-World Examples

### Before

```markdown
# Payment Processing

The system needs to implement a robust and secure payment processing
system that handles credit cards, debit cards, and digital wallets.
It should use industry-standard encryption (TLS 1.3) and be PCI DSS
compliant. The payment flow should be intuitive and guide users through
the process with clear messaging. Error handling should be comprehensive
with user-friendly messages...
```

### After

```markdown
# Payment Processing

**Criticality**: CRITICAL
**Failure Mode**: Users cannot complete purchases without payment processing

## Specification
System processes credit card, debit card, and digital wallet payments
securely with encrypted transmission.

## Validation
- Successfully processes valid payment methods
- Rejects invalid payment information
- Encrypts payment data in transit
- Returns confirmation for successful payments
- Returns clear error for failed payments
```

## Common Specifications

Here are templates for common needs:

### API Endpoint

```markdown
# [Endpoint Name]

**Criticality**: CRITICAL | IMPORTANT
**Failure Mode**: [What breaks without this endpoint]

## Specification
Endpoint [HTTP method] [path] [does what] and returns [what format].

## Validation
- Accepts valid requests
- Returns correct response format
- Rejects invalid requests
- Handles [specific edge cases]
```

### Data Validation

```markdown
# [Data Type] Validation

**Criticality**: CRITICAL
**Failure Mode**: Invalid data causes [specific failure]

## Specification
System validates [data type] against [criteria] before [action].

## Validation
- Valid data accepted
- Invalid data rejected with clear error
- Edge cases handled ([list specific cases])
```

### User Workflow

```markdown
# [Workflow Name]

**Criticality**: CRITICAL | IMPORTANT
**Failure Mode**: Users cannot [achieve goal] without this workflow

## Specification
Users can [do action] by [sequence of steps] resulting in [outcome].

## Validation
- Users complete workflow successfully
- Each step functions correctly
- Final outcome achieved
- Errors handled appropriately
```

## Measuring Success

**Good MSL specifications:**
- ✅ 70% smaller than traditional specs
- ✅ All bullet points are testable
- ✅ No "should" or "nice to have"
- ✅ No implementation details
- ✅ Can't be further reduced
- ✅ AI agents understand them
- ✅ Humans understand them

**If your spec doesn't meet these criteria, keep reducing.**

---

**Remember**: MSL is about brutal minimalism. If you're unsure whether to keep something, delete it. You can always add it back if truly needed.
