---
type: metaspec
purpose: Define quality criteria for domain model specifications
applies_to: specs/3-behaviors/models/*.spec.md
governed-by:
  - .livespec/standard/metaspecs/base.spec.md
  - .livespec/standard/metaspecs/behavior.spec.md
criticality: IMPORTANT
failure_mode: Without explicit domain models, core concepts remain implicit assumptions leading to implementation inconsistencies and edge case bugs
---

# Domain Model Metaspec

**Purpose**: Define what constitutes a well-formed domain model specification that makes implicit concepts explicit and prevents implementation ambiguity.

## What is a Domain Model?

A **domain model** is a core concept or entity that has complex behavior, state, or rules that must be explicitly documented to prevent implementation mistakes.

**Examples**:
- **Threading Model** (Slack): How thread_ts works in channels vs DMs, reply correlation, parent message handling
- **Correlation Model** (async systems): How requests match responses in concurrent operations
- **Session Model** (auth): Token lifecycle, refresh timing, expiry handling
- **Payment State Machine** (e-commerce): Order states, transitions, rollback rules

**NOT domain models** (these are simpler):
- Simple data structures (user profile with name/email)
- Straightforward CRUD entities
- Configuration objects
- Basic value objects

**Test**: "Would different developers implement this differently without explicit specification?" → YES = needs domain model

## Essential Elements

A well-formed domain model specification MUST include:

- [ ] **Concept Definition**
  - What this concept represents in the domain
  - Why it needs explicit modeling (complexity justification)
  - Related concepts and boundaries

- [ ] **State Model**
  - All possible states/values
  - Valid state transitions (if stateful)
  - Initial state and terminal states
  - State transition triggers

- [ ] **Behavior Rules**
  - Invariants (rules that must always hold)
  - Constraints (boundaries and limits)
  - Edge cases and special scenarios
  - Error conditions

- [ ] **Interaction Patterns**
  - How this model interacts with other models
  - Lifecycle (creation, updates, deletion)
  - Concurrency considerations (if applicable)

- [ ] **Implementation Guidance**
  - Key decisions implementers must make
  - Common pitfalls to avoid
  - Validation criteria
  - Examples of correct vs incorrect usage

## Quality Criteria

### Explicitness
Model MUST make implicit assumptions explicit:
- No "everyone knows how X works"
- Document assumptions that caused bugs in past
- Specify behavior for edge cases
- Clear about what's undefined vs defined

**Example**:
❌ Implicit: "Threading works like normal Slack threads"
✅ Explicit: "In channels, thread_ts identifies parent message. In DMs, thread_ts may not exist for some clients. Parent message IS included in thread retrieval."

### Completeness
Model MUST cover all scenarios:
- Normal cases (happy path)
- Edge cases (boundary conditions)
- Error cases (what happens when rules violated)
- Concurrent access (if applicable)

### Consistency
Model MUST be internally consistent:
- No contradictory rules
- Clear precedence when rules conflict
- Terminology used consistently
- State transitions well-defined

### Testability
Model MUST enable validation:
- Observable behaviors specified
- Validation criteria concrete
- Examples of valid/invalid states
- Test scenarios provided

## Structure

### Minimum Viable Domain Model

```markdown
---
criticality: IMPORTANT | CRITICAL
failure_mode: [What breaks without explicit model]
related-concepts:
  - [Other domain models this interacts with]
---

# [Concept Name] Model

## Concept Definition

**What**: [Brief description of concept]
**Why Explicit Modeling**: [Complexity justification]
**Scope**: [What's included vs excluded]

## State Model

### Possible States
- **[State 1]**: [Description, when occurs]
- **[State 2]**: [Description, when occurs]

### State Transitions
\`\`\`mermaid
stateDiagram-v2
    [State1] --> [State2]: [Trigger]
    [State2] --> [State3]: [Trigger]
\`\`\`

**Transition Rules**:
- [State1 → State2]: [Conditions required]
- [Irreversible transitions]: [Which ones, why]

## Behavior Rules

### Invariants
- [!] [Rule that must ALWAYS hold]
- [!] [Another invariant]

### Constraints
- [!] [Boundary or limit]
- [!] [Another constraint]

### Edge Cases
- **[Scenario]**: [How model behaves]
- **[Another scenario]**: [Behavior]

## Interaction Patterns

### With [Other Model]
- [How they interact]
- [Data flow between them]
- [Dependency direction]

### Lifecycle
- **Creation**: [When/how instance created]
- **Updates**: [What can change, what can't]
- **Deletion**: [When/how removed, cascade effects]

## Implementation Guidance

### Key Decisions
- [Decision implementer must make]
- [Another decision point]

### Common Pitfalls
- ❌ [Anti-pattern]: [Why wrong]
- ❌ [Another mistake]: [Impact]

### Validation
- [How to verify correct implementation]
- [Test scenarios]

## Examples

### Valid Usage
\`\`\`[language]
[Code example showing correct usage]
\`\`\`

### Invalid Usage
\`\`\`[language]
[Code example showing what NOT to do]
\`\`\`
```

## Real-World Example: Threading Model

```markdown
---
criticality: CRITICAL
failure_mode: Without explicit threading model, implementations make incorrect assumptions about thread_ts behavior across channels vs DMs, causing message correlation failures
related-concepts:
  - Message Correlation Model
  - Channel Types Model
---

# Slack Threading Model

## Concept Definition

**What**: Model defining how Slack threads work, including thread_ts semantics, parent message inclusion, and channel vs DM differences.

**Why Explicit Modeling**:
- Thread behavior differs between channels and DMs
- Multiple clients handle threading inconsistently
- Parent message inclusion is non-obvious
- Correlation logic depends on understanding threading

**Scope**:
- Included: thread_ts format, parent message, retrieval semantics
- Excluded: Thread UI rendering, notification preferences

## State Model

### Thread States
- **No Thread**: Single message, not part of thread
- **Thread Parent**: Message that started a thread (has replies)
- **Thread Reply**: Message within a thread

### Thread Identification
\`\`\`
thread_ts: Timestamp of parent message
- Format: Unix timestamp with microseconds (e.g., "1699564800.123456")
- Uniqueness: Unique within channel, identifies thread
- Persistence: Immutable once set
\`\`\`

## Behavior Rules

### Invariants
- [!] In channels: thread_ts ALWAYS identifies parent message timestamp
- [!] Parent message IS included when retrieving thread (first in array)
- [!] thread_ts is the parent message's timestamp, not a separate ID

### Constraints
- [!] thread_ts format: "\\d{10}\\.\\d{6}" (10 digits dot 6 digits)
- [!] Minimum 1 message in thread (the parent)
- [!] Maximum 1000 replies per thread (Slack limit)

### Edge Cases
- **DM Threading**: Some DM clients don't support thread_ts; may be null
- **Parent Deleted**: Thread persists but parent shows as deleted
- **Thread in Private Channel**: Requires membership to access

## Interaction Patterns

### With Message Correlation Model
- thread_ts used to correlate responses to requests
- Multiple concurrent threads possible in same channel
- Must track conversation_id separately from thread_ts

### Lifecycle
- **Creation**: First reply to message creates thread (assigns thread_ts)
- **Updates**: Replies added to thread, parent immutable
- **Deletion**: Individual replies deletable, parent deletion marks as deleted

## Implementation Guidance

### Key Decisions
- **DM Threading**: Handle null thread_ts gracefully (fallback to message_ts)
- **Parent Inclusion**: Don't filter out first message thinking it's metadata
- **Correlation**: Use conversation_id for tracking, not thread_ts alone

### Common Pitfalls
- ❌ **Assuming thread_ts is separate ID**: It's the parent's timestamp
- ❌ **Filtering parent from results**: Parent IS part of thread
- ❌ **Relying on thread_ts in DMs**: May be null, fallback required
- ❌ **Using thread_ts for correlation**: Multiple users can reply; need separate correlation ID

### Validation
- Thread retrieval includes parent message as first element
- thread_ts matches parent message timestamp
- Handles null thread_ts gracefully (DMs)
- Doesn't confuse thread_ts with correlation ID

## Examples

### Valid Usage (Channels)
\`\`\`python
# Retrieve thread including parent
response = slack.conversations_replies(
    channel="C123",
    thread_ts="1699564800.123456"  # Parent's timestamp
)

messages = response["messages"]
parent = messages[0]  # First message IS the parent
assert parent["ts"] == "1699564800.123456"
replies = messages[1:]  # Remaining are replies
\`\`\`

### Valid Usage (DMs with fallback)
\`\`\`python
# Handle DMs where thread_ts may be null
thread_ts = message.get("thread_ts") or message["ts"]
response = slack.conversations_replies(
    channel=dm_channel,
    thread_ts=thread_ts
)
\`\`\`

### Invalid Usage
\`\`\`python
# ❌ WRONG: Treating thread_ts as separate from parent
response = slack.conversations_replies(
    channel="C123",
    thread_ts=thread_ts
)
parent = slack.conversations_history(...)  # Separate call for parent
# This is inefficient; parent included in replies!

# ❌ WRONG: Filtering parent thinking it's metadata
messages = [m for m in response["messages"] if m["ts"] != thread_ts]
# This removes the parent message!
\`\`\`
```

## When to Create Domain Models

**CREATE domain model when**:
- Concept has non-obvious behavior (threading, state machines)
- Past implementations had bugs from implicit assumptions
- Multiple developers would implement differently
- Edge cases are complex or numerous
- Concept interacts with multiple other concepts

**SKIP domain model when**:
- Simple data structure (no complex behavior)
- Standard pattern (basic CRUD, simple validation)
- Single obvious implementation
- No edge cases or state transitions

## Placement

Domain models live in:
```
specs/3-behaviors/models/[concept-name].spec.md
```

Examples:
- `specs/3-behaviors/models/threading.spec.md`
- `specs/3-behaviors/models/payment-state-machine.spec.md`
- `specs/3-behaviors/models/session-lifecycle.spec.md`

## Relationship to Other Specs

Domain models:
- **Inform** behavior specs (behaviors reference models)
- **Guide** contract specs (contracts follow model rules)
- **Complement** architecture (models show WHAT, architecture shows WHERE)

```yaml
# In specs/3-behaviors/slack-messaging.spec.md
---
uses-models:
  - specs/3-behaviors/models/threading.spec.md
  - specs/3-behaviors/models/correlation.spec.md
---
```

## Validation Checklist

Before considering domain model complete:

1. [ ] **Concept clearly defined** (what it is, why model needed)
2. [ ] **All states documented** (if stateful)
3. [ ] **Invariants explicit** (rules that always hold)
4. [ ] **Edge cases covered** (boundary conditions specified)
5. [ ] **Interactions documented** (with other models)
6. [ ] **Pitfalls identified** (common mistakes listed)
7. [ ] **Examples provided** (valid and invalid usage)
8. [ ] **Testable** (validation criteria concrete)

## Success Criteria

✅ **Good domain model**:
- Makes implicit concept explicit
- Prevents common implementation mistakes
- Covers edge cases comprehensively
- Provides clear implementation guidance
- Internally consistent
- Testable and verifiable

❌ **Insufficient domain model**:
- Vague descriptions ("threading works normally")
- Missing edge cases
- No implementation guidance
- Contradictory rules
- Can't validate correctness
- Over-specifies implementation details (HOW not WHAT)

---

**Remember**: Domain models document core concepts that are complex enough to cause bugs if left implicit. Don't over-model simple things, but don't under-document complex things.
