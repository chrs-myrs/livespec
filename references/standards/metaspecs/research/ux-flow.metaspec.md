---
type: behavior
category: artifacts
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Without UX flow structure, flows become implementation documents rather than user journey maps that inform specifications
governed-by: []
derives-from:
  - references/standards/metaspecs/base.spec.md
---

# UX Flow Document Requirements

## Requirements

- [!] UX flow documents map user journeys through system states with decision points and error handling.
  - Document located in `research/flows/` folder
  - File name describes the flow: `<journey-name>-flow.md` (e.g., `checkout-flow.md`, `onboarding-flow.md`)
  - Document title: `# <Journey Name> Flow`

- [!] Frontmatter includes context and traceability.
  - `context:` Brief scenario description (when/why user enters this flow)
  - `created:` Date created (YYYY-MM-DD)
  - `related_journey:` Link to user journey research if applicable (or N/A)
  - No downward `informs:` list: each spec this flow informs links up to it with `informed-by:`

- [!] Flow Context section establishes scope and success criteria.
  - **Entry point**: How user enters this flow
  - **User goal**: What user is trying to accomplish
  - **Success criteria**: Observable outcome when flow succeeds
  - **Typical duration**: Expected time to complete (target and current if known)

- [!] Flow Diagram section visualizes the complete journey using Mermaid.
  - Uses `flowchart TD` (top-down) or `flowchart LR` (left-right)
  - Start/end points use `([text])` rounded syntax
  - Screens/states use `[text]` rectangle syntax
  - Decision points use `{text}` diamond syntax
  - Transitions use `-->|label|` for labeled arrows
  - All paths lead to either success end point or error recovery

- [!] Screens/States section documents each state in the flow.
  - Each screen/state has its own subsection: `### Screen N: <Name>` or `### State N: <Name>`
  - **Purpose**: What this screen/state accomplishes
  - **UI Elements** (if applicable): Key interface components
  - **User Actions** or **System Actions**: What happens here
  - **Validation Rules** (if applicable): Input validation requirements
  - **Error States**: What can go wrong and how it appears
  - **Next actions**: What transitions are available from this state

- [!] Decision Points section documents each branching point.
  - Each decision has subsection: `### Decision N: <Name>`
  - **Type**: User choice, system logic, or external dependency
  - **Criteria**: What determines the branch taken
  - **Options**: Each option with when it applies and where it leads
  - **Data required**: What information is needed to make the decision

- [!] Error Handling section documents recovery paths.
  - Each error scenario has subsection: `### Error Scenario N: <Name>`
  - **Trigger**: What causes this error
  - **User message**: What the user sees
  - **UI treatment**: How the error is displayed (inline, modal, page)
  - **Recovery path**: How user can recover
  - **Alternative**: Fallback options if primary recovery fails

- [!] Happy Path Summary provides quick reference for ideal flow.
  - Numbered steps through the successful path
  - Brief description of each step
  - **Expected duration** for happy path completion

- [!] Alternative Paths section documents non-error variations.
  - Each alternative has: **When**, **Difference from happy path**, **Outcome**
  - Covers common variations (returning user, different entry point, etc.)

- [!] Requirements Informed section traces to specifications.
  - Lists each spec this flow informs
  - For each spec: **What** (requirement), **How** (flow addresses it), **Validation** (how to test)

- [!] Testing Notes section documents validation approach.
  - **Validation approach**: How to test (prototype, A/B, user testing)
  - **Success metrics**: Measurable criteria with targets
  - **Test checklist**: Specific items to verify (checkbox format)
  - **Tested with**: Record of actual testing (initially "[To be tested]")

## Section Order

Required order for consistency:

```markdown
# <Flow Name> Flow

---
context: ...
created: ...
related_journey: ...
---

## Flow Context
## Flow Diagram
## Screens / States
## Decision Points
## Error Handling
## Happy Path Summary
## Alternative Paths
## Validation Against Journey (or Implementation)
## Requirements Informed
## Testing Notes
```

## Notes

**UX flows are research artifacts, not specifications:**
- They INFORM specs but are not specs themselves
- Located in `research/flows/`, not `specs/`
- Can be more verbose and exploratory than specs
- May include mockup references, user quotes, metrics

**When to create a UX flow:**
- New user-facing feature with multiple steps
- Existing flow being redesigned
- Complex decision points need documentation
- Multiple stakeholders need shared understanding

**When NOT needed:**
- Simple single-action features
- API-only changes (use contract specs)
- Internal system processes (use behavior specs)

**Flow vs Journey distinction:**
- **Journey**: High-level user goal across multiple sessions/touchpoints
- **Flow**: Specific path through system states in single session

**Mermaid syntax quick reference:**
```
([text])     - Rounded ends (start/end)
[text]       - Rectangle (screen/state)
{text}       - Diamond (decision)
-->          - Arrow
-->|label|   - Labeled arrow
```

## Validation

- Flow document follows required section order
- Frontmatter includes all required fields
- Flow diagram uses correct Mermaid syntax
- All screens/states from diagram are documented
- All decision points from diagram are documented
- All error paths have recovery documented
- Requirements Informed links to actual spec files
- Testing Notes includes measurable success metrics
