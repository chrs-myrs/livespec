---
satisfies:
  - requirements/functional/regulatory-compliance.spec.md
  - requirements/functional/audit-trail.spec.md
guided-by:
  - strategy/calculation-approach.spec.md
criticality: IMPORTANT
failure_mode: Incorrect fees violate state regulations and harm customer trust
---

# Late Fee Calculation Implementation

## Requirements
- [!] System calculates late fees per state-specific regulations with complete audit trail.
  - Formula: `late_fee = min(payment_amount × 0.05, state_maximum)`
    - payment_amount: scheduled payment amount (Decimal, positive)
    - state_maximum: maximum late fee for borrower's state (Decimal, from configuration)
    - Default state_maximum: $15 (conservative safe default)
  - Fee only applied after 15-day grace period from due date
  - Grace period calculation: `days_late = current_date - (due_date + 15 days)`
  - Result rounded to 2 decimal places using ROUND_HALF_EVEN
  - Calculation logged to database with:
    - timestamp
    - payment_amount
    - state_code
    - state_maximum applied
    - days_late
    - grace_period_end_date
    - calculated_fee
    - regulation_reference (e.g., "TX Finance Code §342.201")
    - calculation_id (UUID)

## Validation
- Test case 1: $100 payment, TX state (max $15), 16 days late → $5.00 fee
- Test case 2: $500 payment, TX state (max $15), 20 days late → $15.00 fee (capped)
- Test case 3: $200 payment, CA state (max $25), 30 days late → $10.00 fee
- Test case 4: $1000 payment, CA state (max $25), 45 days late → $25.00 fee (capped)
- Grace period test 1: Payment 14 days late → no fee
- Grace period test 2: Payment exactly 15 days late → no fee (boundary)
- Grace period test 3: Payment 16 days late → fee applied
- Missing state config: Uses default $15 maximum
- Audit test: Database log contains state_code, regulation_reference, and all parameters
- State configuration test: 50 states configured with correct maximum fees
