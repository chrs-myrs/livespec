# Behavior vs Contract Boundary: Complete Guide

**Purpose**: Define clear separation between behaviors (WHAT system does) and contracts (interface agreements).

**For**: Developers and AI assistants implementing LiveSpec 3-layer architecture.

---

## Quick Decision Tree

```
Are you documenting...?

├─ Observable outcome users/system must exhibit?
│  └─ → BEHAVIOR (specs/3-behaviors/)
│
├─ Interface definition (API, data format, function signature)?
│  └─ → CONTRACT (specs/3-contracts/)
│
├─ Cross-cutting technical decision?
│  └─ → STRATEGY (specs/2-strategy/)
│
└─ Strategic outcome or hard constraint?
   └─ → REQUIREMENT (specs/1-requirements/)
```

---

## Core Definitions

### Behaviors (specs/3-behaviors/)

**WHAT**: Observable outcomes the system must exhibit

**Characteristics**:
- Testable from outside the system
- Observable by users or other systems
- Describes system response to inputs
- Technology-agnostic (could implement many ways)
- Answers: "What should happen when...?"

**Examples**:
- ✅ "System authenticates users via OAuth"
- ✅ "Cache invalidates after 1 hour TTL"
- ✅ "Email notifications sent within 5 minutes"
- ✅ "Graceful degradation when API rate-limited"

**NOT behaviors**:
- ❌ "Use Redis for caching" (implementation choice)
- ❌ "API endpoint is POST /auth/login" (interface definition → contract)
- ❌ "Hash passwords with bcrypt" (implementation detail)

### Contracts (specs/3-contracts/)

**WHAT**: Interface agreements between components or systems

**Characteristics**:
- Defines data structures, schemas, signatures
- Specifies request/response formats
- Documents API endpoints and parameters
- Binds producer and consumer
- Answers: "What does the interface look like?"

**Examples**:
- ✅ API contract: `POST /users/{id}` with JSON schema
- ✅ Function signature: `authenticate(username, password) → User | Error`
- ✅ Data contract: User schema with required/optional fields
- ✅ MCP tool contract: `slack_post_message` with parameters

**NOT contracts**:
- ❌ "Authentication must be secure" (behavior requirement)
- ❌ "System validates user input" (observable behavior)
- ❌ "API responds within 200ms" (performance behavior)

---

## The Critical Distinction

### Behaviors describe OUTCOMES

**Question**: "What should the system DO?"

**Example scenario**: User posts message to Slack channel

**Behavior spec** (specs/3-behaviors/channel-messaging.spec.md):
```markdown
# Channel Messaging

## Requirements
- [!] System posts messages to Slack channels.
  - Message appears in target channel
  - Channel members see the message
  - Message includes sender information
  - Thread replies are associated with parent message
  - Graceful failure if channel not found
  - Error response if insufficient permissions
```

**Focus**: WHAT happens, not HOW or WHAT FORMAT

### Contracts describe INTERFACES

**Question**: "What does the API/function/interface look like?"

**Contract spec** (specs/3-contracts/mcp-tools/slack-post.spec.md):
```markdown
# Slack Post Message Contract

## Tool Definition

**Name**: `slack_post_message`

**Parameters**:
- `channel` (required): Slack channel ID
  - Type: string
  - Pattern: `^C[A-Z0-9]{8,}$`
  - Behavior: specs/3-behaviors/channel-messaging.spec.md#channel-resolution

- `text` (required): Message text
  - Type: string
  - Max length: 3000 characters
  - Behavior: specs/3-behaviors/channel-messaging.spec.md#message-formatting

- `thread_ts` (optional): Thread timestamp for replies
  - Type: string (timestamp)
  - Format: "1234567890.123456"
  - Behavior: specs/3-behaviors/threading.spec.md#thread-replies

**Returns**:
- Success: `{ ok: true, ts: string, channel: string }`
- Error: `{ ok: false, error: string, error_code?: string }`
```

**Focus**: WHAT FORMAT, not WHAT HAPPENS

---

## Key Insight: Dual Linkage

**Every contract parameter MUST link to a behavior spec.**

This is the bridge between interface (contract) and outcome (behavior).

### Why This Matters

**Without behavior linkage**:
```markdown
# ❌ Incomplete Contract
- `thread_ts` (optional): Thread timestamp for replies
```

**Problem**: What does this parameter DO? What behavior does it enable?

**With behavior linkage**:
```markdown
# ✅ Complete Contract
- `thread_ts` (optional): Thread timestamp for replies
  - Behavior: specs/3-behaviors/threading.spec.md#thread-replies
```

**Benefit**:
- Contract documents the INTERFACE (parameter exists, type, format)
- Behavior documents the OUTCOME (threaded replies work correctly)
- Parameters without behavior links → incomplete feature (caught by validation)

---

## Common Boundary Violations

### Violation 1: Behavior Details in Contracts

**❌ Wrong** (specs/3-contracts/api/users.spec.md):
```markdown
# User API Contract

## POST /users

Creates new user account.

**Behavior**:
- Validates email format
- Checks for duplicate emails
- Hashes password with bcrypt (12 rounds)
- Sends welcome email
- Returns user object
```

**Problem**: Contract is describing WHAT HAPPENS (behavior), not just interface

**✅ Correct** (specs/3-contracts/api/users.spec.md):
```markdown
# User API Contract

## POST /users

**Request**:
```json
{
  "email": "string",
  "password": "string",
  "name": "string"
}
```

**Response (201 Created)**:
```json
{
  "id": "string",
  "email": "string",
  "name": "string",
  "created_at": "ISO 8601 timestamp"
}
```

**Errors**:
- 400: Invalid input (validation failure)
- 409: Email already exists

**Behavior**: specs/3-behaviors/user-registration.spec.md
```

**Separate behavior spec** (specs/3-behaviors/user-registration.spec.md):
```markdown
# User Registration

## Requirements
- [!] System creates user accounts with valid credentials.
  - Email format validated
  - Duplicate emails rejected (409 error)
  - Passwords securely hashed
  - Welcome email sent asynchronously
  - User object returned with ID
```

### Violation 2: Contract Details in Behaviors

**❌ Wrong** (specs/3-behaviors/authentication.spec.md):
```markdown
# Authentication

## Requirements
- [!] System authenticates users.
  - API endpoint: POST /auth/login
  - Request body: { "email": "string", "password": "string" }
  - Response: { "token": "JWT", "expires_in": 3600 }
  - Token includes user_id, email, issued_at claims
  - Token signed with HS256 algorithm
```

**Problem**: Behavior is describing INTERFACE DETAILS (contract concern)

**✅ Correct** (specs/3-behaviors/authentication.spec.md):
```markdown
# Authentication

## Requirements
- [!] System authenticates users with valid credentials.
  - User provides email and password
  - Valid credentials → authenticated session
  - Invalid credentials → authentication failure
  - Session expires after inactivity timeout
  - User can log out (terminate session)

## Validation
- Login with valid credentials succeeds
- Login with invalid password fails
- Login with non-existent email fails
- Session persists across requests
- Logout terminates session
```

**Separate contract spec** (specs/3-contracts/api/auth.spec.md):
```markdown
# Authentication API Contract

## POST /auth/login

**Request**:
```json
{
  "email": "string",
  "password": "string"
}
```

**Response (200 OK)**:
```json
{
  "token": "string (JWT)",
  "expires_in": "number (seconds)",
  "user": {
    "id": "string",
    "email": "string"
  }
}
```

**Behavior**: specs/3-behaviors/authentication.spec.md
```

### Violation 3: Missing Behavior Links

**❌ Wrong** (specs/3-contracts/mcp-tools/slack.spec.md):
```markdown
# Slack MCP Tools

## slack_post_message

**Parameters**:
- `expected_format` (optional): Expected response format (multiple_choice, yes_no, number)
```

**Problem**: Parameter exists in contract but no behavior spec exists for response validation

**Impact**: API promises functionality that doesn't exist (pitfall #7)

**✅ Correct** (with behavior link):
```markdown
# Slack MCP Tools

## slack_post_message

**Parameters**:
- `expected_format` (optional): Expected response format
  - Behavior: specs/3-behaviors/response-validation.spec.md#format-validation
  - Enum: ["multiple_choice", "yes_no", "number"]
```

**Corresponding behavior spec** (specs/3-behaviors/response-validation.spec.md):
```markdown
# Response Validation

## Requirements
- [!] System validates and parses structured responses.

  ### Multiple Choice Validation
  - Presents numbered options to user
  - Parses numeric or text response
  - Validates selection in range
  - Returns selected option

  ### Yes/No Validation
  - Accepts variations (yes/y/true, no/n/false)
  - Case-insensitive matching
  - Returns boolean

  ### Number Validation
  - Parses numeric input
  - Validates range (if specified)
  - Returns number type
```

---

## Decision Framework

### When to Create Behavior Spec

Ask: "Can I test this outcome WITHOUT knowing the interface details?"

**Examples**:
- ✅ "System authenticates users" → Observable outcome (behavior)
- ✅ "Cache invalidates after TTL" → Observable outcome (behavior)
- ✅ "Messages appear in threads" → Observable outcome (behavior)

### When to Create Contract Spec

Ask: "Am I documenting an interface between components?"

**Examples**:
- ✅ API endpoint with request/response schema → Interface (contract)
- ✅ Function signature with parameters → Interface (contract)
- ✅ MCP tool definition with parameter schemas → Interface (contract)
- ✅ Database table schema → Interface (contract)

### When to Create BOTH

**Most features need both:**

1. **Behavior spec** describes WHAT the feature does (observable outcomes)
2. **Contract spec** describes HOW to interact with it (interface definition)
3. **Contract links to behavior** (each parameter references relevant behavior section)

**Example: Slack Threading**

**Behavior** (specs/3-behaviors/threading.spec.md):
- Thread replies appear under parent message
- Thread participants receive notifications
- Thread context is preserved
- Threads can be retrieved independently

**Contract** (specs/3-contracts/mcp-tools/slack-thread.spec.md):
- `thread_ts` parameter definition
- Type: string (timestamp)
- Format specification
- **Links to**: specs/3-behaviors/threading.spec.md#thread-replies

---

## Organization Patterns

### Pattern 1: One Behavior, Multiple Contracts

**Scenario**: Same behavior exposed through different interfaces

**Example**: User authentication

**Behavior** (specs/3-behaviors/authentication.spec.md):
- Single spec defining authentication outcome

**Contracts**:
- specs/3-contracts/api/auth-rest.spec.md (REST API)
- specs/3-contracts/api/auth-graphql.spec.md (GraphQL mutation)
- specs/3-contracts/sdk/auth-client.spec.md (SDK function)

**All contracts link to same behavior spec**

### Pattern 2: One Contract, Multiple Behaviors

**Scenario**: Complex API endpoint enabling multiple outcomes

**Example**: Slack post_message with features

**Contract** (specs/3-contracts/mcp-tools/slack-post.spec.md):
- Single tool definition with multiple parameters

**Behaviors**:
- specs/3-behaviors/channel-messaging.spec.md (basic posting)
- specs/3-behaviors/threading.spec.md (thread replies)
- specs/3-behaviors/response-validation.spec.md (structured responses)
- specs/3-behaviors/user-resolution.spec.md (username → ID)

**Each contract parameter links to relevant behavior**

### Pattern 3: Domain Models (Neither Behavior nor Contract)

**Scenario**: Complex core concepts that span multiple behaviors

**Example**: Slack threading model

**Domain Model** (specs/3-behaviors/domain-models/threading-model.spec.md):
- Defines threading concepts
- Documents invariants
- Explains interaction patterns
- **Referenced by** multiple behavior specs

**Behaviors reference domain model**:
```markdown
# Channel Threading (Behavior)

## Domain Context
See specs/3-behaviors/domain-models/threading-model.spec.md for core threading concepts.

## Requirements
- [!] Thread replies work according to Slack threading model...
```

---

## Validation Rules

### Contract Completeness (Enforced in 3.3.0)

**Rule**: Every parameter in contract MUST link to behavior spec

**Validation**: scripts/check-contract-completeness.sh

**Checks**:
- Each contract parameter has inline behavior reference OR
- Contract has frontmatter `satisfies:` linking to behavior spec

**Example passing validation**:
```markdown
---
# Contract with frontmatter link
satisfies:
  - specs/3-behaviors/messaging.spec.md
---

# Slack Tools

## slack_post_message
**Parameters**:
- `channel` (required): Channel ID
  - Behavior: specs/3-behaviors/messaging.spec.md#channel-resolution
- `text` (required): Message text
  - Behavior: specs/3-behaviors/messaging.spec.md#message-formatting
```

**Example failing validation**:
```markdown
# ❌ Contract with missing behavior links

## slack_post_message
**Parameters**:
- `channel` (required): Channel ID
- `text` (required): Message text
```

**Fix**:
1. Add inline behavior references, OR
2. Add frontmatter `satisfies:` field, OR
3. Create missing behavior specs and link them

### Behavior Testability

**Rule**: Every behavior MUST be testable without implementation knowledge

**Test**: "Can I verify this outcome by observation?"

**Example passing test**:
```markdown
# ✅ Testable Behavior

## Requirements
- [!] System posts messages to channels.
  - Message visible in channel
  - Timestamp returned
  - Error if channel not found

## Validation
- Post to valid channel → message appears
- Post to invalid channel → error response
- Message includes sender info
```

**Example failing test**:
```markdown
# ❌ Not Testable (Too Vague)

## Requirements
- [!] System handles messages properly.

## Validation
- Messages work correctly
```

**Fix**: Define specific, observable outcomes

---

## Real-World Example: Complete Feature

### Feature: Slack Thread Replies

**1. Requirement** (specs/1-requirements/functional/thread-communication.spec.md):
```markdown
# Thread Communication Requirement

**Why**: Users need context-aware conversations in Slack channels

**Success Criteria**:
- Replies grouped with original message
- Thread participants notified
- Conversation context preserved
```

**2. Domain Model** (specs/3-behaviors/domain-models/threading-model.spec.md):
```markdown
# Slack Threading Model

## Core Concepts
- thread_ts: Parent message timestamp (NOT separate thread ID)
- Channels: Threads visible to all channel members
- DMs: Threads for logical grouping only

## Invariants
- thread_ts ALWAYS references parent message timestamp
- Parent message included in thread retrieval
- Thread replies appear chronologically
```

**3. Behavior** (specs/3-behaviors/threading.spec.md):
```markdown
# Thread Reply Behavior

## Requirements
- [!] System posts replies to message threads.
  - Reply appears under parent message
  - Thread participants notified
  - thread_ts identifies parent
  - Graceful failure if parent not found

## Domain Context
See specs/3-behaviors/domain-models/threading-model.spec.md

## Validation
- Reply with valid thread_ts → appears in thread
- Reply without thread_ts → creates new parent
- Invalid thread_ts → error response
```

**4. Contract** (specs/3-contracts/mcp-tools/slack-post.spec.md):
```markdown
# Slack Post Message Contract

## slack_post_message

**Parameters**:
- `channel` (required): Slack channel ID
  - Type: string
  - Pattern: `^C[A-Z0-9]{8,}$`
  - Behavior: specs/3-behaviors/threading.spec.md#channel-targeting

- `text` (required): Message text
  - Type: string
  - Max length: 3000
  - Behavior: specs/3-behaviors/threading.spec.md#message-content

- `thread_ts` (optional): Parent message timestamp
  - Type: string (timestamp)
  - Format: "1234567890.123456"
  - Behavior: specs/3-behaviors/threading.spec.md#thread-replies

**Returns**:
```json
{
  "ok": true,
  "ts": "1234567890.123456",
  "channel": "C1234567890",
  "thread_ts": "1234567890.123456"
}
```
```

**Notice**:
- Requirement explains WHY (business value)
- Domain model explains CONCEPTS (threading rules)
- Behavior explains WHAT (observable outcomes)
- Contract explains INTERFACE (parameter schemas, return format)
- **Every contract parameter links to behavior section**

---

## Common Questions

### Q: Where do I put validation rules?

**A**: Depends on what you're validating

**Input validation (format/type)** → Contract
- "Email must match regex pattern"
- "Password length 8-128 characters"
- "Integer between 1-100"

**Business validation (rules/logic)** → Behavior
- "Email must not already exist" (uniqueness check)
- "Password must meet complexity requirements" (security policy)
- "Quantity must not exceed inventory" (business rule)

### Q: Where do I put error responses?

**A**: Both, but different aspects

**Contract**: Structure of error response
```markdown
**Error Response**:
{
  "ok": false,
  "error": "string",
  "error_code": "string"
}
```

**Behavior**: When errors occur
```markdown
- Invalid channel ID → "channel_not_found" error
- Insufficient permissions → "not_authorized" error
- Rate limited → "rate_limited" error with retry_after
```

### Q: Where do I put performance requirements?

**A**: Behavior (observable outcomes)

**Example**:
```markdown
# API Response Time (Behavior)

## Requirements
- [!] System responds to API requests within SLA.
  - P95 latency < 200ms
  - P99 latency < 500ms
  - Timeout after 5 seconds
```

**NOT in contract** (contract defines interface, not performance)

### Q: Can a contract exist without a behavior spec?

**A**: Only for pure data schemas with no behavior

**Examples where contract-only is OK**:
- ✅ Database table schema (pure structure)
- ✅ Configuration file format (pure data)
- ✅ DTO/transfer object definition (pure structure)

**Examples where behavior is REQUIRED**:
- ❌ API endpoint (has behavior - what happens when called?)
- ❌ MCP tool (has behavior - what does it do?)
- ❌ Function with logic (has behavior - what's the outcome?)

### Q: Should I create behavior first or contract first?

**A**: Behavior first (spec-first within spec-first!)

**Sequence**:
1. Requirements (WHY) - specs/1-requirements/
2. **Behaviors (WHAT)** - specs/3-behaviors/
3. Contracts (INTERFACE) - specs/3-contracts/
4. Implementation - code

**Why behaviors first**:
- Focuses on outcomes before interface details
- Allows multiple interface designs for same behavior
- Behavior specs can be tested/validated before API design
- Contracts reference behaviors (not vice versa)

---

## Further Reading

- **specs/3-behaviors/validation/contract-completeness.spec.md** - Validation rules for behavior links
- **scripts/check-contract-completeness.sh** - Automated completeness checking
- **dist/guides/common-pitfalls.md** - Real examples of boundary violations (Pitfall #7)
- **dist/standard/metaspecs/behavior.spec.md** - Template for behavior specs
- **dist/standard/metaspecs/contract.spec.md** - Template for contract specs
- **dist/standard/metaspecs/domain-model.spec.md** - Template for domain concepts

---

**Remember**: Behaviors describe OUTCOMES, Contracts describe INTERFACES. Every contract parameter MUST link to a behavior. This separation enables rapid rebuild (same behaviors, different contracts, new implementation).
