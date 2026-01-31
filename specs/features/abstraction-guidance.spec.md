---
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement 1: Specification-Driven Regeneration)
  - specs/foundation/constraints.spec.md (Code Disposability)
  - specs/foundation/constraints.spec.md (Abstraction Purity)
guided-by:
  - specs/strategy/architecture.spec.md
criticality: CRITICAL
failure_mode: Wrong abstraction placement causes specs polluted with implementation details (can't regenerate cleanly) or important requirements lost in code (lost on regeneration)
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
---

# Abstraction Guidance

## Requirements
- [!] Implementation discoveries are placed at the correct abstraction layer using three placement tests, layer placement guide, and tacit knowledge escape strategies. Wrong placement causes regeneration failure or knowledge loss.
  - Three placement tests determine if discovery is spec-worthy
  - Layer placement guide determines which layer receives the discovery
  - Tacit knowledge escape strategies handle hard-to-specify discoveries
  - Specs contain WHAT/WHY only, never implementation HOW

## The Core Problem

When you discover something during implementation, where does it belong?

Wrong placement creates:
- Specs polluted with implementation details (can't regenerate cleanly)
- Important requirements lost in code (lost on regeneration)
- Strategy mixed with behaviors (poor composability)

## Three Placement Tests

When you learn something from implementation, apply these tests:

### Test 1: Regeneration Survival
> "If we regenerated with different technology/team/AI, would this need to be preserved?"

- **Yes** → It's a spec (determine which layer)
- **No** → It's code (disposable)

### Test 2: Implementation Independence
> "Would a different implementation solve this the same way?"

- **Likely same** → It's a requirement or behavior
- **Likely different** → It's implementation detail

### Test 3: The WHAT/WHY vs HOW Test
> "Does this describe WHAT/WHY or HOW?"

- **WHAT/WHY** → Spec
- **HOW (at code level)** → Disposable

## Layer Placement Guide

Once you know it's a spec, determine the layer:

### → PURPOSE
- Mission pivots ("we're solving a different problem")
- Existential changes to why this exists
- **Rare**: Most discoveries don't change purpose

### → REQUIREMENTS (foundation/)
Discoveries that reveal hard boundaries:
- "Must handle edge case X" (discovered through failure)
- "Must comply with regulation Y" (discovered during review)
- "External API has limitation Z" (discovered during integration)
- "Users absolutely need capability W" (discovered through feedback)

**Signal**: Non-negotiable. Would block release if missing.

### → STRATEGY (2-strategy/)
Discoveries about cross-cutting approach:
- "This architectural pattern works/fails for our context"
- "Technology X is essential/unsuitable"
- "These components must be separated/combined"

**Signal**: Affects multiple behaviors. Shapes the whole system.

### → WORKSPACE (specs/workspace/)
Discoveries about how to work:
- "This process/convention makes development smoother"
- "AI agents need this guidance"
- "Team should follow this pattern"

**Signal**: About the workspace, not in the workspace. Affects how you build, not what you build. Generates into AGENTS.md and context tree.

### → CONTRACTS (interfaces/)
Discoveries about interfaces:
- "API must accept/return this shape"
- "External systems expect this protocol"
- "Components communicate via this interface"

**Signal**: Defines boundaries between systems. Changes break integrations.

### → BEHAVIORS (features/)
Discoveries about observable outcomes:
- "Users need to be able to do X"
- "System must respond with Y when Z"
- "This validation is required"

**Signal**: User-facing or testable. Matters for correctness.

### → CODE (disposable)
Everything else:
- Performance tuning numbers
- Library/framework choices (unless strategic)
- Syntax patterns, idioms
- Caching mechanics (unless strategic)
- Error handling details
- Retry logic specifics

**Signal**: Another implementation would solve differently. HOW, not WHAT.

## The Tacit Knowledge Escape

When something feels hard to specify:

1. **Step back** - Make it qualitative, not quantitative
   - Instead of: "50ms debounce because browser quirk"
   - Write: "Input must feel responsive" (behavior)
   - Or: Nothing (it's implementation)

2. **Ask why** - Why does this matter?
   - If the answer is user experience → behavior
   - If the answer is technical → probably code

3. **Accept disposability** - Implementation solves implementation problems
   - Later regeneration will face similar problems
   - It will solve them (perhaps differently)
   - That's fine

## Anti-Patterns

| Anti-Pattern | Why It's Wrong | Fix |
|--------------|----------------|-----|
| "Button is 120px wide" in spec | Implementation detail | Remove, or "Button is prominent" |
| "Use Redis for caching" in behavior | Technology choice (strategy or code) | Move to strategy or remove |
| "API returns in <100ms" in behavior | Performance tuning | "API is responsive" or strategy |
| Edge case handling in requirements | Often implementation | Keep only if truly non-negotiable |
| "How" language in any spec | Specs are WHAT/WHY | Reframe to outcome |

## Integration Points

### During Implementation (Phase 2)
Agent asks: "You discovered X. Does this belong in specs?"
- If yes: "Which layer? Here's my suggestion..."
- If no: Continue (it's disposable)

### During Evolution (Phase 4)
Agent reviews code changes: "These changes suggest discoveries:"
- Lists potential spec-worthy findings
- Suggests placement
- Human (stakeholder) approves

### During Regeneration
Agent checks: "Before regenerating, confirm these specs capture what matters:"
- Shows specs that will drive regeneration
- Flags potential gaps
- Human approves regeneration

## Validation

- Specs contain no implementation details (no HOW at code level)
- Discoveries flow to correct layer automatically
- Upper layers remain stable while code churns
- Specs define system structure
- Developers (human or AI) don't ask "where does this go?"
