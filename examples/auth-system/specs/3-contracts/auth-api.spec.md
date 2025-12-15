---
criticality: CRITICAL
failure_mode: Client applications cannot integrate with authentication system
satisfies:
  - ../1-requirements/functional/authentication.spec.md
  - ../1-requirements/functional/authorization.spec.md
---

# Auth API Contract

## Requirements

### POST /auth/login

- [!] Authenticates user and returns tokens.
  - Request body: `{ "email": string, "password": string }`
  - Success response (200): `{ "access_token": string, "refresh_token": string, "expires_in": number }`
  - Error response (401): `{ "error": "invalid_credentials", "message": string }`
  - Error response (429): `{ "error": "rate_limited", "retry_after": number }`

### POST /auth/logout

- [!] Terminates user session.
  - Request header: `Authorization: Bearer <access_token>`
  - Success response (204): No content
  - Error response (401): `{ "error": "unauthorized", "message": string }`

### POST /auth/refresh

- [!] Exchanges refresh token for new access token.
  - Request body: `{ "refresh_token": string }`
  - Success response (200): `{ "access_token": string, "refresh_token": string, "expires_in": number }`
  - Error response (401): `{ "error": "invalid_token", "message": string }`

### GET /auth/me

- [!] Returns current authenticated user.
  - Request header: `Authorization: Bearer <access_token>`
  - Success response (200): `{ "id": string, "email": string, "roles": string[] }`
  - Error response (401): `{ "error": "unauthorized", "message": string }`

### POST /auth/password-reset/request

- [!] Initiates password reset flow.
  - Request body: `{ "email": string }`
  - Success response (202): `{ "message": "If account exists, reset email sent" }`
  - Note: Always returns 202 to prevent email enumeration

### POST /auth/password-reset/confirm

- [!] Completes password reset with token.
  - Request body: `{ "token": string, "new_password": string }`
  - Success response (200): `{ "message": "Password updated successfully" }`
  - Error response (400): `{ "error": "invalid_token", "message": string }`
  - Error response (400): `{ "error": "weak_password", "message": string }`
