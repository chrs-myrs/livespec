---
type: outcomes
category: foundation
fidelity: behavioral
criticality: CRITICAL
failure_mode: Unauthorized access to system resources
governed-by: []
derives-from:
  - PURPOSE.md
supports:
  - specs/foundation/functional/authentication.spec.md
  - specs/foundation/functional/authorization.spec.md
  - specs/strategy/security-approach.spec.md
---

# Security Outcomes

## Requirements

- [!] Only authenticated users access protected resources.
  - Anonymous users cannot access protected endpoints
  - Authentication state verified on each request
  - Failed authentication clearly communicated

- [!] Users can only perform actions they are authorized for.
  - Role-based access control enforced
  - Permission violations logged
  - Least privilege principle applied

- [!] User credentials are protected from compromise.
  - Passwords never stored in plaintext
  - Secure transmission of credentials
  - Account lockout after failed attempts
