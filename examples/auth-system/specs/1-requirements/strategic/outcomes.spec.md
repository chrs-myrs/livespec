---
criticality: CRITICAL
failure_mode: Unauthorized access to system resources
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
