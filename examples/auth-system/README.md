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
├── 1-requirements/              # Layer 1: WHAT must be achieved
│   ├── strategic/
│   │   └── outcomes.spec.md     # High-level security goals
│   └── functional/
│       ├── authentication.spec.md    # Authentication requirements
│       └── authorization.spec.md     # Access control requirements
├── 2-strategy/                  # Layer 2: HOW to approach
│   └── security-approach.spec.md     # Cross-cutting security decisions
├── 3-behaviors/                 # Layer 3: EXACTLY what happens
│   ├── user-login.spec.md            # Login flow behavior
│   ├── session-management.spec.md    # Session lifecycle
│   ├── role-authorization.spec.md    # RBAC behavior
│   └── password-reset.spec.md        # Password reset flow
└── 3-contracts/                 # Interface definitions
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

`authorization.spec.md` (requirement) is satisfied by:
- `role-authorization.spec.md` - Permission enforcement
- `auth-api.spec.md` - Protected endpoint definitions

## Cascade Impact Analysis

**Scenario**: Security requirement changes (e.g., "add MFA support")

```bash
# Find all behaviors affected by authentication requirement change
grep -r "satisfies:.*authentication.spec.md" specs/3-behaviors/

# Results:
# specs/3-behaviors/user-login.spec.md
# specs/3-behaviors/session-management.spec.md
```

Both behavior specs need review when authentication requirements change.

**Scenario**: Strategy changes (e.g., "switch from session to JWT")

```bash
# Find all behaviors guided by security strategy
grep -r "guided-by:.*security-approach.spec.md" specs/3-behaviors/

# Results:
# specs/3-behaviors/user-login.spec.md
# specs/3-behaviors/session-management.spec.md
# specs/3-behaviors/role-authorization.spec.md
# specs/3-behaviors/password-reset.spec.md
```

All four behavior specs need review when security strategy changes.

## Key Patterns

### Behavior vs Contract Distinction

**Behaviors** (specs/3-behaviors/):
- "System authenticates users via credentials" - Observable outcome
- "Session expires after inactivity" - Observable outcome
- "Unauthorized access returns 401" - Observable outcome

**Contracts** (specs/3-contracts/):
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
