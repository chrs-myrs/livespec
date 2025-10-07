---
spec: specs/prompts/1b-define-behaviors.spec.md
---

# 1b: Define Behaviors

**Phase**: DESIGN
**Purpose**: Specify observable system behaviors
**Context**: See `specs/prompts/` (LiveSpec's own prompt behaviors) as examples

## Task

Create behavior specifications in `specs/behaviors/` that define what the system does.

## What Are Behaviors?

Behaviors are **observable outcomes** that:
- Users can see or experience
- Can be tested or validated
- Don't specify implementation
- Describe "what" not "how"

## Creating Behavior Specifications

For each major feature or capability, create a spec file:

`specs/behaviors/[behavior-name].spec.md`:

```markdown
---
criticality: CRITICAL | IMPORTANT
failure_mode: [What breaks without this behavior]
---

# [Behavior Name]

## Requirements
- [!] [What the system does - observable behavior]
  - [How to verify this behavior]
  - [Observable criteria]
  - [Test approach]
```

## Examples

**Good Behaviors (Observable):**
- "System authenticates users via email/password"
- "API returns JSON responses with 200 status for success"
- "User can export data as CSV file"
- "Dashboard updates within 2 seconds of data change"

**Bad Behaviors (Implementation):**
- ❌ "Use JWT tokens for authentication" → Implementation detail
- ❌ "Store data in PostgreSQL" → Implementation choice
- ❌ "Use React for frontend" → Technology decision

## Organization

Group related behaviors by feature or component:

```
specs/behaviors/
├── authentication.spec.md       # Auth behaviors
├── data-export.spec.md          # Export behaviors
├── dashboard-updates.spec.md    # UI behaviors
└── api-responses.spec.md        # API behaviors
```

## Guidelines

**Keep each behavior focused:**
- One behavior per file
- Single responsibility
- Clear validation criteria

**Make them testable:**
- Every behavior must be verifiable
- Include concrete validation criteria
- Describe how to test

**Stay minimal:**
- Only CRITICAL or IMPORTANT behaviors
- No "nice to have" features
- No implementation details

## Exit Criteria

- [ ] specs/behaviors/ contains all key system behaviors
- [ ] Each behavior is observable and testable
- [ ] All behaviors follow MSL format
- [ ] No implementation details in behavior specs
- [ ] Behaviors cover all aspects of problem statement

## Next Step

Once behaviors are defined, proceed to `1c-create-contracts.md`
