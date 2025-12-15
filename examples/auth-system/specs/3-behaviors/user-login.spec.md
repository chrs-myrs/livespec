---
criticality: CRITICAL
failure_mode: Users cannot log in or unauthorized users gain access
satisfies:
  - ../1-requirements/functional/authentication.spec.md
guided-by:
  - ../2-strategy/security-approach.spec.md
---

# User Login

## Requirements

- [!] System validates credentials and issues tokens on successful login.
  - Email existence verified in user store
  - Password verified against stored hash
  - Access token and refresh token returned on success
  - Token payload includes user ID and assigned roles

- [!] Invalid credentials rejected with appropriate error.
  - Non-existent email returns authentication error
  - Wrong password returns authentication error
  - Error message does not distinguish between wrong email vs wrong password

- [!] Login attempts rate-limited per account and IP.
  - Failed attempts increment counter
  - Counter threshold triggers temporary lockout
  - Successful login resets failure counter

- [!] Login events logged for security audit.
  - Successful logins logged with user ID, timestamp, IP
  - Failed attempts logged with attempted email, timestamp, IP
  - Logs never contain passwords or tokens
