---
implements: specs/3-behaviors/prompts/utils-detect-phase-restart.spec.md
---

# Detect Phase Restart

**Purpose**: Determine if new work on existing project needs Phase 0 restart

## When to Use This

Working on existing project (has completed Phase 2/3/4) and considering:
- New feature or capability
- UX redesign or rethink
- Architectural change
- Accessibility improvements
- Major enhancement

**Question**: Do I continue current phase or restart at Phase 0?

## Decision Process

### Step 1: Classify the Change

**What type of change is this?**

**A. Bug Fix / Small Enhancement**
- Fixing broken behavior
- Minor improvement to existing feature
- Performance optimization
- Technical debt reduction

→ **CONTINUE current phase** (likely Phase 4: EVOLVE)

**B. New User-Facing Feature**
- Adds new capability users will interact with
- New workflow or user journey
- Additional use case or user type

→ **RESTART at Phase 0** (need outcomes, possibly research)

**C. UX Rethink / Redesign**
- Changing how existing feature works
- Reimagining user experience
- Accessibility improvements
- Mobile/responsive redesign

→ **RESTART at Phase 0** (mandatory research evaluation)

**D. Architectural / Technical Change**
- Changing system structure
- Adding new technology
- Infrastructure modification
- New technical constraints

→ **RESTART at Phase 0** (need constraints, possibly architecture)

### Step 2: Check for Mandatory Research Domains

**Does this change involve ANY of these?**
- [ ] Accessibility (users with disabilities, cognitive impairments)
- [ ] Child users (especially with special needs)
- [ ] Safety-critical systems (medical, financial, security)
- [ ] Novel UX patterns (no established conventions)
- [ ] High-complexity workflows (multi-step, multiple user types)

**If YES to ANY → MANDATORY Phase 0 restart with research**

### Step 3: Assess Specification Needs

**Can you implement this change using only existing specifications?**

- **YES** - Existing behavior/contract specs cover this change
  → **CONTINUE** (Phase 2: implement, Phase 4: update specs if drift)

- **NO** - Need new specifications or significant spec updates
  → **RESTART** at appropriate phase:
  - Need new outcomes → Phase 0 (0c-define-outcomes)
  - Need new constraints → Phase 0 (0f-identify-constraints)
  - Need new behaviors → Phase 1 (1b-define-behaviors)
  - Need research → Phase 0 (0e-evaluate-research-needs)

### Step 4: Make Decision

Based on Steps 1-3:

## RESTART at Phase 0

**Use when:**
- New user-facing features (need outcomes)
- UX redesigns (need research evaluation)
- Accessibility work (mandatory research)
- Major architectural changes (need constraints)
- Cannot specify with existing specs

**Start with:**
1. Create sub-project PURPOSE.md (or section in main PURPOSE.md)
2. Run `0c-define-outcomes.md` for this feature
3. Run `0e-evaluate-research-needs.md` (MANDATORY for accessibility/safety/children)
4. Run `0f-identify-constraints.md` for new boundaries
5. Then proceed to Phase 1 (DESIGN)

## CONTINUE Current Phase

**Use when:**
- Bug fixes (Phase 4: fix code, update specs if drift)
- Small enhancements (Phase 2: implement, Phase 3: validate)
- Technical debt (Phase 4: refactor, sync specs)
- Performance improvements (Phase 2/4: optimize, verify specs align)
- Existing specs adequate

**Continue with:**
- Phase 2 if implementing to existing specs
- Phase 3 if validating recent changes
- Phase 4 if fixing drift or evolving system

## Examples

### Example 1: Talevenforge Accessible Reading (RESTART)

**Change**: Redesign story list UI for 9-year-old with ADHD, Renpenning syndrome, cognitive impairment

**Classification**: UX Rethink (C) + Accessibility (mandatory research domain)

**Decision**: **RESTART at Phase 0**
- Mandatory research domain (child with disabilities)
- UX rethink requires understanding user needs
- Cannot proceed to Phase 1 without research

**Actions**:
1. Create `docs/accessible-reading-PURPOSE.md` (sub-project)
2. Run `0c-define-outcomes.md` (accessible reading outcomes)
3. Run `0e-evaluate-research-needs.md` (MANDATORY - accessibility + child)
4. Conduct research (personas, observations, evidence-based insights)
5. Run `0f-identify-constraints.md` (ADHD-specific, cognitive load limits)
6. THEN proceed to Phase 1 (design architecture and behaviors)

### Example 2: Hoardwick Performance Fix (CONTINUE)

**Change**: Scan took 6 hours, reduce to <1 hour

**Classification**: Performance Enhancement (A)

**Decision**: **CONTINUE Phase 4 (EVOLVE)**
- Performance optimization of existing feature
- Scanner behavior specs already exist
- Need to update specs if behavior changes (lazy hashing)

**Actions**:
1. Run `4a-detect-drift.md` to understand current state
2. Update `scanner.spec.md` if changing behavior
3. Implement optimizations (Phase 2)
4. Validate performance (Phase 3)

### Example 3: Add OAuth Provider (RESTART)

**Change**: Add GitHub OAuth alongside existing Auth0

**Classification**: New Feature (B) + Architectural Change (D)

**Decision**: **RESTART at Phase 0** (partial)

**Actions**:
1. Run `0f-identify-constraints.md` - New constraint: "Support multiple OAuth providers"
2. Run `1a-design-architecture.md` - Update architecture for multi-provider auth
3. Run `1b-define-behaviors.md` - New behavior: "Users authenticate via GitHub"
4. Then Phase 2 (implement)

### Example 4: Fix Broken Checkout Button (CONTINUE)

**Change**: Checkout button doesn't work on mobile Safari

**Classification**: Bug Fix (A)

**Decision**: **CONTINUE Phase 4**

**Actions**:
1. Fix bug (Phase 2: implement fix)
2. Run `4a-detect-drift.md` - Verify specs still accurate
3. Update specs only if bug revealed spec inaccuracy

## Output

After decision process, output:

**Decision**: [RESTART at Phase 0 / CONTINUE current phase]

**Rationale**:
- Change type: [A/B/C/D]
- Mandatory research?: [YES/NO]
- Can use existing specs?: [YES/NO]

**Next Steps**:
1. [Specific prompt or action]
2. [Next prompt or action]
3. [Continue sequence...]

**If RESTART → List Phase 0 prompts needed**
**If CONTINUE → Specify which phase and prompts**

## Success Criteria

- Decision appropriate for scope of change
- Accessibility/safety work correctly triggers Phase 0 restart
- Research evaluation happens before design for critical domains
- Bug fixes don't unnecessarily restart phases
- Clear next steps provided

---

**Criticality**: IMPORTANT
**Failure Mode**: Wrong phase selection causes drift (skip research) or wasted effort (unnecessary restart)
