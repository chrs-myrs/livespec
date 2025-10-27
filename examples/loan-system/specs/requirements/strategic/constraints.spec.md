---
derives-from: PURPOSE.md
criticality: CRITICAL
failure_mode: System violates non-negotiable boundaries
---

# Loan System Constraints

## Requirements
- [!] System must operate within critical boundaries:
  - Maximum loan amount: $10,000,000
  - Monetary precision: 2 decimal places minimum
  - Calculation audit: All parameters logged
  - Data retention: 7 years minimum
  - Regulatory compliance: Federal and state laws

## Validation
- Loan above $10M rejected
- All monetary values stored with ≥2 decimal precision
- Database logs contain complete calculation parameters
- Data retention policy enforced (7+ years)
- Legal review confirms regulatory compliance
