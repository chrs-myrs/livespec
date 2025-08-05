# Technical Strategy Documentation Prompt

You are tasked with creating or updating Technical Strategy documents. **CRITICAL**: Technical strategies define the key patterns, technologies, and approaches used in the system. These documents work both forward (choosing strategies for new systems) and backward (documenting strategies observed in existing systems).

## Your Mindset for Technical Strategy

Before you begin, understand that you are:
- **A pattern documenter**, capturing key technical approaches
- **A choice explainer**, making implicit decisions explicit
- **A trade-off articulator**, showing what was optimized for
- **A constraint identifier**, documenting technical boundaries

## Deep Thinking Framework

### For New Systems (Mode 1):

1. **Strategy Identification** (THINK DEEPLY - 10+ minutes):
   - What major technical decisions need to be made?
   - What patterns best fit the system purpose?
   - What are the cross-cutting concerns?
   - Where are the integration boundaries?

2. **Alternative Analysis**:
   - What are the viable options for each decision?
   - What are the trade-offs of each approach?
   - What constraints influence the choice?
   - How reversible is each decision?

### For Existing Systems (Mode 4):

1. **Pattern Recognition** (OBSERVE DEEPLY - 10+ minutes):
   - What architectural patterns are used?
   - What technology choices were made?
   - What integration approaches exist?
   - What security/data patterns are evident?

2. **Rationale Inference**:
   - Why might these choices have been made?
   - What problems do they solve well?
   - What trade-offs are evident?
   - What constraints shaped these decisions?

## Instructions

### Automatic Processing:
1. Read the System Purpose from `reqs/1-purpose/system-purpose.md`
2. Check existing files in `reqs/2-strategy/`
3. Identify strategy documents needed based on:
   - System complexity and scope
   - Major technical decision areas
   - Existing patterns (if reverse engineering)
4. Create/update multiple numbered strategy documents

### Common Strategy Documents:
- `01-architecture-patterns.md` - Overall architectural approach
- `02-data-strategy.md` - Data storage, flow, and consistency
- `03-integration-strategy.md` - How components/systems connect
- `04-security-strategy.md` - Authentication, authorization, encryption
- `05-deployment-strategy.md` - Infrastructure and deployment approach
- Additional as needed for the specific system

### For New Systems:
1. Based on system purpose, identify key decision areas
2. For each area, analyze alternatives and trade-offs
3. Document chosen strategies with rationale
4. Create numbered files in `reqs/2-strategy/`
5. Create change logs for each file
6. Create or update open questions at `reqs/2-strategy/open-questions.md`

### For Existing Systems:
1. Analyze codebase to identify patterns and technologies
2. Group related decisions into strategy areas
3. Document observed patterns and inferred rationale
4. Note where rationale is unclear with "Inferred:"
5. Same file structure as above
6. Create or update open questions at `reqs/2-strategy/open-questions.md`

### For Updates:
1. Check for changes in system purpose or scope
2. Identify new technical areas or changed constraints
3. Update relevant strategy documents
4. Append to respective change logs
5. Update open questions at `reqs/2-strategy/open-questions.md`

## Strategy Document Template:

```markdown
# <Strategy Area> Strategy

**Document Status**: Current
**Last Updated**: <YYYY-MM-DD>
**Purpose Alignment**: Links to system purpose for this strategy

## Strategy Summary
<1-2 paragraphs explaining the overall approach for this area>

## Key Decisions

### Decision: <Specific Choice>
**Choice Made**: <What was chosen>
**Status**: Active|Deprecated|Under Review

**Rationale**:
- <Why this choice makes sense>
- <Problems it solves>
- <Alignment with system purpose>

**Trade-offs**:
- **Pros**: <Benefits of this choice>
- **Cons**: <Drawbacks accepted>

**Alternatives Considered**:
- **Option A**: <Description> - Not chosen because: <reason>
- **Option B**: <Description> - Not chosen because: <reason>

**Reversibility**: Type 1 (hard to change) | Type 2 (easy to change)
**Constraints**: <What limits or shapes this decision>

### Decision: <Next Specific Choice>
[Repeat pattern for each major decision in this strategy area]

## Implementation Guidelines
<How these strategies translate to implementation>

## Compliance and Standards
<Relevant standards, regulations, or policies>

## Evolution Considerations
<How this strategy might need to evolve>

## Dependencies
- **On Other Strategies**: <Which strategies this depends on>
- **From Other Strategies**: <Which strategies depend on this>

## Risks and Mitigations
- **Risk**: <Description> | **Mitigation**: <Approach>

## Open Questions
- <Unresolved strategic questions>

## AI/ML Specific Sections (If Applicable)

### Agent Architecture Strategy
**Reasoning Approach**: <ReAct/CoT/Other>
**Tool Integration**: <How agent interacts with tools>
**State Management**: <Session/conversation handling>

### Behavioral Boundaries
**Acceptable Behaviors**: <What agent should do>
**Prohibited Behaviors**: <What agent must not do>
**Loop Prevention**: <Strategies to avoid repetition>
**Timeout Handling**: <Cascade prevention approach>

### Confidence and Uncertainty
**Confidence Expression**: <How agent communicates certainty>
**Fallback Triggers**: <When to escalate to human>
**Error Recovery**: <How agent handles failures>

### Integration Complexity
**Tool Timeout Strategy**: <How to handle tool delays>
**State Synchronization**: <Cross-component consistency>
**Error Propagation**: <How errors cascade>
**Recovery Mechanisms**: <System resilience approach>
```

## Change Log Template:

```markdown
# <Strategy Area> Strategy Change Log

## <YYYY-MM-DD> - <Brief description>

### Context
<Why this change was made>

### Decisions Changed
- **<Decision>**: <What changed and why>

### New Decisions
- **<Decision>**: <What was added and why>

### Deprecated Decisions
- **<Decision>**: <What was removed and why>

### Impact
<How this affects the system>
```

## Common Strategy Areas and Decisions:

### Architecture Patterns
- Monolith vs Microservices vs Modular Monolith
- Synchronous vs Asynchronous communication
- Event-driven vs Request-response
- Layered vs Hexagonal architecture

### Data Strategy
- SQL vs NoSQL vs Polyglot persistence
- ACID vs BASE consistency
- Event sourcing vs State-based
- Data partitioning approach

### Integration Strategy
- REST vs GraphQL vs gRPC
- API Gateway vs Service Mesh
- Message queues vs Event streams
- Webhook vs Polling

### Security Strategy
- Authentication approach (JWT, OAuth, SAML)
- Authorization model (RBAC, ABAC, ACL)
- Encryption at rest and in transit
- Secret management approach

### Deployment Strategy
- Containers vs Serverless vs VMs
- Blue-green vs Canary vs Rolling
- Multi-region vs Single region
- Auto-scaling vs Manual scaling

### AI/ML Strategy (If Applicable)
- Model architecture (LLM, classical ML, hybrid)
- Inference approach (API, embedded, edge)
- Model versioning and updates
- Fallback for model failures
- Bias detection and mitigation

### AI Agent Strategy (If Applicable)
- Reasoning pattern (ReAct, CoT, Tree-of-Thought)
- State management approach
- Memory/context handling
- Tool design philosophy
- Loop prevention strategies
- Confidence calibration
- Human handoff triggers

## Quality Checks:

Before finalizing:
- [ ] Each decision has clear rationale
- [ ] Trade-offs are explicitly documented
- [ ] Alternatives were considered
- [ ] Reversibility is assessed
- [ ] Strategies align with system purpose
- [ ] Dependencies between strategies are mapped

## Mode-Specific Guidance:

### Mode 1 (New System):
- Start with highest-impact decisions
- Consider multiple alternatives seriously
- Document trade-offs honestly
- Think about long-term implications

### Mode 4 (Reverse Engineering):
- Look for patterns in:
  - Framework and library choices
  - Database and storage systems
  - API designs and protocols
  - Deployment configurations
- Be honest about unclear rationales
- Document technical debt observed

### Mode 2 (Updates):
- Focus on what has changed
- Document why old strategies no longer fit
- Show evolution of thinking
- Update related strategies together

## Examples:

**❌ Poor Strategy Documentation**:
"We use PostgreSQL for the database"

**✅ Good Strategy Documentation**:
"Decision: PostgreSQL for Primary Data Store
- **Choice Made**: PostgreSQL 14+ with read replicas
- **Rationale**: Need ACID compliance for financial data, mature JSON support for semi-structured data, strong consistency for critical paths
- **Trade-offs**: Higher operational complexity than NoSQL, vertical scaling limits at ~10TB
- **Alternatives**: MongoDB (rejected: eventual consistency), DynamoDB (rejected: vendor lock-in)
- **Reversibility**: Type 1 - data migration would take months"

Remember: Technical strategies document the "what" and "why" of technical choices. Good strategies enable confident implementation while explaining the reasoning for future maintainers.

## Open Questions Document

After creating strategy documents, create or update `reqs/2-strategy/open-questions.md` using the template from `prompts/templates/utils/open-questions-template.md`.

### Strategy-Specific Question Types:

**HIGH Priority Questions:**
- Technology choice rationale unclear
- Integration approach undefined
- Performance strategy missing
- Security approach incomplete
- Scalability decisions unmade

**MEDIUM Priority Questions:**
- Alternative approaches unconsidered
- Trade-off analysis incomplete
- Migration path unclear
- Tool chain decisions pending
- Configuration strategy undefined

**LOW Priority Questions:**
- Historical context for decisions
- Future strategy evolution
- Alternative architecture exploration
- Optimization opportunities
- Industry best practice alignment

### Map Missing Info to Questions:
- Each missing rationale → Open question about decision drivers
- Each unclear trade-off → Question about alternatives considered
- Each assumption → Validation requirement
- Each "inferred" item → Clarification needed

## Missing Information Output

After creating or updating Technical Strategy documents, you MUST provide a chat output highlighting missing information and areas needing human attention.

### Output Format:

```
## 📋 Document Generation Summary

### ✅ Completed Sections
- [List sections successfully filled with adequate information]

### ⚠️ Missing Information - HIGH Priority
[Critical items that MUST be addressed]
- **[Section/Field]**: [What's missing and why it's critical]

### 🔍 Missing Information - MEDIUM Priority
[Should be addressed but won't block progress]  
- **[Section/Field]**: [What could be improved]

### 💡 Missing Information - LOW Priority
[Nice-to-have clarifications]
- **[Section/Field]**: [Optional enhancements]

### 🤔 Key Assumptions Made
- [Significant assumptions needing validation]

### 👉 Recommended Next Steps
1. [Specific actions for human to take]
2. [Information to provide]
```

### Strategy-Specific Missing Info to Check:
- Rationale for each technical choice
- Trade-offs not fully explored
- Alternative options not documented
- Reversibility of decisions unclear
- Integration approach gaps
- Security strategy completeness
- Performance targets undefined
- Scalability considerations missing
- Cost implications not analyzed
- Agent behavior boundaries unclear
- Integration complexity underestimated
- Spike phases needed for unknowns

## Update Progress Report

After completing strategy documents:
1. Update `reqs/progress-report.md`:
   - Mark Stage 2 task 2.1 subtasks complete for each strategy doc
   - Update Stage 2 status and progress percentage
   - Record open questions count and high-priority items
   - Note any critical technology decisions made
   - Record technology decisions in decisions section
   - Note any strategy-level spikes needed
   - Add to activity log: `<Date>: Strategy documents created (count: X)`
   - Update overall progress percentage
   - Flag any new risks or blockers discovered

Multiple strategy documents work together - track them all!