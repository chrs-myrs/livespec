---
satisfies:
  - ../requirements/functional/guest-checkout.spec.md
  - ../requirements/functional/simplified-checkout.spec.md
guided-by:
  - ../strategy/ux-optimization.spec.md
criticality: CRITICAL
failure_mode: Poor checkout implementation causes user abandonment and revenue loss
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

## Implementation Details

### Section 1: Account Choice
```javascript
// Default state: guest checkout pre-selected
<div class="account-choice">
  <button class="btn-primary" selected>Continue as Guest</button>
  <a href="/login" class="link-secondary">Already have an account? Login</a>
  <a href="/signup" class="link-tertiary">Create an account</a>
</div>
```

### Section 2: Shipping Information
```javascript
<form class="checkout-form">
  <section id="shipping" class="form-section">
    <h2>Shipping Information</h2>

    <input
      type="email"
      name="email"
      required
      autocomplete="email"
      pattern="[^@]+@[^@]+\.[^@]+"
      aria-describedby="email-error"
    />
    <span id="email-error" class="error-message" role="alert"></span>

    <input
      type="text"
      name="fullName"
      required
      autocomplete="name"
      minlength="2"
      aria-describedby="name-error"
    />
    <span id="name-error" class="error-message" role="alert"></span>

    <input
      type="text"
      name="address"
      required
      autocomplete="shipping street-address"
      data-autocomplete="google-places"
      aria-describedby="address-error"
    />
    <span id="address-error" class="error-message" role="alert"></span>

    <input
      type="tel"
      name="phone"
      required
      autocomplete="tel"
      pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}"
      aria-describedby="phone-error"
    />
    <span id="phone-error" class="error-message" role="alert"></span>
  </section>
</form>
```

### Section 3: Billing Information
```javascript
<section id="billing" class="form-section">
  <h2>Billing Information</h2>

  <label>
    <input type="checkbox" name="billingIsShipping" checked
           onchange="toggleBillingFields()"
    />
    Same as shipping address
  </label>

  <div id="billingFields" style="display: none;">
    <!-- Same fields as shipping, different autocomplete tokens -->
  </div>
</section>
```

### Section 4: Payment Information
```javascript
<section id="payment" class="form-section">
  <h2>Payment Information</h2>

  <input
    type="text"
    name="cardNumber"
    required
    autocomplete="cc-number"
    pattern="[0-9]{15,16}"
    data-validate="luhn"
    inputmode="numeric"
    aria-describedby="card-error"
  />
  <span id="card-error" class="error-message" role="alert"></span>

  <div class="form-row">
    <input
      type="text"
      name="expiry"
      required
      autocomplete="cc-exp"
      placeholder="MM/YY"
      pattern="(0[1-9]|1[0-2])\/([0-9]{2})"
      inputmode="numeric"
    />
    <input
      type="text"
      name="cvv"
      required
      autocomplete="cc-csc"
      pattern="[0-9]{3,4}"
      inputmode="numeric"
    />
  </div>

  <input
    type="text"
    name="cardholderName"
    required
    autocomplete="cc-name"
  />
</section>
```

### Sidebar (Persistent)
```javascript
<aside class="order-summary" role="complementary">
  <h2>Order Summary</h2>

  <details>
    <summary>Items (3)</summary>
    <ul class="cart-items">
      <!-- Cart items -->
    </ul>
  </details>

  <dl class="cost-breakdown">
    <dt>Subtotal</dt>
    <dd id="subtotal">$299.97</dd>

    <dt>Shipping</dt>
    <dd id="shipping">Calculated at address entry</dd>

    <dt>Tax</dt>
    <dd id="tax">$0.00</dd>

    <dt class="total">Total</dt>
    <dd id="total" class="total">$299.97</dd>
  </dl>

  <button type="submit" class="btn-primary btn-large">
    Place Order · <span id="total-in-button">$299.97</span>
  </button>
</aside>
```

### Validation Logic
```javascript
// Inline validation on blur
field.addEventListener('blur', (e) => {
  const isValid = validateField(e.target);
  if (isValid) {
    showValidIndicator(e.target);
    hideError(e.target);
  } else {
    showInvalidIndicator(e.target);
    showError(e.target, getErrorMessage(e.target));
  }
  updateProgressIndicator();
});

// Submit validation
form.addEventListener('submit', (e) => {
  e.preventDefault();

  const invalidFields = validateAllFields();
  if (invalidFields.length > 0) {
    // Show all errors
    invalidFields.forEach(field => showError(field));
    // Focus first invalid
    invalidFields[0].focus();
    return;
  }

  // All valid - submit
  submitCheckout();
});

// Real-time cost updates
addressField.addEventListener('change', async (e) => {
  const address = e.target.value;
  if (isValidAddress(address)) {
    const shippingCost = await calculateShipping(address);
    const tax = await calculateTax(address, subtotal + shippingCost);
    updateSidebar({ shipping: shippingCost, tax: tax });
  }
});
```

### Address Autocomplete
```javascript
// Google Places API integration
let autocomplete;
function initAutocomplete() {
  autocomplete = new google.maps.places.Autocomplete(
    document.getElementById('address'),
    {
      types: ['address'],
      componentRestrictions: { country: 'us' }
    }
  );

  autocomplete.addListener('place_changed', () => {
    const place = autocomplete.getPlace();
    fillAddressFields(place);
    calculateShippingAndTax(place);
  });
}
```

### Progress Indicator
```javascript
function updateProgressIndicator() {
  const sections = ['account', 'shipping', 'billing', 'payment'];
  let completed = 0;

  sections.forEach(section => {
    if (isSectionComplete(section)) completed++;
  });

  const percentage = (completed / sections.length) * 100;
  document.getElementById('progress-bar').style.width = `${percentage}%`;
  document.getElementById('progress-text').textContent = `${percentage}% Complete`;
}
```

### Post-Purchase Account Creation
```javascript
// After successful order confirmation
function showAccountCreationOffer() {
  if (!isGuest()) return; // Only for guest checkouts

  const modal = `
    <div class="modal" role="dialog" aria-labelledby="account-offer-title">
      <h2 id="account-offer-title">Create an account?</h2>
      <p>Track your order and checkout faster next time.</p>
      <p>Email: ${guestEmail}</p>
      <input type="password" placeholder="Create a password" />
      <button class="btn-primary">Create Account</button>
      <button class="btn-secondary">No thanks</button>
    </div>
  `;

  // Non-blocking, dismissible
  showModal(modal, { dismissible: true });
}
```

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
```javascript
// Track checkout flow
analytics.track('Checkout Started', { method: 'guest' | 'account' });
analytics.track('Section Completed', { section: 'shipping' | 'billing' | 'payment' });
analytics.track('Field Error', { field: 'email', error: 'invalid_format' });
analytics.track('Checkout Abandoned', { section: 'payment', time_spent: 120 });
analytics.track('Checkout Completed', {
  method: 'guest',
  total_time: 180,
  total_amount: 299.97
});
```
