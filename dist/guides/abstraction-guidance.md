# Abstraction Guidance

## The Core Question

When you discover something during implementation, where does it belong?

Wrong placement creates:
- Specs polluted with implementation details (can't regenerate cleanly)
- Important requirements lost in code (lost on regeneration)
- Strategy mixed with behaviors (poor composability)

## Three Placement Tests

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

### → PURPOSE.md
- Mission pivots ("we're solving a different problem")
- Existential changes to why this exists
- **Rare**: Most discoveries don't change purpose

### → 1-requirements/ (constraints, outcomes)
Discoveries that reveal hard boundaries:
- "Must handle edge case X" (discovered through failure)
- "Must comply with regulation Y" (discovered during review)
- "External API has limitation Z" (discovered during integration)

**Signal**: Non-negotiable. Would block release if missing.

### → 2-strategy/ (architecture)
Discoveries about cross-cutting approach:
- "This architectural pattern works/fails for our context"
- "Technology X is essential/unsuitable"
- "These components must be separated/combined"

**Signal**: Affects multiple behaviors. Shapes the whole system.

### → workspace/ (specs/workspace/)
Discoveries about how to work:
- "This process/convention makes development smoother"
- "AI agents need this guidance"
- "Team should follow this pattern"

**Signal**: About the workspace, not in the workspace.

### → 3-contracts/
Discoveries about interfaces:
- "API must accept/return this shape"
- "External systems expect this protocol"

**Signal**: Defines boundaries. Changes break integrations.

### → 3-behaviors/
Discoveries about observable outcomes:
- "Users need to be able to do X"
- "System must respond with Y when Z"

**Signal**: User-facing or testable. Matters for correctness.

### → CODE (disposable)
Everything else:
- Performance tuning numbers
- Library/framework choices (unless strategic)
- Syntax patterns, idioms
- Caching mechanics (unless strategic)
- Error handling details

**Signal**: Another implementation would solve differently.

## The Tacit Knowledge Escape

When something feels hard to specify:

1. **Step back** - Make it qualitative, not quantitative
   - Instead of: "50ms debounce because browser quirk"
   - Write: "Input must feel responsive" (behavior)
   - Or: Nothing (it's implementation)

2. **Ask why** - Why does this matter?
   - If user experience → behavior
   - If technical → probably code

3. **Accept disposability** - Implementation solves implementation problems
   - Later regeneration will face similar problems
   - It will solve them (perhaps differently)
   - That's fine

## Common Anti-Patterns

| Anti-Pattern | Why Wrong | Fix |
|--------------|-----------|-----|
| "Button is 120px wide" | Implementation detail | "Button is prominent" or remove |
| "Use Redis for caching" in behavior | Technology choice | Move to strategy or remove |
| "API returns in <100ms" | Performance tuning | "API is responsive" or strategy |
| Edge case in requirements | Often implementation | Keep only if truly non-negotiable |
| "How" language in spec | Specs are WHAT/WHY | Reframe to outcome |

## Quick Decision Flow

```
Discovery during implementation
          ↓
Would we need this after regeneration?
          ↓
    YES → Spec                    NO → Disposable (code)
          ↓
Would different impl solve same way?
          ↓
    YES → Requirement/Behavior    NO → Implementation
          ↓
Is it WHAT/WHY or HOW?
          ↓
    WHAT/WHY → Spec layer        HOW → Disposable
          ↓
Affects multiple behaviors?
          ↓
    YES → Strategy               NO → Behavior
```

## During Your Workflow

### Phase 2 (BUILD)
When you discover something new:
- Ask "Does this belong in specs?"
- If yes: Level it up, then continue implementing
- If no: Implement it (disposable)

### Phase 4 (EVOLVE)
When reviewing code changes:
- List potential spec-worthy findings
- Suggest placement for each
- Get stakeholder approval
- Update specs before regenerating code

## Success Criteria

Abstraction guidance is working when:
- Specs contain no implementation details
- Regeneration produces working code
- Developers don't ask "where does this go?"
- Upper layers remain stable while code churns
