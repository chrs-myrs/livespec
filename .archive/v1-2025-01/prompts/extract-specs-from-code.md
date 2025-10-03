# Extract Specifications from Code Prompt

You are tasked with reverse engineering specifications from an existing codebase. **CRITICAL**: This prompt implements Mode 4 of the bidirectional requirements system - extracting complete specifications from existing code when no documentation exists.

## Your Mindset for Specification Extraction

Before you begin, understand that you are:
- **A code archaeologist**, uncovering the system's purpose and design
- **A pattern recognizer**, identifying architectural decisions
- **A behavior documenter**, capturing what the system actually does
- **A structure mapper**, documenting the as-built reality

## Deep Analysis Framework

### Step 1: Initial Reconnaissance (10 minutes)
1. **Project Structure Analysis**:
   - Examine directory structure
   - Identify main entry points
   - Locate configuration files
   - Find build/deployment files

2. **Technology Stack Discovery**:
   - Programming languages used
   - Frameworks and libraries
   - Databases and storage
   - External service dependencies

### Step 2: Purpose Extraction (15 minutes)
1. **Functionality Analysis**:
   - What does the system do?
   - Who are the users (from UIs, APIs)?
   - What problems does it solve?
   - What value does it provide?

2. **Business Context Inference**:
   - Look for business logic
   - Identify domain models
   - Understand workflows
   - Infer success metrics

### Step 3: Deep Dive Analysis (30+ minutes)
1. **Architecture Reverse Engineering**:
   - Component identification
   - Communication patterns
   - Data flow mapping
   - Integration points

2. **Technical Decision Extraction**:
   - Identify patterns used
   - Understand technology choices
   - Map data strategies
   - Document security approaches

3. **Component Analysis**:
   - For each major component:
     - What it does
     - Its interfaces
     - Its dependencies
     - Its data

4. **Implementation Documentation**:
   - API specifications
   - Database schemas
   - Algorithms used
   - Deployment configuration

## Instructions

### Automatic Processing:
1. Analyze the entire codebase systematically
2. Create the full `reqs/` folder structure
3. Generate all specification documents
4. Mark inferred information appropriately
5. Note areas where purpose is unclear

### Extraction Process:

#### Phase 1: System Purpose (from code to reqs/1-purpose/)
1. Analyze:
   - README files and documentation
   - API endpoints and their purposes
   - UI screens and user flows
   - Database schemas for domain understanding
   - Configuration for deployment context

2. Create `system-purpose.md` documenting:
   - Inferred business purpose
   - Identified user groups
   - Apparent success metrics
   - System boundaries
   - Integration points

#### Phase 2: Technical Strategies (from code to reqs/2-strategy/)
1. Identify patterns in:
   - Architecture (microservices, monolith, etc.)
   - Data management (SQL, NoSQL, caching)
   - Integration (REST, GraphQL, messaging)
   - Security (auth methods, encryption)
   - Deployment (containers, serverless)

2. Create multiple strategy documents:
   - `01-architecture-patterns.md`
   - `02-data-strategy.md`
   - `03-integration-strategy.md`
   - `04-security-strategy.md`
   - Others as needed

#### Phase 3: System Design (from code to reqs/3-design/)
1. Map:
   - Component boundaries
   - Service interactions
   - Data flows
   - Deployment topology

2. Create design documents:
   - `01-system-overview.md`
   - `02-component-details.md`
   - `03-data-flow.md`
   - Others as needed

#### Phase 4: Component Specs (from code to reqs/4-components/)
1. For each component:
   - Document capabilities
   - Map interfaces
   - Identify data ownership
   - Extract business rules

2. Create one spec per component:
   - `01-<component-name>-spec.md`
   - `02-<component-name>-spec.md`
   - etc.

#### Phase 5: Implementation Specs (from code to reqs/5-implementation/)
1. Extract:
   - API contracts
   - Database schemas
   - Core algorithms
   - Deployment configs

2. Create detailed implementation specs:
   - `01-<component-name>-implementation.md`
   - `02-<component-name>-implementation.md`
   - etc.

## Extraction Guidelines:

### Marking Inferences
When information is not explicit, mark it:
- **Inferred**: <reasoning based on code patterns>
- **Assumed**: <likely but unconfirmed>
- **Unknown**: <cannot determine from code>

Example:
```markdown
### Business Value
**Inferred**: Based on the e-commerce checkout flow and payment processing, this system appears to handle online order fulfillment, likely saving manual order processing time.

**Unknown**: Specific cost savings or efficiency metrics.
```

### Code Evidence
Always provide evidence for specifications:
```markdown
### Authentication Strategy
**Choice Made**: JWT-based authentication
**Evidence**: 
- `auth/jwt.js` implements token generation
- All API routes check `Authorization: Bearer` header
- Token expiry set to 24 hours in config
**Inferred Rationale**: Stateless authentication for scalability
```

### Uncertainty Documentation
Be honest about what you don't know:
```markdown
### System Purpose
The payment processing module handles credit card transactions.

**Unclear aspects**:
- Why both Stripe and PayPal are integrated
- What determines payment method selection
- Whether this is for B2C, B2B, or both
```

## Common Extraction Patterns:

### From File Structure
```
src/
├── api/          → REST API component
├── workers/      → Background job component  
├── models/       → Data layer
└── services/     → Business logic layer
```

### From Technology Choices
- Express.js → Node.js REST API
- React → Web frontend component
- PostgreSQL → Relational data needs
- Redis → Caching or sessions
- RabbitMQ → Async messaging
- Kubernetes → Container orchestration

### From Code Patterns
- Repository pattern → Data abstraction strategy
- JWT in auth → Stateless authentication
- Event emitters → Event-driven design
- Retry logic → Resilience strategy
- Connection pools → Performance optimization

### From Naming Conventions
- `UserService` → User management component
- `OrderProcessor` → Order handling workflow
- `PaymentGateway` → Payment integration
- `NotificationQueue` → Async notifications

## Quality Checks:

Before finalizing:
- [ ] All major components identified
- [ ] Technologies and patterns documented
- [ ] Inferences clearly marked
- [ ] Evidence provided for claims
- [ ] Unknowns honestly noted
- [ ] Full folder structure created

## Output Structure:

Create complete folder structure:
```
reqs/
├── 1-purpose/
│   └── system-purpose.md
├── 2-strategy/
│   ├── 01-architecture-patterns.md
│   ├── 02-data-strategy.md
│   └── ...
├── 3-design/
│   ├── 01-system-overview.md
│   ├── 02-component-details.md
│   └── ...
├── 4-components/
│   ├── 01-api-service-spec.md
│   ├── 02-worker-service-spec.md
│   └── ...
├── 5-implementation/
│   ├── 01-api-service-implementation.md
│   ├── 02-worker-service-implementation.md
│   └── ...
└── README.md
```

## Special Considerations:

### Legacy Code
- May lack clear patterns
- Document technical debt
- Note modernization opportunities

### Incomplete Systems
- Document what exists
- Note obvious gaps
- Don't invent missing pieces

### Multi-Language Codebases
- Document each language's role
- Map language boundaries
- Note integration methods

### Undocumented APIs
- Extract from route handlers
- Infer from client code
- Document from tests

Remember: The goal is to document what IS, not what SHOULD BE. Be honest about the current state, mark your inferences clearly, and provide evidence for your conclusions. This extracted documentation becomes the baseline for future bidirectional maintenance.