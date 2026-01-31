# Progressive Disposability

## Core Insight

Code is disposable. Knowledge is not.

LiveSpec inverts traditional development assumptions. Instead of treating code as the durable artifact and documentation as secondary, LiveSpec makes upper layers (purpose, requirements, strategy, behaviors) the durable assets while code becomes regenerable.

## The Disposability Gradient

Lower layers are more disposable than upper layers:

| Layer | Durability | What It Contains |
|-------|------------|-----------------|
| PURPOSE | Most durable | Why this exists, what success looks like |
| REQUIREMENTS | Very durable | Hard constraints, strategic outcomes |
| STRATEGY | Durable | Cross-cutting architectural decisions |
| CONTRACTS | Moderately durable | Interface definitions |
| BEHAVIORS | Moderately durable | Observable outcomes |
| WORKSPACE SPECS | Durable | How we work (generates context tree) |
| ACCEPTANCE TESTS | Semi-durable | Verify WHAT (survive regeneration) |
| CONTEXT TREE | Regenerable | AGENTS.md, ctxt/ (from workspace specs) |
| CODE + UNIT TESTS | Disposable | Verify HOW (regenerate with code) |

## What This Enables

### Technology Independence
Same specs, any stack. When you pivot technologies, you don't lose knowledge - you regenerate code from specs.

### Rapid Evolution
Change upper layers, regenerate lower. No accumulated cruft in code that prevents evolution.

### Knowledge Preservation
Specs survive implementations. Teams, technologies, and trends come and go, but captured requirements persist.

### AI-Native Development
Specs are the human-AI interface. Human owns intention (stakeholder role), AI manages specs, code, and alignment.

## Practical Implications

### Invest Maintenance Proportional to Durability
- Spend significant effort on PURPOSE.md (it rarely changes, but when it does, everything cascades)
- Maintain requirements and strategy carefully (changes propagate widely)
- Let code accumulate cruft until regeneration time (don't polish disposable artifacts)

### Regeneration Over Refactoring
- When code gets messy, don't refactor - regenerate
- Technical debt can't accumulate in disposable layers
- "Time to regenerate" is a positive signal, not failure

### Discovery Leveling
When you learn something during implementation:
1. Ask "Does this need to survive regeneration?"
2. If YES → Level it up to appropriate spec layer
3. If NO → Leave it in code (it's disposable)

### Two-Tier Testing
- **Acceptance tests** (verify WHAT): Derived from behavior specs. Semi-durable. Keep across regenerations.
- **Unit tests** (verify HOW): Test implementation internals. Disposable. Regenerate with code.

## When Regeneration Makes Sense

- Technology stack change
- Major architectural refactor
- Code has accumulated significant cruft
- Team composition changed significantly
- New AI/tooling available with better capabilities
- Performance characteristics need fundamental rethinking

## The Mindset Shift

**Old thinking**: "This code is precious. I spent weeks on it."
**New thinking**: "This code is an artifact of a moment. The specs are what matter."

**Old thinking**: "We need to maintain backwards compatibility."
**New thinking**: "We can regenerate with different interfaces."

**Old thinking**: "Documentation always falls behind code."
**New thinking**: "Code is generated from specs. They can't drift."

## Relationship to TDD

TDD bridges the regeneration fidelity gap:
- Write acceptance tests from specs FIRST
- These tests validate regenerated code works correctly
- Unit tests regenerate with code (they test HOW, which changes)

## Warning Signs

You're violating progressive disposability if:
- Specs contain implementation details (HOW, not WHAT)
- Important knowledge exists only in code comments
- Code changes require archaeology to understand why
- Regeneration would lose critical functionality
- You're afraid to delete code because "we might need it"

## Getting Started

1. Write PURPOSE.md as if it's the most important file in your project (it is)
2. Capture requirements as hard boundaries, not implementation notes
3. Define behaviors by outcomes, not mechanisms
4. Accept that your code is temporary
5. Celebrate regeneration opportunities
