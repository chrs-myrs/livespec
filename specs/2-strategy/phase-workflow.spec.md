---
derives-from:
  - specs/1-requirements/strategic/outcomes.spec.md (Voluntary Adoption, Minimal Maintenance, Bidirectional Synchronization)
  - specs/1-requirements/functional/five-phases.spec.md (phase definitions)
governed-by:
  - specs/1-requirements/strategic/constraints.spec.md (Agent Agnostic, Manual Adoption)
  - .livespec/standard/metaspecs/strategy.spec.md
criticality: CRITICAL
failure_mode: Without clear workflow strategy, users follow rigid waterfall (inflexible) or chaotic iteration (no structure), defeating voluntary adoption
---

# Phase Workflow Strategy

## Requirements
- [!] LiveSpec combines waterfall structure (linear first pass 0→1→2→3) with iterative flexibility (cycling back when discovering unknowns) through loose workflow providing guidance without enforcement, with Phase 4 as continuous background process maintaining bidirectional synchronization.
  - Five specific phases: DEFINE (0), DESIGN (1), BUILD (TDD) (2), VERIFY (3), EVOLVE (4)
  - Natural linear progression for first pass (waterfall spine)
  - Cycling permitted when learning invalidates assumptions (iterative flexibility)
  - Entry/exit criteria are guidance not gates (loose workflow, no enforcement)
  - Phase 4 runs continuously (background process, not one-time stage)
  - Decision criteria documented for when to cycle vs proceed
  - AI agents understand structure without rigidity
  - Light methodology (minimal ceremony, voluntary adoption)

## Why Exactly Five Phases

**Not three** (too coarse):
- Jumps from problem to implementation without design
- Missing DESIGN (ad-hoc architecture) and EVOLVE (one-shot documentation)

**Not seven+** (too fine):
- Each phase adds overhead and context-switch cost
- More phases = more ceremony = less voluntary adoption

**Five phases chosen** (sweet spot):
- **0: DEFINE** - WHAT (problem, constraints, process)
- **1: DESIGN** - HOW (architecture, behaviors, contracts)
- **2: BUILD (TDD)** - Test-driven implementation (tests first, then code)
- **3: VERIFY** - Validation (acceptance, correctness)
- **4: EVOLVE** - Synchronization (continuous drift prevention)

**Rationale**:
- Phase 0: Separate problem understanding from solution design, establish workspace
- Phase 1: Think before building, separate WHAT (behaviors) from HOW (code)
- Phase 2: Core test-driven implementation guided by specs, tests before code ensures correctness
- Phase 3: Separate validation mindset from implementation, stakeholder involvement
- Phase 4: Continuous bidirectional sync (code ↔ specs), unique to LiveSpec

## Hybrid Model: Waterfall Spine + Iterative Cycles

### Waterfall Spine (Linear First Pass)

**Natural progression 0 → 1 → 2 → 3:**

```
0: DEFINE
  ↓ (problem defined, constraints identified)
1: DESIGN
  ↓ (architecture specified, behaviors documented)
2: BUILD (TDD)
  ↓ (tests written first, implementation complete, all tests passing)
3: VERIFY
  ↓ (validation complete, acceptance achieved)
4: EVOLVE (continuous)
```

**Why linear first pass works:**
- Incremental understanding (can't design without problem definition)
- Logical dependencies (can't build without architecture)
- Cognitive flow (natural progression, reduced context switching)
- AI agent clarity ("You're in Phase 1" gives clear guidance)

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
2: BUILD (TDD) ───┘ (discovered design flaw)
  ↓
3: VERIFY      ───→ 1: DESIGN (requirements incomplete)
```

**Cycling triggers (examples)**:

**BUILD → DESIGN:**
- Implementation reveals architectural flaw
- Performance requirements conflict with design
- Example: "Can't implement real-time sync with current architecture"

**BUILD → DEFINE:**
- Constraint discovered during implementation
- Problem definition incomplete
- Example: "Client needs offline mode, not in original requirements"

**VERIFY → DESIGN:**
- Validation shows missing behaviors
- Acceptance review reveals gaps
- Example: "Users need export feature we didn't specify"

**VERIFY → DEFINE:**
- Fundamental problem misunderstood
- Stakeholder expectations misaligned
- Example: "We built X but users needed Y"

**EVOLVE → any earlier phase:**
- Code evolved beyond specs → update specs (cycle to DESIGN)
- Specs evolved beyond code → update implementation (cycle to BUILD)
- New requirements emerged → cycle to DEFINE/DESIGN

**Intentional not chaotic:**
- Cycles based on learning (not premature uncertainty)
- Decision criteria guide when to cycle ("it doesn't work" vs "it might not work")
- Flexibility without chaos

### Phase 4: Continuous Background Process

**Unlike phases 0-3** (sequential stages):
- Phase 4 runs continuously once in production
- Runs parallel to other phases
- Detects drift ongoing
- Triggers cycles to earlier phases

**Why continuous:**
- Code changes frequently (features, bugs, refactoring)
- Specs must stay current (living documentation)
- Drift accumulates if not detected continuously
- Bidirectional sync requires ongoing attention

**Connection to bidirectional sync:**
- Specs → Code: Phase 1-2 workflow
- Code → Specs: Phase 4 extraction workflow
- Both directions enabled by Phase 4 continuity

## "Loose Workflow" Philosophy

**What "loose" means:**

| Strict (heavyweight) | Loose (LiveSpec) | Chaotic (no structure) |
|---------------------|------------------|----------------------|
| Gates require sign-off | Guidelines suggest readiness | No guidance |
| Cannot proceed without approval | Proceed when ready (self-assessed) | No phases |
| Formal deliverables required | Deliverables recommended | No deliverables |
| Process enforced by tooling | Process guided by prompts | No process |
| High ceremony | Minimal ceremony | No ceremony/structure |

**Why loose works:**
- Voluntary adoption (no enforcement = no resistance)
- Developer trust (assume competence)
- Context-dependent (every project different)
- Minimal overhead (guidance accessible, not burdensome)

**Risk accepted:**
- Developers might skip phases inappropriately
- Mitigated by: AI agent guidance, prompt quality, success patterns

**Benefit gained:**
- Methodology feels helpful not restrictive
- Adoption voluntary and sustained
- Adapts to project needs

## Decision Criteria for Cycling

### Cycle Back When:

**From BUILD to DESIGN:**
- Implementation complexity exceeds design anticipation
- Architectural pattern not working
- Missing behaviors discovered during coding
- Technology constraints conflict with design

**From BUILD to DEFINE:**
- Discovered constraint invalidates approach
- Original problem statement incomplete
- Stakeholder needs changed

**From VERIFY to DESIGN:**
- Acceptance testing reveals missing functionality
- Behaviors don't match user expectations
- Performance requirements not met

**From VERIFY to DEFINE:**
- Solution solves wrong problem
- Requirements fundamentally misunderstood
- Success criteria not achievable

### Keep Moving Forward When:

- Making progress toward exit criteria
- Issues tractable (can solve without rework)
- Learning enhances understanding (not invalidates it)
- Unknowns resolvable within current phase

**Example distinction:**
- "This function is complex" → Stay in BUILD (implementation detail)
- "This architecture can't support requirement" → Cycle to DESIGN (fundamental issue)

### Phase 4 Special Case:

**Triggered by drift detection** (not blockers):
- Code changed without spec update → Cycle to DESIGN (extract behaviors)
- Spec changed without code update → Cycle to BUILD (implement)
- New requirements emerged → Cycle to DEFINE (update constraints)
- Production issues → Cycle to VERIFY (re-validate)

## Connection to AI Agents

**How phases help agents:**

**Clarity of intent:**
- "Use .livespec/1-design/1a-design-architecture.md"
- Agent knows: Design phase, focus on architecture (not coding yet)
- Constrains solution space

**Progressive context:**
- Phase 0: Problem space context
- Phase 1: Solution design context
- Phase 2: Implementation context
- Phase 3: Validation context
- Agent builds understanding incrementally

**Decision support:**
- "Should I cycle back?" → Agent references decision criteria
- "What phase am I in?" → Agent checks project state
- "What's next?" → Agent suggests phase-appropriate actions

**Guidance without rigidity:**
- Phases give structure (not aimless)
- Loose workflow gives flexibility (agent adapts)
- Balance: Enough guidance to be useful, not constraining

## Light Methodology Approach

**"Light" means:**
- Minimal prompts per phase (2-5, not 20)
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
- Clear phase purposes
- Entry/exit guidance
- Decision criteria
- AI agent prompts

**Sweet spot:**
- Structure prevents chaos, gives AI agents direction
- Flexibility adapts to projects, supports voluntary adoption
- Minimalism maintains low overhead, sustainable long-term

## Validation
- Five phases specifically (DEFINE, DESIGN, BUILD (TDD), VERIFY, EVOLVE)
- Natural linear first pass (0→1→2→3)
- Cycling permitted based on learning (decision criteria documented)
- Entry/exit criteria are guidance not gates (loose workflow)
- Phase 4 continuous not episodic (ongoing drift detection)
- Hybrid model (waterfall spine + iterative cycles)
- Phase 2 emphasizes TDD (tests before code, mandatory with escape hatch)
- AI agents understand structure without rigidity
- Light methodology maintained (minimal ceremony, voluntary adoption)
- Decision criteria help determine when to cycle vs proceed
