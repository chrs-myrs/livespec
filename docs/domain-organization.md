# Domain Organization Guide

## The Core Insight

**behaviors/** and **contracts/** are domain-agnostic abstractions that work across software, governance, operations, and planning domains. You don't need a config system—just organize with subfolders.

## The Abstractions

### behaviors/ = Observable Outcomes

**From ANY perspective:**
- Users: "Users can log in"
- Systems: "API returns paginated results"
- Organizations: "Only authorized entities access resources" (policy)
- Auditors: "Incidents reported within 72 hours" (compliance)
- Operators: "Backups complete daily" (service)

### contracts/ = Interface Definitions

**Of ANY kind:**
- Software APIs: `GET /users/{id}` returns User object
- Data formats: JSON Schema, Protocol Buffers
- Operational procedures: "When alarm fires, do steps A→B→C" (runbook)
- Process workflows: "To deploy, follow: build→test→approve→release" (procedure)
- Service agreements: "System responds within 5 seconds" (SLA)

### strategy/ = Cross-Cutting Decisions

**Applies everywhere:**
- Technical: "Use PostgreSQL for persistence"
- Organizational: "All policies reviewed quarterly"
- Architectural: "Microservices architecture"

## Organization Patterns by Domain

### Software Development

```
specs/
├── workspace/              # How we work
├── behaviors/
│   ├── user-features/     # User-facing behaviors
│   │   ├── authentication.spec.md
│   │   ├── authorization.spec.md
│   │   └── profile-management.spec.md
│   └── system/            # System behaviors
│       ├── caching.spec.md
│       └── rate-limiting.spec.md
├── contracts/
│   ├── api/v1/            # API contracts
│   │   ├── users-api.yaml
│   │   └── auth-api.yaml
│   └── data/              # Data contracts
│       └── user-schema.json
└── strategy/
    ├── architecture.spec.md
    └── technology-stack.spec.md
```

**Key patterns:**
- behaviors/user-features/ for user-facing functionality
- behaviors/system/ for internal system behaviors
- contracts/api/ versioned for breaking changes
- contracts/data/ for data schemas

### Governance & Compliance

```
specs/
├── workspace/              # How we work
├── behaviors/
│   ├── policies/          # Policy behaviors
│   │   ├── access-control.spec.md
│   │   ├── data-protection.spec.md
│   │   └── incident-response.spec.md
│   └── compliance/        # Compliance behaviors
│       ├── gdpr.spec.md
│       ├── iso27001.spec.md
│       └── sox.spec.md
├── contracts/
│   ├── procedures/        # Process contracts
│   │   ├── access-review.spec.md
│   │   ├── incident-handling.spec.md
│   │   └── audit-prep.spec.md
│   └── standards/         # Technical standards
│       ├── password-standard.spec.md
│       └── encryption-standard.spec.md
└── strategy/
    └── security-posture.spec.md
```

**Key patterns:**
- behaviors/policies/ for organizational requirements
- behaviors/compliance/ for regulatory requirements
- contracts/procedures/ for how to implement policies
- contracts/standards/ for technical requirements

**Why behaviors?** Policies define organizational behaviors ("only authorized users access systems").

**Why contracts?** Procedures define process contracts ("to achieve X, follow steps A→B→C").

### Operations & SRE

```
specs/
├── workspace/              # How we work
├── behaviors/
│   ├── services/          # Service behaviors
│   │   ├── backup.spec.md
│   │   ├── monitoring.spec.md
│   │   └── uptime.spec.md
│   └── operational/       # Operational behaviors
│       ├── alerting.spec.md
│       └── response-time.spec.md
├── contracts/
│   ├── runbooks/          # Operational contracts
│   │   ├── incident-response.spec.md
│   │   ├── deployment.spec.md
│   │   └── backup-restore.spec.md
│   └── playbooks/         # Team coordination contracts
│       ├── major-incident.spec.md
│       └── security-breach.spec.md
└── strategy/
    ├── infrastructure.spec.md
    └── tooling.spec.md
```

**Key patterns:**
- behaviors/services/ for SLOs and service commitments
- behaviors/operational/ for operational requirements
- contracts/runbooks/ for response procedures
- contracts/playbooks/ for coordinated team responses

**Why behaviors?** Services define observable behaviors ("backups complete daily").

**Why contracts?** Runbooks define operational contracts ("when X happens, do Y").

### Planning & Requirements

```
specs/
├── workspace/              # How we work
├── behaviors/
│   ├── requirements/      # High-level requirements
│   │   ├── user-needs.spec.md
│   │   ├── success-criteria.spec.md
│   │   └── constraints.spec.md
│   └── features/          # Feature behaviors (detailed)
│       ├── search.spec.md
│       └── notifications.spec.md
├── contracts/
│   └── workflows/         # Process contracts
│       ├── hlr-to-design.spec.md
│       └── design-to-tasks.spec.md
└── strategy/
    └── product-vision.spec.md
```

**Key patterns:**
- behaviors/requirements/ for high-level needs
- behaviors/features/ for detailed feature specifications
- contracts/workflows/ for delivery process

### Hybrid Projects (Multiple Domains)

```
specs/
├── workspace/              # How we work
├── behaviors/
│   ├── user-features/     # Software domain
│   │   ├── authentication.spec.md
│   │   └── api-access.spec.md
│   ├── policies/          # Governance domain
│   │   ├── access-control.spec.md
│   │   └── data-protection.spec.md
│   └── services/          # Operations domain
│       ├── backup.spec.md
│       └── monitoring.spec.md
├── contracts/
│   ├── api/v1/            # Software domain
│   │   └── users-api.yaml
│   ├── procedures/        # Governance domain
│   │   └── access-review.spec.md
│   └── runbooks/          # Operations domain
│       └── incident-response.spec.md
└── strategy/
    ├── architecture.spec.md      # Software
    ├── security-posture.spec.md  # Governance
    └── infrastructure.spec.md    # Operations
```

**Key insight:** Domains coexist within the same abstraction. Clear subfolder names prevent confusion.

## Intermediate Base Specs Pattern

Create domain-specific base specs for consistency within a domain:

### Example: Governance Base Spec

**specs/behaviors/policies/_base-policy.spec.md:**
```markdown
---
criticality: CRITICAL
failure_mode: Without policy base requirements, policies lack consistency
governed-by:
  - ../../../../.livespec/standard/metaspecs/base.spec.md
  - ../../../../.livespec/standard/metaspecs/behavior.spec.md
---

# Base Policy Requirements

All policies must include (in addition to base.spec.md requirements):

## Requirements
- [!] Policy includes compliance framework mapping
  - ISO 27001 control references
  - GDPR article references
  - Other applicable frameworks
- [!] Policy includes review schedule
  - Quarterly for CRITICAL policies
  - Annual for IMPORTANT policies
- [!] Policy includes enforcement mechanism
  - Technical controls
  - Review processes
  - Audit criteria
- [!] Policy includes exceptions process
  - Who can request exceptions
  - Who approves exceptions
  - How exceptions are documented
```

**Individual policy then extends base:**

**specs/behaviors/policies/access-control.spec.md:**
```markdown
---
criticality: CRITICAL
failure_mode: Weak access control enables unauthorized access
governed-by:
  - _base-policy.spec.md
compliance_mapping:
  - ISO 27001: A.9.2
  - GDPR: Article 32
---

# Access Control Policy

## Requirements
- [!] Only authorized entities can access resources
  - Authentication required for all protected resources
  - Authorization enforced at every access point
  - Least privilege applied to all accounts
  - Access reviews conducted quarterly
  - Privileged access monitored and logged
```

**Benefits:**
- Consistency across domain (all policies follow same structure)
- DRY principle (common requirements in one place)
- Easier maintenance (update base, all policies inherit)
- Domain-specific extensions without LiveSpec prescribing them

### Example: Operations Base Spec

**specs/contracts/runbooks/_base-runbook.spec.md:**
```markdown
---
criticality: IMPORTANT
failure_mode: Without runbook base requirements, runbooks lack consistency
governed-by:
  - ../../../../.livespec/standard/metaspecs/base.spec.md
  - ../../../../.livespec/standard/metaspecs/contract.spec.md
---

# Base Runbook Requirements

All runbooks must include:

## Requirements
- [!] Runbook defines trigger conditions
- [!] Runbook includes prerequisite checks
- [!] Runbook provides rollback procedure
- [!] Runbook specifies escalation criteria
- [!] Runbook includes timing estimates
```

## Decision Guide: When to Use Subfolders

### Use Subfolders When:
- **Domain clarity needed**: policies/ clearer than "organizational behaviors"
- **Multiple domains present**: software + governance + operations
- **Logical grouping valuable**: user-features/ vs system/
- **Team organization matches**: security team owns policies/, ops team owns runbooks/

### Don't Use Subfolders When:
- **Small project**: <10 specs total
- **Single domain**: Just software or just governance
- **Flat structure clearer**: All behaviors conceptually similar

## Real-World Examples

### tmp-security (Governance Project)

Actual structure from governance adaptation:
```
specs/
├── workspace/           # Process
├── behaviors/
│   └── policies/       # Policy behaviors
│       ├── access-control.spec.md
│       ├── data-protection.spec.md
│       └── incident-response.spec.md
├── contracts/
│   └── procedures/     # Process contracts
│       └── (to be added)
└── strategy/
    └── security-posture.spec.md
```

### tmp-planning (Planning Project)

Actual structure from planning adaptation:
```
current/
├── {project}/
│   ├── hlr.md                      # High-level requirements (behavior)
│   ├── design-spec.md              # Technical design (strategy)
│   └── EP-{NAME}/                  # Tasks (implementation)
```

Could be organized as LiveSpec:
```
specs/
├── behaviors/requirements/
│   └── hlr.spec.md
├── contracts/workflows/
│   └── hlr-to-design.spec.md
└── strategy/
    └── design-decisions.spec.md
```

### techops-workspace (Operations Project)

Actual structure from operations adaptation:
```
runbooks/                           # Operational contracts
investigations/                     # Investigation procedures
knowledge/                          # Reference documentation
specs/workspace/                    # Process
```

Could be organized as LiveSpec:
```
specs/
├── workspace/                      # Process
├── behaviors/services/
│   └── slo-targets.spec.md
└── contracts/runbooks/
    ├── incident-response.spec.md
    └── investigation-procedures.spec.md
```

## Templates for Different Domains

LiveSpec provides templates for common domain patterns:

### Governance Templates
- `templates/governance/policy.spec.md.template`
- `templates/governance/procedure.spec.md.template`

### Operations Templates
- `templates/operations/runbook.spec.md.template`
- `templates/operations/playbook.spec.md.template`

### Software Templates (existing)
- `templates/workspace/*.template`

## Summary

**Key Takeaway:** behaviors/ and contracts/ are abstractions that work across ALL domains. Use subfolders for semantic organization, create intermediate base specs for domain consistency, and let your project structure emerge naturally from your domain needs.

**No config needed. No framework complexity. Just clear organization within proven abstractions.**
