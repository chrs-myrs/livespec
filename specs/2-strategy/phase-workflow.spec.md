---
derives-from:
  - specs/1-requirements/strategic/outcomes.spec.md (Voluntary Adoption, Minimal Maintenance, Bidirectional Synchronization)
  - specs/1-requirements/functional/five-phases.spec.md (phase definitions)
governed-by:
  - specs/1-requirements/strategic/constraints.spec.md (Agent Agnostic, Manual Adoption)
  - .livespec/standard/metaspecs/strategy.spec.md
criticality: CRITICAL
failure_mode: Without clear workflow strategy, users either follow rigid waterfall (inflexible) or chaotic iteration (no structure), both defeating voluntary adoption
---

# Phase Workflow Strategy

## Requirements
- [!] LiveSpec combines waterfall structure (linear phase progression 0→1→2→3) with iterative flexibility (cycling back when discovering unknowns) through loose workflow that provides guidance without enforcement, enabling natural first-pass progression while supporting cycles triggered by learning, with Phase 4 as continuous background process maintaining bidirectional synchronization.
  - Five specific phases: DEFINE, DESIGN, BUILD, VERIFY, EVOLVE (not 3, not 7)
  - Natural progression: 0 → 1 → 2 → 3 → 4 (waterfall-like first pass)
  - Cycling permitted: Any phase can trigger return to earlier phase (iterative flexibility)
  - Entry/exit criteria are guidance not gates (loose workflow)
  - Phase 4 different: continuous background process, not one-time stage
  - Decision criteria for cycling documented (when to go back vs forward)
  - AI agents understand phases provide structure without rigidity
  - Users adopt voluntarily (not enforced by tooling)
  - "Light methodology" approach (minimal ceremony)

## Why Exactly Five Phases

**Not three phases (define, build, verify):**
- Too coarse: Jumps from problem to implementation without design
- Missing DESIGN phase means ad-hoc architecture
- Missing EVOLVE phase means one-shot documentation

**Not seven+ phases (define, analyze, design, build, test, deploy, maintain, ...):**
- Too fine-grained: Each phase overhead (entry/exit, context switch)
- Ceremony increases: More phases = more "am I doing this right?" anxiety
- Voluntary adoption decreases: Feels heavyweight

**Five phases chosen:**
- **0: DEFINE** - Establish WHAT (problem, constraints, process)
- **1: DESIGN** - Determine HOW (architecture, behaviors, contracts)
- **2: BUILD** - Create implementation (code, tests)
- **3: VERIFY** - Validate solution (acceptance, validation)
- **4: EVOLVE** - Maintain synchronization (continuous drift prevention)

**Rationale for each:**

**Phase 0: DEFINE** (not lumped into DESIGN)
- Separate problem understanding from solution design
- Constraints identified before architecting (avoids rework)
- Workspace established before creating product specs
- Entry point for both new and existing projects

**Phase 1: DESIGN** (not lumped into BUILD)
- Think before building (reduces thrashing)
- Architecture before implementation (coherent system)
- Specs before code (AI agent guidance)
- Separates WHAT (behaviors) from HOW (implementation)

**Phase 2: BUILD** (core implementation)
- Most familiar phase (developers know how to code)
- Guided by Phase 1 specs (not ad-hoc)
- Creates tests alongside code (validation preparation)

**Phase 3: VERIFY** (not lumped into BUILD)
- Separate validation from implementation (different mindset)
- Acceptance review involves stakeholders (not just dev)
- Gates production deployment (quality control)
- Validates specs AND implementation (both may be wrong)

**Phase 4: EVOLVE** (unique, continuous)
- Prevents documentation drift (core value proposition)
- Bidirectional sync (specs ↔ code)
- Continuous not one-time (unlike other phases)
- Distinguishes LiveSpec from static documentation

**Five phases hit sweet spot:** Enough structure to guide, not so much to burden.

## The Hybrid Model: Waterfall Spine + Iterative Cycles

**Claim we make:** "Phases are iterative, not waterfall"

**What we actually mean:** Hybrid model combining both

### Waterfall Spine (Linear Progression)

**First pass naturally progresses 0 → 1 → 2 → 3:**

```
0: DEFINE
  ↓ (problem defined, constraints identified)
1: DESIGN
  ↓ (architecture specified, behaviors documented)
2: BUILD
  ↓ (implementation complete, tests passing)
3: VERIFY
  ↓ (validation complete, acceptance achieved)
4: EVOLVE (continuous)
```

**Why linear first pass works:**
1. **Incremental understanding**: Can't design without problem definition
2. **Logical dependencies**: Can't build without architecture
3. **Cognitive flow**: Natural progression reduces context switching
4. **AI agent clarity**: "You're in Phase 1" gives clear guidance

**Not enforced waterfall:**
- No gates preventing forward movement
- No sign-offs required
- No formal phase completion criteria
- Trust developers to know when ready

**Benefit:** Structure without bureaucracy

### Iterative Cycles (Feedback Loops)

**Can cycle back when discovering unknowns:**

```
0: DEFINE
  ↓
1: DESIGN  ←──┐
  ↓          │
2: BUILD  ───┘ (discovered design flaw)
  ↓
3: VERIFY ───→ 1: DESIGN (requirements incomplete)
```

**Cycling triggers:**

**From Phase 2 (BUILD) → Phase 1 (DESIGN):**
- Implementation reveals architectural flaw
- Performance requirements conflict with design
- Technology constraints not considered
- Example: "Can't implement real-time sync with current architecture"

**From Phase 2 (BUILD) → Phase 0 (DEFINE):**
- Constraint discovered during implementation
- Problem definition incomplete
- Example: "Client needs offline mode, not in original requirements"

**From Phase 3 (VERIFY) → Phase 1 (DESIGN):**
- Validation shows missing behaviors
- Acceptance review reveals gaps
- Example: "Users need export feature we didn't specify"

**From Phase 3 (VERIFY) → Phase 0 (DEFINE):**
- Fundamental problem misunderstood
- Stakeholder expectations misaligned
- Example: "We built X but users needed Y"

**From Phase 4 (EVOLVE) → any earlier phase:**
- Code evolved beyond specs (update specs)
- Specs evolved beyond code (update implementation)
- New requirements emerged (cycle to DEFINE/DESIGN)

**Not chaos:**
- Cycles are intentional (based on learning)
- Decision criteria guide when to cycle
- Don't cycle prematurely ("it might not work" vs "it doesn't work")

**Benefit:** Flexibility without chaos

### Phase 4: Continuous Background Process

**Unlike other phases:** Phase 4 runs continuously, not episodically

**Other phases (0-3):** Sequential stages
- Enter phase
- Complete work
- Exit phase
- Move to next

**Phase 4 (EVOLVE):** Ongoing background
- Always active once in production
- Runs parallel to other phases
- Detects drift continuously
- Triggers cycles to earlier phases

**Example workflow:**
```
Initial development:
  Phase 0 → 1 → 2 → 3 (linear)

Production:
  Phase 4 running continuously
    ↓ (detects drift)
  Cycle to Phase 1 (update specs)
    ↓
  Cycle to Phase 2 (implement changes)
    ↓
  Cycle to Phase 3 (validate)
    ↓
  Return to Phase 4 (continuous monitoring)
```

**Why continuous?**
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

**NOT loose:**
- Phases can be skipped arbitrarily
- No structure whatsoever
- Do whatever feels right

**IS loose:**
- Entry/exit criteria are guidance not gates
- Trust developers to know when to cycle
- No enforcement mechanism (no CLI blocking progress)
- Phases provide direction without restriction

**Comparison:**

| Strict (heavyweight) | Loose (LiveSpec) | Chaotic (no structure) |
|---------------------|------------------|----------------------|
| Gates require sign-off | Guidelines suggest readiness | No guidance at all |
| Cannot proceed without approval | Proceed when ready (self-assessed) | No phases to follow |
| Formal deliverables required | Deliverables recommended | No deliverables defined |
| Process enforced by tooling | Process guided by prompts | No process |
| High ceremony | Minimal ceremony | No ceremony (also no structure) |

**Examples:**

**Strict methodology:**
```
Phase 1 exit gate:
  ☐ Architecture review board approval
  ☐ All stakeholders signed design doc
  ☐ Performance model validated
  → Cannot proceed to Phase 2 until complete
```

**LiveSpec (loose):**
```
Phase 1 exit criteria (guidance):
  - Architecture specified (behaviors documented)
  - Contracts defined (if needed)
  - Entry criteria for Phase 2 met (design complete enough to build)
  → Developer judges readiness, proceeds when confident
```

**Why loose works:**
- **Voluntary adoption**: No enforcement = no resistance
- **Developer trust**: Assume competence
- **Context-dependent**: Every project different
- **Minimal overhead**: Guidance accessible, not burdensome

**Risk accepted:**
- Developers might skip phases inappropriately
- Mitigated by: AI agent guidance, prompt quality, success patterns

**Benefit gained:**
- Methodology feels helpful not restrictive
- Adoption voluntary and sustained
- Adapts to project needs

## Decision Criteria for Cycling

**When to cycle back (not exhaustive, examples):**

### Cycle Back Signals

**From BUILD to DESIGN:**
- Implementation complexity exceeds design anticipation
- Architectural pattern not working (performance, maintainability)
- Missing behaviors discovered during coding
- Technology constraints conflict with design
- Example: "OAuth flow more complex than spec suggested, need to redesign"

**From BUILD to DEFINE:**
- Discovered constraint invalidates approach
- Original problem statement incomplete
- Stakeholder needs changed
- Example: "Client's firewall blocks WebSocket, need to reconsider architecture"

**From VERIFY to DESIGN:**
- Acceptance testing reveals missing functionality
- Behaviors don't match user expectations
- Performance requirements not met
- Example: "Users can't bulk-delete items, missing from behavior specs"

**From VERIFY to DEFINE:**
- Solution solves wrong problem
- Requirements fundamentally misunderstood
- Success criteria not achievable
- Example: "Built reporting system but users needed dashboards"

### Keep Moving Forward Signals

**Stay in current phase when:**
- Making progress toward exit criteria
- Issues are tractable (can solve without rework)
- Learning enhances understanding (not invalidates it)
- Unknowns can be resolved within phase

**Example:**
- "This function is complex" → Stay in BUILD (implementation detail)
- "This architecture can't support requirement" → Cycle to DESIGN (fundamental issue)

### Phase 4 Special Case

**Phase 4 cycles are different:**
- Triggered by drift detection (not blockers)
- Can cycle to any earlier phase (extract specs, update code, refine constraints)
- Cycles are maintenance not rework
- Continuous not one-time

**Phase 4 cycle triggers:**
- Code changed without spec update → Cycle to DESIGN (extract new behaviors)
- Spec changed without code update → Cycle to BUILD (implement changes)
- New requirements emerged → Cycle to DEFINE (update constraints)
- Production issues → Cycle to VERIFY (re-validate)

## Connection to AI Agents

**How phases help AI agents:**

**Clarity of intent:**
- "Use .livespec/1-design/1a-design-architecture.md"
- Agent knows: I'm in design phase, focus on architecture
- Constrains solution space (not coding yet, just specifying)

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
- Phases give structure (not wandering aimlessly)
- Loose workflow gives flexibility (agent adapts to context)
- Balance: Enough guidance to be useful, not so much to constrain

## Light Methodology Approach

**"Light" means:**
- Minimal prompts per phase (2-5, not 20)
- Short prompts (guidance not exhaustive procedures)
- Quick cycles (minutes to hours, not weeks)
- Low ceremony (no templates requiring 10 fields)
- Voluntary (no enforcement or monitoring)

**Compared to heavyweight methodologies:**
- No project manager role required
- No formal stage gates or reviews
- No extensive documentation templates
- No process compliance audits
- No certification or training needed

**Still structured (not ad-hoc):**
- Clear phase purposes
- Entry/exit guidance
- Decision criteria
- AI agent prompts

**Sweet spot:**
- Structure: Prevents chaos, gives AI agents direction
- Flexibility: Adapts to projects, supports voluntary adoption
- Minimalism: Low overhead, sustainable long-term

## Validation

- Five phases specifically (DEFINE, DESIGN, BUILD, VERIFY, EVOLVE)
- Natural linear progression for first pass (0→1→2→3)
- Cycling permitted based on learning (decision criteria documented)
- Entry/exit criteria are guidance not gates (loose workflow)
- Phase 4 continuous not episodic (ongoing drift detection)
- Hybrid model explained (waterfall spine + iterative cycles)
- AI agents understand phases provide structure without rigidity
- "Light methodology" philosophy maintained (minimal ceremony)
- Voluntary adoption enabled (no enforcement)
- Decision criteria help determine when to cycle vs proceed
