# ADR-XXXX: [Short Title of Decision]

**Status:** [Proposed | Accepted | Deprecated | Superseded by ADR-YYYY]
**Date:** YYYY-MM-DD
**Deciders:** [Names or roles]
**Technical Story:** [Link to issue/epic if applicable]

## Context and Problem Statement

[Describe the context and problem that requires a decision. What is the situation that led to this decision being necessary?]

**Example:**
> We need to decide whether to implement discovery tools (list users/channels) as MCP tools or resources. This affects how Claude accesses discovery functionality and impacts the user interaction model.

## Decision Drivers

[What factors influenced this decision?]

* [Driver 1 - e.g., User experience requirements]
* [Driver 2 - e.g., Technical constraints]
* [Driver 3 - e.g., Performance considerations]
* [Driver 4 - e.g., Maintainability concerns]

## Considered Options

### Option 1: [Title]

**Description:** [What is this option?]

**Pros:**
* [Good point 1]
* [Good point 2]

**Cons:**
* [Bad point 1]
* [Bad point 2]

**Implications:**
* [What would this mean for the system?]
* [What changes would be required?]

---

### Option 2: [Title]

**Description:** [What is this option?]

**Pros:**
* [Good point 1]
* [Good point 2]

**Cons:**
* [Bad point 1]
* [Bad point 2]

**Implications:**
* [What would this mean for the system?]
* [What changes would be required?]

---

### Option 3: [Title] (if applicable)

[Same structure as above]

## Decision Outcome

**Chosen option:** "[Option Title]"

**Rationale:** [Why was this option chosen over the others?]

**Example:**
> Chosen "Option 1: Discovery as Tools" because it provides better user feedback (Claude can report what it's doing) and allows for filtering/searching parameters that resources don't support.

## Consequences

### Positive

* [Good consequence 1]
* [Good consequence 2]

### Negative

* [Negative consequence 1 - and how we'll mitigate it]
* [Negative consequence 2 - accepted trade-off]

### Neutral

* [Thing that changes but isn't inherently good/bad]

## Validation

[How will we know if this decision was correct?]

* [Success criterion 1]
* [Success criterion 2]
* [Timeline for evaluation]

**Example:**
> Success criteria:
> * Users can discover channels/users within 2 API calls
> * Discovery tools invoked successfully in 95% of workflows
> * Evaluate after 30 days of usage

## Implementation Notes

### Changes Required

* [File/component 1 needs updating]
* [File/component 2 needs creating]
* [Specs that need updates]

### Migration Path

[If superseding previous approach, how do we migrate?]

## Links

* [Link to related ADRs]
* [Link to specifications affected]
* [Link to implementation PR]
* [Link to discussion/RFC]

## Metadata

**Tags:** [architecture, api-design, mcp, etc.]
**Affected Components:** [List systems/modules affected]
**Related ADRs:** [ADR-YYYY, ADR-ZZZZ]

---

## Notes

**When to Create ADRs:**
- Architectural decisions with long-term impact
- Technology/framework selection
- API design approaches
- Data model changes
- Integration patterns
- Performance/security trade-offs

**When NOT to Create ADRs:**
- Implementation details within decided architecture
- Routine bug fixes
- Refactoring that doesn't change approach
- Obvious/uncontroversial choices

**Naming Convention:**
```
ADR-0001-use-mcp-protocol.md
ADR-0002-discovery-as-tools.md
ADR-0003-thread-correlation-model.md
```

**Status Workflow:**
```
Proposed → Accepted → [Deprecated | Superseded]
```

**Storage:**
```
docs/decisions/
  ├── 0001-use-mcp-protocol.md
  ├── 0002-discovery-as-tools.md
  ├── README.md (index of all ADRs)
  └── TEMPLATE.md (this file)
```
