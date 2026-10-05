# E-Commerce Checkout Example

A small LiveSpec project showing research-to-implementation traceability:
**Research → Outcomes → Strategy → Behavior**, with every link checked by the
validators.

```
research/insights/checkout-friction-study.md
  (Finding 1: 30% abandonment at account creation)
    ↑ informed-by
specs/foundation/functional/guest-checkout.spec.md
    ↑ satisfies
specs/features/single-page-checkout.spec.md
```

## Structure

```
ecommerce-checkout/
├── PURPOSE.md                          # Why this example exists
├── research/                           # Evidence, not specs
│   ├── personas/time-constrained-shopper.md
│   ├── insights/checkout-friction-study.md
│   └── flows/simplified-checkout-flow.md
└── specs/
    ├── workspace/taxonomy.spec.md      # Project classification
    ├── foundation/
    │   ├── outcomes.spec.md            # Checkout outcomes, from PURPOSE.md
    │   └── functional/
    │       ├── guest-checkout.spec.md
    │       └── simplified-checkout.spec.md
    ├── strategy/ux-optimization.spec.md
    └── features/single-page-checkout.spec.md
```

## How the Links Work

Every link is written upward, from the more specific spec to the more durable
one it depends on:

| Spec | Links up with | To |
|------|---------------|----|
| `foundation/outcomes.spec.md` | `derives-from` | `PURPOSE.md` |
| `foundation/functional/*.spec.md` | `derives-from`, `informed-by` | outcomes, and the research behind them |
| `strategy/ux-optimization.spec.md` | `derives-from` | both functional requirements |
| `features/single-page-checkout.spec.md` | `satisfies`, `guided-by` | both requirements, and the strategy |

```yaml
# specs/foundation/functional/guest-checkout.spec.md
derives-from:
  - specs/foundation/outcomes.spec.md
informed-by:
  - research/insights/checkout-friction-study.md
  - research/personas/time-constrained-shopper.md
```

The downward direction is never written by hand. Each spec's `supports:` list is
generated from the upward links by `validate-crossrefs.sh --fix`, so it cannot
drift from them. Research artifacts are not specs and carry no links: to find
what a study informs, search for it.

```bash
grep -rl "research/insights/checkout-friction-study.md" specs/
```

## Evidence-Based Requirements

The functional requirements cite their research directly: quotes, observed
behaviour, measurements ("8.5 minutes average checkout time"), sample sizes
(n=10) and frequencies ("7/10 participants"). One study informs both
requirements, one requirement draws on several sources, and one behavior
satisfies both requirements.

## Reading Order

1. **Research**: `research/personas/time-constrained-shopper.md`, then
   `research/insights/checkout-friction-study.md`, then
   `research/flows/simplified-checkout-flow.md`
2. **Outcomes**: `specs/foundation/outcomes.spec.md`, then the two functional
   requirements. Note the `informed-by:` links back to research
3. **Strategy**: `specs/strategy/ux-optimization.spec.md`, the decisions and
   their rationale
4. **Behavior**: `specs/features/single-page-checkout.spec.md`, what the
   checkout does, observably. It specifies behaviour, not code: implementation
   lives outside `specs/`

## Validating

Copy the example into its own repository, then run the validators from its root:

```bash
bash scripts/validate-frontmatter.sh
bash scripts/validate-crossrefs.sh
```

The validators come from the LiveSpec plugin; `/livespec:init` vendors them into
a project's `scripts/`.

## Key Learning Points

- **Research is not a spec.** Research artifacts use flexible templates from the
  plugin's `templates/research/`, focused on evidence: separate observation from
  interpretation from implications
- **Links point up.** A spec names what it depends on. The reverse is generated
  or searched for, never maintained by hand
- **Specs describe behaviour.** The behavior spec states what a shopper observes
  and how to validate it; the strategy spec records decisions and rationale

## See Also

- [Frontmatter relationships guide](../../references/guides/frontmatter-relationships.md)
- [Three-layer architecture](../../specs/strategy/three-layer-architecture.spec.md)
- [UX flow metaspec](../../references/standards/metaspecs/research/ux-flow.metaspec.md)
