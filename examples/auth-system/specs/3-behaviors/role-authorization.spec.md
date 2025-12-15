---
criticality: CRITICAL
failure_mode: Users perform unauthorized actions or blocked from authorized actions
satisfies:
  - ../1-requirements/functional/authorization.spec.md
guided-by:
  - ../2-strategy/security-approach.spec.md
---

# Role-Based Authorization

## Requirements

- [!] System checks user roles before allowing protected actions.
  - User roles extracted from authenticated token
  - Action-required roles defined per endpoint/operation
  - Access granted only if user has required role

- [!] Role hierarchy supports permission inheritance.
  - Admin role inherits all lower role permissions
  - Moderator role inherits user role permissions
  - Role definitions stored in authoritative source

- [!] Authorization failures return 403 Forbidden.
  - Authenticated but unauthorized requests get 403
  - Response body contains generic "access denied" message
  - No information about required role leaked

- [!] Authorization decisions logged for audit.
  - Denied requests logged with user ID, action, and missing role
  - Granted requests optionally logged for sensitive operations
  - Log entries include timestamp and request context
