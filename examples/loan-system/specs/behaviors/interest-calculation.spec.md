---
satisfies:
  - requirements/functional/loan-accuracy.spec.md
  - requirements/functional/regulatory-compliance.spec.md
  - requirements/functional/audit-trail.spec.md
guided-by:
  - strategy/calculation-approach.spec.md
criticality: CRITICAL
failure_mode: Incorrect interest charges violate regulations and breach contracts
---

# Interest Calculation Implementation

## Requirements
- [!] System calculates compound interest using standard financial formula with complete auditability.
  - Formula: `interest = principal × ((1 + rate/frequency)^(frequency × years) - 1)`
    - principal: loan amount (Decimal, non-negative, ≤ $10,000,000)
    - rate: annual interest rate as decimal (Decimal, 0 < rate < 1)
    - frequency: compounding periods per year (int, values: 1, 4, 12, 365)
    - years: loan term in years (Decimal, positive)
  - Result rounded to 2 decimal places using ROUND_HALF_EVEN (banker's rounding)
  - Calculation logged to database with:
    - timestamp
    - input parameters (principal, rate, frequency, years)
    - result value
    - user_id who requested calculation
    - calculation_id (UUID)

## Validation
- Test case 1: $10,000 principal, 5% annual rate, monthly compounding, 1 year → $511.62 interest
- Test case 2: $100,000 principal, 3.5% annual rate, quarterly compounding, 30 years → $184,503.59 interest
- Test case 3: $1,000 principal, 0.01% annual rate, daily compounding, 30 years → $9.05 interest
- Edge case: Maximum loan $10,000,000 at 8% annual rate, monthly compounding, 30 years → interest calculated without overflow
- Rounding test: Value 2.125 rounds to 2.12 (ROUND_HALF_EVEN)
- Audit test: Database log contains all parameters and result for each test case
- Reproducibility test: Re-run calculation from logged parameters produces identical result
