# Validation Patterns

## Purpose

This guide provides domain-specific patterns for writing testable validation criteria in MSL specifications. Good validation criteria are **observable**, **measurable**, and **technology-agnostic**.

## The Validation Test

Before adding validation criteria, ask:

1. **Can I observe this?** - Is it visible in system behavior?
2. **Can I measure this?** - Is there a clear pass/fail?
3. **Does this specify HOW?** - If yes, remove it
4. **Is this subjective?** - If yes, make it objective

## Performance Validation

### Load Time
✅ **Good:**
- Initial page render < 1.8s
- Time to interactive < 3.5s
- First contentful paint < 1.0s

❌ **Bad:**
- Page loads quickly
- Performance is good
- Uses optimal loading strategy

### Resource Size
✅ **Good:**
- Total JavaScript ≤ 200KB
- Total CSS ≤ 50KB
- Images optimized (< 500KB total)

❌ **Bad:**
- Bundle size is reasonable
- Assets are compressed
- Uses efficient loading

### Response Time
✅ **Good:**
- API responds within 200ms (p95)
- Database queries < 100ms (p99)
- Search returns results < 500ms

❌ **Bad:**
- System responds quickly
- Performance meets expectations
- Queries are optimized

### Throughput
✅ **Good:**
- Handles 1000 requests/second
- Processes 10K concurrent users
- Batch job completes 100K records/minute

❌ **Bad:**
- System scales well
- Can handle load
- Performance is acceptable

## Accessibility Validation

### Contrast & Visibility
✅ **Good:**
- Text contrast ratio ≥ 4.5:1 (WCAG AA)
- Focus indicators visible (3:1 contrast)
- Touch targets ≥ 44x44px

❌ **Bad:**
- Text is readable
- Focus is visible
- Buttons are tappable

### Keyboard Navigation
✅ **Good:**
- All interactive elements reachable via Tab
- Modal dismissible with Escape
- Form submittable with Enter

❌ **Bad:**
- Keyboard accessible
- Navigation works
- Follows best practices

### Screen Reader Support
✅ **Good:**
- Images have alt text
- Form inputs have labels
- Error messages announced
- Headings follow h1-h6 hierarchy

❌ **Bad:**
- Screen reader friendly
- Accessible markup
- ARIA compliant

## UI Behavior Validation

### State Visibility
✅ **Good:**
- Loading spinner visible during API calls
- Error message displayed on validation failure
- Success notification shown after save

❌ **Bad:**
- User feedback provided
- States are clear
- UI is responsive

### Interaction Feedback
✅ **Good:**
- Button shows hover state
- Form shows validation errors inline
- Modal opens within 100ms of click

❌ **Bad:**
- Interactive elements respond
- Feedback is immediate
- User knows what's happening

### Animation & Motion
✅ **Good:**
- Transitions respect prefers-reduced-motion
- Animations complete within 300ms
- No parallax if reduced-motion enabled

❌ **Bad:**
- Animations are smooth
- Motion is appropriate
- Follows user preferences

### Responsive Behavior
✅ **Good:**
- Layout adapts at 768px breakpoint
- Images scale to container width
- Navigation converts to hamburger menu on mobile

❌ **Bad:**
- Works on mobile
- Responsive design
- Adapts to screen size

## API Validation

### Success Responses
✅ **Good:**
- Returns 200 for successful GET
- Returns 201 for successful POST
- Response includes required fields: id, timestamp

❌ **Bad:**
- Returns success
- Response is correct
- Works as expected

### Error Handling
✅ **Good:**
- Returns 400 for invalid request body
- Returns 401 for missing authentication
- Returns 404 for non-existent resource
- Error response includes message field

❌ **Bad:**
- Handles errors properly
- Returns appropriate status
- Error handling is robust

### Rate Limiting
✅ **Good:**
- Allows 100 requests/minute per user
- Returns 429 when limit exceeded
- Response headers include X-RateLimit-Remaining

❌ **Bad:**
- Prevents abuse
- Rate limits enforced
- Handles high traffic

### Authentication
✅ **Good:**
- Rejects requests without valid token
- Token expires after 1 hour
- Supports token refresh

❌ **Bad:**
- Secured properly
- Authentication works
- Protected endpoints

## Data Validation

### Format Validation
✅ **Good:**
- Email matches pattern: `^[^@]+@[^@]+\.[^@]+$`
- Phone accepts 10-15 digits
- Date format: YYYY-MM-DD

❌ **Bad:**
- Email is valid
- Phone number correct
- Date properly formatted

### Range Validation
✅ **Good:**
- Age between 18-120
- Price > 0 and < 1000000
- Quantity is positive integer

❌ **Bad:**
- Age is reasonable
- Price is valid
- Quantity makes sense

### Required Fields
✅ **Good:**
- Name field cannot be empty
- Email field must be present
- Password minimum 8 characters

❌ **Bad:**
- Required fields provided
- Mandatory data present
- Validates inputs

### Data Integrity
✅ **Good:**
- Foreign key references existing record
- Unique constraint on email field
- Transaction commits or fully rolls back

❌ **Bad:**
- Data is consistent
- Integrity maintained
- No orphaned records

## Security Validation

### Authentication
✅ **Good:**
- Login fails with invalid credentials
- Account locks after 5 failed attempts
- Password reset requires email verification

❌ **Bad:**
- Authentication is secure
- Credentials protected
- Login process safe

### Authorization
✅ **Good:**
- Regular users cannot access admin endpoints
- Users can only view their own data
- DELETE requires admin role

❌ **Bad:**
- Permissions enforced
- Access controlled
- Authorization works

### Input Sanitization
✅ **Good:**
- SQL injection attempts rejected
- XSS payloads escaped in output
- File uploads restricted to: .jpg, .png, .pdf

❌ **Bad:**
- Inputs sanitized
- Protected against attacks
- Security hardened

## Integration Validation

### External APIs
✅ **Good:**
- Handles 500 errors from payment API
- Retries failed requests 3 times
- Timeout after 5 seconds

❌ **Bad:**
- Integrates properly
- Handles failures
- Robust error handling

### Database
✅ **Good:**
- Connection pool maintains 10-50 connections
- Queries use prepared statements
- Transactions isolated (READ COMMITTED level)

❌ **Bad:**
- Database connection stable
- Queries are safe
- Data access optimized

### Message Queues
✅ **Good:**
- Messages processed within 1 second
- Failed messages moved to dead letter queue after 3 attempts
- Queue depth stays below 1000 messages

❌ **Bad:**
- Queue processing works
- Messages handled correctly
- Reliable messaging

## Test-Based Validation

The best validation criteria often come directly from tests:

### From Test Names
```python
def test_user_can_login_with_valid_credentials():
    ...

def test_login_fails_with_invalid_password():
    ...

def test_session_expires_after_1_hour():
    ...
```

### Becomes Validation
```markdown
## Validation
- User can login with valid credentials
- Login fails with invalid password
- Session expires after 1 hour
```

**The test name IS the validation criterion.**

## Combining Validation Patterns

Real specifications often combine multiple patterns:

```markdown
# User Authentication API

**Criticality**: CRITICAL
**Failure Mode**: System unsecured without authentication

## Specification
API authenticates users via email and password, issues session token, and enforces rate limits.

## Validation
- POST /auth/login returns 200 with token for valid credentials
- Returns 401 for invalid credentials
- Returns 429 after 10 failed attempts per minute
- Session token expires after 1 hour
- Token required for protected endpoints (401 without token)
- Requests within limit succeed
- Response time < 200ms (p95)
```

## Anti-Patterns

### ❌ Implementation Details
```markdown
## Validation
- Uses bcrypt for password hashing
- Stores tokens in Redis
- Implements JWT standard
```

**Why Bad:** Specifies HOW, not WHAT. MSL focuses on observable behavior.

### ❌ Subjective Criteria
```markdown
## Validation
- UI looks professional
- Error messages are helpful
- Performance is acceptable
```

**Why Bad:** Not measurable. What does "professional" mean? Make it objective.

### ❌ Vague Criteria
```markdown
## Validation
- Works correctly
- Handles edge cases
- Follows best practices
```

**Why Bad:** Not testable. Be specific about what "correct" means.

## Quick Reference

| Domain | Pattern | Example |
|--------|---------|---------|
| **Performance** | `[metric] < [value]` | FCP < 1.8s |
| **Accessibility** | `[element] [property] ≥ [value]` | Contrast ratio ≥ 4.5:1 |
| **UI Behavior** | `[state] visible on [event]` | Error shown on validation fail |
| **API** | `Returns [code] for [condition]` | Returns 404 for missing resource |
| **Data** | `[field] [constraint]` | Email matches pattern X |
| **Security** | `[action] requires [permission]` | DELETE requires admin role |

## Remember

- **Observable** - Can you see it happen?
- **Measurable** - Can you test pass/fail?
- **Specific** - No vague terms
- **Technology-agnostic** - WHAT not HOW

Good validation criteria make specifications testable, maintainable, and useful for both humans and AI agents.

---

**See also:** [MSL Guide](msl-guide.md) for the complete MSL format
