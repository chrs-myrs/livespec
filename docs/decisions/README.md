# Architecture Decision Records (ADRs)

This directory contains Architecture Decision Records for LiveSpec framework decisions.

## What are ADRs?

**Architecture Decision Records (ADRs)** document significant architectural decisions made during development. They capture:
- The **context** that led to the decision
- The **options** considered
- The **rationale** for the choice
- The **consequences** of the decision

## Why Use ADRs?

1. **Historical Context**: Future maintainers understand why decisions were made
2. **Knowledge Transfer**: New team members learn the reasoning behind architecture
3. **Decision Tracking**: Avoid revisiting settled questions
4. **Transparency**: Stakeholders can review decision rationale

## When to Create an ADR

**CREATE ADR for:**
- Technology/framework selection (MCP vs custom protocol)
- API design approaches (tools vs resources)
- Data model decisions (threading model, correlation pattern)
- Integration patterns (OAuth handling, error recovery)
- Performance/security trade-offs
- Significant deviations from conventions

**DON'T CREATE ADR for:**
- Implementation details within decided architecture
- Routine bug fixes
- Refactoring that doesn't change approach
- Obvious/uncontroversial choices
- Tactical code-level decisions

## ADR Format

Use `TEMPLATE.md` as starting point. Standard sections:

1. **Context**: What situation requires a decision?
2. **Decision Drivers**: What factors matter?
3. **Considered Options**: What alternatives existed?
4. **Decision Outcome**: What was chosen and why?
5. **Consequences**: What are the implications?

## Naming Convention

```
ADR-XXXX-short-descriptive-title.md
```

Examples:
- `ADR-0001-use-mcp-protocol.md`
- `ADR-0002-discovery-as-tools.md`
- `ADR-0003-thread-correlation-model.md`

## Status Workflow

```
Proposed → Accepted → [Deprecated | Superseded]
```

- **Proposed**: Under discussion
- **Accepted**: Decision made and implemented
- **Deprecated**: No longer applicable
- **Superseded**: Replaced by newer ADR

## Index of ADRs

| Number | Title | Status | Date | Tags |
|--------|-------|--------|------|------|
| _TBD_ | _First ADR will be added when architectural decision arises_ | - | - | - |

## Creating a New ADR

1. **Copy template**:
   ```bash
   cp TEMPLATE.md $(printf "ADR-%04d-title.md" $NEXT_NUMBER)
   ```

2. **Fill in sections**:
   - Context and problem
   - Decision drivers
   - Considered options (at least 2)
   - Decision outcome with rationale
   - Consequences

3. **Update this README**:
   - Add entry to index table
   - Link to ADR file

4. **Commit with message**:
   ```
   docs: Add ADR-XXXX for [decision topic]
   ```

## Relationship to LiveSpec Specs

**ADRs vs Specifications:**
- **ADRs**: Document *why* architectural choices were made (decisions)
- **Specs**: Document *what* system must do (requirements/behaviors)

**Example:**
- **ADR**: "ADR-0002: Use tools instead of resources for discovery"
  - Why: Better user feedback, parameter support
  - Context: MCP protocol offers both approaches
- **Spec**: `specs/3-behaviors/user-discovery.spec.md`
  - What: System lists users with filtering
  - Observable: Returns user list with IDs and names

**Cross-References:**
```yaml
# In specs/3-behaviors/user-discovery.spec.md
---
informed-by:
  - docs/decisions/ADR-0002-discovery-as-tools.md
---
```

## Tools for ADR Management

**Optional tools** (not required):
- [adr-tools](https://github.com/npryce/adr-tools) - CLI for ADR management
- [adr-viewer](https://github.com/mrwilson/adr-viewer) - Generate HTML from ADRs
- [log4brains](https://github.com/thomvaill/log4brains) - ADR management with UI

**LiveSpec approach:** Keep it simple - markdown files + this README.

## Further Reading

- [ADR GitHub Org](https://adr.github.io/)
- [Michael Nygard's ADR article](http://thinkrelevance.com/blog/2011/11/15/documenting-architecture-decisions)
- [ThoughtWorks Tech Radar on ADRs](https://www.thoughtworks.com/radar/techniques/lightweight-architecture-decision-records)

---

**Note**: This ADR pattern is optional for projects using LiveSpec. Use it when architectural decisions are complex enough to benefit from explicit documentation and rationale capture.
