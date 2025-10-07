---
criticality: IMPORTANT
failure_mode: Without contract spec rules, API definitions mix with behaviors or become informal documentation
constrained_by:
  - .livespec/specs/metaspecs/base.spec.md
---

# Contract Specification Requirements

## Requirements
- [!] Contract specifications define precise API and data format contracts using standard formats.
  - Spec follows base.spec.md requirements (MSL + criticality + failure_mode) OR uses standard format (OpenAPI, JSON Schema)
  - Spec located in `specs/contracts/` folder
  - Contract defines interface precisely (endpoints, parameters, responses, data formats)
  - Contract uses standard format when possible (OpenAPI YAML, JSON Schema, Protocol Buffers)
  - Contract is versioned (`specs/contracts/api/v1/`, `specs/contracts/api/v2/`)
  - Contract does NOT include implementation details
  - Contract does NOT include business logic or validation rules (→ behavior specs)
  - Contract is machine-readable when possible (enables contract testing)
  - MSL wrapper spec can reference standard format files

## Notes

**Purpose of contract specs:**
- Define precise interfaces between components
- Enable contract testing and mocking
- Version control for breaking changes
- Support code generation

**Contract formats:**
- **APIs**: OpenAPI/Swagger YAML files
- **Data**: JSON Schema, Protocol Buffers
- **Events**: CloudEvents, AsyncAPI
- **MSL wrapper**: When additional context needed

**Example structure:**
```
specs/contracts/
├── api/
│   ├── v1/
│   │   └── users-api.yaml          # OpenAPI spec
│   └── v2/
│       └── users-api.yaml          # Version 2
├── data/
│   └── user-schema.json            # JSON Schema
└── api-versioning.spec.md          # MSL wrapper (versioning strategy)
```

**Good contract content:**
- ✅ `GET /users/{id}` returns `User` object (precise interface)
- ✅ `User.email` string, required, format: email (data contract)
- ✅ `400 Bad Request` when validation fails (error contract)

**Not contract content:**
- ❌ "Users can retrieve their profile" (behavior → behavior spec)
- ❌ "Email must be unique" (business rule → behavior spec)
- ❌ "Store users in PostgreSQL" (implementation → strategy spec)

**Contract testing:**
Contract specs enable automated testing that implementations satisfy contracts without testing full behavior.

Contract specs go in target project's `specs/contracts/` folder. Optional - only needed for projects with APIs or component interfaces.
