# Component Specifications Documentation Prompt

You are tasked with creating or updating Component Specification documents. **CRITICAL**: Component specs define what each component does (its capabilities and responsibilities). These documents work both forward (specifying components to build) and backward (documenting existing component capabilities).

## Your Mindset for Component Specifications

Before you begin, understand that you are:
- **A capability documenter**, defining what each component does
- **A boundary guardian**, ensuring clear component responsibilities  
- **An interface definer**, specifying how components interact
- **A behavior describer**, making capabilities testable

## Deep Thinking Framework

### For New Systems (Mode 1):

1. **Component Capability Definition** (THINK DEEPLY - 10+ minutes per component):
   - What business capabilities does this component provide?
   - What data does it manage?
   - What operations does it support?
   - What events does it handle?

2. **Interface Specification**:
   - What services does it expose?
   - What data does it consume?
   - What events does it publish?
   - What are the SLAs?

3. **Test Strategy Planning** (THINK DEEPLY - 5+ minutes per component):
   - How can we verify each capability works correctly?
   - What makes this component testable?
   - What are the critical paths that must be tested?
   - How do we test integration points?
   - What test data will we need?

### For Existing Systems (Mode 4):

1. **Capability Discovery** (OBSERVE DEEPLY - 10+ minutes per component):
   - What does this component actually do?
   - What APIs/services does it provide?
   - What data does it own?
   - What business rules does it enforce?

2. **Behavior Documentation**:
   - How does it handle various scenarios?
   - What are the error conditions?
   - What are the performance characteristics?
   - What integrations exist?

3. **Test Discovery**:
   - What tests already exist?
   - What testing patterns are used?
   - What gaps exist in test coverage?
   - How is the component currently tested?

## Instructions

### Automatic Processing:
1. Read System Design documents from `reqs/3-design/`
2. Extract component list from design documents
3. Check existing files in `reqs/4-components/`
4. Create/update one specification per component

### For New Systems:
1. For each component identified in design:
   - Define its business capabilities
   - Specify its interfaces and data
   - Document expected behaviors
   - Create numbered spec file
2. Create change logs for each file
3. Create or update open questions at `reqs/4-components/open-questions.md`

### For Existing Systems:
1. For each component found in code:
   - Document actual capabilities
   - Map existing APIs and data
   - Capture current behaviors
   - Note any undocumented features
2. Same file structure as above
3. Create or update open questions at `reqs/4-components/open-questions.md`

### For Updates:
1. Check for design changes affecting components
2. Identify new capabilities or changed behaviors
3. Update relevant component specs
4. Append to change logs
5. Update open questions at `reqs/4-components/open-questions.md`

## Component Specification Template:

```markdown
# <Component Name> Specification

**Component Type**: Service|Library|Application|Database
**Document Status**: Current
**Last Updated**: <YYYY-MM-DD>
**Design Alignment**: Links to design documents

## Component Overview

### Purpose
<1-2 sentences on why this component exists>

### Business Capabilities
- <Capability 1>: <Description>
- <Capability 2>: <Description>

### Key Responsibilities
- <What this component is responsible for>
- <Core functionality it provides>

### Explicit Non-Responsibilities
- <What this component does NOT do>
- <Responsibilities owned by other components>

## Interfaces

### Provided Interfaces

#### <Interface Name> (REST API|gRPC|Event|etc)
**Purpose**: <What this interface provides>
**Authentication**: <Required auth method>
**Authorization**: <Required permissions>

**Operations**:
- `<operation>`: <Description>
  - Input: <Request format>
  - Output: <Response format>
  - Errors: <Possible error conditions>

### Consumed Interfaces
- **<External Service/Component>**: <What is consumed and why>
  - Operations used: <List>
  - SLA expected: <Availability/latency requirements>

## Data Management

### Owned Data
- **<Entity/Table>**: <Description and purpose>
  - Key fields: <Important fields>
  - Retention: <How long data is kept>
  - Privacy: <PII/sensitive data notes>

### Data Access Patterns
- <Common query patterns>
- <Write patterns and frequency>
- <Consistency requirements>

## Events

### Published Events
- **<Event Name>**: <When published and purpose>
  - Schema: <Event structure>
  - Frequency: <How often>
  - Subscribers: <Who consumes>

### Subscribed Events
- **<Event Name>**: <Purpose of subscription>
  - Source: <Publishing component>
  - Processing: <What happens when received>

## Business Rules

### Core Rules
- **<Rule Name>**: <Description>
  - Implementation: <How enforced>
  - Exceptions: <Special cases>

### Validation Rules
- <Field/Data validation requirements>
- <Business constraint validations>

## Behavioral Specifications

### <Scenario/Use Case>
**Given**: <Initial state/context>
**When**: <Action or trigger>
**Then**: <Expected outcome/behavior>

### Error Handling
- **Condition**: <Error scenario>
  - Response: <How component handles it>
  - Recovery: <Recovery mechanism if any>

## Test Strategy

### Testing Approach
**Test Types Required**:
- Unit Tests: <What units need testing>
- Integration Tests: <What integrations to test>
- Contract Tests: <API/Event contracts to verify>
- Performance Tests: <Load/stress scenarios>

### Test Scenarios

#### Unit Test Coverage
- **Business Logic**: <Key algorithms and rules to test>
- **Data Validation**: <Input validation cases>
- **Error Handling**: <Exception scenarios>
- **Edge Cases**: <Boundary conditions>

#### Integration Test Scenarios
- **Happy Path**: <Main success flow>
- **Failure Modes**: <How component handles external failures>
- **Data Consistency**: <Cross-component data integrity>
- **Timeout Handling**: <Behavior under delays>

### Test Data Requirements
- **Test Fixtures**: <Sample data needed>
- **Mock Services**: <External dependencies to mock>
- **Test Environments**: <Isolated test setup needs>

### Testability Considerations
- **Dependency Injection**: <How to inject mocks>
- **State Management**: <How to reset state between tests>
- **Observability**: <How to verify internal behavior>
- **Test Isolation**: <How to prevent test interference>

## Performance Characteristics

### Expected Load
- Requests/second: <Expected rate>
- Data volume: <Expected size>
- Concurrent users: <Expected number>

### Performance Targets
- Response time: <p50/p95/p99 targets>
- Throughput: <Operations per second>
- Resource usage: <CPU/memory expectations>

## Security Specifications

### Authentication
<How component authenticates users/services>

### Authorization
<How component authorizes operations>

### Data Protection
<How sensitive data is protected>

## Operational Specifications

### Health Checks
- Endpoint: <Health check URL/method>
- Checks performed: <What is validated>

### Monitoring
- Key metrics: <What to monitor>
- Alert thresholds: <When to alert>

### Dependencies
- Critical: <Must have to function>
- Optional: <Degraded mode operation>

## Evolution Notes
<Known limitations, technical debt, future considerations>
```

## Change Log Template:

```markdown
# <Component Name> Specification Change Log

## <YYYY-MM-DD> - <Brief description>

### Context
<Why this change was made>

### Capability Changes
- **Added**: <New capabilities>
- **Modified**: <Changed behaviors>
- **Removed**: <Deprecated features>

### Interface Changes
- **API**: <Changes to provided interfaces>
- **Events**: <Changes to event contracts>

### Impact
<How this affects other components>
```

## Quality Checks:

Before finalizing:
- [ ] Component purpose is clear
- [ ] Boundaries are explicit (does and doesn't)
- [ ] All interfaces are documented
- [ ] Behaviors are testable with specific scenarios
- [ ] Test strategy covers all critical paths
- [ ] Test data requirements are identified
- [ ] Performance expectations are stated
- [ ] Security requirements are clear

## Mode-Specific Guidance:

### Mode 1 (New System):
- Focus on business capabilities needed
- Define clear interfaces upfront
- Specify behaviors precisely
- Keep components cohesive

### Mode 4 (Reverse Engineering):
- Document what component actually does
- Capture all exposed interfaces
- Note undocumented behaviors
- Identify technical debt

### Mode 2 (Updates):
- Focus on what capabilities changed
- Update interface documentation
- Revise behavior specifications
- Note deprecated features

## Common Component Types:

### API Services
- Focus on: Endpoints, request/response formats, auth
- Key specs: Operations, error codes, rate limits

### Background Workers
- Focus on: Triggers, processing logic, failure handling  
- Key specs: Job types, retry logic, monitoring

### Data Services
- Focus on: Data models, access patterns, consistency
- Key specs: Schemas, queries, transactions

### Integration Services
- Focus on: External connections, data mapping, error handling
- Key specs: Protocols, transformations, circuit breakers

## Anti-Patterns to Avoid:

### 🚫 The Kitchen Sink Component
- Too many unrelated responsibilities
- Should be split into multiple components

### 🚫 The Anemic Component
- No clear business capability
- Just passes data through

### 🚫 The Tightly Coupled Component
- Knows too much about other components
- Direct database access to others' data

### 🚫 The Black Box Component
- No documented interfaces
- Hidden dependencies

Remember: Component specifications describe what components DO, not what they should do. Focus on capabilities, interfaces, and behaviors that can be tested and verified.

## Open Questions Document

After creating component specifications, create or update `reqs/4-components/open-questions.md` using the template from `prompts/templates/utils/open-questions-template.md`.

### Component-Specific Question Types:

**HIGH Priority Questions:**
- Component interface incomplete (missing endpoints/methods)
- Data ownership unclear between components
- Business capabilities undefined or ambiguous
- Error handling behavior unspecified
- Integration contract missing with other components
- Testing strategy incomplete

**MEDIUM Priority Questions:**
- Performance characteristics unknown
- Configuration requirements unclear
- Dependency management approach undefined
- State management behavior unclear
- Security/authorization behavior unspecified
- Deployment packaging unclear

**LOW Priority Questions:**
- Alternative implementation approaches
- Optimization opportunities
- Monitoring/observability enhancements
- Future capability expansion
- Technology stack alternatives

### Map Missing Info to Questions:
- Each incomplete interface → Question about missing operations
- Each unclear capability → Question about expected behavior  
- Each assumption about dependencies → Validation requirement
- Each undefined error scenario → Question about handling approach

## Missing Information Output

After creating or updating Component Specification documents, you MUST provide a chat output highlighting missing information and areas needing human attention.

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

### Component-Specific Missing Info to Check:
- Interface specifications (missing operations, parameters)
- Error conditions and handling
- Test strategy details
- Performance requirements/SLAs
- Data ownership clarity
- Event schemas
- Security/auth requirements
- Dependencies on other components
- Configuration requirements
- Deployment constraints

## Update Progress Report

After completing component specifications:
1. Update `reqs/progress-report.md`:
   - Mark Stage 4 task 4.1 subtasks complete for each component
   - Update Stage 4 status and progress percentage
   - Record open questions count and interface/capability gaps
   - List all components specified
   - Note any missing interface details
   - Add to activity log: `<Date>: Component specs created (count: X), Y questions identified`
   - Update overall progress percentage
   - Flag readiness for pre-implementation validation

Component specs are the bridge to code - track each one!