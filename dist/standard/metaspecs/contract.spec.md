---
criticality: IMPORTANT
failure_mode: Without contract spec rules, API definitions mix with behaviors or become informal documentation
governed-by:
  - .livespec/standard/metaspecs/base.spec.md
---

# Contract Specification Requirements

## Requirements
- [!] Contract specifications define precise interfaces between any components.
  - Spec follows base.spec.md requirements (MSL + criticality + failure_mode) OR uses standard format (OpenAPI, JSON Schema)
  - Spec located in `specs/3-contracts/` folder or subfolder
  - **Subfolders encouraged** for domain organization (contracts/api/, contracts/runbooks/, contracts/procedures/)
  - Contract defines interface precisely (what both sides must agree on)
  - Contract uses standard format when possible (OpenAPI, JSON Schema, MSL for operational contracts)
  - Contract is versioned when applicable (`contracts/api/v1/`, `contracts/api/v2/`)
  - Contract does NOT include implementation details
  - Contract does NOT include business logic or validation rules (→ behavior specs)
  - Contract is machine-readable when possible (enables contract testing)
  - MSL wrapper spec can reference standard format files
  - **[!] Every contract parameter MUST link to behavior spec** (completeness requirement)
    - Inline reference: `- param_name: Description\n  - Behavior: specs/3-behaviors/feature.spec.md#section`
    - OR frontmatter: `satisfies: [specs/3-behaviors/feature.spec.md]`
    - Validated by: `scripts/check-contract-completeness.sh`
    - Pre-commit hook: Blocks commits if parameters lack behavior links
    - Prevents incomplete features (parameters that promise behavior without implementation)

## Contract vs Behavior Boundary

**Critical distinction**: Contracts describe INTERFACES, behaviors describe OUTCOMES.

**Contracts answer**: "What does the API/function/interface look like?"
- ✅ Parameter schemas (type, format, validation rules)
- ✅ Request/response structures
- ✅ Function signatures
- ✅ Error response formats

**Behaviors answer**: "What should happen when...?"
- ✅ What the system does with those parameters
- ✅ Observable outcomes from using the interface
- ✅ Business logic and validation rules
- ✅ Error conditions and handling

**Dual linkage required**:
```markdown
# Contract (Interface Definition)
## slack_post_message

**Parameters**:
- `thread_ts` (optional): Parent message timestamp
  - Type: string (format: "1234567890.123456")
  - Behavior: specs/3-behaviors/threading.spec.md#thread-replies
```

**Corresponding behavior** (Referenced from contract):
```markdown
# Behavior (Observable Outcome)
## Thread Replies

- [!] System posts replies to message threads.
  - Reply appears under parent message
  - thread_ts identifies parent
  - Graceful failure if parent not found
```

**Common mistakes**:
- ❌ Describing WHAT HAPPENS in contract (put in behavior spec)
- ❌ Describing INTERFACE in behavior (put in contract spec)
- ❌ **Contract parameter without behavior link** (incomplete feature - caught by validation)

**See Reference Library**: `behavior-contract-boundary.md` for complete decision framework.

## Notes

**Contracts apply across domains:**

**Software Development:**
- API contracts: `GET /users/{id}` returns `User` object
- Data contracts: JSON Schema, Protocol Buffers
- Event contracts: CloudEvents, AsyncAPI
- Component interfaces: Between services, libraries, modules

**Operations:**
- Operational contracts (runbooks): "When X happens, execute steps A→B→C"
- Process contracts (procedures): "To achieve Y, follow process Z"
- Service contracts (SLAs): "Service responds within 5 seconds"

**Planning:**
- Workflow contracts: "HLR flows to Design Spec flows to Tasks"
- Delivery contracts: "Feature complete when acceptance criteria met"

**Organizational:**
- Team contracts (RACI): "Team A owns authentication, Team B owns authorization"
- Review contracts: "All policies reviewed quarterly by security team"

**Purpose of contract specs:**
- Define precise interfaces between components (software, human, process, organizational)
- Enable independent evolution of both sides
- Version control for breaking changes
- Support testing and validation

**Contract formats:**
- **Software APIs**: OpenAPI/Swagger YAML
- **Data**: JSON Schema, Protocol Buffers
- **Events**: CloudEvents, AsyncAPI
- **Operational**: MSL format (runbooks, procedures)
- **Process**: MSL format (workflows, handoffs)

**Organization patterns:**
```
specs/contracts/
├── api/                           # Software domain
│   ├── v1/
│   │   └── users-api.yaml        # OpenAPI spec
│   └── v2/
│       └── users-api.yaml        # Version 2
├── data/
│   └── user-schema.json          # JSON Schema
├── runbooks/                     # Operations domain
│   ├── incident-response.spec.md # When incident, do X
│   └── backup-restore.spec.md    # When backup fails, do Y
└── procedures/                   # Process domain
    ├── deployment.spec.md        # How to deploy
    └── code-review.spec.md       # How to review code
```

**Good contract content:**
- ✅ `GET /users/{id}` returns `User` object (API contract)
- ✅ "When alarm fires, execute steps 1-5" (operational contract)
- ✅ "To deploy, follow: build→test→approve→release" (process contract)

**Not contract content:**
- ❌ "Users can retrieve their profile" (behavior → behavior spec)
- ❌ "Email must be unique" (business rule → behavior spec)
- ❌ "Store users in PostgreSQL" (implementation → strategy spec)

**Contract testing:**
Contract specs enable testing that both sides satisfy the interface agreement without testing full behavior.

Contract specs go in target project's `specs/3-contracts/` folder or subfolders. Optional - only needed for projects with interfaces between components.
