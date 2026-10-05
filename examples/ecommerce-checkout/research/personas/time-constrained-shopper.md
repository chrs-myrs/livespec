# Time-Constrained Shopper

---
created: 2025-01-15
source: User interviews Jan 2025
sample_size: 10
---

## Identity

- **Role**: Online shopper (employed professional)
- **Age**: 28-45
- **Tech proficiency**: Medium to High
- **Context**: Shopping during work breaks, commute, or between tasks

## Goals

### Primary Goal
Complete purchases quickly during limited time windows (lunch breaks, brief pauses between meetings)

### Secondary Goals
- Avoid creating yet another account
- Not re-enter information already provided
- Know total cost upfront (no surprises at final step)

### Success Criteria
Complete checkout in under 3 minutes without frustration or abandonment consideration

## Behaviors

### Current Workflow
1. Browse products during break time
2. Add items to cart
3. Start checkout → encounter login/account creation wall
4. Either: create account reluctantly OR abandon if time running out
5. Fill lengthy form with shipping/billing details
6. Discover shipping costs only at final step
7. Complete or abandon based on remaining time

### Tool Usage
- **Mobile phone**: Primary device (70% of shopping during breaks)
- **Desktop**: Secondary (evenings at home)
- **Frequency**: 2-3 purchases per month

### Frequency
- **Browse products**: Daily during breaks
- **Add to cart**: 2-3 times per week
- **Complete checkout**: Weekly (40% abandonment rate)

## Pain Points

### Pain Point 1: Account Creation Friction
- **Issue**: Forced to create account before checking out, adding 2-3 minutes
- **Workaround**: Use "forgot password" flow to avoid creating new account, or abandon purchase
- **Impact**: 30% abandon at account creation step, significant time loss, frustration
- **Quote**: "I just want to buy the thing, not join your club. If I have 5 minutes, I don't have time for this." (P3)

### Pain Point 2: Checkout Length
- **Issue**: Checkout takes 8+ minutes with multiple form pages
- **Workaround**: Save for later, often never return
- **Impact**: Miss time-sensitive deals, abandoned carts, frustration
- **Quote**: "By the time I get to payment, my meeting is starting. I have to abandon and hope I remember later." (P7)

### Pain Point 3: Hidden Shipping Costs
- **Issue**: Shipping cost revealed only at final step, after investing time in forms
- **Workaround**: Calculate mentally during browsing, often wrong
- **Impact**: Feeling deceived, price shock, abandonment at final step
- **Quote**: "I spent 10 minutes checking out, then see shipping is $15. I feel tricked. I close the tab." (P5)

## Needs (That Will Inform Requirements)

### Need 1: Guest checkout option
- **Priority**: HIGH
- **Informs**: `specs/foundation/functional/guest-checkout.spec.md`
- **Rationale**: Account creation adds 2-3 minutes and causes 30% abandonment; time-constrained users prioritize speed over account benefits
- **Evidence**: 8/10 participants requested guest checkout; 6/10 have abandoned due to forced account creation

### Need 2: Simplified, fast checkout flow
- **Priority**: HIGH
- **Informs**: `specs/foundation/functional/simplified-checkout.spec.md`
- **Rationale**: 8.5 minute average checkout exceeds time window (3-5 minutes); causes frustration and abandonment for 40% of this segment
- **Evidence**: All 10 participants mentioned time pressure; 7/10 showed visible frustration during checkout; 4/10 considered abandoning mid-process

### Need 3: Upfront shipping cost visibility
- **Priority**: MEDIUM
- **Informs**: `specs/foundation/functional/simplified-checkout.spec.md`
- **Rationale**: Late shipping cost revelation causes 20% abandonment at final step; users feel deceived after time investment
- **Evidence**: 5/10 participants specifically complained about hidden shipping costs; 8/10 wanted costs upfront

## Validation

- **Evidence sources**: Interview transcripts P1-P10 (Jan 10-20, 2025)
- **Validated by**: Product team, UX research lead
- **Last reviewed**: 2025-01-22
- **Next review**: 2025-07-22 (6 months)

---

**Created from**: `templates/research/persona.md.template` (LiveSpec plugin)
