# MSL for Documentation Projects

**Purpose**: Guide documentation teams in using Minimum Sufficient Language for specification-driven docs.

**Key insight**: Documentation is implementation. Specs define WHAT information docs must convey, not HOW to write it.

---

## Why Spec-Driven Documentation?

**Traditional approach** (no specs):
```
Writer 1: "I'll document the architecture"
Writer 2: "I'll document the API"
→ 6 months later: Inconsistent depth, missing critical info, duplicate content
→ User feedback: "I still don't understand how this works"
```

**Spec-driven approach**:
```
1. Define requirements: "Developers must understand system architecture in 2 hours"
2. Write spec: What docs must contain to achieve requirement
3. Implement: Write actual documentation
4. Validate: New developer tests comprehension time
→ Result: Docs meet defined success criteria
```

**Benefits**:
- Clear success criteria before writing
- Prevents scope creep (only write what's needed)
- Enables collaboration (spec defines consistency)
- Detects drift (docs no longer meet user needs)
- Validates against user outcomes, not author assumptions

---

## MSL Principles for Docs

### 1. Specify Outcomes, Not Content

**❌ Wrong** (specifying HOW to write):
```yaml
## Requirements
- [!] Architecture documentation follows this structure.
  - Section 1: Introduction
  - Section 1.1: Welcome message
  - Section 1.2: Prerequisites
  - Section 2: Components
  - Section 2.1: API Gateway (500 words)
  - Section 2.2: Database (500 words)
  - ...
```

**✅ Right** (specifying WHAT outcome):
```yaml
## Requirements
- [!] Documentation enables developers to understand system architecture within 2 hours.
  - System components identified with clear responsibilities
  - Data flow between components visualized
  - Integration points documented
  - No implementation details (conceptual level only)
  - Updated when architecture changes

## Validation
- New developer completes architecture comprehension in <2 hours
- Can identify which component handles specific responsibilities
- Can trace data flow through system
- Knows which APIs/events connect components
```

**Why better**: Writers have creative freedom for structure/wording while meeting defined outcomes.

### 2. Define Information, Not Presentation

**❌ Wrong** (presentation details):
```yaml
## Requirements
- [!] Getting Started guide uses bullet points, blue callout boxes, and screenshots.
  - First screenshot shows dashboard
  - Callout box highlights common mistakes
  - Code samples use dark theme with line numbers
```

**✅ Right** (information requirements):
```yaml
## Requirements
- [!] Getting Started guide enables new users to complete first task within 15 minutes.
  - Prerequisites clearly listed (no hunting for system requirements)
  - Installation steps in logical order
  - Common errors identified with solutions
  - First successful task demonstrated with expected output
  - Next steps provided for continued learning
```

**Why better**: Presentation can adapt to brand guidelines, but information requirements stay constant.

### 3. Validate Against User Needs

**Every doc spec needs**:
- **Who**: Target audience (new developers, API consumers, operators)
- **Why**: Purpose docs serve (onboarding, reference, troubleshooting)
- **What**: Information that must be conveyed
- **How to verify**: Observable success criteria

**Example**:
```yaml
---
satisfies:
  - specs/1-requirements/strategic/developer-productivity.spec.md
criticality: IMPORTANT
failure_mode: Developers waste time figuring out API usage, support tickets increase
---

# API Reference Documentation

## Requirements
- [!] API documentation enables developers to integrate endpoints correctly on first attempt.
  - All endpoints listed with HTTP method, path, purpose
  - Request parameters typed with constraints (required/optional, format, validation)
  - Response format documented with examples (success and error cases)
  - Authentication method specified
  - Rate limits clearly stated
  - Common error codes explained with solutions

## Validation
- Developer can integrate endpoint without asking questions
- Request/response format examples are copy-pasteable
- Authentication works using documented method
- Error handling covers documented error codes
- No support tickets for "how do I use this API?"
```

---

## Common Documentation Specs

### Architecture/Overview Docs

```yaml
# specs/3-behaviors/documentation/architecture-overview.spec.md
---
satisfies:
  - specs/1-requirements/strategic/developer-onboarding.spec.md
criticality: CRITICAL
failure_mode: New developers cannot understand system design, onboarding takes weeks
---

# Architecture Overview Documentation

## Requirements
- [!] Architecture docs explain system design to new developers within target time.
  - High-level component diagram showing main system parts
  - Component responsibilities explained (what each does, why it exists)
  - Data flow between components visualized
  - Key architectural decisions documented with rationale
  - Technology stack listed with purpose of each technology
  - Deployment architecture diagram showing environments

## Validation
- New developer can explain system architecture after reading
- Can identify which component handles specific use cases
- Understands why key architectural decisions were made
- Knows which technologies are used and why
- Can describe deployment model
```

### API Documentation

```yaml
# specs/3-behaviors/documentation/api-reference.spec.md
---
satisfies:
  - specs/1-requirements/functional/api-integration.spec.md
criticality: CRITICAL
failure_mode: API consumers cannot integrate successfully, support burden increases
---

# API Reference Documentation

## Requirements
- [!] API reference enables developers to integrate all endpoints correctly.
  - Endpoint inventory: All endpoints listed with purpose
  - Request specification: Method, path, headers, body schema
  - Response specification: Status codes, body schema, error formats
  - Authentication: Method documented with examples
  - Rate limits: Documented with headers to monitor usage
  - Examples: Working request/response for each endpoint
  - Errors: Common error codes explained with solutions

## Validation
- All endpoints documented
- Requests can be constructed from specs alone
- Responses match documented schemas
- Authentication examples work
- Error examples cover common failure modes
- Zero "how do I call this API?" support tickets
```

### Runbooks/Operations Docs

```yaml
# specs/3-behaviors/documentation/incident-runbooks.spec.md
---
satisfies:
  - specs/1-requirements/operational/incident-response.spec.md
criticality: CRITICAL
failure_mode: Operators cannot resolve incidents, downtime increases
---

# Incident Response Runbooks

## Requirements
- [!] Runbooks enable operators to diagnose and resolve incidents quickly.
  - Symptom identification: Observable signs of each incident type
  - Diagnostic steps: How to confirm root cause
  - Resolution steps: Precise actions to resolve issue
  - Validation: How to confirm issue resolved
  - Escalation: When to escalate, who to contact
  - Rollback: How to undo changes if resolution fails

## Validation
- Operator can identify incident type from symptoms
- Diagnostic steps lead to correct root cause
- Resolution steps resolve issue without escalation
- Validation confirms system healthy
- Escalation path clear when needed
- Rollback documented if resolution risky
```

### Tutorials/Guides

```yaml
# specs/3-behaviors/documentation/getting-started-guide.spec.md
---
satisfies:
  - specs/1-requirements/strategic/user-activation.spec.md
criticality: IMPORTANT
failure_mode: Users cannot complete first task, abandon product
---

# Getting Started Guide

## Requirements
- [!] Getting Started guide enables new users to complete first meaningful task.
  - Prerequisites listed clearly (system requirements, accounts needed)
  - Installation steps complete and ordered logically
  - Configuration explained with sensible defaults
  - First task walkthrough with expected outcomes at each step
  - Troubleshooting common issues encountered during setup
  - Next steps guide to continued learning

## Validation
- User completes installation without external help
- User completes first task successfully
- User knows what to do next after completing guide
- Common setup errors covered in troubleshooting
- Time to first success meets target (<15 minutes)
```

---

## What to Specify vs Leave to Writers

### Specify (Critical to Outcome)

**Information requirements**:
- ✅ What information must docs contain
- ✅ Depth of coverage (overview vs detailed)
- ✅ Accuracy requirements (what must be precise)
- ✅ Update triggers (when docs must change)
- ✅ Success criteria (how users benefit)

**Structure requirements** (only when critical):
- ✅ Logical ordering (when sequence matters for comprehension)
- ✅ Findability (how users locate information)
- ✅ Cross-references (when context depends on other docs)

**Examples**:
```yaml
# ✅ Specify this
## Requirements
- [!] API docs contain all endpoints with request/response schemas.
  - Endpoints grouped by resource type (users, orders, products)
  - Authentication explained before endpoints
  - Common patterns (pagination, filtering) documented once and referenced

# ❌ Don't specify this
## Requirements
- [!] API docs use OpenAPI specification v3.0.0.
  - Generate docs using Swagger UI
  - Use Redoc theme with custom CSS
  - Host on api.example.com/docs
```

### Leave to Writers (Implementation Details)

**Writing style**:
- ❌ Exact wording (unless critical to meaning)
- ❌ Sentence structure
- ❌ Tone (unless brand-critical)
- ❌ Paragraph length

**Presentation**:
- ❌ Formatting choices (bold, italic, bullets vs numbered)
- ❌ Layout decisions (sidebar, columns)
- ❌ Visual design (colors, fonts)
- ❌ Tooling (static site generator, doc platform)

**Content organization** (unless impacts outcome):
- ❌ Section headings (unless findability critical)
- ❌ Example selection (unless specific example required)
- ❌ Navigation structure (unless users can't find things)

**Exception**: If presentation/structure directly impacts success criteria (e.g., accessibility requirements, search optimization), then specify it.

---

## Value Structure for Documentation

**Every documentation artifact traces to PURPOSE**:

```
PURPOSE.md
    ↓ derives-from
1-requirements/strategic/outcomes.spec.md
    ("Developers onboard in 2 hours", "API consumers integrate successfully")
    ↓ derives-from
2-strategy/documentation-approach.spec.md
    ("Progressive disclosure", "Task-oriented structure")
    ↓ satisfies (WHAT) + guided-by (HOW)
3-behaviors/documentation/architecture-docs.spec.md
    (What architecture docs must contain)
    ↓ implements
docs/architecture/README.md
    (Actual documentation content)
```

**Traceability validation**:
- Can you trace each doc back to user outcome?
- Does each spec link to strategic requirement?
- If a doc doesn't trace to PURPOSE, why does it exist?

**Example traceability**:
```yaml
# PURPOSE.md
"Enable rapid developer onboarding to reduce time-to-productivity"

# specs/1-requirements/strategic/onboarding.spec.md
derives-from:
  - PURPOSE.md
## Requirements
- [!] New developers productive within 2 hours of starting.

# specs/3-behaviors/documentation/architecture-docs.spec.md
satisfies:
  - specs/1-requirements/strategic/onboarding.spec.md
## Requirements
- [!] Architecture docs explain system design within target time.

# docs/architecture/README.md
implements: specs/3-behaviors/documentation/architecture-docs.spec.md
```

**Orphaned doc detection**:
```bash
# Validation catches docs without specs
bash scripts/validate-value-structure.sh

# If doc has no spec → Why does it exist?
# If spec has no requirement → What outcome does it serve?
# If requirement has no PURPOSE link → Why are we building this?
```

---

## Common Anti-Patterns

### Anti-Pattern 1: Over-Specifying Content

**❌ Wrong**:
```yaml
## Requirements
- [!] Overview page contains exactly 500 words.
  - Paragraph 1: Introduce product (100 words)
  - Paragraph 2: List 3 key benefits (150 words)
  - Paragraph 3: Describe use cases (150 words)
  - Paragraph 4: Call to action (100 words)
  - Must include screenshot of dashboard
  - Must use heading "Welcome to Our Platform"
```

**Problem**: Locks writers into specific implementation, prevents improvement.

**✅ Right**:
```yaml
## Requirements
- [!] Overview page enables visitors to understand product value within 1 minute.
  - Product purpose clearly stated
  - Key benefits identified
  - Target use cases explained
  - Clear next action (sign up, demo, docs)

## Validation
- Visitor can explain what product does after reading
- Can identify if product solves their problem
- Knows what to do next
- Comprehension time <1 minute
```

### Anti-Pattern 2: No Validation Criteria

**❌ Wrong**:
```yaml
## Requirements
- [!] System has comprehensive documentation.
  - All features documented
  - API reference complete
  - Examples provided

## Validation
- Documentation exists
```

**Problem**: No way to verify "comprehensive" or "complete". Subjective success.

**✅ Right**:
```yaml
## Requirements
- [!] Documentation enables users to complete all primary workflows without external help.
  - All user-facing features have usage docs
  - All API endpoints have reference docs
  - All common tasks have examples
  - All error messages have solutions

## Validation
- Feature docs cover 100% of UI functionality
- API docs cover 100% of public endpoints
- Task examples cover top 10 user workflows
- Error docs cover errors seen in last 30 days
- Support tickets show <5% "how do I...?" questions
```

### Anti-Pattern 3: Documentation as Afterthought

**❌ Wrong workflow**:
```
1. Build feature
2. Launch feature
3. Users complain docs missing
4. Writer tries to reverse-engineer requirements
5. Docs don't match user needs (wrong focus)
```

**✅ Right workflow**:
```
1. Define requirement (what users need to accomplish)
2. Write doc spec (what information users need)
3. Build feature (implementation of requirement)
4. Write docs (implementation of doc spec)
5. Validate (users accomplish goal using docs)
```

**Spec-first for docs**:
- Document WHAT users need before HOW to build
- Validates documentation serves user outcomes
- Prevents "we built it but can't explain it" syndrome

### Anti-Pattern 4: One Spec Per Doc File

**❌ Wrong** (too granular):
```
specs/3-behaviors/documentation/
├── readme-md.spec.md
├── architecture-overview-md.spec.md
├── architecture-components-md.spec.md
├── architecture-dataflow-md.spec.md
└── ... (20+ files)
```

**Problem**: Spec overhead becomes burden, defeats MSL minimalism.

**✅ Right** (group by purpose):
```
specs/3-behaviors/documentation/
├── architecture-docs.spec.md          # Covers all architecture/*.md files
├── api-reference.spec.md              # Covers all api/*.md files
└── onboarding-guides.spec.md          # Covers all guides/getting-started/*.md files
```

**Test**: "Do these docs serve the same user outcome?"
- YES → One spec covers all
- NO → Separate specs

---

## MSL Decision Framework for Docs

**Before adding requirement to doc spec, ask**:

### 1. Would docs fail without this?
```
"API reference must include examples"
→ Without examples, developers can't integrate (FAIL)
→ INCLUDE

"Examples must use TypeScript"
→ JavaScript examples work fine (NO FAIL)
→ EXCLUDE (let writer choose)
```

### 2. Is this WHAT or HOW?
```
"Docs must explain authentication process" (WHAT)
→ INCLUDE

"Docs must use OAuth 2.0 diagrams from RFC 6749" (HOW)
→ EXCLUDE (writer can choose diagram style)
```

### 3. What breaks if this is wrong?
```
"Installation steps must be in correct order"
→ Users can't install successfully (BREAKS)
→ INCLUDE ordering requirement

"Installation section must have 5 subsections"
→ Content works fine with 3 or 7 sections (DOESN'T BREAK)
→ EXCLUDE
```

### 4. Can this be validated?
```
"Docs must be comprehensive"
→ Can't measure (TOO VAGUE)
→ REWRITE: "Docs cover 100% of API endpoints"

"Docs must be beautiful"
→ Subjective (TOO VAGUE)
→ REWRITE: "Docs meet WCAG AA accessibility standards"
```

**If unsure**: Start minimal. Add requirements only when validated absence causes failure.

---

## Examples: Before and After

### Example 1: Architecture Documentation

**Before MSL** (300-line spec):
```yaml
## Requirements
- [!] Architecture documentation follows this exact structure:
  - Title: "System Architecture Overview"
  - Introduction: 200 words welcoming developers
  - Architecture Principles section:
    - Principle 1: Microservices
      - Definition of microservices (150 words)
      - Why we chose microservices (200 words)
      - Microservices diagram using PlantUML
    - Principle 2: Event-driven
      - Definition of event-driven (150 words)
      - Event flow diagram (specific tools listed)
  - Components section:
    - Each component gets subsection
    - Component 1: API Gateway (500 words)
      - Purpose
      - Technology (Node.js + Express)
      - Configuration
      - Code examples
    - Component 2: User Service (500 words)
    ... (15 more components specified in detail)
  - Deployment section:
    - Kubernetes architecture diagram
    - Namespace structure
    - Pod specifications
  ... (continues for 300 lines)
```

**After MSL** (30-line spec):
```yaml
## Requirements
- [!] Architecture documentation enables new developers to understand system design within 2 hours.
  - System components identified with clear responsibilities
  - Architectural decisions explained with rationale (why microservices, why event-driven)
  - Data flow visualized between major components
  - Technology stack listed with purpose of each choice
  - Deployment model explained at conceptual level

## Validation
- New developer can explain system architecture after reading
- Can identify which component handles specific responsibilities
- Understands key architectural decisions and rationale
- Knows which technologies are used and why
- Can describe deployment model
- Comprehension time <2 hours (tested with new hires)
```

**Impact**:
- 90% reduction in spec size
- Writers have freedom to organize content effectively
- Focus on user outcome, not structure
- Validation criteria make success measurable

### Example 2: API Reference

**Before MSL** (over-specified):
```yaml
## Requirements
- [!] API reference uses OpenAPI 3.0.0 specification.
  - Generate docs with Redoc
  - Use custom CSS theme (colors specified: #007bff, #28a745, #dc3545)
  - Host at https://api.example.com/docs
  - Generate code samples in 5 languages (Python, JavaScript, Ruby, Go, Java)
  - Use following request/response example format:
    ```
    ### Request
    \`\`\`bash
    curl -X GET https://api.example.com/v1/users \
      -H "Authorization: Bearer TOKEN"
    \`\`\`

    ### Response
    \`\`\`json
    {
      "users": [...]
    }
    \`\`\`
    ```
  - Include response time SLA in each endpoint doc
  - Show OpenAPI spec version at top of page
  ... (continues with formatting details)
```

**After MSL** (outcome-focused):
```yaml
## Requirements
- [!] API reference enables developers to integrate endpoints correctly on first attempt.
  - All endpoints documented with method, path, purpose
  - Request parameters typed with constraints
  - Response schemas with examples (success + error cases)
  - Authentication method demonstrated
  - Rate limits clearly stated
  - Common errors explained with solutions

## Validation
- Developer can construct valid request from docs alone
- Response format matches documented schema
- Authentication examples work when copy-pasted
- Error handling covers documented error codes
- Zero "how do I call this?" support tickets
```

**Impact**:
- Frees writers to choose best doc tooling
- Focuses on what developers need, not presentation
- Tooling can change without spec change
- Validation based on developer success, not doc presence

---

## Testing Documentation Specs

### Validation Methods

**1. Time-to-Task Completion**
```yaml
## Validation
- New user completes first task in <15 minutes
- Developer integrates API in <30 minutes
- Operator resolves common incident in <10 minutes

# How to test:
- Recruit target user (new developer, operator, etc.)
- Give them docs, observe task completion
- Measure time, note where they struggle
- Iterate docs until time target met
```

**2. Comprehension Testing**
```yaml
## Validation
- User can explain architecture after reading
- Can identify which component handles X
- Can describe deployment model

# How to test:
- User reads docs
- Ask comprehension questions
- Score answers (can they explain correctly?)
- Iterate docs until comprehension target met
```

**3. Support Ticket Analysis**
```yaml
## Validation
- <5% of support tickets are "how do I...?" questions
- Zero tickets for topics documented
- Error message docs reduce resolution time by 50%

# How to test:
- Track support tickets before/after doc changes
- Categorize by type (missing docs, unclear docs, bug)
- Measure reduction in docs-related tickets
```

**4. Success Rate Measurement**
```yaml
## Validation
- 95% of developers successfully integrate API on first attempt
- 90% of installations succeed without support contact
- 100% of documented procedures execute successfully

# How to test:
- Track success/failure rates for documented tasks
- Identify failure patterns (where docs unclear)
- Iterate docs until success rate target met
```

### Example Test Plan

**For**: API Reference Documentation

**Spec validation criteria**:
- Developer can integrate endpoint without asking questions
- Request/response examples are copy-pasteable
- Authentication works using documented method

**Test plan**:
1. **Recruit**: 5 developers unfamiliar with API
2. **Task**: "Integrate the POST /users endpoint to create a user"
3. **Provide**: Only API reference docs (no other help)
4. **Observe**:
   - Can they construct valid request from docs?
   - Do they need to ask questions?
   - Does their code work on first attempt?
5. **Measure**:
   - Success rate (did integration work?)
   - Time to first successful call
   - Number of questions asked
6. **Pass criteria**:
   - 100% success rate (all 5 developers succeed)
   - Zero questions asked (docs are self-sufficient)
   - Time <30 minutes

**If test fails**: Identify doc gaps, update docs, retest.

---

## Getting Started with MSL for Docs

### Quick Start (5 steps)

**1. Define user outcome** (Why docs exist)
```
Before: "We need API documentation"
After: "Developers must integrate our API correctly on first attempt"
```

**2. Write spec** (What docs must contain)
```yaml
# specs/3-behaviors/documentation/api-reference.spec.md
---
satisfies:
  - specs/1-requirements/functional/api-integration.spec.md
criticality: CRITICAL
failure_mode: Developers cannot integrate API, support burden increases
---

# API Reference Documentation

## Requirements
- [!] API reference enables first-attempt integration success.
  - All endpoints documented with purpose
  - Request/response schemas with examples
  - Authentication demonstrated
  - Errors explained with solutions

## Validation
- Developer integrates endpoint without questions
- Code works on first attempt
- Support tickets <5 per month
```

**3. Create documentation** (Implementation)
```
docs/api/reference.md (implements spec)
- Endpoints listed
- Request examples
- Response schemas
- Auth examples
- Error codes
```

**4. Validate** (Test against spec criteria)
```
- Recruit developer unfamiliar with API
- Task: "Integrate POST /users endpoint"
- Success? Time? Questions?
- Meets spec criteria?
```

**5. Iterate** (Update docs until validation passes)
```
- Developer couldn't find auth info → Add auth section earlier
- Request example missing required header → Fix example
- Error code 409 not documented → Add to errors section
- Retest until validation passes
```

### Migration: Existing Docs to Spec-Driven

**Step 1**: Identify user outcomes (reverse-engineer purpose)
```
Current doc: "API Reference"
Ask: Why does this exist? What must users accomplish?
Answer: "Developers must integrate our API successfully"
```

**Step 2**: Write minimal spec
```yaml
## Requirements
- [!] API reference enables successful integration.
  - [Observable behaviors that current docs achieve]

## Validation
- [How you'd test if docs work]
```

**Step 3**: Test current docs against spec
```
- Do current docs meet all requirements?
- Do they pass validation criteria?
- If NO, identify gaps
```

**Step 4**: Iterate docs to meet spec
```
- Fill identified gaps
- Remove content that doesn't serve spec requirements
- Retest until validation passes
```

**Step 5**: Maintain spec-first discipline
```
- Changes to docs → Update spec if requirements change
- New docs → Write spec first
- Validation → Regular testing against spec criteria
```

---

## Summary

**MSL for documentation**:
- Specify WHAT information (outcomes), not HOW to write (implementation)
- Define validation criteria (measurable success)
- Leave structure/style to writers (trust implementers)
- Trace docs to user needs (Value Structure)
- Test against real users (validation)

**Decision framework**:
1. Would docs fail without this? → Include
2. Is this WHAT or HOW? → Include WHAT only
3. What breaks if wrong? → If nothing, exclude
4. Can it be validated? → Rewrite until measurable

**Start minimal**:
- One spec can cover multiple docs (same purpose)
- Focus on critical information (CRITICAL/IMPORTANT only)
- Add requirements only when absence causes failure
- Trust writers for implementation details

**Validation is key**:
- Test with real users
- Measure task completion
- Track support tickets
- Iterate until validation passes

**Value structure**:
- Every doc traces to PURPOSE
- Specs link to requirements
- Validation ensures docs serve users
- No orphaned documentation

---

**See also**:
- `dist/standard/metaspecs/taxonomy.spec.md` - Documentation project example
- `dist/guides/spec-decision-framework.md` - "Does this need a spec?" (YES)
- `dist/guides/msl-minimalism.md` - Full MSL framework
- `dist/guides/frontmatter-relationships.md` - How to link specs
