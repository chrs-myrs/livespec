---
type: strategy
category: strategy
fidelity: decisions-only
criticality: CRITICAL
failure_mode: Without clear workflow strategy, users follow rigid waterfall (inflexible) or chaotic iteration (no structure), defeating voluntary adoption
governed-by:
  - specs/foundation/constraints.spec.md (Agent Agnostic, Manual Adoption)
derives-from:
  - specs/foundation/outcomes.spec.md (Voluntary Adoption, Maintenance Proportional to Durability, Specification-Driven Architecture)
  - specs/features/three-modes.spec.md (mode definitions)
---

# Mode Workflow Strategy

## Requirements
- [!] LiveSpec combines waterfall structure (linear first pass 0→1) with iterative flexibility (cycling back when discovering unknowns) through loose workflow providing guidance without enforcement, with Mode 2 as continuous evolution workflow where specs are source of truth and lower layers are derived.
  - Three specific modes: DEFINE (0), DESIGN (1), EVOLVE (2)
  - Natural linear progression for first pass (waterfall spine)
  - Cycling permitted when learning invalidates assumptions (iterative flexibility)
  - Entry/exit criteria are guidance not gates (loose workflow, no enforcement)
  - Mode 2 runs continuously (background process, not one-time stage)
  - Decision criteria documented for when to cycle vs proceed
  - AI agents understand structure without rigidity
  - Light methodology (minimal ceremony, voluntary adoption)

## Why Exactly Three Modes

**Not two** (too coarse):
- Jumps from problem to evolution without design
- Missing DESIGN (ad-hoc spec architecture)

**Not five+** (too fine):
- Each mode adds overhead and context-switch cost
- More modes = more ceremony = less voluntary adoption
- Implementation phases are out of scope for spec framework

**Three modes chosen** (sweet spot):
- **0: DEFINE** - WHAT (problem, constraints, process)
- **1: DESIGN** - HOW (architecture, behaviors, contracts)
- **2: EVOLVE** - Synchronization (continuous spec health)

**Rationale**:
- Mode 0: Separate problem understanding from solution design, establish workspace
- Mode 1: Think before detailing, separate WHAT (behaviors) from HOW (structure)
- Mode 2: Continuous evolution workflow (spec health, learning capture), unique to LiveSpec

## Hybrid Model: Waterfall Spine + Iterative Cycles

### Waterfall Spine (Linear First Pass)

**Natural progression 0 → 1:**

```
0: DEFINE
  ↓ (problem defined, constraints identified)
1: DESIGN
  ↓ (architecture specified, behaviors documented)
2: EVOLVE (continuous)
```

**Why linear first pass works:**
- Incremental understanding (can't design without problem definition)
- Logical dependencies (can't evolve without spec foundation)
- Cognitive flow (natural progression, reduced context switching)
- AI agent clarity ("You're in Mode 1" gives clear guidance)

**Not enforced waterfall:**
- No gates, no sign-offs, no formal completion criteria
- Trust developers to know when ready
- Structure without bureaucracy

### Iterative Cycles (Feedback Loops)

**Cycle back when discovering unknowns:**

```
0: DEFINE
  ↓
1: DESIGN      ←──┐
  ↓              │
2: EVOLVE    ────┘ (discovered spec flaw)
```

**Cycling triggers (examples)**:

**EVOLVE → DESIGN:**
- Spec health check reveals structural issues
- Behaviors don't match current needs
- Example: "Specs are too detailed/too abstract for current use"

**EVOLVE → DEFINE:**
- Constraint discovered during evolution
- Problem definition incomplete
- Example: "Original purpose has evolved"

**DESIGN → DEFINE:**
- Design reveals problem understanding was incomplete
- Constraints conflict with requirements
- Example: "Can't satisfy requirements given constraints"

**Intentional not chaotic:**
- Cycles based on learning (not premature uncertainty)
- Decision criteria guide when to cycle
- Flexibility without chaos

### Mode 2: Continuous Background Process

**Unlike modes 0-1** (sequential stages):
- Mode 2 runs continuously once specs established
- Runs parallel to other modes
- Detects spec health issues ongoing
- Triggers cycles to earlier modes

**Why continuous:**
- Specs change as understanding deepens
- Spec quality must be maintained (MSL compliance)
- Issues accumulate if not detected continuously
- Learning capture requires ongoing attention

**Connection to spec health workflow:**
- Mode 1 → Mode 2: Create specs, then maintain them
- Mode 2 → Mode 1: Learning reveals need for new specs
- Both directions enabled by Mode 2 continuity

## "Loose Workflow" Philosophy

**What "loose" means:**

| Strict (heavyweight) | Loose (LiveSpec) | Chaotic (no structure) |
|---------------------|------------------|----------------------|
| Gates require sign-off | Guidelines suggest readiness | No guidance |
| Cannot proceed without approval | Proceed when ready (self-assessed) | No modes |
| Formal deliverables required | Deliverables recommended | No deliverables |
| Process enforced by tooling | Process guided by prompts | No process |
| High ceremony | Minimal ceremony | No ceremony/structure |

**Why loose works:**
- Voluntary adoption (no enforcement = no resistance)
- Developer trust (assume competence)
- Context-dependent (every project different)
- Minimal overhead (guidance accessible, not burdensome)

**Risk accepted:**
- Developers might skip modes inappropriately
- Mitigated by: AI agent guidance, prompt quality, success patterns

**Benefit gained:**
- Methodology feels helpful not restrictive
- Adoption voluntary and sustained
- Adapts to project needs

## Decision Criteria for Cycling

### Cycle Back When:

**From EVOLVE to DESIGN:**
- Spec complexity exceeds design anticipation
- Spec structure not working
- Missing behaviors discovered during evolution
- Quality constraints conflict with design

**From EVOLVE to DEFINE:**
- Discovered constraint invalidates approach
- Original problem statement incomplete
- Stakeholder needs changed

**From DESIGN to DEFINE:**
- Design reveals fundamental misunderstanding
- Requirements incomplete
- Constraints discovered

### Keep Moving Forward When:

- Making progress toward exit criteria
- Issues tractable (can solve without rework)
- Learning enhances understanding (not invalidates it)
- Unknowns resolvable within current mode

**Example distinction:**
- "This spec is complex" → Stay in EVOLVE (maintenance detail)
- "This spec structure can't support requirement" → Cycle to DESIGN (fundamental issue)

### Mode 2 Special Case:

**Triggered by spec health issues** (not blockers):
- Spec quality degraded → Mode 2 maintenance
- New requirements emerged → Cycle to DEFINE (update constraints)
- Learning reveals gaps → Cycle to DESIGN (new specs needed)

## Connection to AI Agents

**How modes help agents:**

**Clarity of intent:**
- "Use .livespec/1-design/1a-design-architecture.md"
- Agent knows: Design mode, focus on architecture
- Constrains solution space

**Progressive context:**
- Mode 0: Problem space context
- Mode 1: Solution design context
- Mode 2: Spec maintenance context
- Agent builds understanding incrementally

**Decision support:**
- "Should I cycle back?" → Agent references decision criteria
- "What mode am I in?" → Agent checks project state
- "What's next?" → Agent suggests mode-appropriate actions

**Guidance without rigidity:**
- Modes give structure (not aimless)
- Loose workflow gives flexibility (agent adapts)
- Balance: Enough guidance to be useful, not constraining

## Light Methodology Approach

**"Light" means:**
- Minimal prompts per mode (2-5, not 20)
- Short prompts (guidance not exhaustive procedures)
- Quick cycles (minutes to hours, not weeks)
- Low ceremony (no templates requiring 10 fields)
- Voluntary (no enforcement or monitoring)

**Compared to heavyweight:**
- No project manager role
- No formal stage gates or reviews
- No extensive documentation templates
- No process compliance audits
- No certification or training

**Still structured** (not ad-hoc):
- Clear mode purposes
- Entry/exit guidance
- Decision criteria
- AI agent prompts

**Sweet spot:**
- Structure prevents chaos, gives AI agents direction
- Flexibility adapts to projects, supports voluntary adoption
- Minimalism maintains low overhead, sustainable long-term

## Validation
- Three modes specifically (DEFINE, DESIGN, EVOLVE)
- Natural linear first pass (0→1)
- Cycling permitted based on learning (decision criteria documented)
- Entry/exit criteria are guidance not gates (loose workflow)
- Mode 2 continuous not episodic (ongoing spec health)
- Hybrid model (waterfall spine + iterative cycles)
- AI agents understand structure without rigidity
- Light methodology maintained (minimal ceremony, voluntary adoption)
- Decision criteria help determine when to cycle vs proceed
