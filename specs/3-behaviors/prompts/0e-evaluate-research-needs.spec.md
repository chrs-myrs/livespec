---
specifies: prompts/0-define/0e-evaluate-research-needs.md
criticality: IMPORTANT
failure_mode: Requirements based on assumptions rather than evidence, leading to misaligned features and wasted development effort
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/functional/five-phases.spec.md
guided-by:
  - specs/2-strategy/phase-workflow.spec.md
---

# Prompt Behavior: Evaluate Research Needs

## Requirements
- [!] Prompt enforces mandatory research for critical domains, preventing assumption-based requirements in high-risk contexts.
  - Identifies MANDATORY research domains: accessibility projects, safety-critical systems, child users, users with disabilities, novel UX patterns
  - For mandatory domains: Research is NOT optional, prompt REQUIRES research completion
  - For mandatory domains: Documents why research cannot be skipped (user safety, legal compliance, UX risk)
  - Blocks progression to Phase 1 if mandatory research not completed
  - Explicit callout: "⚠️ MANDATORY RESEARCH - Cannot skip for accessibility/safety domains"

- [!] Prompt analyzes project characteristics and intelligently suggests relevant research activities to inform requirements.
  - Produces research suggestions with rationale, effort estimates, and priority levels (HIGH/MEDIUM/LOW)
  - Classifies project type (user-facing app, developer platform, internal tool, infrastructure, governance)
  - Checks existing research/ folder for completed activities
  - Identifies research gaps based on project type and complexity
  - Provides clear "why this matters" rationale for each suggestion
  - Guides execution using appropriate templates and metaspecs
  - Validates research completeness before proceeding to Phase 1
  - Supports iterative re-runs as understanding evolves

## Context

Use when:
- After outcomes defined (0c complete)
- After complexity assessed (0d complete)
- Before designing architecture (Phase 1)
- Requirements need evidence base
- User-facing features require understanding
- Uncertain about user needs or workflows

Optional - skip when:
- Backend API with clear contract
- Infrastructure/tooling with no users
- Requirements fully documented from existing research
- Simple CRUD with standard patterns

## Prerequisites

- PURPOSE.md exists (project vision)
- specs/1-requirements/strategic/outcomes.spec.md exists (high-level requirements)
- specs/1-requirements/strategic/complexity-assessment.md exists (project complexity understood)
- Agent has access to:
  - .livespec/standard/metaspecs/research/*.metaspec.md (quality guidance)
  - .livespec/templates/research/*.md.template (structured formats)

## Outputs

- **Research suggestions report** (console output): Prioritized list of suggested research activities with:
  - Activity type (persona, journey, flow, insights)
  - Rationale (why this would help)
  - Effort estimate (hours/days)
  - Priority level (HIGH/MEDIUM/LOW)
  - Template reference
  - Metaspec reference

- **research/*.md** files (if user chooses to execute):
  - Created using appropriate template
  - Follows quality criteria from metaspec
  - Links to requirements via `informs:` frontmatter

- **Updated specs/1-requirements/strategic/outcomes.spec.md** (if research reveals new insights):
  - Added `informed-by:` frontmatter linking to research
  - Refined requirements based on evidence

## Validation

- Project characteristics correctly classified
- Research suggestions align with project type
- Each suggestion has clear rationale
- Effort estimates are realistic (not overly optimistic)
- Priority levels justified by impact
- Existing research/ folder checked before suggesting
- Templates and metaspecs correctly referenced
- Can skip entirely for non-user-facing projects
- Can iterate multiple times as understanding evolves
- Research artifacts link to requirements they inform

## Success Criteria

- Requirements grounded in evidence (not assumptions)
- Research activities targeted to genuine unknowns
- User guides execution using provided templates
- Quality maintained through metaspec guidance
- Time invested proportional to project risk
- Research seamlessly informs Phase 1 (design)
- No unnecessary research for simple projects

## Error Handling

**If project has no user-facing aspects:**
- Acknowledge research likely not needed
- Offer technical spike option if uncertainty exists
- Proceed directly to Phase 1

**If research already exists in research/ folder:**
- Acknowledge existing research
- Validate completeness against project needs
- Suggest additional research only if gaps identified
- Update requirements with `informed-by:` links

**If user uncertain which research to do:**
- Provide decision framework
- Prioritize HIGH items first
- Explain impact vs effort trade-offs
- Support incremental approach (start small)

**If research reveals major requirement changes:**
- Flag significant shifts
- Recommend updating PURPOSE.md or outcomes.spec.md first
- Re-run 0e after changes to reassess

**If user wants to skip research:**
- Acknowledge decision
- Document assumption risks
- Recommend validation approach during/after implementation
- Proceed to Phase 1

## Constraints

What this prompt should NOT do:
- ❌ Force research on every project (make it genuinely optional)
- ❌ Suggest research for well-understood domains (focus on genuine unknowns)
- ❌ Create rigid MSL specs for research artifacts (use flexible metaspecs)
- ❌ Make research feel like busywork (every activity must have clear value)
- ❌ Block progress to Phase 1 if user decides to skip (respect their choice)
- ❌ Treat research as one-time activity (support iterative discovery)
