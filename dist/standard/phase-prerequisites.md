# Phase Prerequisites Reference

**Purpose**: Central checklist for phase dependencies - reduces repetitive warnings in prompts

**When to use**: Referenced by prompts to verify prerequisites before executing

---

## Phase 0: DEFINE - Prerequisites

**Entry**: New project or existing codebase without LiveSpec

**No prerequisites** - Phase 0 is the starting point

**Exit criteria**:
- [ ] PURPOSE.md exists (why project exists, what success looks like)
- [ ] specs/workspace/ exists (constitution, patterns, workflows)
- [ ] specs/1-requirements/strategic/outcomes.spec.md exists (high-level requirements)
- [ ] specs/1-requirements/strategic/constraints.spec.md exists (hard boundaries)
- [ ] Complexity assessed OR skip decision documented
- [ ] Research evaluated OR skip decision documented

---

## Phase 1: DESIGN - Prerequisites

**⚠️ STOP: Verify Phase 0 prerequisites before proceeding. Phase jumping causes drift and missed requirements.**

**Check these files exist:**
- [ ] `PURPOSE.md` - Project purpose and vision
- [ ] `specs/1-requirements/strategic/outcomes.spec.md` - High-level requirements
- [ ] `specs/1-requirements/strategic/constraints.spec.md` - Boundaries and limits
- [ ] Research evaluation complete OR documented skip decision
- [ ] `specs/workspace/` - Development governance (constitution, patterns, workflows)

**If ANY file is missing → STOP implementation:**
- Missing PURPOSE.md → "Use `.livespec/0-define/0b-define-problem.md` to define problem first"
- Missing outcomes.spec.md → "Use `.livespec/0-define/0c-define-outcomes.md` to define outcomes first"
- Missing constraints.spec.md → "Use `.livespec/0-define/0f-identify-constraints.md` to define constraints first"
- No research evaluation → "Use `.livespec/0-define/0e-evaluate-research-needs.md` to evaluate research needs first"
- Missing workspace specs → "Use `.livespec/0-define/0a-setup-workspace.md` to initialize workspace first"

**Exit criteria**:
- [ ] specs/2-strategy/architecture.spec.md exists (system structure)
- [ ] specs/3-behaviors/ has behavior specs (observable outcomes)
- [ ] specs/3-contracts/ has contracts if needed (API/data interfaces)

---

## Phase 2: BUILD - Prerequisites

**⚠️ STOP: Verify Phase 1 prerequisites before implementation.**

**Check these files exist:**
- [ ] `specs/2-strategy/architecture.spec.md` - System architecture defined
- [ ] `specs/3-behaviors/[feature].spec.md` - Behaviors specified for features you're implementing
- [ ] `specs/3-contracts/[interface].spec.md` - Contracts defined for external interfaces (if applicable)
- [ ] All Phase 0 prerequisites (PURPOSE, outcomes, constraints, workspace)

**Spec-First Verification** (CRITICAL):
- [ ] Specification exists for deliverable being implemented
- [ ] Specification has Requirements section with [!] items
- [ ] Specification has Validation criteria
- [ ] Specification has Failure Mode defined

**If spec doesn't exist → STOP:**
- "I need a specification before implementing. Let's create specs/3-behaviors/[deliverable].spec.md first."
- Guide to Phase 1 (DESIGN):
  - For behaviors: "Use `.livespec/1-design/1b-define-behaviors.md`"
  - For contracts: "Use `.livespec/1-design/1c-create-contracts.md`"
  - For architecture/strategy: "Use `.livespec/1-design/1a-design-architecture.md`"

**Exit criteria**:
- [ ] Implementation matches specifications
- [ ] Tests created (if applicable)
- [ ] Implementation validated against spec criteria

---

## Phase 3: VERIFY - Prerequisites

**Check these exist:**
- [ ] Implementation complete (code/features built)
- [ ] Tests created (Phase 2: 2b-create-tests.md)
- [ ] Specifications exist for all implemented features
- [ ] All Phase 0-2 prerequisites met

**Exit criteria**:
- [ ] All tests pass
- [ ] Implementation satisfies spec validation criteria
- [ ] Stakeholder acceptance obtained (if applicable)

---

## Phase 4: EVOLVE - Prerequisites

**Ongoing phase** - runs continuously alongside development

**Check these exist:**
- [ ] System in production OR active development
- [ ] Specifications exist (from Phase 0-1 OR extracted via 4b)
- [ ] Code exists (implementation from Phase 2 OR legacy code)

**No strict entry gate** - Phase 4 prompts can be used:
- After completing Phase 3 (continuous maintenance)
- On existing codebase without specs (extract specs first)
- When drift detected (specs and code misaligned)
- Periodically (weekly, before releases, after major changes)

**Exit criteria**:
- None - Phase 4 is continuous loop back to other phases as needed

---

## Why Phase Prerequisites Matter

**Phase jumping causes:**
- Drift between specs and code (specs don't match implementation)
- Missed requirements (assumed instead of documented)
- Rework (implementing without design leads to architectural issues)
- Lost traceability (can't trace code back to requirements)

**Real example** (from LiveSpec development):
- Jumped to implementation without behavior spec
- Result: CHANGELOG implemented without requirements documented
- Impact: Violation of methodology, had to backtrack and create spec
- Lesson: Even "obvious" deliverables need specs first

**Prevention**:
- Use this checklist before starting each phase
- Reference in prompts: "⚠️ Prerequisites: `.livespec/standard/phase-prerequisites.md#phase-1`"
- Run validation: "Use `.livespec/prompts/utils/validate-project.md`"
- Check status: "Use `.livespec/prompts/utils/next-steps.md`"

---

## Quick Reference by Phase

| Phase | Key Prerequisite | What Happens If Skipped |
|-------|------------------|--------------------------|
| **0: DEFINE** | None (starting point) | N/A |
| **1: DESIGN** | PURPOSE + outcomes + constraints | Design without context → drift |
| **2: BUILD** | Architecture + behavior specs | Implementation without requirements → rework |
| **3: VERIFY** | Implementation + tests | Validation without tests → unverified quality |
| **4: EVOLVE** | Specs + code exist | Continuous maintenance |

---

## Using This Reference

**In prompts** (compressed warning):
```markdown
⚠️ **Prerequisites**: See `.livespec/standard/phase-prerequisites.md#phase-1`
```

**For AI agents** (verify before execution):
```markdown
Before proceeding, verify Phase 1 prerequisites at `.livespec/standard/phase-prerequisites.md#phase-1`
```

**For users** (understand dependencies):
```markdown
"This phase requires artifacts from Phase 0. Check prerequisites: `.livespec/standard/phase-prerequisites.md`"
```

This centralized reference reduces repetition while maintaining clear phase dependencies.
