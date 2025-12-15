---
criticality: CRITICAL
failure_mode: Sessions persist beyond intended lifetime or terminate unexpectedly
satisfies:
  - ../1-requirements/functional/authentication.spec.md
guided-by:
  - ../2-strategy/security-approach.spec.md
---

# Session Management

## Requirements

- [!] Access tokens expire after configured duration.
  - Default expiration: 1 hour from issuance
  - Expired tokens rejected with 401 Unauthorized
  - Token expiration checked on each authenticated request

- [!] Refresh tokens enable session continuation.
  - Refresh token valid for longer period (default: 7 days)
  - Valid refresh token exchanges for new access token
  - Refresh token rotation: old token invalidated on use

- [!] Logout invalidates all user tokens.
  - Access token blacklisted until natural expiration
  - Refresh token immediately invalidated
  - Subsequent requests with invalidated tokens rejected

- [!] Concurrent sessions supported with configurable limits.
  - Multiple devices can authenticate simultaneously
  - Optional: maximum concurrent session limit
  - Oldest session revoked when limit exceeded
