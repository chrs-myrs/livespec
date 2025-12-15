---
criticality: CRITICAL
failure_mode: Users locked out permanently or accounts compromised via reset flow
satisfies:
  - ../1-requirements/functional/authentication.spec.md
guided-by:
  - ../2-strategy/security-approach.spec.md
---

# Password Reset

## Requirements

- [!] Users can request password reset via email.
  - Reset request accepted for any email (prevents enumeration)
  - Reset token sent only to registered email addresses
  - Token delivery via email within reasonable timeframe

- [!] Reset tokens are single-use and time-limited.
  - Token expires after configurable period (default: 1 hour)
  - Token invalidated immediately after successful reset
  - Only most recent token valid (previous tokens invalidated)

- [!] Password change requires valid reset token.
  - Token validated before allowing password change
  - New password must meet strength requirements
  - Password hash updated atomically with token invalidation

- [!] Reset events logged for security audit.
  - Reset requests logged with email and timestamp
  - Successful resets logged with user ID and timestamp
  - Failed reset attempts logged with reason
