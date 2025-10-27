---
satisfies:
  - requirements/functional/loan-accuracy.spec.md
  - requirements/functional/regulatory-compliance.spec.md
guided-by:
  - strategy/calculation-approach.spec.md
criticality: CRITICAL
failure_mode: Incorrect schedule misleads borrowers about payment obligations
---

# Amortization Schedule Generation

## Requirements
- [!] System generates complete amortization schedule showing payment breakdown over loan term.
  - Monthly payment formula: `payment = [principal × rate × (1 + rate)^n] / [(1 + rate)^n - 1]`
    - principal: loan amount (Decimal)
    - rate: monthly interest rate (annual_rate / 12)
    - n: total number of payments (years × 12)
  - Schedule includes for each payment:
    - payment_number (1 to n)
    - payment_date (calculated from origination date)
    - payment_amount (fixed monthly payment)
    - principal_portion (principal paid this payment)
    - interest_portion (interest paid this payment)
    - remaining_balance (balance after payment)
  - All monetary values rounded to 2 decimal places using ROUND_HALF_EVEN
  - Final payment adjusted if rounding creates small balance (<$0.10)
  - Schedule generation logged with loan_id and generation timestamp

## Validation
- Test case 1: $100,000 loan, 5% annual rate, 30 years
  - Monthly payment: $536.82
  - First payment: $120.49 principal, $416.67 interest, $99,879.51 remaining
  - Last payment: $534.59 principal, $2.23 interest, $0.00 remaining
  - Total interest paid: $93,255.20
- Test case 2: $250,000 loan, 3.5% annual rate, 15 years
  - Monthly payment: $1,788.69
  - Verify amortization curve (more principal in later payments)
- Edge case: Final balance within $0.10 (last payment adjusted)
- Schedule total test: Sum of all payments equals principal + total interest
- Date calculation test: Payment dates correct for leap years
- Reproducibility test: Generate schedule twice, results identical
