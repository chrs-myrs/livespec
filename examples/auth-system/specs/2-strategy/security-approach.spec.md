---
criticality: CRITICAL
failure_mode: Inconsistent security implementation across system
derives-from:
  - ../1-requirements/strategic/outcomes.spec.md
  - ../1-requirements/functional/authentication.spec.md
  - ../1-requirements/functional/authorization.spec.md
---

# Security Approach

Cross-cutting security strategy guiding all authentication and authorization behaviors.

## Requirements

- [!] Token-based authentication using short-lived access tokens.
  - Access tokens expire within configurable period (default: 1 hour)
  - Refresh tokens enable session continuation without re-authentication
  - Token payload contains user identity and role claims

- [!] Passwords hashed using adaptive algorithm.
  - Algorithm resistant to brute-force attacks
  - Salt unique per password
  - Work factor adjustable for hardware evolution

- [!] Rate limiting applied at authentication endpoints.
  - Per-IP rate limiting for login attempts
  - Per-account lockout after threshold exceeded
  - Exponential backoff for repeated failures

- [!] Security headers applied to all responses.
  - HTTPS enforced for all endpoints
  - CORS restricted to allowed origins
  - Content-Type headers prevent MIME confusion

- [!] Audit logging for security-relevant events.
  - Login success/failure logged with timestamp and IP
  - Permission denials logged with context
  - Logs exclude sensitive data (passwords, tokens)
