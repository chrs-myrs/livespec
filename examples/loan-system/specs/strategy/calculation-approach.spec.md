---
derives-from:
  - requirements/functional/loan-accuracy.spec.md
  - requirements/functional/regulatory-compliance.spec.md
  - requirements/functional/audit-trail.spec.md
governed-by: requirements/strategic/constraints.spec.md
criticality: CRITICAL
failure_mode: Inconsistent calculation approach creates bugs and audit failures
---

# Financial Calculation Strategy

## Requirements
- [!] System uses standardized approach for all financial calculations ensuring accuracy, auditability, and compliance.
  - Standard financial formulas only (no proprietary algorithms)
  - Backend calculation for security and auditability
  - Decimal type (not floating point) for all monetary values
  - Calculation parameters stored in database for audit trail
  - Calculation library: Python `decimal` module with ROUND_HALF_EVEN
  - All calculations must be reproducible from logged parameters
  - Calculation validation: Results checked against known test cases

## Validation
- All financial calculations use `decimal.Decimal` type (grep confirms no `float` for money)
- No client-side financial calculations exist (grep frontend code)
- Database schema includes calculation_log table with parameters
- Test suite includes known-value validation tests
- Calculation reproducibility test: Re-run from logs produces identical results
- Code review confirms standard formulas used
