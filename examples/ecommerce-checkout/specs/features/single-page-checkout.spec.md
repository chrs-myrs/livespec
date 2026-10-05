---
type: behavior
category: features
fidelity: behavioral
criticality: CRITICAL
failure_mode: Poor checkout implementation causes user abandonment and revenue loss
governed-by: []
satisfies:
  - specs/foundation/functional/guest-checkout.spec.md
  - specs/foundation/functional/simplified-checkout.spec.md
guided-by:
  - specs/strategy/ux-optimization.spec.md
---

# Single-Page Checkout Implementation

## Requirements
- [!] Single-page checkout form consolidates all information collection with real-time cost calculation and validation.
  - **Layout**: Single scrollable page with form sections and persistent sidebar
  - **Sections** (sequential, collapsible after completion):
    1. Account choice (guest/login/signup) - default guest pre-selected
    2. Shipping information (email, name, address, phone)
    3. Billing information (checkbox "same as shipping" default checked)
    4. Payment information (card details, cardholder name)
  - **Sidebar** (persistent, always visible):
    - Cart items summary (collapsible item list)
    - Subtotal
    - Shipping cost (updates when address entered)
    - Tax (updates when address entered)
    - Total (bold, prominent)
  - **Form behavior**:
    - Address autocomplete using Google Places API with 500ms debounce
    - Inline validation on field blur with green checkmark (valid) or red error (invalid)
    - Submit validation prevents submission if any field invalid
    - All fields use appropriate HTML5 input types (email, tel, text)
    - Mobile: Software keyboard matches input type
    - Autofocus on first invalid field after submit attempt
  - **Progress indicator**: Percentage bar at top (0-25-50-75-100%)
  - **Guest checkout**: No login/signup required, account creation offered post-purchase only
  - **Performance**: Page load <2s, address autocomplete response <500ms, form submission <3s
  - **Accessibility**: WCAG 2.1 Level AA compliance, keyboard navigable, screen reader tested
  - **Analytics tracking**:
    - Time on each section
    - Field completion rates
    - Error rates by field
    - Abandonment points
    - Completion time total

## Validation
- Page renders as single scrollable form with sidebar
- Four sections present in sequence: Account choice, Shipping, Billing, Payment
- Sidebar shows itemized costs (subtotal, shipping, tax, total) updating dynamically
- Address autocomplete suggests addresses after 3 characters typed
- Valid fields show green checkmark icon
- Invalid fields show red border + inline error message on blur
- Submit button disabled if any required field invalid
- Guest checkout path requires no account creation
- Post-purchase modal offers optional account creation (dismissible)
- Page load measured <2s (90th percentile)
- Address autocomplete response <500ms (90th percentile)
- Form submission to confirmation <3s (90th percentile)
- WCAG 2.1 Level AA compliance validated via automated + manual testing
- Tab navigation works correctly through all fields
- Screen reader announces form structure, errors, and progress
- Analytics events fire for section entry, field completion, errors, abandonment, completion

## Performance Targets
- Page load (fully interactive): <2s (90th percentile)
- Address autocomplete response: <500ms (90th percentile)
- Cost calculation (shipping + tax): <1s
- Form submission to confirmation: <3s (includes payment processing)
- Checkout completion time: ≤3 minutes (80th percentile)

## Mobile Optimizations
- Touch targets minimum 44×44px
- Inputs use appropriate `inputmode` (numeric for card/CVV)
- Viewport locked during form submission (prevent accidental navigation)
- Software keyboard appearance matches input type
- Form scrolls to field on focus (keyboard doesn't obscure)
- Large, thumb-friendly submit button

## Error Messages
- **Email invalid**: "Please enter a valid email address (e.g., you@example.com)"
- **Name too short**: "Please enter your full name"
- **Address invalid**: "Please enter a complete address"
- **Phone invalid**: "Please enter a 10-digit phone number (e.g., 555-123-4567)"
- **Card invalid**: "Please enter a valid card number"
- **Expiry invalid**: "Please enter a valid expiration date (MM/YY)"
- **CVV invalid**: "Please enter the 3 or 4-digit security code on your card"
- **Payment declined**: "Your payment could not be processed. Please check your card details or try a different payment method."

## Analytics Events
- **Checkout Started**: method (guest or account)
- **Section Completed**: which section (shipping, billing, payment)
- **Field Error**: field and error kind
- **Checkout Abandoned**: section reached and time spent
- **Checkout Completed**: method, total time and order total
