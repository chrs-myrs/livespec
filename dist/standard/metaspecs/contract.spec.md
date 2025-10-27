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
