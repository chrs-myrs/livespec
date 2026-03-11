---
specifies: dist/prompts/1-design/1a-document-ux-flows.md
governed-by:
  - specs/workspace/constitution.spec.md
  - .livespec/standard/metaspecs/prompt.spec.md
  - .livespec/standard/metaspecs/research/ux-flow.metaspec.md
criticality: IMPORTANT
failure_mode: Without UX flow documentation, agents jump from requirements to tool contracts, missing complete user journey understanding and interaction patterns
---

# Document UX Flows

## Requirements
- [!] Prompt guides AI agents to create UX flow diagrams that document complete user journeys BEFORE designing system architecture or contracts.
  - UX flows created in Phase 1a (before architecture design in 1b)
  - Flows stored in `research/flows/[flow-name].md`
  - Each flow includes Mermaid diagram showing all paths (happy + error + alternative)
  - Flows document screens/states, decision points, error handling
  - Flows validate against user journeys (if exist) or requirements
  - Flows link to requirements they inform (bidirectional traceability)
  - Agent prompted to consider all interaction paths (not just happy path)
  - Follows `.livespec/standard/metaspecs/research/ux-flow.metaspec.md` structure
  - Optional for simple projects (use when UX complexity justifies documentation)

## When to Create UX Flows
- [!] Agent determines when UX flows add value vs overhead using complexity assessment.
  - **CREATE UX FLOWS when**:
    - User-facing features with multiple interaction paths
    - Complex state transitions (authentication, checkout, multi-step processes)
    - Error recovery patterns need documentation
    - Multiple user roles with different paths
    - Integration with external systems (OAuth, payment gateways)
    - User journeys identified pain points requiring validation
  - **SKIP UX FLOWS when**:
    - Purely backend/API work (no user interaction)
    - Single-path operations (CRUD with no branching)
    - Internal tools with trivial UX
    - Prototypes/spikes (document later if becomes permanent)
  - Decision framework: "Would documenting interaction paths prevent implementation mistakes or missing requirements?"

## Flow Coverage
- [!] Each major user flow documented separately (one flow per file).
  - Bug investigation flow (from URL to posting findings)
  - User interview flow (multi-turn conversation patterns)
  - Checkout flow (cart to payment to confirmation)
  - Authentication flow (login, registration, password reset)
  - One flow per complete user journey (not one flow for entire system)
  - Flows can reference each other (checkout flow references authentication flow)

## Mermaid Diagram Requirements
- [!] Flow diagram shows complete paths using Mermaid flowchart syntax.
  - Entry point → all decision points → all end states
  - Happy path clearly marked
  - Error paths show recovery mechanisms
  - Alternative paths documented
  - Decision criteria labeled on arrows
  - Standard shapes: ([entry/exit]), [process], {decision}
  - No dead ends (all paths lead to terminal state)

## Screen/State Documentation
- [!] Each screen or state documented with purpose, elements, validation, and errors.
  - Purpose: What this screen does
  - Key UI elements: Inputs, buttons, displays
  - Validation rules: Client-side and server-side
  - Error states: What can go wrong and how to recover
  - Documented in separate section below flow diagram

## Requirements Traceability
- [!] Flows explicitly link to requirements they validate or inform.
  - Frontmatter includes `informed-by:` (requirements that led to this flow)
  - Section "Requirements Informed" lists requirements this flow validates
  - Bidirectional: Requirements reference flows, flows reference requirements
  - Documents how flow addresses pain points or validates approach

## Agent Behavior
- [!] Agent creates flows before jumping to architecture or contracts.
  - Prompts user about key user journeys BEFORE designing system
  - Asks about decision points, error scenarios, alternative paths
  - Creates Mermaid diagram first (visual thinking)
  - Expands with screen documentation
  - Links to requirements
  - Optional: Can skip for simple projects (agent assesses complexity)

## Validation
- Flow document created in `research/flows/[name].md`
- Mermaid flowchart includes all paths (happy, error, alternative)
- Each screen/state documented with purpose and error handling
- Decision points have clear criteria
- Requirements traceability established (informed-by frontmatter)
- Flow follows ux-flow.metaspec.md structure
- No dead ends in flow diagram
- Agent considered whether UX flow documentation was needed (complexity assessment)
