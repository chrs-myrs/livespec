# Auth System Example

This example demonstrates LiveSpec's handling of **cross-cutting concerns** - patterns that span multiple modules and require coordinated specification.

## Why Cross-Cutting Concerns Matter

Authentication and authorization touch nearly every part of a system:
- Every API endpoint needs access control
- Every user action may need permission checking
- Session state affects all user interactions
- Security failures cascade across the entire application

Traditional documentation struggles with cross-cutting concerns because they don't fit neatly into feature-based organization. LiveSpec's three-layer architecture handles this naturally.

## Structure

```
specs/
├── foundation/              # Layer 1: WHAT must be achieved
│   ├── outcomes.spec.md              # High-level security goals
│   └── functional/
│       ├── authentication.spec.md    # Authentication requirements
│       └── authorization.spec.md     # Access control requirements
├── strategy/                  # Layer 2: HOW to approach
│   └── security-approach.spec.md     # Cross-cutting security decisions
├── features/                 # Layer 3: EXACTLY what happens
│   ├── user-login.spec.md            # Login flow behavior
│   ├── session-management.spec.md    # Session lifecycle
│   ├── role-authorization.spec.md    # RBAC behavior
│   └── password-reset.spec.md        # Password reset flow
└── interfaces/                 # Interface definitions
    └── auth-api.spec.md              # Auth API contract
```

## Cross-Cutting Pattern Demonstrated

### One Strategy Guides Many Behaviors

`security-approach.spec.md` (strategy) guides:
- `user-login.spec.md` - How login implements security principles
- `session-management.spec.md` - How sessions maintain security
- `role-authorization.spec.md` - How RBAC enforces access control
- `password-reset.spec.md` - How reset flows protect accounts

### One Requirement Satisfied By Many Implementations

`authentication.spec.md` (requirement) is satisfied by:
- `user-login.spec.md` - Credential verification
- `session-management.spec.md` - Authentication persistence
- `password-reset.spec.md` - Account recovery
- `auth-api.spec.md` - Login and session endpoints

`authorization.spec.md` (requirement) is satisfied by:
- `role-authorization.spec.md` - Permission enforcement
- `auth-api.spec.md` - Protected endpoint definitions

## How the Links Work

Links are written upward: each spec names what it depends on (`satisfies`,
`guided-by`, `derives-from`), from the repository root. The downward direction
is generated: every spec's `supports:` lists the specs that link up to it,
written by `validate-crossrefs.sh --fix`, so it never drifts from the upward
links.

## Cascade Impact Analysis

**Scenario**: Security requirement changes (e.g., "add MFA support")

Open `specs/foundation/functional/authentication.spec.md`. Its `supports:`
lists everything that depends on it:

```yaml
supports:
  - specs/features/password-reset.spec.md
  - specs/features/session-management.spec.md
  - specs/features/user-login.spec.md
  - specs/interfaces/auth-api.spec.md
  - specs/strategy/security-approach.spec.md
```

Each needs review when authentication requirements change.

**Scenario**: Strategy changes (e.g., "switch from session to JWT")

`specs/strategy/security-approach.spec.md` lists the four behavior specs it
guides in its `supports:`. All four need review when the strategy changes.

## Validating

Copy the example into its own repository, then run the LiveSpec validators from
its root; `/livespec:init` vendors them into a project's `scripts/`:

```bash
bash scripts/validate-frontmatter.sh
bash scripts/validate-crossrefs.sh
```

## Key Patterns

### Behavior vs Contract Distinction

**Behaviors** (specs/features/):
- "System authenticates users via credentials" - Observable outcome
- "Session expires after inactivity" - Observable outcome
- "Unauthorized access returns 401" - Observable outcome

**Contracts** (specs/interfaces/):
- `POST /auth/login` with JSON schema - Interface definition
- `POST /auth/logout` request format - Interface definition
- `GET /auth/me` response structure - Interface definition

### Strategy as Cross-Cutting Glue

The strategy spec (`security-approach.spec.md`) contains decisions that apply across all auth behaviors:
- Token-based vs session-based authentication
- Password hashing approach
- Rate limiting strategy
- Security headers policy

Individual behavior specs reference the strategy but don't repeat it.

## Benefits Demonstrated

- **Clear separation**: Requirements (WHAT) vs Strategy (HOW) vs Behaviors (EXACTLY)
- **Traceability**: Know exactly what satisfies what
- **Cascade analysis**: Find all affected specs when security requirements change
- **Cross-cutting support**: Strategy layer naturally handles concerns spanning modules
- **Contract clarity**: API interface separate from behavioral specification
