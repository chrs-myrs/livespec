---
applies_to:
  - all_projects
criticality: IMPORTANT
failure_mode: Duplicate external documentation or over-specify obvious integrations, wasting specification maintenance effort
governed-by:
  - .livespec/standard/metaspecs/workspace.spec.md
derives-from:
  - specs/workspace/patterns.spec.md
---

# Third-Party Dependencies and External Integrations

## Requirements
- [!] LiveSpec projects reference external documentation rather than duplicating it, specifying integration behaviors only when non-obvious, critical, or requiring failure mode documentation.
  - Standard dependency files handle versions (package.json, requirements.txt, go.mod)
  - External documentation linked, never copied
  - Integration behaviors specified only if non-obvious or critical
  - Architecture specs mention significant dependencies with links
  - Constraints specs document critical dependency requirements
  - knowledge/integrations/ holds reference material (optional)

## Core Principle

**Don't duplicate external documentation.** Reference Auth0 docs, don't copy them.

## Default Approach

Most third-party components don't need LiveSpec specifications:

**Standard dependency files:**
- package.json - npm packages, versions
- requirements.txt - Python dependencies
- go.mod - Go modules
- Gemfile - Ruby gems

**External documentation:**
- Link to Auth0 docs, not copy them
- Reference ApiService docs, not duplicate them
- Point to AWS documentation

**Only specify when:**
- Integration behavior is non-obvious or critical
- Failure modes require handling
- Multiple components need shared understanding

## Decision Tree

```
Do you integrate with external service/library?
├─ Is it in standard dependency file? (package.json, requirements.txt)
│  └─ YES → Sufficient for most cases, no spec needed
│
├─ Is integration behavior obvious from external docs?
│  └─ YES → Just reference external docs, no spec needed
│
├─ Is integration behavior non-obvious or critical?
│  └─ YES → Create behavior spec in specs/3-behaviors/integrations/
│
├─ Does architecture need to justify dependency choice?
│  └─ YES → Mention in specs/2-strategy/architecture.spec.md (one line + link)
│
└─ Is dependency a critical constraint? (contractual, regulatory)
   └─ YES → Document in specs/1-requirements/strategic/constraints.spec.md
```

## Location Patterns

**specs/3-behaviors/integrations/** - Integration behaviors (rare)
- YOUR system's behavior when using external service
- Only if non-obvious, critical, or has failure modes
- Links to external documentation, doesn't duplicate it
- Example: specs/3-behaviors/integrations/auth0-authentication.spec.md

**specs/2-strategy/architecture.spec.md** - Major dependencies (common)
- One-line mention of significant dependencies
- Link to external documentation
- Example: "System uses Auth0 (https://auth0.com/docs) for authentication"

**specs/1-requirements/strategic/constraints.spec.md** - Critical dependency constraints (rare)
- Only if dependency is fundamental business constraint
- Example: "Must support Auth0 as identity provider" (contractual requirement)

**knowledge/integrations/** - Reference material (optional)
- Integration notes, discoveries, research
- Imported OpenAPI specs (if needed for code generation)
- Links to scattered external documentation
- NOT specifications, just reference material

## Examples

### ✅ Good Patterns

**Simple library usage** (no spec needed):
- Express.js web framework → package.json only, no spec
- Lodash utilities → package.json only, no spec
- AWS SDK → package.json + link in README, no spec

**External service with good docs** (mention in architecture):
```markdown
# specs/2-strategy/architecture.spec.md

## External Dependencies

- **AuthProvider** (https://auth-provider.example/docs) - User authentication, OAuth2/OIDC
- **ApiService** (https://api-service.example/docs/api) - External service integration
- **CloudStorage** (https://docs.cloud-storage.example/api/) - File storage
```

**Complex integration needing behavior spec:**
```markdown
# specs/3-behaviors/integrations/webhook-processing.spec.md
---
criticality: IMPORTANT
failure_mode: Event confirmations not processed, transactions stuck
---

# External Service Webhook Processing

## Requirements
- [!] System processes external service webhook events reliably
  - Validates webhook signatures
  - Handles idempotent processing
  - Retries failed webhooks with exponential backoff
  - References: https://api-service.example/docs/webhooks

## Validation
- Webhook signature validation prevents spoofing
- Duplicate events processed idempotently
- Failed processing retried up to 5 times
```

**Critical dependency constraint:**
```markdown
# specs/1-requirements/strategic/constraints.spec.md

## Requirements
- [!] System must support Auth0 as identity provider
  - Contractual requirement with enterprise customers
  - Cannot migrate to alternative IdP without customer approval
```

### ❌ Bad Patterns

**Duplicating external docs:**
```markdown
❌ specs/3-contracts/auth0-api.yaml
   (copying Auth0's entire API spec - just link to their docs)
```

**Specifying obvious integrations:**
```markdown
❌ specs/3-behaviors/logging-with-winston.spec.md
   (obvious library usage, no critical behaviors)
```

**Over-specifying implementation details:**
```markdown
❌ specs/3-behaviors/http-client-configuration.spec.md
   (implementation detail, not behavior)
```

## Integration with Standard Dependency Management

**Use existing tools:**
- package.json, requirements.txt, go.mod for versions
- Dependabot, Renovate for updates
- npm audit, pip check for vulnerabilities

**LiveSpec adds:**
- Architectural justification (why this dependency?)
- Integration behaviors (non-obvious system behaviors)
- Failure mode documentation (what breaks if dependency unavailable?)
- Links to external docs (consolidated references)

**Don't duplicate:**
- Version specifications (use package.json)
- API documentation (link to external docs)
- Library usage examples (use external tutorials)

## Validation
- Standard dependency files exist for version management
- External documentation linked, not copied
- Integration specs created only when non-obvious or critical
- Architecture specs mention significant dependencies
- Constraints specs document critical requirements
- knowledge/ used for reference material (not specs)
- No duplication of external API documentation
